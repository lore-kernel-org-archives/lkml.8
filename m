Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCD9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06ABC214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSUZ3FZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgDSPGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgDSPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:06:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D0FC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so8809251wrw.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PlXCkAj7SQ4UkWuPcToquaH1G9B7ruGi30ZWGX4XAOI=;
        b=bSUZ3FZ/E0Yll9mMB7lRuIpfWOJ2UjnTn9Y5kylSnIcCBmpx/1nfXbMiCD57DgznMV
         kmSKROR6KdG6ukdsKOjv6ygoc05kmCMtgbG4HLY9LlKG4AYF836ilgTkc1YmVI3FHUjG
         fZaQzKjN5hXLG5S55dPB4vSgIy713coGDKRGk7VCi4miffBi8/SOMAd4IBZvUESUWaio
         3IzvdC6MbiwnUjFwnMfLg+eyVRYFnFgA0bGKJcuaJHWUhO1UT1IBSqOcXflq+MpR2tAU
         m+8qYq6KqGr30MvoZsQVzyb+az+TKHWLOdz2thY9pjPPbZh4tGfeUu3xJaCtBHXwhdMA
         UEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PlXCkAj7SQ4UkWuPcToquaH1G9B7ruGi30ZWGX4XAOI=;
        b=dIUAUGBIj1Nv8TsrS/g/bPcIWau77w1NtPRHO1Fbl47SYGL4HUuOcH8K0A6vbF1e/l
         WDiq9n/fSi2JJjClNmz6hf5h9/prBBk3/biI+EveGAZ6PbUm3+PDIg5mP3OjX2G91r0y
         loM66x1tYE9sqU3RZfARYC/tMNV9eLSnw81HFzYmyf9ClT25FuXUiUyEQoWLk1l9qf2z
         m/raeE5dUaLvSNmvRCrFaVH8UT/aboi1bp3K5IFjE4TLNxVHS67LSFtMrwsCYny4oLFT
         XaS69HKhiDqaGW7v937NbrFmAD5pYHfcG14ENLGWlMywYPDrx2M9z6weDkpaYChW6j7c
         DUhw==
X-Gm-Message-State: AGi0PuaI0rCMb8wlJ8NKD3B3TOtp6gg8HPSuYbVW14J5aOMYTu/UquAn
        PywXd3U4L6Ha5qc/fJ15gmyNsP+NYJ3YDrovX9E=
X-Google-Smtp-Source: APiQypK4xdmIs7kwsa7WCAqQXbtAO2TeUQmMZY0x3pN8rCZP9NcFL0C2FPOU1tjGn0zBRSXgyKLwpQ==
X-Received: by 2002:adf:c109:: with SMTP id r9mr13905434wre.265.1587308765612;
        Sun, 19 Apr 2020 08:06:05 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id w12sm25948635wrk.56.2020.04.19.08.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 08:06:05 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH 5/6] firmware: stratix10: use SMCCC v1.0 helper functions
Date:   Sun, 19 Apr 2020 17:05:29 +0200
Message-Id: <20200419150530.20508-6-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419150530.20508-1-etienne.carriere@linaro.org>
References: <20200419150530.20508-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change Stratix 10 firmware driver to use SMCCC v1.0 helper function.

Main functional change is that SMCCC conduit for the device is ensured
being consistent with the method used by PSCI firmware.

Another functional change is a additional info trace in the device
probed sequence: "probing for conduit method from DT.".

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/stratix10-svc.c | 97 +++-----------------------------
 1 file changed, 9 insertions(+), 88 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index d5f0769f3761..132f05f2bcc8 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -41,10 +41,6 @@
 /* stratix10 service layer clients */
 #define STRATIX10_RSU				"stratix10-rsu"
 
-typedef void (svc_invoke_fn)(unsigned long, unsigned long, unsigned long,
-			     unsigned long, unsigned long, unsigned long,
-			     unsigned long, unsigned long,
-			     struct arm_smccc_res *);
 struct stratix10_svc_chan;
 
 /**
@@ -60,7 +56,6 @@ struct stratix10_svc {
  * @sync_complete: state for a completion
  * @addr: physical address of shared memory block
  * @size: size of shared memory block
- * @invoke_fn: function to issue secure monitor or hypervisor call
  *
  * This struct is used to save physical address and size of shared memory
  * block. The shared memory blocked is allocated by secure monitor software
@@ -73,7 +68,6 @@ struct stratix10_svc_sh_memory {
 	struct completion sync_complete;
 	unsigned long addr;
 	unsigned long size;
-	svc_invoke_fn *invoke_fn;
 };
 
 /**
@@ -126,7 +120,6 @@ struct stratix10_svc_data {
  * @svc_fifo: a queue for storing service message data
  * @complete_status: state for completion
  * @svc_fifo_lock: protect access to service message data queue
- * @invoke_fn: function to issue secure monitor call or hypervisor call
  *
  * This struct is used to create communication channels for service clients, to
  * handle secure monitor or hypervisor call.
@@ -142,7 +135,6 @@ struct stratix10_svc_controller {
 	struct kfifo svc_fifo;
 	struct completion complete_status;
 	spinlock_t svc_fifo_lock;
-	svc_invoke_fn *invoke_fn;
 };
 
 /**
@@ -206,8 +198,8 @@ static void svc_thread_cmd_data_claim(struct stratix10_svc_controller *ctrl,
 
 	pr_debug("%s: claim back the submitted buffer\n", __func__);
 	do {
-		ctrl->invoke_fn(INTEL_SIP_SMC_FPGA_CONFIG_COMPLETED_WRITE,
-				0, 0, 0, 0, 0, 0, 0, &res);
+		arm_smccc_1_0_invoke(INTEL_SIP_SMC_FPGA_CONFIG_COMPLETED_WRITE,
+				     0, 0, 0, 0, 0, 0, 0, &res);
 
 		if (res.a0 == INTEL_SIP_SMC_STATUS_OK) {
 			if (!res.a1) {
@@ -256,8 +248,8 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 
 	count_in_sec = FPGA_CONFIG_STATUS_TIMEOUT_SEC;
 	while (count_in_sec) {
-		ctrl->invoke_fn(INTEL_SIP_SMC_FPGA_CONFIG_ISDONE,
-				0, 0, 0, 0, 0, 0, 0, &res);
+		arm_smccc_1_0_invoke(INTEL_SIP_SMC_FPGA_CONFIG_ISDONE,
+				     0, 0, 0, 0, 0, 0, 0, &res);
 		if ((res.a0 == INTEL_SIP_SMC_STATUS_OK) ||
 		    (res.a0 == INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR))
 			break;
@@ -420,7 +412,7 @@ static int svc_normal_to_secure_thread(void *data)
 			 __func__, (unsigned int)a0, (unsigned int)a1);
 		pr_debug(" a2=0x%016x\n", (unsigned int)a2);
 
-		ctrl->invoke_fn(a0, a1, a2, 0, 0, 0, 0, 0, &res);
+		arm_smccc_1_0_invoke(a0, a1, a2, 0, 0, 0, 0, 0, &res);
 
 		pr_debug("%s: after SMC call -- res.a0=0x%016x",
 			 __func__, (unsigned int)res.a0);
@@ -540,8 +532,8 @@ static int svc_normal_to_secure_shm_thread(void *data)
 	struct arm_smccc_res res;
 
 	/* SMC or HVC call to get shared memory info from secure world */
-	sh_mem->invoke_fn(INTEL_SIP_SMC_FPGA_CONFIG_GET_MEM,
-			  0, 0, 0, 0, 0, 0, 0, &res);
+	arm_smccc_1_0_invoke(INTEL_SIP_SMC_FPGA_CONFIG_GET_MEM,
+			     0, 0, 0, 0, 0, 0, 0, &res);
 	if (res.a0 == INTEL_SIP_SMC_STATUS_OK) {
 		sh_mem->addr = res.a1;
 		sh_mem->size = res.a2;
@@ -661,73 +653,6 @@ svc_create_memory_pool(struct platform_device *pdev,
 	return genpool;
 }
 
-/**
- * svc_smccc_smc() - secure monitor call between normal and secure world
- * @a0: argument passed in registers 0
- * @a1: argument passed in registers 1
- * @a2: argument passed in registers 2
- * @a3: argument passed in registers 3
- * @a4: argument passed in registers 4
- * @a5: argument passed in registers 5
- * @a6: argument passed in registers 6
- * @a7: argument passed in registers 7
- * @res: result values from register 0 to 3
- */
-static void svc_smccc_smc(unsigned long a0, unsigned long a1,
-			  unsigned long a2, unsigned long a3,
-			  unsigned long a4, unsigned long a5,
-			  unsigned long a6, unsigned long a7,
-			  struct arm_smccc_res *res)
-{
-	arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
-}
-
-/**
- * svc_smccc_hvc() - hypervisor call between normal and secure world
- * @a0: argument passed in registers 0
- * @a1: argument passed in registers 1
- * @a2: argument passed in registers 2
- * @a3: argument passed in registers 3
- * @a4: argument passed in registers 4
- * @a5: argument passed in registers 5
- * @a6: argument passed in registers 6
- * @a7: argument passed in registers 7
- * @res: result values from register 0 to 3
- */
-static void svc_smccc_hvc(unsigned long a0, unsigned long a1,
-			  unsigned long a2, unsigned long a3,
-			  unsigned long a4, unsigned long a5,
-			  unsigned long a6, unsigned long a7,
-			  struct arm_smccc_res *res)
-{
-	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
-}
-
-/**
- * get_invoke_func() - invoke SMC or HVC call
- * @dev: pointer to device
- *
- * Return: function pointer to svc_smccc_smc or svc_smccc_hvc.
- */
-static svc_invoke_fn *get_invoke_func(struct device *dev)
-{
-	const char *method;
-
-	if (of_property_read_string(dev->of_node, "method", &method)) {
-		dev_warn(dev, "missing \"method\" property\n");
-		return ERR_PTR(-ENXIO);
-	}
-
-	if (!strcmp(method, "smc"))
-		return svc_smccc_smc;
-	if (!strcmp(method, "hvc"))
-		return svc_smccc_hvc;
-
-	dev_warn(dev, "invalid \"method\" property: %s\n", method);
-
-	return ERR_PTR(-EINVAL);
-}
-
 /**
  * stratix10_svc_request_channel_byname() - request a service channel
  * @client: pointer to service client
@@ -979,20 +904,17 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	struct stratix10_svc_sh_memory *sh_memory;
 	struct stratix10_svc *svc;
 
-	svc_invoke_fn *invoke_fn;
 	size_t fifo_size;
 	int ret;
 
-	/* get SMC or HVC function */
-	invoke_fn = get_invoke_func(dev);
-	if (IS_ERR(invoke_fn))
+	/* get SMC or HVC conduit */
+	if (arm_smccc_1_0_set_device_conduit(&pdev->dev))
 		return -EINVAL;
 
 	sh_memory = devm_kzalloc(dev, sizeof(*sh_memory), GFP_KERNEL);
 	if (!sh_memory)
 		return -ENOMEM;
 
-	sh_memory->invoke_fn = invoke_fn;
 	ret = svc_get_sh_memory(pdev, sh_memory);
 	if (ret)
 		return ret;
@@ -1017,7 +939,6 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	controller->chans = chans;
 	controller->genpool = genpool;
 	controller->task = NULL;
-	controller->invoke_fn = invoke_fn;
 	init_completion(&controller->complete_status);
 
 	fifo_size = sizeof(struct stratix10_svc_data) * SVC_NUM_DATA_IN_FIFO;
-- 
2.17.1

