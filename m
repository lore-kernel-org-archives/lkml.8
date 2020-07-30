Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C895C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8042074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096622;
	bh=d2ykpq0HLu37WsOzX2nM/4UzxyXO+CJh8/ET11Cwvlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dnBysspbpaHkJw/XvoV0lx7p9U1sSA8UxW+C8+3rO1o8yYHi3CqrfyqxtVveguHfD
	 oyoTcR9/uhZuzSXnN8XT5smsnRA1z6xw8p48FAx+vficxx8SCD27yffQwt8mVdH8Q9
	 epCTxfiobZ640b/94spx5pCjChZbkS9vmH2AZLTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgG3IKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgG3IKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:10:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD04E2084D;
        Thu, 30 Jul 2020 08:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096615;
        bh=d2ykpq0HLu37WsOzX2nM/4UzxyXO+CJh8/ET11Cwvlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtFZX/VPkokobonZxXpS8YcKh1D93gLULprBy93GViz/EAzlJuy0zg2Tfjn9b/StN
         MZRB0lBG5LzGueF57iFwWLLU0goBpN6B22HtgfZeBr5wq4sGUP/zvpijfHZInJJ3/+
         WJCf87V2BIFmM7PZG+tHYXfiXd06PRxfwMQG0SUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 48/61] dev: Defer free of skbs in flush_backlog
Date:   Thu, 30 Jul 2020 10:05:06 +0200
Message-Id: <20200730074423.160526285@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.811058810@linuxfoundation.org>
References: <20200730074420.811058810@linuxfoundation.org>
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
@@ -4392,7 +4392,7 @@ static void flush_backlog(struct work_st
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
-			kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			input_queue_head_incr(sd);
 		}
 	}


