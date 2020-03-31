Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76C0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838BB206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ktp1j6+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgCaKeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:34:04 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6102 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbgCaKeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:34:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e831c3a0001>; Tue, 31 Mar 2020 03:32:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 31 Mar 2020 03:34:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 31 Mar 2020 03:34:02 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 31 Mar
 2020 10:34:01 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 31 Mar 2020 10:34:01 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.72.141]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e831c980001>; Tue, 31 Mar 2020 03:34:01 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 2/3] soc/tegra: fuse: Correct Tegra194 revision
Date:   Tue, 31 Mar 2020 11:33:40 +0100
Message-ID: <20200331103341.19571-2-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331103341.19571-1-jonathanh@nvidia.com>
References: <20200331103341.19571-1-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585650746; bh=BOpF4d4lG8wL2VaatutEQmw90UMrqfjLPHpA/upHK5c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Ktp1j6+zfUNqav2bzpC1klF8ZpDepj/+7ajvcLutj1cVemE6LKAuB6B3zk7QPV37J
         5XsjkOyUNXALihjg4yyNT5fA4WOtmTnrdPRenZMP2XiEKtiaW29jF8TsBwcnQZNX/g
         Ls5VwAcAiLecaSLcsjj2XJjCv47fgox15Twxoy8AtDP3PfX8MOx+VUmr/3SgyptGFX
         6UjYkNuQmkN4OJg628Wcy7fw0yHI8snKig1sECO2tZYlnZdqj504AFInwrFQ61biJ2
         /PKikhUtIF+vj4rwUqFACVH1RBlFQA6kPU1L0d0MwIZ2mzJYH9ZfA22lGf9D7RjXgK
         Do68KTbQtoMZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Determining the revision for Tegra194 devices is slightly different from
previous generations. For Tegra194, the majorrev field of the HIDREV
register determines if the major revision is A, B, C, etc and the
minorrev field determines if the minorrev is 01, 02, 03, etc.

For Tegra194, there are two main revisions which are A01 and A02.
Therefore, add a new function to correctly identify the revision for
Tegra194 devices.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra20.c  |  3 ++-
 drivers/soc/tegra/fuse/fuse-tegra30.c  |  8 ++++++-
 drivers/soc/tegra/fuse/fuse.h          |  2 ++
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 29 ++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/soc/tegra/fuse/fuse-tegra20.c
index 16aaa28573ac..d2838503e146 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra20.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra20.c
@@ -154,13 +154,14 @@ static void __init tegra20_fuse_init(struct tegra_fuse *fuse)
 {
 	fuse->read_early = tegra20_fuse_read_early;
 
-	tegra_init_revision();
+	fuse->soc->revision_init();
 	fuse->soc->speedo_init(&tegra_sku_info);
 	tegra20_fuse_add_randomness();
 }
 
 const struct tegra_fuse_soc tegra20_fuse_soc = {
 	.init = tegra20_fuse_init,
+	.revision_init = tegra_init_revision,
 	.speedo_init = tegra20_init_speedo_data,
 	.probe = tegra20_fuse_probe,
 	.info = &tegra20_fuse_info,
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 85accef41fa1..9804b0a6e328 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -91,7 +91,7 @@ static void __init tegra30_fuse_init(struct tegra_fuse *fuse)
 	fuse->read_early = tegra30_fuse_read_early;
 	fuse->read = tegra30_fuse_read;
 
-	tegra_init_revision();
+	fuse->soc->revision_init();
 
 	if (fuse->soc->speedo_init)
 		fuse->soc->speedo_init(&tegra_sku_info);
@@ -110,6 +110,7 @@ static const struct tegra_fuse_info tegra30_fuse_info = {
 const struct tegra_fuse_soc tegra30_fuse_soc = {
 	.init = tegra30_fuse_init,
 	.speedo_init = tegra30_init_speedo_data,
+	.revision_init = tegra_init_revision,
 	.info = &tegra30_fuse_info,
 	.soc_attr_group = &tegra_soc_attr_group,
 };
@@ -125,6 +126,7 @@ static const struct tegra_fuse_info tegra114_fuse_info = {
 const struct tegra_fuse_soc tegra114_fuse_soc = {
 	.init = tegra30_fuse_init,
 	.speedo_init = tegra114_init_speedo_data,
+	.revision_init = tegra_init_revision,
 	.info = &tegra114_fuse_info,
 	.soc_attr_group = &tegra_soc_attr_group,
 };
@@ -204,6 +206,7 @@ static const struct tegra_fuse_info tegra124_fuse_info = {
 const struct tegra_fuse_soc tegra124_fuse_soc = {
 	.init = tegra30_fuse_init,
 	.speedo_init = tegra124_init_speedo_data,
+	.revision_init = tegra_init_revision,
 	.info = &tegra124_fuse_info,
 	.lookups = tegra124_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra124_fuse_lookups),
@@ -290,6 +293,7 @@ static const struct tegra_fuse_info tegra210_fuse_info = {
 const struct tegra_fuse_soc tegra210_fuse_soc = {
 	.init = tegra30_fuse_init,
 	.speedo_init = tegra210_init_speedo_data,
+	.revision_init = tegra_init_revision,
 	.info = &tegra210_fuse_info,
 	.lookups = tegra210_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra210_fuse_lookups),
@@ -320,6 +324,7 @@ static const struct tegra_fuse_info tegra186_fuse_info = {
 
 const struct tegra_fuse_soc tegra186_fuse_soc = {
 	.init = tegra30_fuse_init,
+	.revision_init = tegra_init_revision,
 	.info = &tegra186_fuse_info,
 	.lookups = tegra186_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra186_fuse_lookups),
@@ -350,6 +355,7 @@ static const struct tegra_fuse_info tegra194_fuse_info = {
 
 const struct tegra_fuse_soc tegra194_fuse_soc = {
 	.init = tegra30_fuse_init,
+	.revision_init = tegra194_init_revision,
 	.info = &tegra194_fuse_info,
 	.lookups = tegra194_fuse_lookups,
 	.num_lookups = ARRAY_SIZE(tegra194_fuse_lookups),
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index 9d4fc315a007..49b38d934ef7 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -26,6 +26,7 @@ struct tegra_fuse_info {
 struct tegra_fuse_soc {
 	void (*init)(struct tegra_fuse *fuse);
 	void (*speedo_init)(struct tegra_sku_info *info);
+	void (*revision_init)(void);
 	int (*probe)(struct tegra_fuse *fuse);
 
 	const struct tegra_fuse_info *info;
@@ -61,6 +62,7 @@ struct tegra_fuse {
 };
 
 void tegra_init_revision(void);
+void tegra194_init_revision(void);
 void tegra_init_apbmisc(void);
 
 bool __init tegra_fuse_read_spare(unsigned int spare);
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 44a154ca16b5..08a2522bd4de 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -108,6 +108,35 @@ void __init tegra_init_revision(void)
 	tegra_sku_info.sku_id = tegra_fuse_read_early(FUSE_SKU_INFO);
 }
 
+void __init tegra194_init_revision(void)
+{
+	u8 major_rev, minor_rev;
+
+	major_rev = tegra_get_major_rev();
+	minor_rev = tegra_get_minor_rev();
+
+	switch (major_rev) {
+	case 1:
+		switch (minor_rev) {
+		case 1:
+			tegra_sku_info.revision = TEGRA_REVISION_A01;
+			break;
+		case 2:
+			tegra_sku_info.revision = TEGRA_REVISION_A02;
+			break;
+		default:
+			tegra_sku_info.revision = TEGRA_REVISION_UNKNOWN;
+			break;
+		}
+		break;
+	default:
+		tegra_sku_info.revision = TEGRA_REVISION_UNKNOWN;
+		break;
+	}
+
+	tegra_sku_info.sku_id = tegra_fuse_read_early(FUSE_SKU_INFO);
+}
+
 void __init tegra_init_apbmisc(void)
 {
 	void __iomem *apbmisc_base, *strapping_base;
-- 
2.17.1

