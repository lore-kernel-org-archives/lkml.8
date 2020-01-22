Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF052467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699519;
	bh=TXcC6BnWAkgFp+79APnoo1ym85vAluRkHJ1fGwFcUuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R7kju0noQnRPTeQr68GRsM0VnFiM6cl7GMhonxqFaUGzcrqjOL5XskOb9KmqyywNl
	 R2rCaMLYubPmp+CkdCNPRpah4f37uVsNgBxWHqtyG5zrnv0xa9CtDce0BTIss0w+Wc
	 VdIsQI52rKTAVMLJYYgCOEePKaiqiL/yRSRu6jO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgAVNZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbgAVNZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:25:16 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977052467B;
        Wed, 22 Jan 2020 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699516;
        bh=TXcC6BnWAkgFp+79APnoo1ym85vAluRkHJ1fGwFcUuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5ady8/w+F2b68APRywrCR+yZOMp1AsseX+AzScFqZE2Og5D30h4PtoMoPolKtPbS
         KQBEUCv/jF5RcOm6l+9SZjatNtcrufKWsEbuglEazorhKTjHYqsksRoz5RbhcVi3K9
         mHemztwgINBvQGeQYl3x0adeogruGFIHOyRIjsKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        syzbot+b0a18ed7b08b735d2f41@syzkaller.appspotmail.com,
        Alex Veber <alexve@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 169/222] devlink: Wait longer before warning about unset port type
Date:   Wed, 22 Jan 2020 10:29:15 +0100
Message-Id: <20200122092845.809734481@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

commit 4c582234ab3948d08a24c82eb1e00436aabacbc6 upstream.

The commit cited below causes devlink to emit a warning if a type was
not set on a devlink port for longer than 30 seconds to "prevent
misbehavior of drivers". This proved to be problematic when
unregistering the backing netdev. The flow is always:

devlink_port_type_clear()	// schedules the warning
unregister_netdev()		// blocking
devlink_port_unregister()	// cancels the warning

The call to unregister_netdev() can block for long periods of time for
various reasons: RTNL lock is contended, large amounts of configuration
to unroll following dismantle of the netdev, etc. This results in
devlink emitting a warning despite the driver behaving correctly.

In emulated environments (of future hardware) which are usually very
slow, the warning can also be emitted during port creation as more than
30 seconds can pass between the time the devlink port is registered and
when its type is set.

In addition, syzbot has hit this warning [1] 1974 times since 07/11/19
without being able to produce a reproducer. Probably because
reproduction depends on the load or other bugs (e.g., RTNL not being
released).

To prevent bogus warnings, increase the timeout to 1 hour.

[1] https://syzkaller.appspot.com/bug?id=e99b59e9c024a666c9f7450dc162a4b74d09d9cb

Fixes: 136bf27fc0e9 ("devlink: add warning in case driver does not set port type")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: syzbot+b0a18ed7b08b735d2f41@syzkaller.appspotmail.com
Reported-by: Alex Veber <alexve@mellanox.com>
Tested-by: Alex Veber <alexve@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/devlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -6280,7 +6280,7 @@ static bool devlink_port_type_should_war
 	       devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_DSA;
 }
 
-#define DEVLINK_PORT_TYPE_WARN_TIMEOUT (HZ * 30)
+#define DEVLINK_PORT_TYPE_WARN_TIMEOUT (HZ * 3600)
 
 static void devlink_port_type_warn_schedule(struct devlink_port *devlink_port)
 {


