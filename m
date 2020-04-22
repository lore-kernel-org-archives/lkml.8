Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B672AC5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFE020776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550902;
	bh=UGUfe1U4LpfmshnMIP8jNUJV/ZQTslokztFJNdAPGx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tL//sa37Ivv37CaUPNIeOu2qZi0glM2iHVYqCasfmgsauXHhEc4CDm9+KTLfmDko4
	 sK/ywxDTtWDo3KHQ4opRUnSfs35IN31mzvkQKYhnhe6ePgEKbPFTdSK4/JXMKG/TPJ
	 lkk3mHg0Cs4xUCOSXi2SDHo4S7N4UfilPACttWO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgDVKVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729999AbgDVKSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:18:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 108802070B;
        Wed, 22 Apr 2020 10:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550719;
        bh=UGUfe1U4LpfmshnMIP8jNUJV/ZQTslokztFJNdAPGx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dx6MvKW3w5RasMtBpMgIjRAuSRvHwloR3xzLHeAss1yus/9im9CWZCbiwZL8/cXnc
         8gUwBZnVZtd+exJWm8sKkxIUYU6MReXp9tkCHY7bCSZfxvMjJSRQYpisWJkWMT69cX
         VrLmGJIuqf2ugwhPwn8g5B0SUHnkJKu6C/udxA+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 038/118] net/mlx5e: Enforce setting of a single FEC mode
Date:   Wed, 22 Apr 2020 11:56:39 +0200
Message-Id: <20200422095038.180585894@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 4bd9d5070b92da012f2715cf8e4859acb78b8f35 ]

Ethtool command allow setting of several FEC modes in a single set
command. The driver can only set a single FEC mode at a time. With this
patch driver will reply not-supported on setting several FEC modes.

Signed-off-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 304ddce6b0872..39ee32518b106 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1548,6 +1548,10 @@ static int mlx5e_set_fecparam(struct net_device *netdev,
 	int mode;
 	int err;
 
+	if (bitmap_weight((unsigned long *)&fecparam->fec,
+			  ETHTOOL_FEC_BASER_BIT + 1) > 1)
+		return -EOPNOTSUPP;
+
 	for (mode = 0; mode < ARRAY_SIZE(pplm_fec_2_ethtool); mode++) {
 		if (!(pplm_fec_2_ethtool[mode] & fecparam->fec))
 			continue;
-- 
2.20.1



