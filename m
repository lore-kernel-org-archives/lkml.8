Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52813C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E9420678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mm2fWmRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407684AbgDNRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407592AbgDNRXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:23:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1976C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:23:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so5501645pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ek4s7c7RG7UOQUZe6ls+Mj3+UEMRQAnNOOuniDFDT/Y=;
        b=Mm2fWmRZrz0425GfyDiIr8TJzlU90JLGiCDyJBvHFd4h2J0Pl7LISBZEeiB3zgT82e
         E6bI5NNZUBGY00u9rq7j/a1UlSrB+aPwHi1pVgU3ckYYyeH+LlRzgS2aLaNAmE0h7pbT
         GDlRcoSee5o+yHBV4S0U1T/cQQzlX/s84bGgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ek4s7c7RG7UOQUZe6ls+Mj3+UEMRQAnNOOuniDFDT/Y=;
        b=MY+0ia8hhp20j0QN4bq+iw8u4Jgu5Acn2KYd62dVqOKkpjlcI00z5tQ/zF0ZfuFkz+
         XnsBUqlcNjE3pLbUy8r5b7fr0ULekfgFZhqZNp1DhTnULleUjdyRg706w2SDQk9/PMzG
         d9WLMDMtbEOiUSKK9m/tci4AKclCumNVh3FyQ8OGZD9tRJvFK24HnUIJMaF4XEiYFqBR
         i+z0xKB94iVFynMt5AHWPj13L9WeFYZyU+WYJ+LvcrHAmomrUgECC/M72cfoMIoKK3xv
         /hZK3NjyuEdZuTgPQ4A7WYvQpH0wH7pIH/Q3wqVwDiPGR7If0mqmPSrZI98248dkdp4z
         oNrQ==
X-Gm-Message-State: AGi0PuaoZFBlcxZf1AMRQDuLqIgr7UJ6ygA2cb3sQkdemi7dGl0jH41A
        TdRRirFu+5cFLUXds7Uh5dB9aw==
X-Google-Smtp-Source: APiQypKEmDtWo4jignZ0k+Pc+IvX3sbywZISP/fOQ9NXiR+RByeupF4KcvQNkJwpcFbW3bRwxElGpw==
X-Received: by 2002:a17:90a:8c96:: with SMTP id b22mr1316892pjo.25.1586885032093;
        Tue, 14 Apr 2020 10:23:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i8sm9564297pgr.82.2020.04.14.10.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:23:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mkshah@codeaurora.org, swboyd@chromium.org, mka@chromium.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: rpmh-rsc: Remove the pm_lock
Date:   Tue, 14 Apr 2020 10:23:26 -0700
Message-Id: <20200414102312.1.I295cb72bc5334a2af80313cbe97cb5c9dcb1442c@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been postulated that the pm_lock is bad for performance because
a CPU currently running rpmh_flush() could block other CPUs from
coming out of idle.  Similarly CPUs coming out of / going into idle
all need to contend with each other for the spinlock just to update
the variable tracking who's in PM.

Let's optimize this a bit.  Specifically:

- Use a count rather than a bitmask.  This is faster to access and
  also means we can use the atomic_inc_return() function to really
  detect who the last one to enter PM was.
- Accept that it's OK if we race and are doing the flush (because we
  think we're last) while another CPU is coming out of idle.  As long
  as we block that CPU if/when it tries to do an active-only transfer
  we're OK.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/rpmh-internal.h |  7 ++---
 drivers/soc/qcom/rpmh-rsc.c      | 46 +++++++++++++++-----------------
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index dba8510c0669..449cd511702b 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -97,7 +97,7 @@ struct rpmh_ctrlr {
  * @num_tcs:            Number of TCSes in this DRV.
  * @rsc_pm:             CPU PM notifier for controller.
  *                      Used when solver mode is not present.
- * @cpus_entered_pm:    CPU mask for cpus in idle power collapse.
+ * @cpus_in_pm:         Number of CPUs not in idle power collapse.
  *                      Used when solver mode is not present.
  * @tcs:                TCS groups.
  * @tcs_in_use:         S/W state of the TCS; only set for ACTIVE_ONLY
@@ -111,8 +111,6 @@ struct rpmh_ctrlr {
  *                      grabbing this lock and a tcs_lock at the same time,
  *                      grab the tcs_lock first so we always have a
  *                      consistent lock ordering.
- * @pm_lock:            Synchronize during PM notifications.
- *                      Used when solver mode is not present.
  * @client:             Handle to the DRV's client.
  */
 struct rsc_drv {
@@ -121,11 +119,10 @@ struct rsc_drv {
 	int id;
 	int num_tcs;
 	struct notifier_block rsc_pm;
-	struct cpumask cpus_entered_pm;
+	atomic_t cpus_in_pm;
 	struct tcs_group tcs[TCS_TYPE_NR];
 	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
 	spinlock_t lock;
-	spinlock_t pm_lock;
 	struct rpmh_ctrlr client;
 };
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 732316bb67dc..4e45a8ac6cde 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -740,6 +740,8 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
  * SLEEP and WAKE sets. If AMCs are busy, controller can not enter
  * power collapse, so deny from the last cpu's pm notification.
  *
+ * Context: Must be called with the drv->lock held.
+ *
  * Return:
  * * False		- AMCs are idle
  * * True		- AMCs are busy
@@ -754,9 +756,6 @@ static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
 	 * dedicated TCS for active state use, then re-purposed wake TCSes
 	 * should be checked for not busy, because we used wake TCSes for
 	 * active requests in this case.
-	 *
-	 * Since this is called from the last cpu, need not take drv or tcs
-	 * lock before checking tcs_is_free().
 	 */
 	if (!tcs->num_tcs)
 		tcs = &drv->tcs[WAKE_TCS];
@@ -791,36 +790,36 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
 {
 	struct rsc_drv *drv = container_of(nfb, struct rsc_drv, rsc_pm);
 	int ret = NOTIFY_OK;
-
-	spin_lock(&drv->pm_lock);
+	int cpus_in_pm;
 
 	switch (action) {
 	case CPU_PM_ENTER:
-		cpumask_set_cpu(smp_processor_id(), &drv->cpus_entered_pm);
-
-		if (!cpumask_equal(&drv->cpus_entered_pm, cpu_online_mask))
-			goto exit;
+		cpus_in_pm = atomic_inc_return(&drv->cpus_in_pm);
+		if (cpus_in_pm < num_online_cpus())
+			return NOTIFY_OK;
 		break;
 	case CPU_PM_ENTER_FAILED:
 	case CPU_PM_EXIT:
-		cpumask_clear_cpu(smp_processor_id(), &drv->cpus_entered_pm);
-		goto exit;
-	}
-
-	ret = rpmh_rsc_ctrlr_is_busy(drv);
-	if (ret) {
-		ret = NOTIFY_BAD;
-		goto exit;
+		atomic_dec(&drv->cpus_in_pm);
+		return NOTIFY_OK;
 	}
 
-	ret = rpmh_flush(&drv->client);
-	if (ret)
+	/*
+	 * It's likely we're on the last CPU. Grab the drv->lock and write
+	 * out the sleep/wake commands to RPMH hardware. Grabbing the lock
+	 * means that if we race with another CPU coming up we are still
+	 * guaranteed to be safe. If another CPU came up just after we checked
+	 * and has already started an active transfer then we'll notice we're
+	 * busy and abort. If another CPU comes up after we start flushing it
+	 * will be blocked from starting an active transfer until we're done
+	 * flushing. If another CPU starts an active transfer after we release
+	 * the lock we're still OK because we're no longer the last CPU.
+	 */
+	spin_lock(&drv->lock);
+	if (rpmh_rsc_ctrlr_is_busy(drv) || !rpmh_flush(&drv->client))
 		ret = NOTIFY_BAD;
-	else
-		ret = NOTIFY_OK;
+	spin_unlock(&drv->lock);
 
-exit:
-	spin_unlock(&drv->pm_lock);
 	return ret;
 }
 
@@ -964,7 +963,6 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
 	if (!solver_config) {
 		drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
-		spin_lock_init(&drv->pm_lock);
 		cpu_pm_register_notifier(&drv->rsc_pm);
 	}
 
-- 
2.26.0.110.g2183baf09c-goog

