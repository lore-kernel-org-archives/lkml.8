Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F5C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F55B206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kMqNCrsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgBQKlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:41:31 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:37098
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727648AbgBQKla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:41:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyJmNiwvavPslIDan9FGAbXsGHZrqkdy/01iElm6oHKOgIV80j7b6XETbAipHthpNF91mBdxrqj5U8KSTwBQSrQaOev+9Lse1EvnFeOvYAk1C87DUIm5UVEoMyNk0glgFZn1fM+HGwowZ8RjE26crAznEZKyPt4azd4mrW6lubJTd1+Bj95W5NU5dpDubYgA8l402d8nDacCGsYWQ4vXcwHBZ9mYjXEbk/L2o8qCeMrNxO05tVHpj5NZ3Q0zVpevahaga7kj+GSir/r9pph2HB5pOJtULlNrYQd9NdAyDQGjugOA3H2y/GdFDpuz25zNrP0zsmo2/IC4ZG0BLvETew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuLufXCAWFwMpTqpS4MuG4823mheLeOSNK/WMMkvEEg=;
 b=cgU1dZ5JmFNdPFgoK9L+ev3a0Hv25TgR8SnIufVOPKx7uKAJcfSdbHW+lPlncLKrt3qbBPBAQ0fXp/YsV+bzl+01m3xOnpUnAQk8Iv+SNJeov1+VRcel16+kTlEU1gH+6zlL6RxUFMIOGY4jydShMBrTfb+/kUJj/nEOeDkpUS9yMTnhBXs2kwNXR/78RxKsg3hT3RlLHvUMpQ2KIAtXd4lvlrdjdPURwg3E2sfpkDfnfOiz7IowSdcfJi3eSKzS+T2d8dBNtwqwtFC/eOI/7odHfZzId+1Td6uLjm5pUmWwbjTyh72zqqU89c5hEAwbWIO1EatHeNajms0O+O4sgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuLufXCAWFwMpTqpS4MuG4823mheLeOSNK/WMMkvEEg=;
 b=kMqNCrspMJr74CY11mzz4eiPE+AUy9HS4piGa4yBCo4MoeiTLeqm7ewlrBFnESM/eyy8zQuLpxWwO6B+ZqLRj6qFjLa8y6FLyIU8lZ1heM0BaqhDgOXGrUi/QsRGKwKf6ndC0+/r1WD9Inm9tuojCxlul7kwA1HcVTTvmMxiGXQ=
Received: from DM5PR12CA0014.namprd12.prod.outlook.com (2603:10b6:4:1::24) by
 CY4PR12MB1637.namprd12.prod.outlook.com (2603:10b6:910:d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Mon, 17 Feb 2020 10:41:26 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by DM5PR12CA0014.outlook.office365.com
 (2603:10b6:4:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Mon, 17 Feb 2020 10:41:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2729.22 via Frontend Transport; Mon, 17 Feb 2020 10:41:25 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 17 Feb
 2020 04:41:25 -0600
Received: from vishnu-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 17 Feb 2020 04:41:22 -0600
From:   Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     <Alexander.Deucher@amd.com>, <broonie@kernel.org>,
        "Ravulapati Vishnu vardhan rao" <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: ACP needs to be powered off in BIOS.
Date:   Mon, 17 Feb 2020 16:09:19 +0530
Message-ID: <1581935964-15059-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(428003)(189003)(199004)(54906003)(4326008)(7696005)(356004)(2906002)(70586007)(6666004)(478600001)(70206006)(8936002)(36756003)(2616005)(186003)(109986005)(26005)(316002)(336012)(86362001)(426003)(8676002)(5660300002)(81166006)(81156014)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1637;H:SATLEXMB02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e30df6ca-f402-4e75-5e29-08d7b395f051
X-MS-TrafficTypeDiagnostic: CY4PR12MB1637:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16376E2873A040AA1518FDEDE7160@CY4PR12MB1637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-Forefront-PRVS: 0316567485
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGwI52n/iKEPGg6/bp/LRTTJcYbHhmpBI2IGb8dPeX4VKT8tL1xXW+XJPrg+PkY6X0/umD+Rybf7ZZa/lmgJY7knNAL+Vr+AwvGdrmokWz4t2nsXGRbrrU1Vr1wuLNt66W0qmPlxDEx+19uxTY9USbDnfWiM8PQ6lsKR7ut6yqiPliFPcGSDRsNaDb4RoAHzBdl0FAmQIJGMXpn1klLjoJEj4b96/XXgl9hRDv2OXfeX35fVmlWx+pPU/LJGh/fNJOvdpSZh2KRoUcHYWBLdrT8V8asThAXESPVwaS6fr71S58o7Jn/YwKIKmAS+w8t7wdJ1JvPGaTBzYGghlXBmNMpRhJwyD6NDyT7K5bNZySZarWbf9iodV49o5roPfFbUK+EVwQjiMQPFs5cGq2MEE1Uv+pDZmxxdfsL1lbJNd5RlpKiNe3iPZ8I9L5acaNU1Cdv/fGinKthcq4GGOvWqg50QPWY3RGZauKv/TLuhriQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 10:41:25.8647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e30df6ca-f402-4e75-5e29-08d7b395f051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1637
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed this logic because It is BIOS which needs to
power off the ACP power domian through ACP_PGFSM_CTRL
register when you De-initialize ACP Engine.

Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/pci-acp3x.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 65330bb..da60e2e 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -45,23 +45,6 @@ static int acp3x_power_on(void __iomem *acp3x_base)
 	return -ETIMEDOUT;
 }
 
-static int acp3x_power_off(void __iomem *acp3x_base)
-{
-	u32 val;
-	int timeout;
-
-	rv_writel(ACP_PGFSM_CNTL_POWER_OFF_MASK,
-			acp3x_base + mmACP_PGFSM_CONTROL);
-	timeout = 0;
-	while (++timeout < 500) {
-		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
-		if ((val & ACP_PGFSM_STATUS_MASK) == ACP_POWERED_OFF)
-			return 0;
-		udelay(1);
-	}
-	return -ETIMEDOUT;
-}
-
 static int acp3x_reset(void __iomem *acp3x_base)
 {
 	u32 val;
@@ -115,12 +98,6 @@ static int acp3x_deinit(void __iomem *acp3x_base)
 		pr_err("ACP3x reset failed\n");
 		return ret;
 	}
-	/* power off */
-	ret = acp3x_power_off(acp3x_base);
-	if (ret) {
-		pr_err("ACP3x power off failed\n");
-		return ret;
-	}
 	return 0;
 }
 
-- 
2.7.4

