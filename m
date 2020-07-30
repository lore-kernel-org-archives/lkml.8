Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE39FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE0620672
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096421;
	bh=K/h7A8kKGN4wHhcvFtshv8yR07+AP4b6we41P/CZ3qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RXU1s6UUR1TKlBBHRejtGyvvasqeKf5u3y3yUwGSXt4XJ//CiWo2srMxyLYjl3thH
	 z493wKWPCcIXlGFm40TUXH4Ab62aCNKLgUf5ejFszkIhtVtDozXPAHpFgSs4gbACd4
	 z1R7LAcZ+sd/kDbsPrwX9eCxrGg/o3X3aFZ5mEJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgG3IHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbgG3IGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:06:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876D220672;
        Thu, 30 Jul 2020 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096415;
        bh=K/h7A8kKGN4wHhcvFtshv8yR07+AP4b6we41P/CZ3qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUTlUN2A3LEsmXQrBe9CDs718hX5bXzfi+PdLTTNyL7Ij/Xw8cjB3uthej2pldXQ/
         RbwEcU0nCdKYtzGhC4FH690Gqcb6ELiGb2r7V22dQxBBqkBoOwatMVmdOlLTT80PFl
         WtbKQOEzyjrDjNayQBKYcllBrasl4jIg7WMgHTYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 03/17] dev: Defer free of skbs in flush_backlog
Date:   Thu, 30 Jul 2020 10:04:29 +0200
Message-Id: <20200730074420.623709912@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.449233408@linuxfoundation.org>
References: <20200730074420.449233408@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit 7df5cb75cfb8acf96c7f2342530eb41e0c11f4c3 ]

IRQs are disabled when freeing skbs in input queue.
Use the IRQ safe variant to free skbs here.

Fixes: 145dd5f9c88f ("net: flush the softnet backlog in process context")
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5252,7 +5252,7 @@ static void flush_backlog(struct work_st
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
-			kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			input_queue_head_incr(sd);
 		}
 	}


