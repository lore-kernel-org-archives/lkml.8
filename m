Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAE6C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1377A21D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jTrND0St"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgIJCAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgIJBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:37:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2D0C061345
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgNOaHyOXBCIsNWiNSZ+QnxF4nvnjUfqO100x0IQObKjnHSmbdXZJE/U+CC3WUM4diLQIsFfv/EWzdYCoOvFBAD0GmwQpN/125KpKDZeStlLp4pu89Rn73dXif3/t8OSU3g4aVB9YN4f52ULr4+qdztz6g9NH7IYMh3ZL8FHe5WbazuJGtzbv2O2XURHUyKvsW4OUWxkVntJJs5q+bbBqUTGuJV9JTHv5ziS8MuFw2Qq/MKE9ZqNbjiNfOfMyV8OxqzCmV6I0I5HnA31SYFcQmg2oL8ZZ8BWHlc8Awgm2NC/FFOO9CF+xOeu76F3ftOR3Pp27DnpQrmCxEZVkwcvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4qgcsxwL1pyNoSkL4sAWpCgU7raFfiiSG5cGLfWf8I=;
 b=fOVXiiccVCP0arhVN6fwMmm9HFc5ULxEjpopH+PrclwKS+utHW0H33Mj+w3g9jMINGjE6/rRV2rwkTHFUhHUDht2CK7yyjAokBni2s/fiRU7uzdkXL4N6c7JIBAEvTK68CWF/BVCwi7MhBktb4taXJJZQhBb1Vwq33qIM564TMmMZjc3bLrxCynEygXeYS6xjcFtgCBkGiumjn6Sti6TiARri7S5b1I021sV+TAmMebAm1rttHjdap+gnh7vuPm7kEX/7cJxeKcevzVSSdL4ZQI+Sp4t9n+UQwMJ4WRCvtYGegB5ZFGtiAQDtV5wQA9iZBBIP09rUINWJV32hp8RtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4qgcsxwL1pyNoSkL4sAWpCgU7raFfiiSG5cGLfWf8I=;
 b=jTrND0StFrHbxEHfaS0MANYXY6QDrs7hmYS5AA6up6pwGwlZ8G12U0/HCJp/F03y3mA1JfEwpabFu6Hn2QfosZBk1xCyxfYYddTNve2hwVmMsxD1nA84NMaGGe5s4uM0eTuFS96JVpOy51FuaKedLP4JeEwCVgacVW6O/wdwYSc=
Received: from SN6PR05CA0017.namprd05.prod.outlook.com (2603:10b6:805:de::30)
 by DM5PR02MB3372.namprd02.prod.outlook.com (2603:10b6:4:63::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 00:20:22 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::90) by SN6PR05CA0017.outlook.office365.com
 (2603:10b6:805:de::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Thu, 10 Sep 2020 00:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 00:20:21
 +0000
Received: from [149.199.38.66] (port=47475 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJp-0007Mk-85; Wed, 09 Sep 2020 17:20:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAK5-0006hf-M9; Wed, 09 Sep 2020 17:20:21 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08A0K6a3001925;
        Wed, 9 Sep 2020 17:20:08 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJq-0006Dg-3G; Wed, 09 Sep 2020 17:20:06 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, tejas.patel@xilinx.com, jollys@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH 2/3] firmware: xilinx: Add support for GET_LAST_RESET_REASON IOCTL
Date:   Wed,  9 Sep 2020 17:20:03 -0700
Message-Id: <1599697204-32103-3-git-send-email-amit.sunil.dhamne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599697204-32103-1-git-send-email-amit.sunil.dhamne@xilinx.com>
References: <1599697204-32103-1-git-send-email-amit.sunil.dhamne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 66949870-ea4d-4cc1-49c8-08d8551f4e58
X-MS-TrafficTypeDiagnostic: DM5PR02MB3372:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3372DF433BF57528690CBDECA7270@DM5PR02MB3372.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3fb8N4/+a2aMiPABAOJC27KtIiKaHKpeV5QM/Nc2EGwabO4dsIxfx8lfJAcEyWzJIFnWS06mn+kILbvMt974tHXi7VVJ8ixwZgXH73kC1r8ao038heAKF/utxioEswl4Ot/DrSof3KPJ7tVXuxtROXnDSOHWT13S92J2e3ZXRikhFR1tyLXRltXFgDu603+1sFH1Qlhld6Tght6nF6vRmKRcO1kNxlI3gsqwN2+7nA3yatO1vJRiXbu5qPeN/p0VC9Z+JihpsTDAUKRkOZspTpmqiv2OGf+PeNPujN6lR5mQVHLySS5SZviDfrknrai+mtbOVV8dwt+J4BkoTt4Ye1+UJv9IwN0jNxfd5Z9VkmyvPhdejctBSXLLDJNa4w/55yWOpMgPAWE2MvgQx/DvgZStTCMlh+29bAAvImVHRQw=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39860400002)(46966005)(478600001)(5660300002)(7696005)(426003)(8676002)(6666004)(82740400003)(81166007)(47076004)(70206006)(70586007)(26005)(7416002)(2906002)(36756003)(4326008)(6636002)(9786002)(316002)(2616005)(186003)(107886003)(336012)(8936002)(356005)(83380400001)(82310400003)(921003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 00:20:21.9541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66949870-ea4d-4cc1-49c8-08d8551f4e58
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Add support to get last reason using IOCTL API. Also validate IOCTL
ID for Versal or ZynqMP platforms before calling
zynqmp_pm_invoke_fn().

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zyn=
qmp.c
index 8fe0912..c5db34f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -533,6 +533,7 @@ static inline int versal_is_valid_ioctl(u32 ioctl_id)
        case IOCTL_WRITE_PGGS:
        case IOCTL_READ_PGGS:
        case IOCTL_SET_BOOT_HEALTH_STATUS:
+       case IOCTL_GET_LAST_RESET_REASON:
                return 1;
        default:
                return 0;
@@ -772,6 +773,25 @@ int zynqmp_pm_set_boot_health_status(u32 value)
 }

 /**
+ * zynqmp_pm_get_last_reset_reason() - PM API for getting last reset reaso=
n
+ *
+ * @reset_reason:      last reset reason
+ *
+ * This function returns last reset reason
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_get_last_reset_reason(u32 *reset_reason)
+{
+       if (!reset_reason)
+               return -EINVAL;
+
+       return zynqmp_pm_ioctl(0, IOCTL_GET_LAST_RESET_REASON, 0, 0,
+                              reset_reason);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_last_reset_reason);
+
+/**
  * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - rele=
ase)
  * @reset:             Reset to be configured
  * @assert_flag:       Flag stating should reset be asserted (1) or
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/=
xlnx-zynqmp.h
index 5968df8..90c8664 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -116,6 +116,8 @@ enum pm_ioctl_id {
        IOCTL_READ_PGGS =3D 15,
        /* Set healthy bit value */
        IOCTL_SET_BOOT_HEALTH_STATUS =3D 17,
+       /* IOCTL to get last reset reason */
+       IOCTL_GET_LAST_RESET_REASON =3D 23,
 };

 enum pm_query_id {
@@ -357,6 +359,7 @@ int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
+int zynqmp_pm_get_last_reset_reason(u32 *reset_reason);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -507,6 +510,10 @@ static inline int zynqmp_pm_set_boot_health_status(u32=
 value)
 {
        return -ENODEV;
 }
+static inline int zynqmp_pm_get_last_reset_reason(u32 *reset_reason)
+{
+       return -ENODEV;
+}
 #endif

 #endif /* __FIRMWARE_ZYNQMP_H__ */
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
