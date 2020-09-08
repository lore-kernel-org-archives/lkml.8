Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0B3C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E8E2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599590291;
	bh=QDY3/kFueJcsMt1b0ZKfYh3Q1QDZa4GUx5uBD6WnL40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bV0AuxAB3zeNYVTyGHQtGRpBm6IAYUJIpfMeEQ2dIWFK58aX5XQNylG+QZMeJj2BL
	 8OyiD9U/hBswuqoWGoEfZISIA9dp3Pi2IbRCXbHfAbhwhwvjAbdRhaI5ZDS6Ts88HI
	 tC4IeDE9MngEfq2i5jbBIZLg35AF/stShkPDVbNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgIHSiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731336AbgIHQJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:09:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A3A24061;
        Tue,  8 Sep 2020 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580134;
        bh=QDY3/kFueJcsMt1b0ZKfYh3Q1QDZa4GUx5uBD6WnL40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8rExpF98YUZwbRKv/sLhJjp4nPeFX9bjTaxerhrAyK/3tC1Y0FgQTGB+A97NInzw
         id92OdIqDnUQ3dC6mZnJA/kqp6b0QqihQg7buL1BM/ny0k5pm8q4oe3llbX+GB/E8I
         /i92ih+soAO2t87u9vqChEKY8ybZu9946KSl1rJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 41/88] net: ethernet: mlx4: Fix memory allocation in mlx4_buddy_init()
Date:   Tue,  8 Sep 2020 17:25:42 +0200
Message-Id: <20200908152223.178555420@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
References: <20200908152221.082184905@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shung-Hsi Yu <shung-hsi.yu@suse.com>

[ Upstream commit cbedcb044e9cc4e14bbe6658111224bb923094f4 ]

On machines with much memory (> 2 TByte) and log_mtts_per_seg == 0, a
max_order of 31 will be passed to mlx_buddy_init(), which results in
s = BITS_TO_LONGS(1 << 31) becoming a negative value, leading to
kvmalloc_array() failure when it is converted to size_t.

  mlx4_core 0000:b1:00.0: Failed to initialize memory region table, aborting
  mlx4_core: probe of 0000:b1:00.0 failed with error -12

Fix this issue by changing the left shifting operand from a signed literal to
an unsigned one.

Fixes: 225c7b1feef1 ("IB/mlx4: Add a driver Mellanox ConnectX InfiniBand adapters")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mr.c b/drivers/net/ethernet/mellanox/mlx4/mr.c
index 1a11bc0e16123..cfa0bba3940fb 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mr.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mr.c
@@ -114,7 +114,7 @@ static int mlx4_buddy_init(struct mlx4_buddy *buddy, int max_order)
 		goto err_out;
 
 	for (i = 0; i <= buddy->max_order; ++i) {
-		s = BITS_TO_LONGS(1 << (buddy->max_order - i));
+		s = BITS_TO_LONGS(1UL << (buddy->max_order - i));
 		buddy->bits[i] = kvmalloc_array(s, sizeof(long), GFP_KERNEL | __GFP_ZERO);
 		if (!buddy->bits[i])
 			goto err_out_free;
-- 
2.25.1



