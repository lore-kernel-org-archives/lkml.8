Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B964C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3891214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAsKztdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgDSPGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgDSPGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:06:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBBDC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j1so3427913wrt.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ObSDf1aLj5u4GmmbiRGYRUxXBmWBTKTJj89dIRLXbuQ=;
        b=FAsKztdL6snh1BvfjbKlo3DppwMhfJGyfvYsvsLDgMAglmASIZERqy/cdA3zJg6Puw
         3HTyEoaVdE6Aa1WsXVffBrI3qn+8dIcyobWayRxzZlgfefMyN2a8IWQITohU4VAeYwBw
         gfCtxfPIGieg2Lh5DvpL9MjAjK2qX0I6Mh5BosntHrUQnST2aCbFysOypsis+dwXkRRk
         3fCEpbPZ0aBHf1S0EZx+fb0TnsSh+TaW4t3lBjmFGDDZ0FL7jVcsG/dKPKn4pKFXQBcA
         T5xZLNbD+nsAoCij2bXT5aaNR373Kr2DrpKwYvPilMJ0UnJoVar/VTx2xatPYLebPqR+
         773g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ObSDf1aLj5u4GmmbiRGYRUxXBmWBTKTJj89dIRLXbuQ=;
        b=f3vzmQdhroN0YaGGJuAm0MMgMBwIAmagdYGE1G1OF+kD8VV1I67Fzpj7rx+IBXsk1i
         iCA62d/CvL+FCFXqo1Cw0ZEH9xNq+G34ITRxVI76rdkyI+z4JJrsvv0I0CEr/nhA0wQO
         5Xhb5ey/v6DudI2TGDCMYCjtncvLIwd5j44LvXw4GwyKptUgMfJGyacg8dnQG1dFIenc
         vMGrMU027pJzzSWZLmdSjPUe7XotVgrgFTzgJU6PYe5bcSjJbcN+CaXx9k3Qjx71JUYG
         a8k2E/AXmJ5rBtjMp3Wh4CCs7eYJWGVN0N/phe3p3K98LoDubNkX3m89XCaMrWnT/Mlr
         6WDQ==
X-Gm-Message-State: AGi0PuYYzYhksPR6J8CpELFQN1rynX19kYpNTnT8h2B2YttfJx+G5viQ
        +/SA/7fCcRej1rZe6vzSttEghGf0tL5NF6CMWr8=
X-Google-Smtp-Source: APiQypLkrRiQ4l9Ag27jWuqY2Firc1AQu0LIYqJNeNMNzAN9BhPzlQzcaNCc7h6b2/CA98LcZcj1WQ==
X-Received: by 2002:a5d:6647:: with SMTP id f7mr14854178wrw.41.1587308762199;
        Sun, 19 Apr 2020 08:06:02 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id w12sm25948635wrk.56.2020.04.19.08.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 08:06:01 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH 3/6] tee: optee: use SMCCC v1.0 helper functions
Date:   Sun, 19 Apr 2020 17:05:27 +0200
Message-Id: <20200419150530.20508-4-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419150530.20508-1-etienne.carriere@linaro.org>
References: <20200419150530.20508-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change OP-TEE driver to use SMCCC v1.0 helper function.

No functional change but initialization traces that are changed
from pr_*() traces the device dev_*() traces and info trace
"probing for conduit method." being replaced with trace
"probing for conduit method from DT."

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/tee/optee/call.c          | 14 ++---
 drivers/tee/optee/core.c          | 85 ++++++++-----------------------
 drivers/tee/optee/optee_private.h |  4 +-
 3 files changed, 30 insertions(+), 73 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index cf2367ba08d6..706e7814a401 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -137,9 +137,9 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
 	while (true) {
 		struct arm_smccc_res res;
 
-		optee->invoke_fn(param.a0, param.a1, param.a2, param.a3,
-				 param.a4, param.a5, param.a6, param.a7,
-				 &res);
+		arm_smccc_1_0_invoke(param.a0, param.a1, param.a2, param.a3,
+				     param.a4, param.a5, param.a6, param.a7,
+				     &res);
 
 		if (res.a0 == OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
 			/*
@@ -395,8 +395,8 @@ void optee_enable_shm_cache(struct optee *optee)
 	while (true) {
 		struct arm_smccc_res res;
 
-		optee->invoke_fn(OPTEE_SMC_ENABLE_SHM_CACHE, 0, 0, 0, 0, 0, 0,
-				 0, &res);
+		arm_smccc_1_0_invoke(OPTEE_SMC_ENABLE_SHM_CACHE,
+				     0, 0, 0, 0, 0, 0, 0, &res);
 		if (res.a0 == OPTEE_SMC_RETURN_OK)
 			break;
 		optee_cq_wait_for_completion(&optee->call_queue, &w);
@@ -421,8 +421,8 @@ void optee_disable_shm_cache(struct optee *optee)
 			struct optee_smc_disable_shm_cache_result result;
 		} res;
 
-		optee->invoke_fn(OPTEE_SMC_DISABLE_SHM_CACHE, 0, 0, 0, 0, 0, 0,
-				 0, &res.smccc);
+		arm_smccc_1_0_invoke(OPTEE_SMC_DISABLE_SHM_CACHE,
+				     0, 0, 0, 0, 0, 0, 0, &res.smccc);
 		if (res.result.status == OPTEE_SMC_RETURN_ENOTAVAIL)
 			break; /* All shm's freed */
 		if (res.result.status == OPTEE_SMC_RETURN_OK) {
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 99698b8a3a74..f3bc657d1e97 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -335,11 +335,11 @@ static const struct tee_desc optee_supp_desc = {
 	.flags = TEE_DESC_PRIVILEGED,
 };
 
-static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
+static bool optee_msg_api_uid_is_optee_api(void)
 {
 	struct arm_smccc_res res;
 
-	invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
+	arm_smccc_1_0_invoke(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	if (res.a0 == OPTEE_MSG_UID_0 && res.a1 == OPTEE_MSG_UID_1 &&
 	    res.a2 == OPTEE_MSG_UID_2 && res.a3 == OPTEE_MSG_UID_3)
@@ -347,7 +347,7 @@ static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
 	return false;
 }
 
-static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
+static void optee_msg_get_os_revision(void)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -358,8 +358,8 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
 		}
 	};
 
-	invoke_fn(OPTEE_SMC_CALL_GET_OS_REVISION, 0, 0, 0, 0, 0, 0, 0,
-		  &res.smccc);
+	arm_smccc_1_0_invoke(OPTEE_SMC_CALL_GET_OS_REVISION,
+			     0, 0, 0, 0, 0, 0, 0, &res.smccc);
 
 	if (res.result.build_id)
 		pr_info("revision %lu.%lu (%08lx)", res.result.major,
@@ -368,14 +368,15 @@ static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
 		pr_info("revision %lu.%lu", res.result.major, res.result.minor);
 }
 
-static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
+static bool optee_msg_api_revision_is_compatible(void)
 {
 	union {
 		struct arm_smccc_res smccc;
 		struct optee_smc_calls_revision_result result;
 	} res;
 
-	invoke_fn(OPTEE_SMC_CALLS_REVISION, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
+	arm_smccc_1_0_invoke(OPTEE_SMC_CALLS_REVISION,
+			     0, 0, 0, 0, 0, 0, 0, &res.smccc);
 
 	if (res.result.major == OPTEE_MSG_REVISION_MAJOR &&
 	    (int)res.result.minor >= OPTEE_MSG_REVISION_MINOR)
@@ -383,8 +384,7 @@ static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
 	return false;
 }
 
-static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
-					    u32 *sec_caps)
+static bool optee_msg_exchange_capabilities(u32 *sec_caps)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -400,8 +400,8 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 	if (!IS_ENABLED(CONFIG_SMP) || nr_cpu_ids == 1)
 		a1 |= OPTEE_SMC_NSEC_CAP_UNIPROCESSOR;
 
-	invoke_fn(OPTEE_SMC_EXCHANGE_CAPABILITIES, a1, 0, 0, 0, 0, 0, 0,
-		  &res.smccc);
+	arm_smccc_1_0_invoke(OPTEE_SMC_EXCHANGE_CAPABILITIES, a1,
+			     0, 0, 0, 0, 0, 0, &res.smccc);
 
 	if (res.result.status != OPTEE_SMC_RETURN_OK)
 		return false;
@@ -437,8 +437,7 @@ static struct tee_shm_pool *optee_config_dyn_shm(void)
 	return rc;
 }
 
-static struct tee_shm_pool *
-optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
+static struct tee_shm_pool *optee_config_shm_memremap(void **memremaped_shm)
 {
 	union {
 		struct arm_smccc_res smccc;
@@ -455,7 +454,8 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 	void *rc;
 	const int sz = OPTEE_SHM_NUM_PRIV_PAGES * PAGE_SIZE;
 
-	invoke_fn(OPTEE_SMC_GET_SHM_CONFIG, 0, 0, 0, 0, 0, 0, 0, &res.smccc);
+	arm_smccc_1_0_invoke(OPTEE_SMC_GET_SHM_CONFIG,
+			     0, 0, 0, 0, 0, 0, 0, &res.smccc);
 	if (res.result.status != OPTEE_SMC_RETURN_OK) {
 		pr_err("static shm service not available\n");
 		return ERR_PTR(-ENOENT);
@@ -515,45 +515,6 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 	return rc;
 }
 
-/* Simple wrapper functions to be able to use a function pointer */
-static void optee_smccc_smc(unsigned long a0, unsigned long a1,
-			    unsigned long a2, unsigned long a3,
-			    unsigned long a4, unsigned long a5,
-			    unsigned long a6, unsigned long a7,
-			    struct arm_smccc_res *res)
-{
-	arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
-}
-
-static void optee_smccc_hvc(unsigned long a0, unsigned long a1,
-			    unsigned long a2, unsigned long a3,
-			    unsigned long a4, unsigned long a5,
-			    unsigned long a6, unsigned long a7,
-			    struct arm_smccc_res *res)
-{
-	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
-}
-
-static optee_invoke_fn *get_invoke_func(struct device *dev)
-{
-	const char *method;
-
-	pr_info("probing for conduit method.\n");
-
-	if (device_property_read_string(dev, "method", &method)) {
-		pr_warn("missing \"method\" property\n");
-		return ERR_PTR(-ENXIO);
-	}
-
-	if (!strcmp("hvc", method))
-		return optee_smccc_hvc;
-	else if (!strcmp("smc", method))
-		return optee_smccc_smc;
-
-	pr_warn("invalid \"method\" property: %s\n", method);
-	return ERR_PTR(-EINVAL);
-}
-
 static int optee_remove(struct platform_device *pdev)
 {
 	struct optee *optee = platform_get_drvdata(pdev);
@@ -586,7 +547,6 @@ static int optee_remove(struct platform_device *pdev)
 
 static int optee_probe(struct platform_device *pdev)
 {
-	optee_invoke_fn *invoke_fn;
 	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
@@ -594,23 +554,23 @@ static int optee_probe(struct platform_device *pdev)
 	u32 sec_caps;
 	int rc;
 
-	invoke_fn = get_invoke_func(&pdev->dev);
-	if (IS_ERR(invoke_fn))
-		return PTR_ERR(invoke_fn);
+	rc = devm_arm_smccc_1_0_set_conduit(&pdev->dev);
+	if (rc)
+		return rc;
 
-	if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
+	if (!optee_msg_api_uid_is_optee_api()) {
 		pr_warn("api uid mismatch\n");
 		return -EINVAL;
 	}
 
-	optee_msg_get_os_revision(invoke_fn);
+	optee_msg_get_os_revision();
 
-	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
+	if (!optee_msg_api_revision_is_compatible()) {
 		pr_warn("api revision mismatch\n");
 		return -EINVAL;
 	}
 
-	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps)) {
+	if (!optee_msg_exchange_capabilities(&sec_caps)) {
 		pr_warn("capabilities mismatch\n");
 		return -EINVAL;
 	}
@@ -625,7 +585,7 @@ static int optee_probe(struct platform_device *pdev)
 	 * If dynamic shared memory is not available or failed - try static one
 	 */
 	if (IS_ERR(pool) && (sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
-		pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm);
+		pool = optee_config_shm_memremap(&memremaped_shm);
 
 	if (IS_ERR(pool))
 		return PTR_ERR(pool);
@@ -636,7 +596,6 @@ static int optee_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	optee->invoke_fn = invoke_fn;
 	optee->sec_caps = sec_caps;
 
 	teedev = tee_device_alloc(&optee_desc, NULL, pool, optee);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index d9c5037b4e03..e186e318e157 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -69,8 +69,7 @@ struct optee_supp {
  * struct optee - main service struct
  * @supp_teedev:	supplicant device
  * @teedev:		client device
- * @invoke_fn:		function to issue smc or hvc
- * @call_queue:		queue of threads waiting to call @invoke_fn
+ * @call_queue:		queue of threads waiting to invoke secure world
  * @wait_queue:		queue of threads from secure world waiting for a
  *			secure world sync object
  * @supp:		supplicant synchronization struct for RPC to supplicant
@@ -82,7 +81,6 @@ struct optee_supp {
 struct optee {
 	struct tee_device *supp_teedev;
 	struct tee_device *teedev;
-	optee_invoke_fn *invoke_fn;
 	struct optee_call_queue call_queue;
 	struct optee_wait_queue wait_queue;
 	struct optee_supp supp;
-- 
2.17.1

