Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73294C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A7C20866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258482;
	bh=hPq/Z75x+CgdvVjSkwVvKor8npYi0Xg4dg9rQ4+tPlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aNC2D8w/OFlM1C8XZVglR2RmO1ABP5bpsxCUlJ+1jakgSyRAxw7oXOmtF6ueDM7U6
	 X/nBnmIbL/Ymf+rmkWcYU4pd2rfJhv1iMXzuHW0yoJg4RPpo3aQhYFW6hoS0hYPvpw
	 e+teDa8ame8gTcKvmkIF5FEkr6xhf5aXEXzuZ4Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbgCCSBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:01:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387627AbgCCSBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:01:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A64214D8;
        Tue,  3 Mar 2020 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258478;
        bh=hPq/Z75x+CgdvVjSkwVvKor8npYi0Xg4dg9rQ4+tPlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifo5ENN/IJFIEmS5ecfBlWsMkA+FOTOG9Keoed1SNY5EOXyr5mYR2rV9YDFGcv3Kf
         NSofduBB/g3fXA417Lr8/Mrm4M/24rhBRI6/A7K/3vwFXzzNy4DHvgR3hzYffXAoBC
         B8ialAh447M6ZHk5mCwJi1PILRSI5SwQJzdnhGP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Vu-Brugier <cvubrugier@fastmail.fm>,
        Igor Russkikh <irusskikh@marvell.com>,
        Pavel Belous <pbelous@marvell.com>,
        Dmitry Bogdanov <dbogdanov@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 63/87] net: atlantic: fix use after free kasan warn
Date:   Tue,  3 Mar 2020 18:43:54 +0100
Message-Id: <20200303174356.002654266@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Belous <pbelous@marvell.com>

commit a4980919ad6a7be548d499bc5338015e1a9191c6 upstream.

skb->len is used to calculate statistics after xmit invocation.

Under a stress load it may happen that skb will be xmited,
rx interrupt will come and skb will be freed, all before xmit function
is even returned.

Eventually, skb->len will access unallocated area.

Moving stats calculation into tx_clean routine.

Fixes: 018423e90bee ("net: ethernet: aquantia: Add ring support code")
Reported-by: Christophe Vu-Brugier <cvubrugier@fastmail.fm>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Pavel Belous <pbelous@marvell.com>
Signed-off-by: Dmitry Bogdanov <dbogdanov@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c  |    4 ----
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c |    7 +++++--
 2 files changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -530,10 +530,6 @@ int aq_nic_xmit(struct aq_nic_s *self, s
 	if (likely(frags)) {
 		err = self->aq_hw_ops->hw_ring_tx_xmit(self->aq_hw,
 						       ring, frags);
-		if (err >= 0) {
-			++ring->stats.tx.packets;
-			ring->stats.tx.bytes += skb->len;
-		}
 	} else {
 		err = NETDEV_TX_BUSY;
 	}
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -162,9 +162,12 @@ bool aq_ring_tx_clean(struct aq_ring_s *
 			}
 		}
 
-		if (unlikely(buff->is_eop))
-			dev_kfree_skb_any(buff->skb);
+		if (unlikely(buff->is_eop)) {
+			++self->stats.rx.packets;
+			self->stats.tx.bytes += buff->skb->len;
 
+			dev_kfree_skb_any(buff->skb);
+		}
 		buff->pa = 0U;
 		buff->eop_index = 0xffffU;
 		self->sw_head = aq_ring_next_dx(self, self->sw_head);


