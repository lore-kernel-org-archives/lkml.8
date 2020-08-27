Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC854C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D30207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="acncFKpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH0B6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:58:25 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:14689
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgH0B6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blHZaa6ysY8cIeH1KakjHEBNXLe77d7rUekkf80MKH8q8HmA8CI2x1YR6MuezjQDdU/+/TNOik0KsggMlppYBC1W3XOxTCbsMq1PHcQUkMcVsohVxtSAXNWSgjk6MH2OdxYoTdA1I3z3BvjWMnviZvZJ9ddvtkS5hfGRpwh2xomqhSPuXlEDM0yeena/LkvucY5Fr3MPCO/gzQHw+Xxc6g1I27KsvWesDNqD7BXUP0iQZGuN7q3glv7tAGsJMs5i2sSBVqR93kE1Zp7PZEDjmjqXWlbvuoKXsjxdWPWz94Dg16sTMuy3eAsb9IqhMTs0QHqFKOnfaedmtZFC5DMnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACCp6JV+gTdHi5tkf1gwDE9thBTYm9bd6ENG4orHBfk=;
 b=ckd/6/PioS8P5Wc6tK0Czxcdfv93WZHWA/RlvOktg6lAiDXFjxvk5K3lQWTOKqiiPc2/iObid0V3XzjPcVYuRxSomMW20YNPC1x7Nl8MdNQRBtGnfrKzpWhEAWD0rARllMzCSNlKOAQnOVSq2rGL6dKh4dcxv8FfEyOCiZgy0a4+XDswF6IONVCKOi+MahcLCSMmxf85OsR8gtXVSS9FvKuyyPSA1FU36za/af7wP9BmA7SAP6/63N3O1x2PMGKJVOF5hPpo4OHQDADic90YCGePp7vgwkenwM3kkgvcDXwjEp2+XLpbUtwTuUK4bUKEd8Nf9we5YMaob+pzTeub6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACCp6JV+gTdHi5tkf1gwDE9thBTYm9bd6ENG4orHBfk=;
 b=acncFKpJ04zO8GRiGaj6wcsejts38S/CbYGAB8QPKvo1KxfrLIZKLf/NQVLTns/DtmiC2oDh+vescE2UIv+V2XuCUjmRuU3Ptj4FHC2KkP7NeQ1oUc9m46xUtKAVy6KTCDdOymPZvS8fRy2dTAf8SuDmZi2Zrv1sdlDsTGvMtKI=
Received: from SA9PR11CA0025.namprd11.prod.outlook.com (2603:10b6:806:6e::30)
 by DM6PR02MB4972.namprd02.prod.outlook.com (2603:10b6:5:18::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 01:58:16 +0000
Received: from SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::de) by SA9PR11CA0025.outlook.office365.com
 (2603:10b6:806:6e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 01:58:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT013.mail.protection.outlook.com (10.152.72.98) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 01:58:15
 +0000
Received: from [149.199.38.66] (port=58670 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7Ad-0002AF-9G; Wed, 26 Aug 2020 18:57:43 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7B8-000183-TU; Wed, 26 Aug 2020 18:58:14 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07R1wAe0007536;
        Wed, 26 Aug 2020 18:58:11 -0700
Received: from [172.19.2.206] (helo=xsjblevinsk50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <ben.levinsky@xilinx.com>)
        id 1kB7B4-000155-S8; Wed, 26 Aug 2020 18:58:10 -0700
From:   Ben Levinsky <ben.levinsky@xilinx.com>
To:     stefano.stabellini@xilinx.com, michals@xilinx.com,
        michael.auchter@ni.com
Cc:     devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        emooring@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10 3/5] firmware: xilinx: Add RPU configuration APIs
Date:   Wed, 26 Aug 2020 18:58:08 -0700
Message-Id: <20200827015810.11157-4-ben.levinsky@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827015810.11157-1-ben.levinsky@xilinx.com>
References: <20200827015810.11157-1-ben.levinsky@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d5b40feb-493b-421f-2623-08d84a2ca949
X-MS-TrafficTypeDiagnostic: DM6PR02MB4972:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4972DE3A4C3467AADB2C8D7AB5550@DM6PR02MB4972.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgLce8ZOkY3vL1h4T53lHvNixDSpYHtcI4g8kHhDm10uuoCI3jZW9rRYQCq5UQxhZdFAG8JVyH4cGsm/tdqi5yo9hKmi6pyO8/aMA3y16jYtcZsGHCUMCRNHBFgqm7oL7C5gmzATUE2Z+6tjlrpyBklnprUebizSjld4ks2fH6nyQ40h4TXLLMnDWKySHTeA9EpBtO6pTD1AjoYC2lwmBAfNrlJQV6nIPi0oRSE2gzgC9HKWoH7SoTnz1qxOFLECdQgP1F61vxetb7CujieFsKSheAud0MT3zkhKCE6Qr2wYtRy0lF/aBnTro94lzZEScYTcHzdevl28+uHNlxnXGVV24NnLx6YbGYLRysmdvwUOSGXK9VfH3WP+HYj/MKjYLcWdtwNhyI74D68OIqPMrQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(39860400002)(46966005)(70586007)(70206006)(426003)(2906002)(336012)(5660300002)(4326008)(478600001)(9786002)(26005)(186003)(82310400002)(8676002)(82740400003)(81166007)(7696005)(356005)(83380400001)(47076004)(2616005)(316002)(44832011)(1076003)(8936002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 01:58:15.1995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b40feb-493b-421f-2623-08d84a2ca949
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4972
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds APIs to access to configure RPU and its
processor-specific memory.

That is query the run-time mode of RPU as either split or lockstep as well
as API to set this mode. In addition add APIs to access configuration of
the RPUs' tightly coupled memory (TCM).

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
---
v3:
- add xilinx-related platform mgmt fn's instead of wrapping around
  function pointer in xilinx eemi ops struct
v4:
- add default values for enums
v9:
- update commit message
- for zynqmp_pm_set_tcm_config and zynqmp_pm_get_rpu_mode update docs for
  expected output, arguments as well removing unused args
- remove unused fn zynqmp_pm_get_node_status
---
 drivers/firmware/xilinx/zynqmp.c     | 51 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 22 ++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a966ee956573..6907abcaa981 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -846,6 +846,57 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_get_rpu_mode() - Get RPU mode
+ * @node_id:	Node ID of the device
+ * @out:	Returned output value
+ *
+ * Return: RPU mode. This is enum rpu_oper_mode
+ */
+int zynqmp_pm_get_rpu_mode(u32 node_id, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_GET_RPU_OPER_MODE, 0, 0, out);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
+
+/**
+ * zynqmp_pm_set_rpu_mode() - Set RPU mode
+ * @node_id:	Node ID of the device
+ * @arg1:	Argument 1 to requested IOCTL call. This is expeted to
+ *              to be value from enum rpu_oper_mode
+ * @out:	Returned output value
+ *
+ * This function is used to set RPU mode to split or lockstep
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_set_rpu_mode(u32 node_id,
+			   u32 arg1, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_SET_RPU_OPER_MODE, arg1, 0, out);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
+
+/**
+ * zynqmp_pm_set_tcm_config - configure TCM
+ * @arg1:	Argument 1 to requested IOCTL call
+ *              either PM_RPU_TCM_COMB or PM_RPU_TCM_SPLIT
+ * @out:	Returned output value
+ *
+ * This function is used to set RPU mode to split or combined
+ *
+ * Return: status: 0 for success, else failure
+ */
+int zynqmp_pm_set_tcm_config(u32 node_id,
+			     u32 arg1, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
+				   IOCTL_TCM_COMB_CONFIG, arg1, 0, out);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
+
 /**
  * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
  *             be powered down forcefully
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 6241c5ac51b3..c9977d890095 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -385,6 +385,11 @@ int zynqmp_pm_request_wake(const u32 node,
 			   const bool set_addr,
 			   const u64 address,
 			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_get_rpu_mode(u32 node_id, u32 *out);
+int zynqmp_pm_set_rpu_mode(u32 node_id,
+			   u32 arg1, u32 *out);
+int zynqmp_pm_set_tcm_config(u32 node_id,
+			     u32 arg1, u32 *out);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -549,6 +554,23 @@ static inline int zynqmp_pm_request_wake(const u32 node,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_get_rpu_mode(u32 node_id, u32 *out)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_rpu_mode(u32 node_id,
+					 u32 arg1, u32 *out)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_set_tcm_config(u32 node_id,
+					   u32 arg1, u32 *out)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.17.1

