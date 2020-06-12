Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EE1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35324206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lR6+haSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFLWtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:49:52 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49212 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgFLWti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:49:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnW69103516;
        Fri, 12 Jun 2020 17:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592002172;
        bh=dJfNet5z/jwMk1KyTLxkDrBpDH/7oBNjz2rfy7DYy2k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lR6+haSK7Q96LT+l3dgEHmT3JM9s7Op/GiuFx8ZW0aTA16ULzKblbmVpmdDyeCdAk
         4EigFPgX5On2KBpD8NSdXG1yR+MvWFDgVSL99Y8INp7b89h5stoYQE4Vxrud0aAjc2
         jef3So1ghR/1D0Z4x6xsneilteNme/evCfQlwOTc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CMnW1f119692
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 17:49:32 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 17:49:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 17:49:32 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CMnW0e112307;
        Fri, 12 Jun 2020 17:49:32 -0500
Received: from localhost ([10.250.48.148])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 05CMnWtG062201;
        Fri, 12 Jun 2020 17:49:32 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 6/6] remoteproc: k3-dsp: Add support for L2RAM loading on C66x DSPs
Date:   Fri, 12 Jun 2020 17:49:14 -0500
Message-ID: <20200612224914.7634-7-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200612224914.7634-1-s-anna@ti.com>
References: <20200612224914.7634-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resets for the DSP processors on K3 SoCs are managed through the
Power and Sleep Controller (PSC) module. Each DSP typically has two
resets - a global module reset for powering on the device, and a local
reset that affects only the CPU while allowing access to the other
sub-modules within the DSP processor sub-systems.

The C66x DSPs have two levels of internal RAMs that can be used to
boot from, and the firmware loading into these RAMs require the
local reset to be asserted with the device powered on/enabled using
the module reset. Enhance the K3 DSP remoteproc driver to add support
for loading into the internal RAMs. The local reset is deasserted on
SoC power-on-reset, so logic has to be added in probe in remoteproc
mode to balance the remoteproc state-machine.

Note that the local resets are a no-op on C71x cores, and the hardware
does not supporting loading into its internal RAMs.

Signed-off-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
v3: No code changes, picked up review tags, switched to : in patch title
v2: https://patchwork.kernel.org/patch/11561785/

 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 72 +++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 2f8b3ff5427d..668bb45b3fe8 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -175,6 +175,9 @@ static int k3_dsp_rproc_reset(struct k3_dsp_rproc *kproc)
 		return ret;
 	}
 
+	if (kproc->data->uses_lreset)
+		return ret;
+
 	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
 						    kproc->ti_sci_id);
 	if (ret) {
@@ -192,6 +195,9 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
 	struct device *dev = kproc->dev;
 	int ret;
 
+	if (kproc->data->uses_lreset)
+		goto lreset;
+
 	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
 						    kproc->ti_sci_id);
 	if (ret) {
@@ -199,6 +205,7 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
 		return ret;
 	}
 
+lreset:
 	ret = reset_control_deassert(kproc->reset);
 	if (ret) {
 		dev_err(dev, "local-reset deassert failed, ret = %d\n", ret);
@@ -210,6 +217,53 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
 	return ret;
 }
 
+/*
+ * The C66x DSP cores have a local reset that affects only the CPU, and a
+ * generic module reset that powers on the device and allows the DSP internal
+ * memories to be accessed while the local reset is asserted. This function is
+ * used to release the global reset on C66x DSPs to allow loading into the DSP
+ * internal RAMs. The .prepare() ops is invoked by remoteproc core before any
+ * firmware loading, and is followed by the .start() ops after loading to
+ * actually let the C66x DSP cores run.
+ */
+static int k3_dsp_rproc_prepare(struct rproc *rproc)
+{
+	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
+						    kproc->ti_sci_id);
+	if (ret)
+		dev_err(dev, "module-reset deassert failed, cannot enable internal RAM loading, ret = %d\n",
+			ret);
+
+	return ret;
+}
+
+/*
+ * This function implements the .unprepare() ops and performs the complimentary
+ * operations to that of the .prepare() ops. The function is used to assert the
+ * global reset on applicable C66x cores. This completes the second portion of
+ * powering down the C66x DSP cores. The cores themselves are only halted in the
+ * .stop() callback through the local reset, and the .unprepare() ops is invoked
+ * by the remoteproc core after the remoteproc is stopped to balance the global
+ * reset.
+ */
+static int k3_dsp_rproc_unprepare(struct rproc *rproc)
+{
+	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
+						    kproc->ti_sci_id);
+	if (ret)
+		dev_err(dev, "module-reset assert failed, ret = %d\n", ret);
+
+	return ret;
+}
+
 /*
  * Power up the DSP remote processor.
  *
@@ -353,6 +407,8 @@ static void *k3_dsp_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
 }
 
 static const struct rproc_ops k3_dsp_rproc_ops = {
+	.prepare	= k3_dsp_rproc_prepare,
+	.unprepare	= k3_dsp_rproc_unprepare,
 	.start		= k3_dsp_rproc_start,
 	.stop		= k3_dsp_rproc_stop,
 	.kick		= k3_dsp_rproc_kick,
@@ -615,6 +671,22 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		goto release_tsp;
 	}
 
+	/*
+	 * ensure the DSP local reset is asserted to ensure the DSP doesn't
+	 * execute bogus code in .prepare() when the module reset is released.
+	 */
+	if (data->uses_lreset) {
+		ret = reset_control_status(kproc->reset);
+		if (ret < 0) {
+			dev_err(dev, "failed to get reset status, status = %d\n",
+				ret);
+			goto release_mem;
+		} else if (ret == 0) {
+			dev_warn(dev, "local reset is deasserted for device\n");
+			k3_dsp_rproc_reset(kproc);
+		}
+	}
+
 	ret = rproc_add(rproc);
 	if (ret) {
 		dev_err(dev, "failed to add register device with remoteproc core, status = %d\n",
-- 
2.26.0

