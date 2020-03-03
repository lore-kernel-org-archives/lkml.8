Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D89C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8999E21739
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204537;
	bh=KN9SO/J+tUto2qJJGvqUlkJWp2gYhmf9sKcl2h9v6Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YUgLkfatxKoh4TJZU0dSfcgrmQ2+fqnSdvkarenUBWon2pHVgdxb9IQKjyH4Rquup
	 mBF7kRkchd+CYgk8cBSv0QLwgC1900jX8OEBuwR4jGkZ0kV9CS8yC0ZmEEjdJawLoN
	 fkzC64VCF/G2LqfGFydJk41XjrzbC9W8XYhUP+rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgCCDCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbgCCCqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:46:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C8AE2465E;
        Tue,  3 Mar 2020 02:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203608;
        bh=KN9SO/J+tUto2qJJGvqUlkJWp2gYhmf9sKcl2h9v6Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIws6RM93RKHJrgTQIELZTDwgpA16gOtZpQrXx8ZTjjKrGrjcoJ6AI73PZybSyVBI
         vcenmK/2WZ7NYzgrNxAz8LHFIcs9g0hfideKmib1hZTrxo/E0jkZY0rHNItIxDTsbh
         WuaZ6HTIGz75matxbIo7FxFFtg3ZhJmoXgXclYMU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Belous <pbelous@marvell.com>,
        Christophe Vu-Brugier <cvubrugier@fastmail.fm>,
        Igor Russkikh <irusskikh@marvell.com>,
        Dmitry Bogdanov <dbogdanov@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 26/66] net: atlantic: fix use after free kasan warn
Date:   Mon,  2 Mar 2020 21:45:35 -0500
Message-Id: <20200303024615.8889-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024615.8889-1-sashal@kernel.org>
References: <20200303024615.8889-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Belous <pbelous@marvell.com>

[ Upstream commit a4980919ad6a7be548d499bc5338015e1a9191c6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c  | 4 ----
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c | 7 +++++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index c85e3e29012c0..263beea1859c1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -655,10 +655,6 @@ int aq_nic_xmit(struct aq_nic_s *self, struct sk_buff *skb)
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
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 6941999ae845d..bae95a6185608 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -272,9 +272,12 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
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
-- 
2.20.1

