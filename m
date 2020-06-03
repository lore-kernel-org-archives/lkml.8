Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A912AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870D520772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="m38bN+d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFCOtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:49:51 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:63529
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726123AbgFCOtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:49:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV5MfEfz0vgQK8Bt7A3cs8LCglqsiTZJ/KYyEWQpY8ryGj1VryamrhRm2+Boo6NF+y8esY9RwKKk84Tj+D2/0hI9MIVvQ5AMdC+26tDtJmOSSCoXMeo7OEEY8foPfntGCLuKJRxS4zsM9EliOsv0JR0J9i4467Hm/+5wc34MkzTwaD0LfX1qReyacbw+S6xwXma+nSsPQrkuwwJq6nQW/QRjx9f0Hq1sbROwOawRAaT+/5Oyb8OJ4B3bgTKGGD4cKs7DKp6zIOgdvdqXxckv4ssL+Uoxhf8JxHixA7fqXXpeJ7ViY58Qk7vCg8eV/c3bHW0NCFHSshumDGVRPJu0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb+7R98fZ7vwAKf08Y2Xz/ClgfG8ljyHxv7HG5gskQU=;
 b=il05p7Aomc8fm3kJOjQMedVz5IpeSkKvQ8oj7SfDlybaANVSp/umVKfbT3rWja3A2qQk0/Eywg8hHlypr52QonsryiShglsxvSvQ8iJOihZevDWXYSVX184XJCA99fkl0f/3eI4oXaTqJbwoSjM+fqXOc2Qoa0alnj7qvzcnJDocJR262ZkZcU6xcNS9oNpAixkepOSGuWL0/B9bmsomvru/YnKLSXIdUlQsHEuXQR1pITQhhiDFAWsttoL1RjVqiFlS5V0UmlGZgnGRKpbtiSK+Mstn4IojqkVVPrRFQ+jyZ0jrxTdnxBqaFuS6GQSWg+NNfynL0sgR47nQEeUl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb+7R98fZ7vwAKf08Y2Xz/ClgfG8ljyHxv7HG5gskQU=;
 b=m38bN+d8QCaoa6yuitMqd4zmpvv8oUcRNkE2JREp7Xj3HbivmA1/Qs5+QxNjXMdtTTy9N7JV6cqvBTRaZ0ZW+98v5MEflradzv3qv6cgV/CH1W01yvFFEen0dQBR78dnGRYCkQ6TxdXSbCG/AeIETV//Sc3XvGLmy3QRoXJENCc=
Received: from DM6PR08CA0032.namprd08.prod.outlook.com (2603:10b6:5:80::45) by
 DM6PR02MB4012.namprd02.prod.outlook.com (2603:10b6:5:9d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Wed, 3 Jun 2020 14:49:48 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::4c) by DM6PR08CA0032.outlook.office365.com
 (2603:10b6:5:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 14:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server id 15.20.3045.17 via Frontend Transport; Wed, 3 Jun 2020 14:49:48
 +0000
Received: from [149.199.38.66] (port=60695 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUhR-0007G7-Qw; Wed, 03 Jun 2020 07:49:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUiB-000515-KL; Wed, 03 Jun 2020 07:49:47 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 053EnhQ0017032;
        Wed, 3 Jun 2020 07:49:43 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1jgUi7-00050a-82; Wed, 03 Jun 2020 07:49:43 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, michals@xilinx.com,
        jollys@xilinx.com, rajanv@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Wed,  3 Jun 2020 07:49:39 -0700
Message-Id: <1591195783-10290-2-git-send-email-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
References: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(136003)(39860400002)(346002)(376002)(46966005)(478600001)(336012)(70206006)(2906002)(83380400001)(26005)(4326008)(316002)(8676002)(36756003)(82740400003)(8936002)(47076004)(81166007)(9786002)(5660300002)(186003)(7696005)(356005)(426003)(2616005)(82310400002)(6666004)(44832011)(70586007);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5cba284b-1a48-4e2b-3df7-08d807cd5cda
X-MS-TrafficTypeDiagnostic: DM6PR02MB4012:
X-Microsoft-Antispam-PRVS: <DM6PR02MB40123EB816DECE48F0E85CFAB5880@DM6PR02MB4012.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOLC08M0v/nwMYqTnGCjQUSRoquQ0hH0ziJl8YOzVngrzedpISIu6PTC7b/EWY3p6jYAhEgr1e94g4uJZym2q5/KEHhc9bcyCECbI9cfpvbL7WzKbAT9B3UpnXam3B+Q2tlngX7mv3Pwk3DyA0BAMxKMW07/uhtJeq3MWPragqM8Lww/MzkbTwgEK43OqnoJGeebW5bN7gu9MnTf8NFyp+r7ytVVsp7xfagzXzcVQGBho0S747KnAOa1jo4mW72rdwkI8H3PlejIETU7Bx++c4YfD+oHbx0PswJkaQ4WqczRFUcC5k4ECVVY1rmLjeX/dYbDy7SnXOoZ4kS7Z1s1UwFK4lO1/0tryepNgO08tPi5AaSMv6wPo162sKCpp+4ql/c/gZQ6nlGoVXgKDdOfxg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 14:49:48.0291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cba284b-1a48-4e2b-3df7-08d807cd5cda
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4012
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
index 5968df8..bb347df 100644
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
2.7.4

