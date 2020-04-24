Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DE7C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAA521775
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYmAPTxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgDXUZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgDXUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:25:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B01C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f7so5338816pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kG2iXiDOAlrBuv2wqeB6r8YKH3F8C14k21yMdoM6KR8=;
        b=IYmAPTxMHxW01D1OdVg6js0cI3JraeOKhnKiDvx7CwBKWa6HBJ5zMo2JXOk06e/Sk6
         z+nio/13fncpMdAUX7spt/kaAdFvjjhFr27I5IGkEnpyq5itIbJ0DZadSC1kV0kfU/VG
         KIXb/wx4Kwy0Mv7cMRsloIra5uyuvT9FtN9fxkamelqavtEsRm76jY+Wvkc4oyMTAquw
         rC3J1uAtJ2ew8ID6OijjWwnBJ8HaNk8LwVmSMfuZ5btvxQLoMOiTZl0oQtLYU4f9iD3j
         WRpWAniZVy7XJpx+Zexi4t9p9A9yjEGUR2K8OpOexgNyGxG/SY7LUmS5ytP8iAuFCN7J
         yHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kG2iXiDOAlrBuv2wqeB6r8YKH3F8C14k21yMdoM6KR8=;
        b=BfTTc70tkcb8yk8oMDeX5WBRb4GaOlHVPCov5fxV6YpWA9akURNszxjdmc9z3Uzljo
         qKzGBofdc89ZPtLzsIGsVqEMnZxcFZfSWBJphlE9YxvBz9SsjiL70UKpDUOAHR17rlV7
         M3GGRCZ731Q9ghqcyjIQHHEiYU2VbXzK1yUGD5b5AOTmqUOCxTIWz1wsO/tqezUacQ8G
         DZHgQbaJ0pgZhf95VRggSqLxOJGCehbm155XfuI6f2kMkFGJdpbhPd6+LCuRZNWiO//v
         O3/MCOFZf1VaCtfJQtz2U7mIZxILy/Iy0apYAOZ96KpnOTe4f3l7vyi+g1SaDMuHVFjj
         iXvg==
X-Gm-Message-State: AGi0Puap9nPOLN0ES1V+0Oh24VNnkkCDotnzrz9AFbdiNN0Hr5RPOD4Y
        Oe5/USj5g1KKmSV5NUQWCA5fIg==
X-Google-Smtp-Source: APiQypKviZ6PkeE83136I1kJAdKrTrljVnv7Q8b8j/LsmS+zqipjOpZk/taRmaQdP/cWXjJXLqB8TA==
X-Received: by 2002:a63:4a59:: with SMTP id j25mr10666444pgl.336.1587759921334;
        Fri, 24 Apr 2020 13:25:21 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c1sm6553245pfc.94.2020.04.24.13.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:25:20 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] remoteproc: stm32: Set synchronisation state machine if needed
Date:   Fri, 24 Apr 2020 14:25:05 -0600
Message-Id: <20200424202505.29562-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424202505.29562-1-mathieu.poirier@linaro.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the flags and operations to use if the M4 has been started
by another entity than the remoteproc core.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index dcae6103e3df..02dad3f51c7a 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -598,13 +598,20 @@ static struct rproc_ops st_rproc_ops = {
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
 
-static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
+static struct rproc_ops st_rproc_sync_ops = {
 	.start		= stm32_rproc_sync_start,
 	.stop		= stm32_rproc_stop,
+	.kick		= stm32_rproc_kick,
 	.parse_fw       = stm32_rproc_sync_parse_fw,
 	.find_loaded_rsc_table = stm32_rproc_sync_elf_find_loaded_rsc_table,
 };
 
+static struct rproc_sync_flags st_sync_flags = {
+	.on_init = true, /* sync with MCU when the kernel boots */
+	.after_stop = false, /* don't resync with MCU if stopped from sysfs */
+	.after_crash = false, /* don't resync with MCU after a crash */
+};
+
 static const struct of_device_id stm32_rproc_match[] = {
 	{ .compatible = "st,stm32mp1-m4" },
 	{},
@@ -803,6 +810,7 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	struct stm32_rproc *ddata;
 	struct device_node *np = dev->of_node;
 	struct rproc *rproc;
+	struct rproc_sync_flags sync_flags = {0};
 	unsigned int state;
 	bool auto_boot = false;
 	int ret;
@@ -837,11 +845,17 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 	}
 
 	if (state == M4_STATE_CRUN) {
+		auto_boot = true;
+		sync_flags = st_sync_flags;
 		ret = stm32_rproc_get_loaded_rsc_table(pdev, ddata);
 		if (ret)
 			goto free_rproc;
 	}
 
+	ret = rproc_set_state_machine(rproc, &st_rproc_sync_ops, sync_flags);
+	if (ret)
+		goto free_rproc;
+
 	rproc->auto_boot = auto_boot;
 	rproc->has_iommu = false;
 	ddata->workqueue = create_workqueue(dev_name(dev));
-- 
2.20.1

