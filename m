Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD9AC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750F12467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845154;
	bh=sKWT9C6S3r2RGpbAtBeNneIuanNERDEEBk/3vOnT6T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q9xRvY8vfqgoQMF1BOm6kMQ4PK5p9b63epT5p8MIqGHV5YWawfNv2RNiT/Fw0SWFt
	 tBKj/BA6067EbUWg7nOnckYKxT5eSQW6Ixhq7chpZL3ex738prIVamoTDabWLeDe3E
	 pitLuy3OrG6yEUTnFAvw/q7GpK4ot0kWHdqHTLJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgCJM7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:59:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbgCJM7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:59:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39FA2468D;
        Tue, 10 Mar 2020 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845147;
        bh=sKWT9C6S3r2RGpbAtBeNneIuanNERDEEBk/3vOnT6T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJMV/NnuODWiE/qOik4ivy/O84HqKXHiuFSiKSBfd1vCRaJtDaGSvxgUwgMu5gbNh
         MGssBn7pMLZkJiq/RIdV/NhZJ6c+09KNjmHYX4CHJ5RW5K7aGuQ46s8JNphTphyK1x
         hiFDvzf+hjtsdvrYBuJrfnoBSfwhynVql/toWeGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hamdan Igbaria <hamdani@mellanox.com>,
        Alex Vesker <valex@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 041/189] net/mlx5: DR, Fix matching on vport gvmi
Date:   Tue, 10 Mar 2020 13:37:58 +0100
Message-Id: <20200310123643.628314647@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hamdan Igbaria <hamdani@mellanox.com>

[ Upstream commit 52d214976d4f64504c1bbb52d47b46a5a3d5ee42 ]

Set vport gvmi in the tag, only when source gvmi is set in the bit mask.

Fixes: 26d688e3 ("net/mlx5: DR, Add Steering entry (STE) utilities")
Signed-off-by: Hamdan Igbaria <hamdani@mellanox.com>
Reviewed-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
index c6c7d1defbd78..aade62a9ee5ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste.c
@@ -2307,7 +2307,9 @@ static int dr_ste_build_src_gvmi_qpn_tag(struct mlx5dr_match_param *value,
 	struct mlx5dr_cmd_vport_cap *vport_cap;
 	struct mlx5dr_domain *dmn = sb->dmn;
 	struct mlx5dr_cmd_caps *caps;
+	u8 *bit_mask = sb->bit_mask;
 	u8 *tag = hw_ste->tag;
+	bool source_gvmi_set;
 
 	DR_STE_SET_TAG(src_gvmi_qp, tag, source_qp, misc, source_sqn);
 
@@ -2328,7 +2330,8 @@ static int dr_ste_build_src_gvmi_qpn_tag(struct mlx5dr_match_param *value,
 	if (!vport_cap)
 		return -EINVAL;
 
-	if (vport_cap->vport_gvmi)
+	source_gvmi_set = MLX5_GET(ste_src_gvmi_qp, bit_mask, source_gvmi);
+	if (vport_cap->vport_gvmi && source_gvmi_set)
 		MLX5_SET(ste_src_gvmi_qp, tag, source_gvmi, vport_cap->vport_gvmi);
 
 	misc->source_eswitch_owner_vhca_id = 0;
-- 
2.20.1



