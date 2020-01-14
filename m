Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D104CC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A815D24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zo9V5ClK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgANT55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:57:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35069 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgANT5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:57:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so13618059qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OghplwU/tPhbSguv+TUOhHr2qr6XCiHT707bOgXEuSc=;
        b=zo9V5ClK6c10cKd8Lfx3psNwT8Q1bV0KAI4GPm+30DCNGBzGipK+hHdvdh0GoHb1id
         SWIXRhySHoyye3YNtYBk4qV7g68iDpAfLrdEgRYyhyfd3nVaHLQXISuRFzeKLNHdy385
         m3dtOtEF/hzK33G/mG0KRrr4wNLKHvCnUG3f2QJmyjyY4yxRq2EKSl3xPqpdG3HHX/gl
         +3t6G+js1Iu5Q8PZYA920KSQ9rTFhL68qqlF1YUy/Ktf5NkxSzJOckqgtAhbBUXw96M4
         HSft7lw+xwXyYre4ikKiyUJYHHgF/NR2FrW6pFzyHEukgO3QULGRyg/LYo/UBn9So+Js
         vrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OghplwU/tPhbSguv+TUOhHr2qr6XCiHT707bOgXEuSc=;
        b=uRxYNfqtASNqnCIsGZehVStxokxoPmNk3musqS6A/IH/tNmEUGuMq03nRG3G1d+gFL
         AKkhxO3hs5g4Q4ZnzEVXbpDolvXGWU/pwJLc7A/S42ZwFFN57yjeDT+2n0hWSkrmFpUP
         31Eh6i/Qde/YgEYytN+nO84egEQYcKECt8x1iOnppCs32rt+TQpS6CBphLy3klSHTM/l
         kYlqlTbg5gfd10tdNoq0nbLfXAU2Gw2R6CPEdUfIKQMW2eTQiDNJnBlFWDMc6BgqYOGj
         u4I09cA07qcUeSxKqxrFs2Gt5btrMZKm+NQWZOxVwwBvznVgrM3/HCGsRAC3wz5Vvdpa
         OjFA==
X-Gm-Message-State: APjAAAUQHpovTfixUMJgwXv0t2gY2sb/G4wA7XKP8j1keXo+p0AIjAe0
        mWD3OuG9I5On0QwSIOgpeKLpIg==
X-Google-Smtp-Source: APXvYqwrG0hSVvxZVSQ6XStJSC5wgZ9J3n5LHFBl0nrSWEhy9J5TGsTzHMqLhCQGe30qCrqFQTX3Eg==
X-Received: by 2002:ac8:5215:: with SMTP id r21mr243796qtn.77.1579031873992;
        Tue, 14 Jan 2020 11:57:53 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id b81sm7183497qkc.135.2020.01.14.11.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 11:57:53 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v8 6/7] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Tue, 14 Jan 2020 14:57:38 -0500
Message-Id: <1579031859-18692-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal governors can request for a cpu's maximum supported frequency to
be capped in case of an overheat event. This in turn means that the
maximum capacity available for tasks to run on the particular cpu is
reduced. Delta between the original maximum capacity and capped maximum
capacity is known as thermal pressure. Enable cpufreq cooling device to
update the thermal pressure in event of a capped maximum frequency.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v6->v7
	- Changed the input argument in arch_set_thermal_pressure from
	  capped capacity to delta capacity(thermal pressure) as per
	  Ionela's review comments. Hence the calculation for delta
	  capacity(thermal pressure) is moved to cpufreq_cooling.c.

 drivers/thermal/cpufreq_cooling.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index fe83d7a..4ae8c85 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -431,6 +431,10 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	struct cpumask *cpus;
+	unsigned int frequency;
+	unsigned long max_capacity, capacity;
+	int ret;
 
 	/* Request state should be less than max_level */
 	if (WARN_ON(state > cpufreq_cdev->max_level))
@@ -442,8 +446,19 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 
 	cpufreq_cdev->cpufreq_state = state;
 
-	return freq_qos_update_request(&cpufreq_cdev->qos_req,
-				get_state_freq(cpufreq_cdev, state));
+	frequency = get_state_freq(cpufreq_cdev, state);
+
+	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
+
+	if (ret > 0) {
+		cpus = cpufreq_cdev->policy->cpus;
+		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
+		capacity = frequency * max_capacity;
+		capacity /= cpufreq_cdev->policy->cpuinfo.max_freq;
+		arch_set_thermal_pressure(cpus, max_capacity - capacity);
+	}
+
+	return ret;
 }
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
-- 
2.1.4

