Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5414C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957C720735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442681;
	bh=LwGtMzxaubBnMYxIqHVX2TSfy4YLY5UyzD5VZ0mCWSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wgITM6l39Y3WdiEZgKx5f53QJSZhCYWDbPjd/oIjKqJp0g/NuE4+M7iFCCje4Mh7U
	 rKiPlD2HbbufkfHVnwMjKO0makiihtoNxuuoz7RrjCSfdUlW58BXHozQFj4vZqOmkV
	 qu5+hkdSS3F4dsxZApeQ9Idhid1p5E1D3Ps/+2IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgCQK6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgCQK55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:57:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D641C20658;
        Tue, 17 Mar 2020 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442677;
        bh=LwGtMzxaubBnMYxIqHVX2TSfy4YLY5UyzD5VZ0mCWSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cODOlfZ5iqWKEH+9LxBuJxieXsTCfKidvwOfyMbdv48UIkS/+1nNC9plHiyVjneWT
         8c5XoDomxPprxeFB4vfifv4UTEjWZoi8UHnbXcd+UmLMKDr+K17ajMIOFZUjWuGaZJ
         VQpEieUJQxCj0L/zON69I04stmXSc7Tgbm1GdOHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 45/89] macvlan: add cond_resched() during multicast processing
Date:   Tue, 17 Mar 2020 11:54:54 +0100
Message-Id: <20200317103305.147896836@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit ce9a4186f9ac475c415ffd20348176a4ea366670 ]

The Rx bound multicast packets are deferred to a workqueue and
macvlan can also suffer from the same attack that was discovered
by Syzbot for IPvlan. This solution is not as effective as in
IPvlan. IPvlan defers all (Tx and Rx) multicast packet processing
to a workqueue while macvlan does this way only for the Rx. This
fix should address the Rx codition to certain extent.

Tx is still suseptible. Tx multicast processing happens when
.ndo_start_xmit is called, hence we cannot add cond_resched().
However, it's not that severe since the user which is generating
 / flooding will be affected the most.

Fixes: 412ca1550cbe ("macvlan: Move broadcasts into a work queue")
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macvlan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -338,6 +338,8 @@ static void macvlan_process_broadcast(st
 		if (src)
 			dev_put(src->dev);
 		kfree_skb(skb);
+
+		cond_resched();
 	}
 }
 


