Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1571FC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7257207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWPSGWqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIBHZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgIBHZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:25:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C54C061246
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 00:25:08 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m5so2096583pgj.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QakrURdUkg4E7FIP/CypxAR9NETwtzt47NN+BbaWNug=;
        b=RWPSGWqX08GKXFj5iHZkTa+y4XaDiqWxfL0yK70eGkiIQN/S+3ikTN0IFRwKKzRIyd
         Ej9S4ynaTJ8vNfXb1YWWnbA3UTwhzXnj0zsmh4prkdWZFzYo0tPp9PWLbx33SVHDDTaK
         hnL/GS/yLVwSq7nixL0qoJPEOxAbKkRI37eZTn//vbrdPQM5eIPVB67m4BQ5azV4JvmP
         /MP14dCT6xZe3lW9hFQJRu6dmVgpI2yqe1PBG9cLmX+jmK+RIMV/IXgNBQQ+SYJpcdRy
         h4a8vAsrw+ByO0Bi346aRy9Kkhcut78cS0bAtFECh5KYUSzsMjr5oQWOa1OXVY2fhD5t
         dcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QakrURdUkg4E7FIP/CypxAR9NETwtzt47NN+BbaWNug=;
        b=QPF8LyAC6RapZdeCeb3501t1wrI4NBNz5iihxloYO+fg0Cmdp8TA2fI57/+m+FxIQl
         2WHk9sCFh/cO090Y2JVHSTsjUwHiIne8k6VcZXZMSXRQwfQyKLWoCwoFY5V4Ie3aCyhv
         AWYj46q8gOLeoOUhRUV501qP5RIOTmwY6rEw2Tx4g4K9CFh1lz31tVdV232GsJyqDrQa
         uRnrvV9/9/sxc9xa5EZ0ODPA1QJUsC7WY0Y6c4zIqnaWnXZiDkJ0GGmph59LsNa/3Xow
         VIDgEIWRFADvWs7BxOZ0L5VmqT6UEWHW64+9NNyBmsggFBvbzbahIQi0hu20pYn+WsGZ
         5sog==
X-Gm-Message-State: AOAM5315qUgQx4W8XgmBRn0CfmYzOZBWFMRDnTJBEmCZkjwlpod4do9n
        8AE8eonekNBTFuV6e8Yk8E7H+A==
X-Google-Smtp-Source: ABdhPJwYKPhGLgGgRTPpDmiSBrRJWDy3BvG7NKeo7XSr+SuLuefADDOnU7M/eyr65Jt0d2n9JeEtzw==
X-Received: by 2002:aa7:8646:: with SMTP id a6mr2054058pfo.54.1599031507740;
        Wed, 02 Sep 2020 00:25:07 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id k5sm3656831pjq.5.2020.09.02.00.25.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 00:25:07 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cpufreq: stats: Enable stats for fast-switch as well
Date:   Wed,  2 Sep 2020 12:54:43 +0530
Message-Id: <6a25f7c9c96dc25bb2acf26b4ab58ed954113965.1599031227.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1599031227.git.viresh.kumar@linaro.org>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the blockers are gone for enabling stats in fast-switching
case, enable it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c       | 6 +++++-
 drivers/cpufreq/cpufreq_stats.c | 6 ------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 47aa90f9a7c2..d5fe64e96be9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2057,8 +2057,12 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = cpufreq_driver->fast_switch(policy, target_freq);
 
-	return cpufreq_driver->fast_switch(policy, target_freq);
+	if (target_freq)
+		cpufreq_stats_record_transition(policy, target_freq);
+
+	return target_freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index d86ea9744649..06b5ee12f3b2 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -69,9 +69,6 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i;
 
-	if (policy->fast_switch_enabled)
-		return 0;
-
 	for (i = 0; i < stats->state_num; i++) {
 		if (pending) {
 			if (i == stats->last_index)
@@ -115,9 +112,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i, j, count;
 
-	if (policy->fast_switch_enabled)
-		return 0;
-
 	len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
-- 
2.25.0.rc1.19.g042ed3e048af

