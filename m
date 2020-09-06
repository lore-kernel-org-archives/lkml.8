Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666DCC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 01:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07DFE2078D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 01:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lSrJiiZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgIFBS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 21:18:29 -0400
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:44000
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728409AbgIFBS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 21:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3W0c49KMdZFRBVafm/KLI8Hs+ig69K41ZzX8j/DTPKYa+fe/VREDnmQ29ziySG9DflFLCgUUS5b+exJUknfoaEUPC34ejsqQMAcbkXk14qGsIgUI6EWXl+N+BS8sT+KFqvtdvp37rK4iEk5v7xmWrjQmugRaDx1eWtZ9S43cuubQgxTdFlRf9N6ITBuIY07C7rMLRGXoaRpSd6tt6XF6tfC0p9htjPgui/j2IAl8O74WiVd/RG5g9LSjsEl4mK3xbZj0JNsnk34K3SVnfVMx6RUQyAAgPbkLL6tQrM5JsewfuExPtMb+VoZMLP0Du7DS8Vu1Qmy2aX4EoaOCYqUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2cWYuSdJofaQYt75nidga/cw/85dyMEIU9Aj1hCzcg=;
 b=ZsRcXj1nFZRR/l6l1bvmTBnaXohvyks05Z86HdM4R/hO2p8V2j8fk7DZ2hIkZSQJSuPSPatKqdPNXQPD5lunLX74KzbYabf7KFw2vjjPTpBZJ+lJqNC6jVes42Pt17vfqsWyNo8lYQSudiEYbTsOFjXHv9AcPYOxCH9W9BKdFPxMSIr3cEz6Y2TcMx4U+0QvX4ROFXBW3/0ohGnvLEkAdIy4Q1IM4CaybezPAymqf4PL5wk6WnfoJ7Wx42Ck4Rpt5IKZ3irQ4UTnRaVHeUMREvDmOCG3M5cjhjrif0tSxhgvgUrx+yfsCS+rW9kuogtYBwooMZ7vOA6VqRu+KciOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=sina.com smtp.mailfrom=srdcmail.amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2cWYuSdJofaQYt75nidga/cw/85dyMEIU9Aj1hCzcg=;
 b=lSrJiiZRo5oAVM3VVBA0cahoMhThdPD8YGMd2in7PRx2yYeaGAW6+0N0isByzpXk4ECu+3d+sFRBhB/6+GoExUelN4X5fqCn93Eo1ePyoV+OLHOA6RNowNXRBENIXzG5ICtv8wX9vWRcW8A/slIFU8iz1iITV38uR0504f3KWUI=
Received: from DM5PR18CA0056.namprd18.prod.outlook.com (2603:10b6:3:22::18) by
 BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Sun, 6 Sep
 2020 01:18:22 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::d6) by DM5PR18CA0056.outlook.office365.com
 (2603:10b6:3:22::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Sun, 6 Sep 2020 01:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=srdcmail.amd.com; sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: srdcmail.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Sun, 6 Sep 2020 01:18:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 5 Sep 2020
 20:18:20 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 5 Sep 2020
 20:18:19 -0500
Received: from atlvmail01.amd.com (10.180.10.61) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Sat, 5 Sep 2020 20:18:19 -0500
Received: from srdcmail.amd.com (srdcmail.amd.com [10.237.16.23])
        by atlvmail01.amd.com (8.14.4/8.14.4) with ESMTP id 0861IF2F006359;
        Sat, 5 Sep 2020 21:18:16 -0400
Received: from srdcws1054.amd.com (srdcws1054.amd.com [10.66.16.34])
        by srdcmail.amd.com (8.13.8/8.13.8) with ESMTP id 0861IErh010230;
        Sun, 6 Sep 2020 09:18:14 +0800
Received: (from weisheng@localhost)
        by srdcws1054.amd.com (8.14.7/8.14.7/Submit) id 0861I97R022681;
        Sun, 6 Sep 2020 09:18:09 +0800
From:   Wesley Sheng <wesley.sheng@amd.com>
To:     <joro@8bytes.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, Wesley Sheng <wesley.sheng@amd.com>
Subject: [PATCH] iommu/amd: Add prefetch iommu pages command build function
Date:   Sun, 6 Sep 2020 09:18:08 +0800
Message-ID: <20200906011808.22614-1-wesley.sheng@amd.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cda10af-4bda-4ad0-da57-08d85202be39
X-MS-TrafficTypeDiagnostic: BY5PR12MB4100:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41001998D53DE668D8B8DE14F02B0@BY5PR12MB4100.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yHN3FjRhWcfGUWvde3ForY9bXn2r9dP9w0ZfkUerxCD5o7xRELtSbgnLykMP5iDhKpZUokO4C5p43y8cbfHtOyFvkdplGMw8wWLu3MWqTkN9x09py2V2hd57/weZAJVaRwfuH2/9I7Vfd9feReDoStmjQmsk/ZSMEIekCFvy/MfGA6UsQOSHtcheAAdLb9i0vj2CY2BbRGldENBNNBBrmrfsN1qBCuIL9nTfTagxw+Wl4FjWn4ScUK1h7w4b1ZLJTdb8TU0nnHDFWMw/HResdUigLivvdnOl3W3FtAliRQiMfXRsbu00ywjKSreUhRt9q6l5E3UZU+ZVH20+X1EWUfTEVksOTbhQ6DxpFyEB7TiYQePGqemyTvJUO20I1rK9B80epgz2hLyzg7MffoLcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(36756003)(110136005)(44832011)(2616005)(54906003)(83170400001)(1076003)(4326008)(82310400003)(2906002)(336012)(47076004)(26005)(42186006)(81166007)(82740400003)(426003)(8676002)(70206006)(70586007)(5660300002)(8936002)(356005)(316002)(498600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2020 01:18:20.6960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cda10af-4bda-4ad0-da57-08d85202be39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function to build prefetch iommu pages command

Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/iommu.c           | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index baa31cd2411c..73734a0c4679 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -173,6 +173,7 @@
 #define CMD_INV_IOMMU_PAGES	0x03
 #define CMD_INV_IOTLB_PAGES	0x04
 #define CMD_INV_IRT		0x05
+#define CMD_PF_IOMMU_PAGES	0x06
 #define CMD_COMPLETE_PPR	0x07
 #define CMD_INV_ALL		0x08
 
@@ -181,6 +182,7 @@
 #define CMD_INV_IOMMU_PAGES_SIZE_MASK	0x01
 #define CMD_INV_IOMMU_PAGES_PDE_MASK	0x02
 #define CMD_INV_IOMMU_PAGES_GN_MASK	0x04
+#define CMD_PF_IOMMU_PAGES_INV_MASK	0x10
 
 #define PPR_STATUS_MASK			0xf
 #define PPR_STATUS_SHIFT		12
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ba9f3dbc5b94..b3971595b0e9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -976,6 +976,25 @@ static void build_inv_irt(struct iommu_cmd *cmd, u16 devid)
 	CMD_SET_TYPE(cmd, CMD_INV_IRT);
 }
 
+static void build_pf_iommu_pages(struct iommu_cmd *cmd, u64 address,
+					u16 devid, int pfcnt, bool size,
+					bool inv)
+{
+	memset(cmd, 0, sizeof(*cmd));
+
+	address &= PAGE_MASK;
+
+	cmd->data[0]  = devid;
+	cmd->data[0] |= (pfcnt & 0xff) << 24;
+	cmd->data[2]  = lower_32_bits(address);
+	cmd->data[3]  = upper_32_bits(address);
+	if (size)
+		cmd->data[2] |= CMD_INV_IOMMU_PAGES_SIZE_MASK;
+	if (inv)
+		cmd->data[2] |= CMD_PF_IOMMU_PAGES_INV_MASK;
+	CMD_SET_TYPE(cmd, CMD_PF_IOMMU_PAGES);
+}
+
 /*
  * Writes the command to the IOMMUs command buffer and informs the
  * hardware about the new command.
-- 
2.16.2

