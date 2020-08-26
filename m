Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E880DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D722075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Y/JCnIcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHZQOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:14:06 -0400
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com ([40.107.92.56]:60995
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726856AbgHZQNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acKpSSOARBYytHnT0rCho2JdLrriWYuo7aWY3m1KJ33nmyN4VhTByDECv6UEPbM1jeXZOhGDsxcsH3Ksd+B5Xo6s+4Q+h1bPrbGogwMfGnELwsu94nI+64fsFMMqFm2/30xhUw/BmsfNalJ77ywfU2oSPMFLVZko/4Gi8LFewRUY+OXlfD0EtuL+dBQ7e6Bd5oJjCgJJAR034POzF/ZxQvVOP9+0s1jEWQaRyq9KgKCpnyRSM3YW60bVE4wcnACtgzso6PBp7qoUeoqSULks1nJaA8V/ie3tJKlspKISAHZ/34dSWKiT1nFV9LHkD01uTuzuwhx2OSyQODH2KxfRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=C+DiBldnYUUvbIobTh3wE2Nh/rFNao/klbMOpgkmdSTGzafNwdBKpm0BxuK6UdOh29zNu1ggTSSing3dKIKqisg2bghKcc7M5v/cB9ajr+c4TnMzxLNZG9XXAk5wPRmsxdBXMLwuhRD5d//bagUIGC86JbXS3qwUaDfeUNcr9+e7przy7oaZextqDZ46mHsJD2QnTYzjXOavX0Qtgzfx03lqoQdbVX53+//OcHECjBTP8pA764GjryLPgfTBntaP2/iWSkUYN86/0QmmnOXAEMuPgzzz9UldfLl+C7yOfwRjXy5+Q8jtVr5Mh7Qp8EpbWHkdV1VX0ZewgSwk8kfyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5xh2iMbOUuYykH3VtoEpRrVeANMsj9APMUlrpsyzW0=;
 b=Y/JCnIcmPxWKCDITok3HjXUBOd96SR3zpkH0K0DutLSKixmY6lukltgGtMF2ZB5BDUNM/oQihBfJwzREzScqMOmAJce/zHTVVFgY/GTYIIZft2406WuWP2mQ4X0SfO9ODeqWjHPf7Tt4XZ2DRxMXBbbUmfNhGDcXOCg2rsXhTs4=
Received: from SN4PR0501CA0100.namprd05.prod.outlook.com
 (2603:10b6:803:42::17) by BN7PR02MB5123.namprd02.prod.outlook.com
 (2603:10b6:408:22::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 16:13:10 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::df) by SN4PR0501CA0100.outlook.office365.com
 (2603:10b6:803:42::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Wed, 26 Aug 2020 16:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 16:13:09
 +0000
Received: from [149.199.38.66] (port=58625 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2Q-0006aB-Le; Wed, 26 Aug 2020 09:12:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2v-0008BQ-KG; Wed, 26 Aug 2020 09:13:09 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kAy2t-0008B0-MA; Wed, 26 Aug 2020 09:13:07 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michals@xilinx.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        michael.auchter@ni.com
Subject: [PATCH v9 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Wed, 26 Aug 2020 09:13:03 -0700
Message-Id: <20200826161307.1064-2-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826161307.1064-1-ben.levinsky@xilinx.com>
References: <20200826161307.1064-1-ben.levinsky@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8465121b-165d-4a3c-616c-08d849daece6
X-MS-TrafficTypeDiagnostic: BN7PR02MB5123:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5123D81B3BEF951A0FFE1B0EB5540@BN7PR02MB5123.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjI1ZkVD/0bXcGe9O7rvSJv4L1eyclsvbLGHaYOQbdFViv+AYYP+qWJXBsQ7uwdx1Cp5z3cj1yg6yAAW1C99YUWs431zFA7A8xboa00eJLHZlLIpFBgCKRR1VD6E1lmk5RNBhP1QqtTMdEw+A2l4bDTlkK1cnzHUlbPrpylTbIBZnAz7wfPvSEru7H56S+gHkv4cLKUHnB9efErp3DSd637cnjkg/135JakoxEuFAVt9vYjn0K+CMC4gC40YJKfsSMe6T6Aw4xeSlpzdL5fnuY21ZDKWVZeBzm4lqHwmsfAdgna9l4GwfUw5ULD56Ru+JcK98tExnqDcbwcdpPTtB0kbNRPZ4FD3/zMcEA0hY1RsVvHOEoL/SBeB4TrzXFF4zcm3xgAb6s2/GHW73lp0JA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(376002)(39860400002)(396003)(346002)(46966005)(1076003)(26005)(5660300002)(2906002)(336012)(36756003)(83380400001)(44832011)(426003)(4326008)(82310400002)(2616005)(186003)(7696005)(8676002)(6666004)(81166007)(82740400003)(356005)(70586007)(47076004)(6636002)(70206006)(9786002)(478600001)(8936002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 16:13:09.9054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8465121b-165d-4a3c-616c-08d849daece6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5123
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

