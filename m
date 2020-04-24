Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E95C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E612166E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JqFkQMc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDXU6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:58:39 -0400
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:3200
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbgDXU60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:58:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayUETFL725WHvYqWEkBxycImH9yVSolAqqAEOOETXjaBiJr4XfaqwRxUNYRrbbPt6JhNngeBe6NHJX3OCzK7ghSwygu7haiNbdBMlF6ckMt6yiO1r9Pgxit7O1+nHlNKlDlWCtuyTucP4bvgcDBRLDApOBBqswK/6HktzCiOOJe39ejDKEzvdP200sOloUDaZfa5JGxayPpxLxjZIrg2i5O0f734x5TfvNdG9tUgD2RuU9AkhEbKn5e4TIQmNG+uDGTFZjujhg+9sQqgymTEYE8pVZKMeNIuIh/LOSnYDBisEvMv3jw53c1E19LGFsW/XP0S8TinRPM9xaIfvodHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Wn0MOr//dSvPxJzOp7hW7sFwpMBUymVIfq0k0171Nk=;
 b=IGUcD4EW8WFiu5sgsFD9L5NkrZOgLpajJGLC0njFu49n0oBqm7Jr9utoG+CV0A18afv8XWO4cWH+7FwiiuyOrMQDuVyaLMYGHz6b2f2vjKsjyiW6yYS1BQx+p7Yh2wJVRo9FEUxvsV0xaFw4noBysm2lXoEiaCmJWeIEqfcJEmq35/IIXC1+IVM9/5PU8p+Z/fYXwUOnduG8PVV7RXQzG7JdWYqERuMH0Ajx1SVfZv00PVPDZed8nuFDNzWjxxa5j/Q6XOVJ3IQEUhpKCir2rRMPjVA/8c7kMuA9q4L61lpyTCwirSQL7edgSEy7ASwq6MwSnVCNa8/s+NQXeBmzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Wn0MOr//dSvPxJzOp7hW7sFwpMBUymVIfq0k0171Nk=;
 b=JqFkQMc2WHp5D3WugXnqLSBNeYFeIzAe4kSpGyW6qFtlQ5oMXv8QuPE2mVIvV3vcYYSkB6Tf5c4tjT3skY/vmR0/ltUfDjJfcwLNUafqkvuOIXvR/Zicy+nudtS8UUsa9PcAerH0GZZ47zSZTX2I65TarcxV67fHKyWFyUrhmIU=
Received: from SN4PR0201CA0025.namprd02.prod.outlook.com
 (2603:10b6:803:2e::11) by BN6PR02MB3265.namprd02.prod.outlook.com
 (2603:10b6:405:62::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.30; Fri, 24 Apr
 2020 20:58:22 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2e:cafe::27) by SN4PR0201CA0025.outlook.office365.com
 (2603:10b6:803:2e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Fri, 24 Apr 2020 20:58:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Fri, 24 Apr 2020 20:58:21
 +0000
Received: from [149.199.38.66] (port=33266 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Nm-0002Cq-8E; Fri, 24 Apr 2020 13:57:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Ov-0007N4-7Y; Fri, 24 Apr 2020 13:58:21 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03OKwJUO026317;
        Fri, 24 Apr 2020 13:58:19 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jS5Os-0007Lo-Vj; Fri, 24 Apr 2020 13:58:19 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v5 06/25] firmware: xilinx: Remove eemi ops for clock_getstate
Date:   Fri, 24 Apr 2020 13:57:48 -0700
Message-Id: <1587761887-4279-7-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
References: <1587761887-4279-1-git-send-email-jolly.shah@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966005)(6666004)(54906003)(2616005)(82310400002)(70586007)(81166007)(316002)(9786002)(5660300002)(36756003)(70206006)(426003)(82740400003)(7416002)(336012)(478600001)(2906002)(44832011)(7696005)(47076004)(186003)(8676002)(356005)(6636002)(81156014)(107886003)(26005)(8936002)(4326008);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 703376ff-10dd-4e7f-601c-08d7e89238fd
X-MS-TrafficTypeDiagnostic: BN6PR02MB3265:
X-Microsoft-Antispam-PRVS: <BN6PR02MB3265E9F8D3ED71F1623918F8B8D00@BN6PR02MB3265.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 03838E948C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4vekZNH/OVPRtfz8tzxwWBoinJKSvke3pp4GiDYq2zNcgXGzRlKsJ/rzaYKSKNcaM/13SL8bIPYfgad88C1Jv9RZiRP3EyBtY6XgG7rOxY1zpS2m88NBvyXkHRXEl3BoHNpe7xGQJLElhjo8eCVjCi8/wHjvEQgWB8LqjeRyIBPcUVbptLM19KQp3hY8ZQjmKa+6arV1Q3pwRFmzrhAChBcZdW6KUFh4HRVDMgMVTbBvm2pByCJqdkCxHJ8CCu8uh88pWu8gXY/7qeENTSkQKpwnTkBs2jSWoA7RYU1TcK7KYp07c5kS3m2BOIoLDSMORm7bj7DfeKNZ7sAUhDu0heaeFZE+0seFNqGsRTzSVFBRSiCwVS2Dzxx8VaOFMRolN5ot7fdssHs1SGcg64iSbW/daI+cHD/MgFPUbXi+RQoBmmEy0ZXO6m1IYhJZ/ZSqZFeW1Ej9/qHEQyXyGYCtsJ1v50KseQSpCJWxN9RBpusRP5LyByVZLJbalA1lK3JGSCLNUPkMnonFs1eDzxpwQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 20:58:21.5063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703376ff-10dd-4e7f-601c-08d7e89238fd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3265
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of eemi ops for clock_getstate.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/clk-gate-zynqmp.c | 3 +--
 drivers/clk/zynqmp/pll.c             | 3 +--
 drivers/firmware/xilinx/zynqmp.c     | 4 ++--
 include/linux/firmware/xlnx-zynqmp.h | 6 +++++-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
index 11f1b97..10c9b88 100644
--- a/drivers/clk/zynqmp/clk-gate-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -77,9 +77,8 @@ static int zynqmp_clk_gate_is_enabled(struct clk_hw *hw)
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 clk_id = gate->clk_id;
 	int state, ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_getstate(clk_id, &state);
+	ret = zynqmp_pm_clock_getstate(clk_id, &state);
 	if (ret) {
 		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 38b8dbc..41f376a 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -222,9 +222,8 @@ static int zynqmp_pll_is_enabled(struct clk_hw *hw)
 	u32 clk_id = clk->clk_id;
 	unsigned int state;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_getstate(clk_id, &state);
+	ret = zynqmp_pm_clock_getstate(clk_id, &state);
 	if (ret) {
 		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index d884805..c11b528 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -382,7 +382,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_disable);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
@@ -393,6 +393,7 @@ static int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getstate);
 
 /**
  * zynqmp_pm_clock_setdivider() - Set the clock divider for given id
@@ -739,7 +740,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.clock_getstate = zynqmp_pm_clock_getstate,
 	.clock_setdivider = zynqmp_pm_clock_setdivider,
 	.clock_getdivider = zynqmp_pm_clock_getdivider,
 	.clock_setrate = zynqmp_pm_clock_setrate,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index f9a84d9..e874f0c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,7 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*clock_getstate)(u32 clock_id, u32 *state);
 	int (*clock_setdivider)(u32 clock_id, u32 divider);
 	int (*clock_getdivider)(u32 clock_id, u32 *divider);
 	int (*clock_setrate)(u32 clock_id, u64 rate);
@@ -331,6 +330,7 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
 int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
 int zynqmp_pm_clock_enable(u32 clock_id);
 int zynqmp_pm_clock_disable(u32 clock_id);
+int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -357,6 +357,10 @@ static inline int zynqmp_pm_clock_disable(u32 clock_id)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

