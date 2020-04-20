Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59BC55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3109C20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="C6t2oN39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgDTW12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:27:28 -0400
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:30771
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728025AbgDTW1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:27:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDp9X6nM8PFBgMfQAWZFaI86GnQE+nJjjvj9mb1tFQ040AS0BCcjnVt2h7U8ylNmjcFlYhGp45BWg7hnikxJQVwSUDCO5HbPbQjcxbG2GBqXl68EchWWxKsnLV8Bcq4ey4AIii/v2VEugvJFFExPLFt8FZVD5WZ4z1Y92org5MW623/yHqec5hwOSH3sTDKCAw9WBTTn9i4NOsdalJoy3POvUT+Z6UZSHiFucxT0D7G7hDSuTiytF1SvPzvzn9mNoPxxTbRUTcre8ly4k2LEgBKGP+cTTvQ4XMNZs+3531TwdHMUD6N6Kx0KOHWT4t6YqRp4pNoTarSxC8QyBRYzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roz9wI1ufrWkq6jN5pjC6kpqV8Ab8puozveoIWPA/RY=;
 b=T2kKIzLBdNhVja7RYruvrnutuRFmNVoBMQPlsaijPAcufGjAUJRX6QnCFqwq2c0wT0dicic25w6rOgnS+VK3tFGo3ePsQTy9alsGApPIJ7K0kI5HpIHDbI+BXGwZ6CDBXuudbIa2C6pdQa9tPOc5w1670FamcCPkQkPa6WEvuEUYVIN4WwnaihHP+9pJ0KhTvYowd0foelg39Qv4tuX0K4aRm4MDxMLkdpdL7zENQ0EV9Ll0qtc1Ium96E/1P0zLCEVt5D0i/wdXDQ2b9R3SiVWLcofnPrQRJHFTsgPz5Fk+n2zfBkD55eC48DNgge1XaRl2QfjrTXA8QaLktX94Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roz9wI1ufrWkq6jN5pjC6kpqV8Ab8puozveoIWPA/RY=;
 b=C6t2oN39GSkq2qGSd8CteN/ozKTL7jwInCRF13Ec61g5amMkT/WVsU8VDpoHAosAUQejE/kgKGvtgLgK4OcA+kgDFNmx62FZgIiV02b9+AQL1upiKA31OgCNreQyRLy35dkGOx+LEJ/StYDY9qO3mZ6pXk0mUdLiY5VEhaX2HxQ=
Received: from BL0PR01CA0012.prod.exchangelabs.com (2603:10b6:208:71::25) by
 BL0PR02MB6482.namprd02.prod.outlook.com (2603:10b6:208:1ce::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 22:27:20 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:71:cafe::7a) by BL0PR01CA0012.outlook.office365.com
 (2603:10b6:208:71::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 22:27:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 22:27:19
 +0000
Received: from [149.199.38.66] (port=33639 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jQerr-0000SX-Vo; Mon, 20 Apr 2020 15:26:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jQesp-0008OD-4m; Mon, 20 Apr 2020 15:27:19 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03KMR9JL006352;
        Mon, 20 Apr 2020 15:27:09 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jQesf-0008MN-7D; Mon, 20 Apr 2020 15:27:09 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        michal.simek@xilinx.com, jollys@xilinx.com, rajan.vaja@xilinx.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Mon, 20 Apr 2020 15:27:05 -0700
Message-Id: <1587421629-914-2-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587421629-914-1-git-send-email-ben.levinsky@xilinx.com>
References: <1587421629-914-1-git-send-email-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966005)(7696005)(82740400003)(9786002)(356005)(4326008)(81166007)(8676002)(44832011)(81156014)(8936002)(2906002)(336012)(426003)(26005)(36756003)(5660300002)(2616005)(478600001)(70586007)(316002)(6666004)(186003)(70206006)(47076004);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6a73f9e-65ec-4c6f-5e84-08d7e579fd1b
X-MS-TrafficTypeDiagnostic: BL0PR02MB6482:
X-Microsoft-Antispam-PRVS: <BL0PR02MB648204992B3E5AEE9CB17B3BB5D40@BL0PR02MB6482.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 03793408BA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emHRRVBWcip2GeGSF9fGkMseNBa4rVS6P0SwY60htwFbLEXchkDdyNLI/jPv5yh1oMmHPKzxeggrJ9t5IXJXVUA273Bz0oNH+n0xWopOh7d3rMANlj+Qou3ztFX1ENwIay3wQyYtjkd9rxS8eIPP7bzFOQNTlIw4/OCvs2zT8URtZI0jNcDlzvvJQIm4vvvOGAq5U8V1YI8C4y2pWdCadWJtv+KtybcYLI1/WnN1mjnJ2DF/zp+ew9Sjgo+N4fDnARQCQA5sk+XJk53VjkT+/Q5Jt9PU/qd//TeDEHZ+k2rirRo41R9NGthDgRxuipC+AT1Fo5liM4ZwyJjWR7MU3r5qr9GZ/JfTkTEr+sInoHQUQXjz/LqnHtpvo2fBtwB/bmtary8BbKxOYel6HJ3hcLt57romb66Wg3KE1EYqqQianwQVMP0s0htqTRXltGuxYkZvSdUOr7wSZi33WBQkGdU9JkObzh5OGM6W1qC0qvw21yLYvPUGbb46cwgsrdlWNPbSgGsR79cHh11tYvyARw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 22:27:19.6317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a73f9e-65ec-4c6f-5e84-08d7e579fd1b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6482
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware ioctl enums for RPU configuration.

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5968df8..074ad71 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -104,6 +104,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE,
+	IOCTL_RPU_BOOT_ADDR_CONFIG,
+	IOCTL_TCM_COMB_CONFIG,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY,
 	IOCTL_SET_PLL_FRAC_MODE,
@@ -129,6 +133,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_MAX_DIVISOR,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP,
+	PM_RPU_MODE_SPLIT,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC,
+	PM_RPU_BOOTMEM_HIVEC,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT,
+	PM_RPU_TCM_COMB,
+};
+
 enum zynqmp_pm_reset_action {
 	PM_RESET_ACTION_RELEASE,
 	PM_RESET_ACTION_ASSERT,
-- 
2.7.4

