Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35530C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB97321D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VKEofA2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgIJCAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgIJBhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:37:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3278C061342
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgwNJtwb7/FcApGP+5kHK9+ynaK9mCDErjpGf0oGgZKQ4RAYasDSbxT2dhBBdvd2YTYQXZvI1icoHsj0RMMuQmrCxk0e2YGbt6ptJQ15p4VD8boQDf5ED4gcbp1IwbZQS8aLQv6bN6kp4gnZpvBLkb/zzllL6+xm9EMryIO6Oa+WxSLYOm4o/sz/1oYvQ/TXbYFIp+eBb28lFzeqceOfsMoNQoI4+LZWIfCQupjch0Z/xOjWRtz5Efz0ovPyOTZ7g1MyM9HIC/byxpUWiLq2hcToJTgAs9G7s3/J5uIZIn52SC4sdCihgthrLTT1z2VqS1kLhz5KnBRVtDU1PChwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k34GbCKNhs5oVWSpXkK5XyHxD3fgz/UVd2dZGEfcxBE=;
 b=XvhHBSBz6gT0QviTSQcE5XuzsnpgYxevj//pxB5RTOILKGtSB49qJaeMkufihXSTioRGgmEx+O+2EOAq2/SbV607a9Nc3DmOWtB1pHN92bXU4sfvsYd3EbXMPfNN3jTiziSO+bn3CuqaA/pyNyHvelcqKu8A1/RLzjuDgAiCrTs+qEO9NCfx2OpDVn6ANQpEKe7vuRUMkCtf+v657ROyOH9R1fVjM63G5IgTqB0rfv+97vARvc3yk++3oUQzmCaHaTkUTo8+tueN4bG/yaPnuz2a3vcvTYEtcw82gbp6NVmvud4bRPV4HDsrs03QxGjf/3JKCqksI/Jl9QLHK9pk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k34GbCKNhs5oVWSpXkK5XyHxD3fgz/UVd2dZGEfcxBE=;
 b=VKEofA2OLHKteMWxOJtpohVW+Cdnxzo/3Rox9MLIpMuo15FC3sby/M6ya+jcHYM9wcH4avYRZ3dEHpnw02x87Nc2IF3FX8wVoKRwlvQPrkGoNRhzWKRU83jAnct7Ld/mXvkA8GEte5hyM8tmbmVtfgmoCfHuByCRnwsAndWyxLM=
Received: from CY4PR04CA0046.namprd04.prod.outlook.com (2603:10b6:903:c6::32)
 by SN6PR02MB4319.namprd02.prod.outlook.com (2603:10b6:805:ac::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 00:20:13 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:c6:cafe::77) by CY4PR04CA0046.outlook.office365.com
 (2603:10b6:903:c6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 00:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Thu, 10 Sep 2020 00:20:11
 +0000
Received: from [149.199.38.66] (port=46259 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJf-0007M4-4S; Wed, 09 Sep 2020 17:19:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJv-0006Qx-HQ; Wed, 09 Sep 2020 17:20:11 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08A0K6Dd001924;
        Wed, 9 Sep 2020 17:20:06 -0700
Received: from [10.18.5.8] (helo=xsjamitsuni51.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.sunil.dhamne@xilinx.com>)
        id 1kGAJq-0006Dg-0i; Wed, 09 Sep 2020 17:20:06 -0700
From:   Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, tejas.patel@xilinx.com, jollys@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, jolly.shah@xilinx.com,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Subject: [PATCH 1/3] firmware: xilinx: Add validation check for IOCTL
Date:   Wed,  9 Sep 2020 17:20:02 -0700
Message-Id: <1599697204-32103-2-git-send-email-amit.sunil.dhamne@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14c5ebb9-c08e-4049-1352-08d8551f484b
X-MS-TrafficTypeDiagnostic: SN6PR02MB4319:
X-Microsoft-Antispam-PRVS: <SN6PR02MB43195DD378AF1A61FD6235B7A7270@SN6PR02MB4319.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6U9fJgUYmWTpHB4GdC/MXniwipBn8L+mMleBaS6zmlObiiN7eYYXeyL/bg+rn2FTDk2AqD5CQ1ZLXIp1Bztgeqtf2ZS7WZobZ0LRVPf+KYb82KlBqOFWegywYKRnzTRN9iNnZJ6MKhN78KD8pOF8ZGniY9JJnLcCSyc05roUv2eD40mKMzCj7OnmxweDBrIqo/kWhT41F710pVJlJyW/l4CfFx9zvGbspY8Ox1zePqiyiwB8UHxfjdN9W8CBzeKyL/YCvTnG55rmeNE9/aOAk9BxNMPV20/ytd8+L10+CAedjzIm3i8DtGi8tpLCPY8syYue+PDuzLZmM+XsNNgeB3AaObex5/to4hDf0LS0AYy7fyk+w06E313uqiY3sL3ZrRl1jMJTps1kVBZkNX+QrwTE1rtltCs7qTbGKHvva34=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(346002)(376002)(39860400002)(136003)(396003)(46966005)(426003)(6666004)(82740400003)(6636002)(2616005)(316002)(478600001)(336012)(7696005)(8936002)(107886003)(5660300002)(2906002)(70206006)(4326008)(8676002)(70586007)(186003)(356005)(26005)(7416002)(83380400001)(47076004)(36756003)(82310400003)(81166007)(9786002)(921003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 00:20:11.8022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c5ebb9-c08e-4049-1352-08d8551f484b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Patel <tejas.patel@xilinx.com>

Validate IOCTL ID for ZynqMP and Versal before calling
zynqmp_pm_invoke_fn().

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 117 +++++++++++++++++++++++++++++++----=
----
 1 file changed, 95 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zyn=
qmp.c
index 8d1ff24..8fe0912 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -514,6 +514,89 @@ int zynqmp_pm_clock_getparent(u32 clock_id, u32 *paren=
t_id)
 EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);

 /**
+ * versal_is_valid_ioctl() - Check whether IOCTL ID is valid or not for ve=
rsal
+ * @ioctl_id:  IOCTL ID
+ *
+ * Return: 1 if IOCTL is valid else 0
+ */
+static inline int versal_is_valid_ioctl(u32 ioctl_id)
+{
+       switch (ioctl_id) {
+       case IOCTL_SD_DLL_RESET:
+       case IOCTL_SET_SD_TAPDELAY:
+       case IOCTL_SET_PLL_FRAC_MODE:
+       case IOCTL_GET_PLL_FRAC_MODE:
+       case IOCTL_SET_PLL_FRAC_DATA:
+       case IOCTL_GET_PLL_FRAC_DATA:
+       case IOCTL_WRITE_GGS:
+       case IOCTL_READ_GGS:
+       case IOCTL_WRITE_PGGS:
+       case IOCTL_READ_PGGS:
+       case IOCTL_SET_BOOT_HEALTH_STATUS:
+               return 1;
+       default:
+               return 0;
+       }
+}
+
+/**
+ * zynqmp_is_valid_ioctl() - Check whether IOCTL ID is valid or not
+ * @ioctl_id:  IOCTL ID
+ *
+ * Return: 1 if IOCTL is valid else 0
+ */
+static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
+{
+       switch (ioctl_id) {
+       case IOCTL_SD_DLL_RESET:
+       case IOCTL_SET_SD_TAPDELAY:
+       case IOCTL_SET_PLL_FRAC_MODE:
+       case IOCTL_GET_PLL_FRAC_MODE:
+       case IOCTL_SET_PLL_FRAC_DATA:
+       case IOCTL_GET_PLL_FRAC_DATA:
+       case IOCTL_WRITE_GGS:
+       case IOCTL_READ_GGS:
+       case IOCTL_WRITE_PGGS:
+       case IOCTL_READ_PGGS:
+       case IOCTL_SET_BOOT_HEALTH_STATUS:
+               return 1;
+       default:
+               return 0;
+       }
+}
+
+/**
+ * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
+ * @node_id:   Node ID of the device
+ * @ioctl_id:  ID of the requested IOCTL
+ * @arg1:      Argument 1 to requested IOCTL call
+ * @arg2:      Argument 2 to requested IOCTL call
+ * @out:       Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configurat=
ion.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+                          u32 *out)
+{
+       struct device_node *np;
+
+       np =3D of_find_compatible_node(NULL, NULL, "xlnx,versal");
+       if (np) {
+               if (!versal_is_valid_ioctl(ioctl_id))
+                       return -EINVAL;
+       } else {
+               if (!zynqmp_is_valid_ioctl(ioctl_id))
+                       return -EINVAL;
+       }
+       of_node_put(np);
+
+       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id, arg1, arg2,
+                                  out);
+}
+
+/**
  * zynqmp_pm_set_pll_frac_mode() - PM API for set PLL mode
  *
  * @clk_id:    PLL clock ID
@@ -525,8 +608,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
  */
 int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_MODE,
-                                  clk_id, mode, NULL);
+       return zynqmp_pm_ioctl(0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode, NU=
LL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);

@@ -542,8 +624,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
  */
 int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_MODE,
-                                  clk_id, 0, mode);
+       return zynqmp_pm_ioctl(0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0, mode)=
;
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);

@@ -560,8 +641,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
  */
 int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_DATA,
-                                  clk_id, data, NULL);
+       return zynqmp_pm_ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, data, NU=
LL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);

@@ -577,8 +657,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
  */
 int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_DATA,
-                                  clk_id, 0, data);
+       return zynqmp_pm_ioctl(0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0, data)=
;
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);

@@ -595,8 +674,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
  */
 int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_SD_TAPDELAY=
,
-                                  type, value, NULL);
+       return zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY, type, value,
+                              NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);

@@ -612,8 +691,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
  */
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_SD_TAPDELAY=
,
-                                  type, 0, NULL);
+       return zynqmp_pm_ioctl(node_id, IOCTL_SET_SD_TAPDELAY, type, 0, NUL=
L);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);

@@ -628,8 +706,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
  */
 int zynqmp_pm_write_ggs(u32 index, u32 value)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_GGS,
-                                  index, value, NULL);
+       return zynqmp_pm_ioctl(0, IOCTL_WRITE_GGS, index, value, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);

@@ -644,8 +721,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
  */
 int zynqmp_pm_read_ggs(u32 index, u32 *value)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_GGS,
-                                  index, 0, value);
+       return zynqmp_pm_ioctl(0, IOCTL_READ_GGS, index, 0, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);

@@ -661,8 +737,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
  */
 int zynqmp_pm_write_pggs(u32 index, u32 value)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_PGGS, index, va=
lue,
-                                  NULL);
+       return zynqmp_pm_ioctl(0, IOCTL_WRITE_PGGS, index, value, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);

@@ -678,8 +753,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
  */
 int zynqmp_pm_read_pggs(u32 index, u32 *value)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_PGGS, index, 0,
-                                  value);
+       return zynqmp_pm_ioctl(0, IOCTL_READ_PGGS, index, 0, value);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);

@@ -694,8 +768,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
  */
 int zynqmp_pm_set_boot_health_status(u32 value)
 {
-       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_BOOT_HEALTH_STATU=
S,
-                                  value, 0, NULL);
+       return zynqmp_pm_ioctl(0, IOCTL_SET_BOOT_HEALTH_STATUS, value, 0, N=
ULL);
 }

 /**
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
