Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19E4C3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD724677
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204427;
	bh=BVyEN67TtDpCiNbaG8wcbtPddkG6IrosjShyMCm7+jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMVz1NHAc+4bC6zOMYF2FiS3knirrfvckK6icU2d6mVb7pE1pL1lamai6HmacKq3/
	 VbEvTq/pU5jrfoIdCQ8PPLm2YJJW5vM9PxtaRo0Dy61k4Lf9vT/ruYhCYLJ+Y4vdvU
	 5lK0x6riq0reyaMhrkyquKpy1/kNRP+Hft/7Pjw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgCCDAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgCCCrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C4B246BB;
        Tue,  3 Mar 2020 02:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203643;
        bh=BVyEN67TtDpCiNbaG8wcbtPddkG6IrosjShyMCm7+jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3dVZmekq40ErOiFoqkWzuvB4ZG1OKnzdPrTTjcEytkPwW+gZYkQuk942ZWwA3C1T
         seNV8dofrwVocuOzHk9uGCZCdXII5Yz3t8Cltw6h+T0qq7KvkX0Mylr5s71WG6t4gz
         f2GKhJYEfITtj1aNbGHUoxrbfsGWymZzSyIbfqVs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 54/66] s390/qeth: fix off-by-one in RX copybreak check
Date:   Mon,  2 Mar 2020 21:46:03 -0500
Message-Id: <20200303024615.8889-54-sashal@kernel.org>
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

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 54a61fbc020fd2e305680871c453abcf7fc0339b ]

The RX copybreak is intended as the _max_ value where the frame's data
should be copied. So for frame_len == copybreak, don't build an SG skb.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 623475717183e..4fd7b0ceb4ffd 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5141,7 +5141,7 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 	}
 
 	use_rx_sg = (card->options.cq == QETH_CQ_ENABLED) ||
-		    ((skb_len >= card->options.rx_sg_cb) &&
+		    (skb_len > card->options.rx_sg_cb &&
 		     !atomic_read(&card->force_alloc_skb) &&
 		     !IS_OSN(card));
 
-- 
2.20.1

