Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2099AC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 19:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED45220739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 19:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFSkxNik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgCUTbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:31:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37710 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCUTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 15:31:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so11654929wrm.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tAhMZYvG/G7C+UxGyPYY7dK/Sq4D4s4ohO0yGJZTXxY=;
        b=SFSkxNikzlUEPoZZkz9LGgx8W0ZYrakIf9SQ2cED+xBRql8xEffMwXkqluyb7PYY2D
         MrPKftWf9bd/BJV6ZAdi573Gp+F7dSKXAswYTRvUTubdzO6nIuYDgE4rVLNvsdMmbBn3
         fGVuGxYINpcwDlYoZ9OBMMFny6gPsg9dqoFbqXwtQk8zTn7esFWJE6l2FGikN/AluTwT
         HjZLD27u0oiAwJlawipPVhVgrhaIQyVOoZOhawyJ2jGaqC1VoeeUiEWbc0DZWjtuR+N5
         vPZwwKc6+7O9JFOZJUt010k8EM+Dj/BZqtkwhICSdbd8czvcrvktfcjMNQXz2gA/Rlbw
         6gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tAhMZYvG/G7C+UxGyPYY7dK/Sq4D4s4ohO0yGJZTXxY=;
        b=dhJlYXgsMU6hEwALbrigiyCbJ7C0aySudAbKCtq6OfYyihj12FQ1gXOdc5Exqd+7ue
         Yb8p9rdp4pnHlSdX/nLBrgq0/iAzMVxGcpJkQCP8aSiEoSCLMQWpBN3pkRaOWtdbyQf5
         OlKxxcKTj0/7VeWn9DCsoGxGku9rNLzSm4I3YGiVdhBBHqhIdBh87r8HNLLTc81qMNfI
         PtGDOE7G5qYP5ycv18IuIn63c9U4BRnO5P/SWSmxNbqBelWQ2qe09rgKkHhz6wojuY0E
         YoT6l/tneN3zmN7f7M59xb3g09mq2+GoT/DH9ByJhMv+38g4CqpGdzOS9igK8H3dLjyK
         3s3A==
X-Gm-Message-State: ANhLgQ2dytXumqzQH8AKn+oZuF54QqpkVHem5sQtT7svQqDCi1CTPYaA
        9THKfW0ISC3X/N5oktMxeLavGA==
X-Google-Smtp-Source: ADFU+vviGuHhsNoh791a6fmt5zGMi1TMVN4TNwD7gf+jlyLbXgSp/3Ucq0V4kGML+qzTr1054nIAgQ==
X-Received: by 2002:adf:f88b:: with SMTP id u11mr16031186wrp.84.1584819112216;
        Sat, 21 Mar 2020 12:31:52 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:ca2:a5ed:e238:a0c0])
        by smtp.gmail.com with ESMTPSA id n124sm8990714wma.11.2020.03.21.12.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 12:31:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/drivers/cpufreq_cooling: Remove abusing WARN_ON
Date:   Sat, 21 Mar 2020 20:31:07 +0100
Message-Id: <20200321193107.21590-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WARN_ON macros are used at the entry functions state2power() and
set_cur_state().

state2power() is called with the max_state retrieved from
get_max_state which returns cpufreq_cdev->max_level, then it check if
max_state is > cpufreq_cdev->max_level. The test does not really makes
sense but let's assume we want to make sure to catch an error if the
code evolves. However the WARN_ON is overkill.

set_cur_state() is also called from userspace if we write to the
sysfs. It is easy to see a stack dumped by just writing to sysfs
/sys/class/thermal/cooling_device0/cur_state a value greater than
"max_level". A bit scary. Returing -EINVAL is enough.

Remove these WARN_ON.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index af55ac08e1bd..d66791a71320 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -273,7 +273,7 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
 	/* Request state should be less than max_level */
-	if (WARN_ON(state > cpufreq_cdev->max_level))
+	if (state > cpufreq_cdev->max_level)
 		return -EINVAL;
 
 	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
@@ -434,7 +434,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	int ret;
 
 	/* Request state should be less than max_level */
-	if (WARN_ON(state > cpufreq_cdev->max_level))
+	if (state > cpufreq_cdev->max_level)
 		return -EINVAL;
 
 	/* Check if the old cooling action is same as new cooling action */
-- 
2.17.1

