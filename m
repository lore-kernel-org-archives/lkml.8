Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDC4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846612468A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580219959;
	bh=OEsGfAD1Z+hIdPREY+MSLf1P6cwvF10/s8/wQSWnvaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ArTU/2FeETLmH50A1bStF9RLwOqpBSO7+X+gDLkygW2Z3Wci7CHxY8rjjKo0Mplkt
	 8lnvoY0KitIzVCnQ58Oug6WzaCfoH+0ZglkCWe/Oq4SjuSngqMOoGoq3eIFcbju/LZ
	 4SOycSjsb0WQi2+X+WU7cOJMs4b/waogBcniS/Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgA1N7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgA1N7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:59:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9DAE24694;
        Tue, 28 Jan 2020 13:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219953;
        bh=OEsGfAD1Z+hIdPREY+MSLf1P6cwvF10/s8/wQSWnvaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfpSWcE2GL08L3iKLD58/fdNkfzQvDHYIzhF0lcmE5QysajWq04KuEx42m86x8R0I
         TUH85O7pirTM2r0eFKxMepU02R/0TI+4j0VVp1NG4ekUewAmpxIi1fj0LguFLhlW/E
         N1eo3OUrnIwaw/moDvocGtUyFFXU4LaK3BZHew6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jouni Hogander <jouni.hogander@unikie.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 10/46] net-sysfs: fix netdev_queue_add_kobject() breakage
Date:   Tue, 28 Jan 2020 14:57:44 +0100
Message-Id: <20200128135751.442708030@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 48a322b6f9965b2f1e4ce81af972f0e287b07ed0 upstream.

kobject_put() should only be called in error path.

Fixes: b8eb718348b8 ("net-sysfs: Fix reference count leak in rx|netdev_queue_add_kobject")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jouni Hogander <jouni.hogander@unikie.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/net-sysfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1339,6 +1339,7 @@ static int netdev_queue_add_kobject(stru
 #endif
 
 	kobject_uevent(kobj, KOBJ_ADD);
+	return 0;
 
 err:
 	kobject_put(kobj);


