Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4186DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15961206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726959;
	bh=akhqUkT0c9xF/42feGFbgYB1eZCfR8+2RTKObv/fnaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0RsV8wNQGpXlSWhT/GesAgwAO9J97LdvOKzNs+0g/oUSgpLaBwPj5C/XbeVfNs0ZM
	 XuY9IfOU6sQxwLkRy1tHuyFvUoqezptCUC9+IxOEH6mrBBqvzxI1uw3xEao1h1rmjL
	 2ERFxfno1HVJR3cIIHtqi5brKhQEqbeEDflMY7X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgFIRsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgFIRr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:47:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88A8520814;
        Tue,  9 Jun 2020 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724879;
        bh=akhqUkT0c9xF/42feGFbgYB1eZCfR8+2RTKObv/fnaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtX/tdr09R5lTzBjKqtOKuVK+VgsxbSVd8f86+PQ6WWvn0PmHmgii5ugzS4ZrCsfY
         0fc6Yu/BvMt9x0Hey/+3ly1Qrn1rJYGRqvq4fdm+76HJHswfWFb9rvoS/ytJa1jGj/
         EawD710C6kbSy/PPljq4c6crnqBxztR04QlCkUf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 19/42] slip: not call free_netdev before rtnl_unlock in slip_open
Date:   Tue,  9 Jun 2020 19:44:25 +0200
Message-Id: <20200609174017.570647743@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174015.379493548@linuxfoundation.org>
References: <20200609174015.379493548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yangerkun <yangerkun@huawei.com>

commit f596c87005f7b1baeb7d62d9a9e25d68c3dfae10 upstream.

As the description before netdev_run_todo, we cannot call free_netdev
before rtnl_unlock, fix it by reorder the code.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to <4.11: free_netdev() is called through sl_free_netdev()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/slip/slip.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -867,7 +867,10 @@ err_free_chan:
 	sl->tty = NULL;
 	tty->disc_data = NULL;
 	clear_bit(SLF_INUSE, &sl->flags);
+	/* do not call free_netdev before rtnl_unlock */
+	rtnl_unlock();
 	sl_free_netdev(sl->dev);
+	return err;
 
 err_exit:
 	rtnl_unlock();


