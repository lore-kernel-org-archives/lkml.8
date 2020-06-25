Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5908C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62A420781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k36VGpGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404180AbgFYLO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404130AbgFYLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:14:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB158C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:14:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so5149307wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R/lDDVQxBaGyt+9YnrsQ1wKsoAv0GGQeOtACQNKqcjA=;
        b=k36VGpGdF5OlhC+8f1yEnrrYH8Ad3A5QPOITnITknSyJCbzwoGN78Phj6ZxCGzPxxP
         kfqk0XRGUZAuVYSSfevip8RpnneAjP5HY01vLdRN5mv4/0MIGvIsFV3roI86k/FdQd1Z
         uUJGRXZtkTjCxdIJ2qRbkCYpAm0K65IdTCXNicemA5LBSda8pFhWChhQzbzA5n4TlUX9
         4kfmO3h6SmX/YkuH7DPpSGNQgLCdbhpjbA+54w5Y/6tVi7qbP1E9IVRjb5cBuvRJ4f53
         OIwi1yoa8kGusFkZ9fR7tPZ00ZUEZVhYc6PMH0UqC/xrkyll6mHxz6S5UiYMgpk1f14c
         csvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/lDDVQxBaGyt+9YnrsQ1wKsoAv0GGQeOtACQNKqcjA=;
        b=QYbvVJkhH/RVf9LTCnM4FGOd6Y4NjohYQjInBGWrPVHPB5LAtchaPe3eJ9amHr8t99
         SE55e/5Cym4uCSsft/XGFVwJVNCmyyCwZP0HlEf/3SamO1+s0xCUhdE6hZZHbyFhbC/7
         zoGSWafEaw7ZtT9IEbrljKHfymXETdNnjfHbMAxkvn7Ib3/B4c6v0zmyoRT2Lv9s0z0W
         PjYKxU2EfAzLAZ2gcnr/kWRBeu0x7zag+D0LCdaWrgfeNpq50O5q93lol4OELVrpLYv3
         JU9rR40o4yKneQWh+ay8c8/WNZSnvr2kovHVy87cQmEYgxMmEV522SzzpLgjoYpcroCz
         xXdQ==
X-Gm-Message-State: AOAM530MouIfjaQHkuVQglSY6ZFxyqLbVm5C7tPUxEOQeGbbCDjehmb5
        b62ihlFfpjKCA1o31VxgYkN/3A==
X-Google-Smtp-Source: ABdhPJxgdPBbbMLdq/cmKASgPLLX/kkQN2E3eojVcP9qm12NwASF3dDjPJXzHTgAZP6ShUd3wYJ70Q==
X-Received: by 2002:a7b:cb0f:: with SMTP id u15mr2850767wmj.34.1593083696262;
        Thu, 25 Jun 2020 04:14:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id f14sm14454978wro.90.2020.06.25.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 04:14:55 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:14:52 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Fix locking issues with governors
Message-ID: <20200625111452.GA200288@google.com>
References: <49c7d64460cdb39b006991e5251260eb0eea9f2a.1593082448.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c7d64460cdb39b006991e5251260eb0eea9f2a.1593082448.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Viresh

On Thursday 25 Jun 2020 at 16:24:16 (+0530), Viresh Kumar wrote:
> The locking around governors handling isn't adequate currently. The list
> of governors should never be traversed without locking in place. Also we
> must make sure the governor isn't removed while it is still referenced
> by code.

Thanks for having a look at this!

This solves the issue for the reference to policy->last_governor, but
given that your patch is based on top of
20200623142138.209513-3-qperret@google.com, 'default_governor' needs a
similar treatment I think.

Perhaps something along the lines of the (completely untested) snippet
below?

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index dad6b85f4c89..9d7cf2ce2768 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1062,6 +1062,17 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
 	return NULL;
 }
 
+static bool get_default_governor(void)
+{
+	bool ret;
+
+	mutex_lock(&cpufreq_governor_mutex);
+	ret = default_governor && !try_module_get(default_governor->owner);
+	mutex_unlock(&cpufreq_governor_mutex);
+
+	return ret;
+}
+
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
@@ -1073,20 +1084,21 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 		/* Update policy governor to the one used before hotplug. */
 		gov = get_governor(policy->last_governor);
 		if (gov) {
-			put_governor = true;
 			pr_debug("Restoring governor %s for cpu %d\n",
 				 policy->governor->name, policy->cpu);
-		} else if (default_governor) {
+		} else if (get_default_governor()) {
 			gov = default_governor;
 		} else {
 			return -ENODATA;
 		}
+		put_governor = true;
 	} else {
 		/* Use the default policy if there is no last_policy. */
 		if (policy->last_policy) {
 			pol = policy->last_policy;
-		} else if (default_governor) {
+		} else if (get_default_governor()) {
 			pol = cpufreq_parse_policy(default_governor->name);
+			module_put(default_governor->owner);
 			/*
 			 * In case the default governor is neiter "performance"
 			 * nor "powersave", fall back to the initial policy
