Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8470EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59241207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eJk3qKcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgEUPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:16:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38236 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbgEUPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:16:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LFGfpH106524;
        Thu, 21 May 2020 10:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590074201;
        bh=FLX5BGiA2jzuKm0fysF7agio1KGEJZtEH0AKo+Wdr1Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eJk3qKcMN3dfTb4mMrz5CVeXkKL8CcuoSQLKIBqCn3RKDiReQGk/ckt8d8AcJ8oOG
         mbKrKy0FysIE/VRUWTxtYi8Xc5uE8v3I/m6kzHfK+3VLydKq+qhjlbxrIkitveZkyJ
         8sDONOA6Xhha8GavDKSakG3o7YOQmL8GGPwBmM7Q=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LFGf6g035534;
        Thu, 21 May 2020 10:16:41 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 10:16:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 10:16:41 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LFGfQH071720;
        Thu, 21 May 2020 10:16:41 -0500
Received: from localhost ([10.250.48.148])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 04LFGfwq076181;
        Thu, 21 May 2020 10:16:41 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 2/2] remoteproc/k3-dsp: Add support for C71x DSPs
Date:   Thu, 21 May 2020 10:16:36 -0500
Message-ID: <20200521151636.28260-3-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200521151636.28260-1-s-anna@ti.com>
References: <20200521151636.28260-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Texas Instrument's K3 J721E SoCs have a newer next-generation
C71x DSP Subsystem in the MAIN voltage domain in addition to the
previous generation C66x DSP subsystems. The C71x DSP subsystem is
based on the TMS320C71x DSP CorePac module. The C71x CPU is a true
64-bit machine including 64-bit memory addressing and single-cycle
64-bit base arithmetic operations and supports vector signal processing
providing a significant lift in DSP processing power over C66x DSPs.
J721E SoCs use a C711 (a one-core 512-bit vector width CPU core) DSP
that is cache coherent with the A72 Arm cores.

Each subsystem has one or more Fixed/Floating-Point DSP CPUs, with 32 KB
of L1P Cache, 48 KB of L1D SRAM that can be configured and partitioned as
either RAM and/or Cache, and 512 KB of L2 SRAM configurable as either RAM
and/or Cache. The CorePac also includes a Matrix Multiplication Accelerator
(MMA), a Stream Engine (SE) and a C71x Memory Management Unit (CMMU), an
Interrupt Controller (INTC) and a Powerdown Management Unit (PMU) modules.

Update the existing K3 DSP remoteproc driver to add support for this C71x
DSP subsystem. The firmware loading support is provided by using the newly
added 64-bit ELF loader support, and is limited to images using only
external DDR memory at the moment. The L1D and L2 SRAMs are used as scratch
memory when using as RAMs, and cannot be used for loadable segments. The
CMMU is also not supported to begin with, and the driver is designed to
treat the MMU as if it is in bypass mode.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v2: 
 - k3_dsp_rproc_prepare/unprepare plugged in dynamically based on local reset,
   C71x doesn't use local resets
 - Dropped the sanity_check ops override, not needed on latest codebase
v1: https://patchwork.kernel.org/patch/11458595/

 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 610fbbf85ee6..2dbed316b6ac 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -406,8 +406,6 @@ static void *k3_dsp_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
 }
 
 static const struct rproc_ops k3_dsp_rproc_ops = {
-	.prepare	= k3_dsp_rproc_prepare,
-	.unprepare	= k3_dsp_rproc_unprepare,
 	.start		= k3_dsp_rproc_start,
 	.stop		= k3_dsp_rproc_stop,
 	.kick		= k3_dsp_rproc_kick,
@@ -617,6 +615,10 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 
 	rproc->has_iommu = false;
 	rproc->recovery_disabled = true;
+	if (data->uses_lreset) {
+		rproc->ops->prepare = k3_dsp_rproc_prepare;
+		rproc->ops->unprepare = k3_dsp_rproc_unprepare;
+	}
 	kproc = rproc->priv;
 	kproc->rproc = rproc;
 	kproc->dev = dev;
@@ -744,6 +746,12 @@ static const struct k3_dsp_mem_data c66_mems[] = {
 	{ .name = "l1dram", .dev_addr = 0xf00000 },
 };
 
+/* C71x cores only have a L1P Cache, there are no L1P SRAMs */
+static const struct k3_dsp_mem_data c71_mems[] = {
+	{ .name = "l2sram", .dev_addr = 0x800000 },
+	{ .name = "l1dram", .dev_addr = 0xe00000 },
+};
+
 static const struct k3_dsp_dev_data c66_data = {
 	.mems = c66_mems,
 	.num_mems = ARRAY_SIZE(c66_mems),
@@ -751,8 +759,16 @@ static const struct k3_dsp_dev_data c66_data = {
 	.uses_lreset = true,
 };
 
+static const struct k3_dsp_dev_data c71_data = {
+	.mems = c71_mems,
+	.num_mems = ARRAY_SIZE(c71_mems),
+	.boot_align_addr = SZ_2M,
+	.uses_lreset = false,
+};
+
 static const struct of_device_id k3_dsp_of_match[] = {
 	{ .compatible = "ti,j721e-c66-dsp", .data = &c66_data, },
+	{ .compatible = "ti,j721e-c71-dsp", .data = &c71_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, k3_dsp_of_match);
-- 
2.26.0

