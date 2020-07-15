Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142BBC433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D3A2071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h5Had1Jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGOPdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:33:37 -0400
Received: from mail-eopbgr690074.outbound.protection.outlook.com ([40.107.69.74]:27878
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbgGOPdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:33:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC/l1E3O9bKiiSBR/5V9y0xCFwvhSS2DZ0lXhDphKkH50BcsldjVvKvw4JDOV3yQTMU/wUCp3A31RDRJsBYypRyQ+7Tq59WLSunhT1zpVaNvrJRtjbrDUpchCA2d6rJRLBudvIt9mUR/CB883Bszv++OHvO72wu7OgKEYhWsfi2Vij/Ms8XAixCVhJIOBc15XwPqu/iN3JfNHs3xRDEA7iuB4/SlmX88K33sxK8ydA8M6Te4kAY601J3a8RkGjGle4jMwX95Sj+dY9G/BKvAnylUhW+A/j28Tc1Xzp9vafODOdS6Qws21AbzDQ/UYrL/dHNd3+yH45fGgdXV8MWXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=LHRWUdqdJZnKmAUTbRdfeCYsAQd+dMMQM/E9Gj/181Ea8KEnT4qb8asIIAVDIWc2HJ8jQscTmuI0AoL89ZsFKQezKQhkQqjYsTLL+MDgSON/eS3viepv8w++Jpvtyg0huZR4tT/aCNwjpye4pT0mGMU1M7IQOXFB2j84Au0PItqznUprjWnUO4uqqeDlNyZd4q+KZh5wq77SAadUGrQpJcJW+F2xzykAp1QGuEr8ptGegwOvmlsqHJWh9LYcZlYaKA6wXB5ku7smfUmG6fKToy3zn+yIAZ5uw8Btck5WDXewd1CwgZvsEM8nwrVb6qC6RzgD63Pi+SSIXLZoK6zWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wizery.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=h5Had1JllF3aZQa17xe3xAtew8CxnaQkb17D9nPwbaQxmw41sxxBPkQl7jCFbPnIvt+ZLBov88Bp9BrWqY74TFgw8lTytvUDZTlhenh7JiJ1Saj3nBFdjLPoXyRy8+LvT/TqmXpgbekwFUowExBNkm/jjcqw4/wxl4JxYDwBFgA=
Received: from BL1PR13CA0049.namprd13.prod.outlook.com (2603:10b6:208:257::24)
 by DM6PR02MB4250.namprd02.prod.outlook.com (2603:10b6:5:9a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 15 Jul
 2020 15:33:20 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:257:cafe::7d) by BL1PR13CA0049.outlook.office365.com
 (2603:10b6:208:257::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend
 Transport; Wed, 15 Jul 2020 15:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wizery.com; dkim=none (message not signed)
 header.d=none;wizery.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 15:33:20
 +0000
Received: from [149.199.38.66] (port=39350 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjNh-0005fG-1a; Wed, 15 Jul 2020 08:31:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPL-0007rZ-TW; Wed, 15 Jul 2020 08:33:19 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jvjPJ-0007qz-L6; Wed, 15 Jul 2020 08:33:17 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        JOLLYS@xilinx.com, RAJANV@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        stefanos@xilinx.com
Subject: [PATCH v6 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Wed, 15 Jul 2020 08:33:13 -0700
Message-Id: <20200715153317.25643-2-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715153317.25643-1-ben.levinsky@xilinx.com>
References: <20200715153317.25643-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(396003)(346002)(46966005)(44832011)(5660300002)(336012)(6666004)(2616005)(2906002)(478600001)(8936002)(1076003)(82310400002)(426003)(186003)(356005)(7696005)(82740400003)(47076004)(26005)(4326008)(83380400001)(36756003)(81166007)(107886003)(8676002)(316002)(70206006)(9786002)(70586007);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d4d1c08-33a0-4d0b-e531-08d828d4673c
X-MS-TrafficTypeDiagnostic: DM6PR02MB4250:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4250097B380137684458FBD8B57E0@DM6PR02MB4250.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFdVRKxnrqPBSMQpgWKLt6g2jxOroqAvhV9/Q75qTxLfrH8RrDgrb+sbJfsQ6jxiQCdH2K9t0OqlT2LeegHn6rs0qXatJohWxBPCpsj0ZLGEQro/ZNqZltd2NyTEWP4yUK0VrlQ8uOIfgOeUbpPyQDnwf/I/AVy41iJvRzCZDzZ72p9pROhRa5n9EnPeRt2WI3qxIZi+kps/pIRRkrPMF6B2N/H0xc97lx/O48415sgGM6lKhDTKIkOqHVhaWGyIc2Buh3WQgC7eaPrkK32cSyMKjzJwqu5fC2ctySASb1J2FoPwZGsB7eTmrZWVv9dbqO3nLgKz+zdTNFzx0Yqe2OrtC7SBaekCPjopnpQEOOMNPAJcebFq4zUmVikNS8WjG6VdZOeX8C2aG1X3ST13Tw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 15:33:20.2987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4d1c08-33a0-4d0b-e531-08d828d4673c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4250
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware ioctl enums for RPU configuration.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
v4:
- add default values for enums
---
 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5968df82b991..bb347dfe4ba4 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -104,6 +104,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE = 1,
+	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
+	IOCTL_TCM_COMB_CONFIG = 3,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY,
 	IOCTL_SET_PLL_FRAC_MODE,
@@ -129,6 +133,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_MAX_DIVISOR,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP = 0,
+	PM_RPU_MODE_SPLIT = 1,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC = 0,
+	PM_RPU_BOOTMEM_HIVEC = 1,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT = 0,
+	PM_RPU_TCM_COMB = 1,
+};
+
 enum zynqmp_pm_reset_action {
 	PM_RESET_ACTION_RELEASE,
 	PM_RESET_ACTION_ASSERT,
-- 
2.17.1

