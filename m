Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812EDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5730021D80
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGNKVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:21:02 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:20465 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbgGNKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:21:01 -0400
X-IronPort-AV: E=Sophos;i="5.75,351,1589209200"; 
   d="scan'208";a="52086652"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2020 19:21:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 097A2421EC5C;
        Tue, 14 Jul 2020 19:20:58 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Joerg Roedel <joro@8bytes.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
Date:   Tue, 14 Jul 2020 11:20:54 +0100
Message-Id: <1594722055-9298-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594722055-9298-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1594722055-9298-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Add support for RZ/G2H (R8A774E1) SoC IPMMUs.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iommu/ipmmu-vmsa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index b90cd9ff96f6..55c09cb8fc56 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -739,6 +739,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a774a1", },
 	{ .soc_id = "r8a774b1", },
 	{ .soc_id = "r8a774c0", },
+	{ .soc_id = "r8a774e1", },
 	{ .soc_id = "r8a7795", },
 	{ .soc_id = "r8a7796", },
 	{ .soc_id = "r8a77965", },
@@ -751,6 +752,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
 static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
 	{ .soc_id = "r8a774b1", },
 	{ .soc_id = "r8a774c0", },
+	{ .soc_id = "r8a774e1", },
 	{ .soc_id = "r8a7795", .revision = "ES3.*" },
 	{ .soc_id = "r8a77961", },
 	{ .soc_id = "r8a77965", },
@@ -963,6 +965,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
 	}, {
 		.compatible = "renesas,ipmmu-r8a774c0",
 		.data = &ipmmu_features_rcar_gen3,
+	}, {
+		.compatible = "renesas,ipmmu-r8a774e1",
+		.data = &ipmmu_features_rcar_gen3,
 	}, {
 		.compatible = "renesas,ipmmu-r8a7795",
 		.data = &ipmmu_features_rcar_gen3,
-- 
2.17.1

