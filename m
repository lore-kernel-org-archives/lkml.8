Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBBCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F8620775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REu2vVnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgFZDwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 23:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgFZDwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 23:52:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B67C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 20:52:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q17so4071757pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 20:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kNSCiHNHSb6jIhG+JaGhvWbvnCv4GNFP8GZBjcVO0Y=;
        b=REu2vVnNvFUO7RMznNy7FQBFECB9nt/3gLuM5qsneFWLgFzaMJa3uw3MHsopvaIhRw
         PbNnmBTaimtKOz0klQp0RnQodX5uRKSH9pOq1Ccz3zTI4vV7+v0MISmgwCZGCkc21vZN
         U52lXDHn+Y5h2h8hpp74pkX3e4Xn6Fqw0fyKD/EE6CQz38h8MhZnzIGlb5VfyqxU5MAA
         gb8Q4OnL2jpwG2KyrfR2BHXksxqb2G1KFHUhKDdsVFtA7dnMzYVwnpziKtHmLattaA6x
         P1FnWmQNQaAou+Uwc+cmpdSWtLmP9SJ2gRcQjE0KhbOZDgERvj50ZKjAmRaLZn3zKK1O
         rHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kNSCiHNHSb6jIhG+JaGhvWbvnCv4GNFP8GZBjcVO0Y=;
        b=lvEjKdoEUY7mWVsUf93g2qh3Um0xXIU3Z8Sfbbo1X9py4TKxP8CpybRpcQdozO0Lj1
         4dH+CVvkYFdbK2s+I+BarvYVxyHXcUqlCpatvr6/OkF9T3pjm6JiHUppZ8UkasFvJfWw
         enLHOhqixrt43+RMEGmxhAZyM3EdAXY4UriSu3yJ5fiRjYkQSrvI11YyfCgCNy0mgqgL
         PCzscNjmB/v7cxK2LYxS6Kbk8JhxPRbkwxStil1LagV4A7pWJsTcfi2X20Yr1FroXnnt
         ualarfW5rtpA1CirWWHygRnfm/6VsvI2Az0X5XpB0wUuIhORVsA8gtlqCTA10g8e1NfC
         tV+Q==
X-Gm-Message-State: AOAM530fyXx5CIxFtFBNVmRnsW0cfNtPJeezG9xuzPOC1PakMX9KSk+p
        H3Sab1RlyqXrKHV2ECMP6VFrCZ+uua4=
X-Google-Smtp-Source: ABdhPJxPjqWrG39q9awzXKeB5MXv4YUXUaJP0+B/iWs3190cB3S0L3qYXloC/o4T6J/Sv50uR1AkYA==
X-Received: by 2002:aa7:9abc:: with SMTP id x28mr885223pfi.39.1593143519452;
        Thu, 25 Jun 2020 20:51:59 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id k2sm21272108pgm.11.2020.06.25.20.51.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 20:51:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        Quentin Perret <qperret@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/3] cpufreq: Specify default governor on command line
Date:   Fri, 26 Jun 2020 09:21:44 +0530
Message-Id: <7eb38608b2b32c0c72dfb160c51206ec42e74e35.1593143118.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1593143118.git.viresh.kumar@linaro.org>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <qperret@google.com>

Currently, the only way to specify the default CPUfreq governor is via
Kconfig options, which suits users who can build the kernel themselves
perfectly.

However, for those who use a distro-like kernel (such as Android, with
the Generic Kernel Image project), the only way to use a different
default is to boot to userspace, and to then switch using the sysfs
interface. Being able to specify the default governor on the command
line, like is the case for cpuidle, would enable those users to specify
their governor of choice earlier on, and to simplify slighlty the
userspace boot procedure.

To support this use-case, add a kernel command line parameter enabling
to specify a default governor for CPUfreq, which takes precedence over
the builtin default.

This implementation has one notable limitation: the default governor
must be registered before the driver. This is solved for builtin
governors and drivers using appropriate *_initcall() functions. And in
the modular case, this must be reflected as a constraint on the module
loading order.

Signed-off-by: Quentin Perret <qperret@google.com>
[ Viresh: Converted 'default_governor' to a string and parsing it only
	  at initcall level, and several updates to
	  cpufreq_init_policy(). ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 Documentation/admin-guide/pm/cpufreq.rst      |  6 ++--
 drivers/cpufreq/cpufreq.c                     | 36 ++++++++++++++-----
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..8deb5a89328a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -703,6 +703,11 @@
 	cpufreq.off=1	[CPU_FREQ]
 			disable the cpufreq sub-system
 
+	cpufreq.default_governor=
+			[CPU_FREQ] Name of the default cpufreq governor or
+			policy to use. This governor must be registered in the
+			kernel before the cpufreq driver probes.
+
 	cpu_init_udelay=N
 			[X86] Delay for N microsec between assert and de-assert
 			of APIC INIT to start processors.  This delay occurs
diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index 0c74a7784964..368e612145d2 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -147,9 +147,9 @@ CPUs in it.
 
 The next major initialization step for a new policy object is to attach a
 scaling governor to it (to begin with, that is the default scaling governor
-determined by the kernel configuration, but it may be changed later
-via ``sysfs``).  First, a pointer to the new policy object is passed to the
-governor's ``->init()`` callback which is expected to initialize all of the
+determined by the kernel command line or configuration, but it may be changed
+later via ``sysfs``).  First, a pointer to the new policy object is passed to
+the governor's ``->init()`` callback which is expected to initialize all of the
 data structures necessary to handle the given policy and, possibly, to add
 a governor ``sysfs`` interface to it.  Next, the governor is started by
 invoking its ``->start()`` callback.
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e798a1193bdf..93c6399c1a42 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -50,6 +50,9 @@ static LIST_HEAD(cpufreq_governor_list);
 #define for_each_governor(__governor)				\
 	list_for_each_entry(__governor, &cpufreq_governor_list, governor_list)
 
+static char cpufreq_param_governor[CPUFREQ_NAME_LEN];
+static char default_governor[CPUFREQ_NAME_LEN];
+
 /**
  * The "cpufreq driver" - the arch- or hardware-dependent low
  * level driver of CPUFreq support, and its spinlock. This lock
@@ -1061,7 +1064,6 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
 
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
-	struct cpufreq_governor *def_gov = cpufreq_default_governor();
 	struct cpufreq_governor *gov = NULL;
 	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
 	bool put_governor = false;
@@ -1071,22 +1073,29 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 		/* Update policy governor to the one used before hotplug. */
 		gov = get_governor(policy->last_governor);
 		if (gov) {
-			put_governor = true;
 			pr_debug("Restoring governor %s for cpu %d\n",
-				 policy->governor->name, policy->cpu);
-		} else if (def_gov) {
-			gov = def_gov;
+				 gov->name, policy->cpu);
 		} else {
-			return -ENODATA;
+			gov = get_governor(default_governor);
+		}
+
+		if (gov) {
+			put_governor = true;
+		} else {
+			gov = cpufreq_default_governor();
+			if (!gov)
+				return -ENODATA;
 		}
+
 	} else {
+
 		/* Use the default policy if there is no last_policy. */
 		if (policy->last_policy) {
 			pol = policy->last_policy;
-		} else if (def_gov) {
-			pol = cpufreq_parse_policy(def_gov->name);
+		} else {
+			pol = cpufreq_parse_policy(default_governor);
 			/*
-			 * In case the default governor is neiter "performance"
+			 * In case the default governor is neither "performance"
 			 * nor "powersave", fall back to the initial policy
 			 * value set by the driver.
 			 */
@@ -2796,13 +2805,22 @@ EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
 
 static int __init cpufreq_core_init(void)
 {
+	struct cpufreq_governor *gov = cpufreq_default_governor();
+	char *name = gov->name;
+
 	if (cpufreq_disabled())
 		return -ENODEV;
 
 	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
 	BUG_ON(!cpufreq_global_kobject);
 
+	if (strlen(cpufreq_param_governor))
+		name = cpufreq_param_governor;
+
+	strncpy(default_governor, name, CPUFREQ_NAME_LEN);
+
 	return 0;
 }
 module_param(off, int, 0444);
+module_param_string(default_governor, cpufreq_param_governor, CPUFREQ_NAME_LEN, 0444);
 core_initcall(cpufreq_core_init);
-- 
2.25.0.rc1.19.g042ed3e048af

