Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C9BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87DE206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rTTGFtf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgCaKeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:34:07 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14019 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbgCaKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:34:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e831c8e0000>; Tue, 31 Mar 2020 03:33:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 31 Mar 2020 03:34:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 31 Mar 2020 03:34:03 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 10:34:03 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 31 Mar 2020 10:34:02 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.72.141]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e831c990003>; Tue, 31 Mar 2020 03:34:02 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 3/3] soc/tegra: fuse: Trivial clean-up of tegra_init_revision()
Date:   Tue, 31 Mar 2020 11:33:41 +0100
Message-ID: <20200331103341.19571-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331103341.19571-1-jonathanh@nvidia.com>
References: <20200331103341.19571-1-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585650830; bh=Ch98wVkeNDBu45J5iyMXFZdcYJMhALREZUPAvteVPdw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=rTTGFtf2o6qXmQqa/jmaE4BrcHBdOYQjoxGUTD7l5WZuhZmRLuiiJpljHbstpF61t
         JuKfu1i772yYMQI50xme4gLxcUceDJejXnhFPXpYCiv3erPelks3VfzHGvAZ4/2dCg
         uFR9jxD/uODZb0vRapCiJemobXPIVdrnf7FrBIAd0EL7mkxtF0Mf6tTM92v7kjM1uI
         OM4m40wJaKfSkirKm1G3pVUOKTUerJ1x72PZEvTyyqvS52Zgisoc9VsvbFj+EsH2n0
         QMFp5ymo8xhoIOgAM4tkmG1oiNmZbvMxE0RAbYApturPuhuiLpLQoU1WzI93PGyXWe
         ypHE7BGLtJbYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean-up the tegra_init_revision() function by removing the 'rev'
variable which is not needed and use the newly added helper function
tegra_get_minor_rev() to get the minor revision.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 08a2522bd4de..5b1238c2b187 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -75,36 +75,32 @@ static const struct of_device_id apbmisc_match[] __initconst = {
 
 void __init tegra_init_revision(void)
 {
-	u32 id, chip_id, minor_rev;
-	int rev;
+	u8 chip_id, minor_rev;
 
-	id = tegra_read_chipid();
-	chip_id = (id >> 8) & 0xff;
-	minor_rev = (id >> 16) & 0xf;
+	chip_id = tegra_get_chip_id();
+	minor_rev = tegra_get_minor_rev();
 
 	switch (minor_rev) {
 	case 1:
-		rev = TEGRA_REVISION_A01;
+		tegra_sku_info.revision = TEGRA_REVISION_A01;
 		break;
 	case 2:
-		rev = TEGRA_REVISION_A02;
+		tegra_sku_info.revision = TEGRA_REVISION_A02;
 		break;
 	case 3:
 		if (chip_id == TEGRA20 && (tegra_fuse_read_spare(18) ||
 					   tegra_fuse_read_spare(19)))
-			rev = TEGRA_REVISION_A03p;
+			tegra_sku_info.revision = TEGRA_REVISION_A03p;
 		else
-			rev = TEGRA_REVISION_A03;
+			tegra_sku_info.revision = TEGRA_REVISION_A03;
 		break;
 	case 4:
-		rev = TEGRA_REVISION_A04;
+		tegra_sku_info.revision = TEGRA_REVISION_A04;
 		break;
 	default:
-		rev = TEGRA_REVISION_UNKNOWN;
+		tegra_sku_info.revision = TEGRA_REVISION_UNKNOWN;
 	}
 
-	tegra_sku_info.revision = rev;
-
 	tegra_sku_info.sku_id = tegra_fuse_read_early(FUSE_SKU_INFO);
 }
 
-- 
2.17.1

