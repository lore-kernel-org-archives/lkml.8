Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53CDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D5D20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTd34Wi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgFWFPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgFWFPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:15:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D304C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:15:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j12so7312418pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3phtSZElnKhAKAsJ0GkPo5emlqkKBgqm+SMemI7XzZE=;
        b=yTd34Wi8nuuX1GjOPwJKiPvV3apHnv1PBY5cE3Txgjq7ZhCA5x5CVfF/3zOXQLo+RA
         UNoQkrET3GF3kqKwRgcoppDliQzeTcK5pE8JNYIku0KWis95i5MicFo/DyTaGlMENdEY
         OFOz6j8HmYJpWGOqHNoD3yOZh32eNXcWVEGB/n87Lt2YBNoQ3uq5eoV3lQCNVvD/6zvb
         a+tOvufVyKXv4E1Jb7Jum/3U8uqBsq1WG1sfdom6B0K1GUaIJcK3oShUwQo1MLjAcAZ5
         3paxC0VY98zUkGERCN58qkatsvsXvocT/RKh02WsluOPObokqUMkHKtqRAP/q3VBhzu3
         RO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3phtSZElnKhAKAsJ0GkPo5emlqkKBgqm+SMemI7XzZE=;
        b=cijUMFOhrn+DfJGX/e82H/dmOZ52zz2DHvQ4Y/SDIoOYD/L+TsIOJhrrJ2MacdL4pk
         26ib9iP9SsYqyMfZLDZm8yMFuZnDk4QloCE7eikXfRxTw4qbou/DKvdNgjnZ9cSMjiHt
         4eY2XelLLGvA932OyPsOIRgJmZipl2q8WVO3TurLoQfy5lX+OPmTnKt0ICO3KpX8KRa2
         FQh/xK3w5XjiqeWf69papt1BrMIC39jjkXVUf3Gv3r79/Nijyr8KwiqnnV89YWgmfl/r
         0AXwk9J27mfZ9mJxhy9bu8Z9ED2mus/KV76EUjqFxvBy3AiB/k7CkOkZWoprQX1KeoQt
         yjMw==
X-Gm-Message-State: AOAM533MWlr3PPF7DT2sULIXWBxfxHp/Wlx4y6TlZUJQWALgUQHCe/1Y
        /DBVBIGYHkggqEImW9r/kgMQMw==
X-Google-Smtp-Source: ABdhPJxDJmmDQujdEzvEsZ71dYVPCTHV1QA8cJuQCCak03eaFvWu2zff1mtJNhHPc1SW3zuBJ0uUaw==
X-Received: by 2002:aa7:9184:: with SMTP id x4mr23054383pfa.271.1592889317007;
        Mon, 22 Jun 2020 22:15:17 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id o1sm16562358pfu.70.2020.06.22.22.15.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 22:15:16 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: cppc: Reorder code and remove apply_hisi_workaround variable
Date:   Tue, 23 Jun 2020 10:45:11 +0530
Message-Id: <b217dc843935e3f86584a73893d330fd99a4e472.1592889188.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the current approach we have an extra check in the
cppc_cpufreq_get_rate() callback, which checks if hisilicon's get rate
implementation should be used instead. While it works fine, the approach
isn't very straight forward, over that we have an extra check in the
routine.

Rearrange code and update the cpufreq driver's get() callback pointer
directly for the hisilicon case. This gets the extra variable is removed
and the extra check isn't required anymore as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Xiongfeng Wang, will it be possible for you to give this a try as I
can't really test it locally.

 drivers/cpufreq/cppc_cpufreq.c | 91 ++++++++++++++++------------------
 1 file changed, 42 insertions(+), 49 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 257d726a4456..03a21daddbec 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -45,8 +45,6 @@ struct cppc_workaround_oem_info {
 	u32 oem_revision;
 };
 
-static bool apply_hisi_workaround;
-
 static struct cppc_workaround_oem_info wa_info[] = {
 	{
 		.oem_id		= "HISI  ",
@@ -59,50 +57,6 @@ static struct cppc_workaround_oem_info wa_info[] = {
 	}
 };
 
-static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
-					unsigned int perf);
-
-/*
- * HISI platform does not support delivered performance counter and
- * reference performance counter. It can calculate the performance using the
- * platform specific mechanism. We reuse the desired performance register to
- * store the real performance calculated by the platform.
- */
-static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
-{
-	struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
-	u64 desired_perf;
-	int ret;
-
-	ret = cppc_get_desired_perf(cpunum, &desired_perf);
-	if (ret < 0)
-		return -EIO;
-
-	return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
-}
-
-static void cppc_check_hisi_workaround(void)
-{
-	struct acpi_table_header *tbl;
-	acpi_status status = AE_OK;
-	int i;
-
-	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
-	if (ACPI_FAILURE(status) || !tbl)
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
-		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
-		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
-		    wa_info[i].oem_revision == tbl->oem_revision) {
-			apply_hisi_workaround = true;
-			break;
-		}
-	}
-
-	acpi_put_table(tbl);
-}
-
 /* Callback function used to retrieve the max frequency from DMI */
 static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 {
@@ -402,9 +356,6 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
 	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
 	int ret;
 
-	if (apply_hisi_workaround)
-		return hisi_cppc_cpufreq_get_rate(cpunum);
-
 	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
 	if (ret)
 		return ret;
@@ -455,6 +406,48 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.name = "cppc_cpufreq",
 };
 
+/*
+ * HISI platform does not support delivered performance counter and
+ * reference performance counter. It can calculate the performance using the
+ * platform specific mechanism. We reuse the desired performance register to
+ * store the real performance calculated by the platform.
+ */
+static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
+{
+	struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
+	u64 desired_perf;
+	int ret;
+
+	ret = cppc_get_desired_perf(cpunum, &desired_perf);
+	if (ret < 0)
+		return -EIO;
+
+	return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
+}
+
+static void cppc_check_hisi_workaround(void)
+{
+	struct acpi_table_header *tbl;
+	acpi_status status = AE_OK;
+	int i;
+
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
+	if (ACPI_FAILURE(status) || !tbl)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
+		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
+		    wa_info[i].oem_revision == tbl->oem_revision) {
+			/* Overwrite the get() callback */
+			cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
+			break;
+		}
+	}
+
+	acpi_put_table(tbl);
+}
+
 static int __init cppc_cpufreq_init(void)
 {
 	int i, ret = 0;
-- 
2.25.0.rc1.19.g042ed3e048af

