Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B9EC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3CE206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 07:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tKCwmOel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgIEHPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 03:15:05 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:28480
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgIEHPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:15:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+/LrW/OZL5LC3DVZwz/ec2C6VIgMcFIDyqO9fS1pIWxjMydznCp1FUlIF5TbxBlqtEDNvjpJj8UfT5cdGhLnE5/OhLSsyvfecpk3lix70m+OZ9F2kb/MCXKCWuimMn7AMRD2P6laT0p1NsVHQsN0iOB+EkiKbeSdpLQv8OoaCxWFwg8XzO8x6r22Txnt/5cPzR37B6MpUyqvazVIw4h1BEkJ6xm4i0TW8IIOlN9B6sopBLupqpAcgLGEmGMpeCociklqYpUZrAxJ8Pzrqn9kMJ0ejlJykZVbO7fB9elaEOx5e8jHU4BPn4wQrprlLTKat98wRReTwvUK8C2ISkQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMYI/7IBgDn1aTWi3oacH+aF+elap3W2C5YqHBlrrRk=;
 b=K9S6IVat2/bhUgLT3o4gMiG3AM+D07PRzayCPjfa5G2BkjtcFsnU8GLi7gKA1s+CJfy1iD9uPRdleRWGF9/npvL5sKknlj0Bv4VxZ5Zs6D+3uz8xh3f4UlxIV+W0SLwZ/CAdKA7rmZvOAr/8iM1b2MUmVUX8zL2wHWIH/EGTCNr8u4moyTqW/5A0z0vxNYtggBqUNwUoPs0OLd002gShNGRVctOpFWSniu4TAYOr85zCOlRbWGXiRE8kIBbbOutZsBAStETtlu2BJujU5JBmFOXUzu/1rYyYquYsW1den5lf8hD1JrUaACEPrrrl1AWjyQyI/bCdRxmx4OW50vTstg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=sina.com smtp.mailfrom=srdcmail.amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMYI/7IBgDn1aTWi3oacH+aF+elap3W2C5YqHBlrrRk=;
 b=tKCwmOelqr1ixsr0q0+5esCLIgmeuesaZn9f/xMYXbYFmrf7UD03jkon2GTRnmsfc4+SPF5efIkkw5ekC20AhevH0X7zmwmmn+5QY9Zi3iPKEioDcrh3HVlLnVFtfHT7BYKDEvKrL0is1Gp5FxqJm82inPS7zdTWjJm2ojjXry0=
Received: from BN6PR10CA0042.namprd10.prod.outlook.com (2603:10b6:404:109::28)
 by MN2PR12MB3519.namprd12.prod.outlook.com (2603:10b6:208:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Sat, 5 Sep
 2020 07:14:57 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::6b) by BN6PR10CA0042.outlook.office365.com
 (2603:10b6:404:109::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Sat, 5 Sep 2020 07:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=srdcmail.amd.com; sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: srdcmail.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Sat, 5 Sep 2020 07:14:55 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 5 Sep 2020
 02:14:54 -0500
Received: from atlvmail01.amd.com (10.180.10.61) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Sat, 5 Sep 2020 02:14:54 -0500
Received: from srdcmail.amd.com (srdcmail.amd.com [10.237.16.23])
        by atlvmail01.amd.com (8.14.4/8.14.4) with ESMTP id 0857Eqrb012120;
        Sat, 5 Sep 2020 03:14:53 -0400
Received: from srdcws1054.amd.com (srdcws1054.amd.com [10.66.16.34])
        by srdcmail.amd.com (8.13.8/8.13.8) with ESMTP id 0857Emfw008832;
        Sat, 5 Sep 2020 15:14:48 +0800
Received: (from weisheng@localhost)
        by srdcws1054.amd.com (8.14.7/8.14.7/Submit) id 0857EkwK020256;
        Sat, 5 Sep 2020 15:14:46 +0800
From:   Wesley Sheng <wesley.sheng@amd.com>
To:     <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, Wesley Sheng <wesley.sheng@amd.com>
Subject: [PATCH] iommu/amd: Add prefetch iommu pages command build function
Date:   Sat, 5 Sep 2020 15:14:20 +0800
Message-ID: <20200905071420.20190-1-wesley.sheng@amd.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1deb7a25-b5dc-49ea-0500-08d8516b642c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3519:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3519484C8B6F3BDEF1C311ECF02A0@MN2PR12MB3519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zel1pj96iJF/B9C+xqa+aTmiCAekOiVyaD+ScFOzfEDCeTwbTs/2aTo9OlB28Dohw9/fMOyvmKj4kpgihBeDjZeq7LBO/oSvuIuTbIgGhQrlVpsxK32QDqmx9Yb2QjL/pK2tQbbk/BZch+pQbq8hLD3YztfmcU93gWQ5ODFT7qisCRHKguZeMD+DiooxgYLecCpvnEoeVbZao6uoI8YMmzu0Fd2pXZQwWZ5tvBWP2cSgDNkmo2jl69KjeQr69bhQTfAueeR7vibjs8i2uV5NyIV3E30/6HO6WCtHMKtW8fBaHznLLxpLV5PFbhnDT3t1PkFUOTc3fsWGYMSkc425Xfbv/bjV+AYfCbKuh9A/C2+zc7B+VeOLdjLTDDZtBQDp6gTIi9uY/KfDZOzSsGeQMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB02.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966005)(42186006)(4326008)(54906003)(110136005)(6666004)(5660300002)(1076003)(498600001)(26005)(316002)(44832011)(70206006)(70586007)(2616005)(336012)(426003)(8676002)(82310400003)(8936002)(356005)(82740400003)(47076004)(81166007)(2906002)(36756003)(83170400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2020 07:14:55.6442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deb7a25-b5dc-49ea-0500-08d8516b642c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3519
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
+	cmd->data[3]  = upper_32_bits(address;
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

