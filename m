Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF61C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799EA20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRaZNdmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgH0FYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgH0FYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:24:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA6BC061244
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:24:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so2510773pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 22:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWnOmZQiE1diGG7f4xMEwIVX10lb7UFm+giUYyHedJQ=;
        b=kRaZNdmGKAg4HLrE/uGXgzjrobjeg9t/Pk1pY/YiXJZG9LKcE3HWgvpc4pXBQdT/Dp
         BaxA6FsrvZamlFnpGRQfXE9kC616WOSDQ+UkXmHO/nVFHtVRF3KfvAlKf0HVXh4O9ED3
         RpTwruLbf3b8F+mcY1Z9kMuuz7h6G9SICrgihKOAfx8BPtrYjBw9dDEDjZ3f2Y2aCD7b
         /uQWeevM+9Lk0bvjrRJMSn9D+v/jHpvXY+fyM2NVl5fuXGJMU35CMX3EOqBr5vRBq9gw
         cUI0oG4KZ6HRY4MaES8SY9+2m1Wx2QSkcsw8LU7zafJbDKf4IVnSwo9VMnNgBjCljAp4
         OBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWnOmZQiE1diGG7f4xMEwIVX10lb7UFm+giUYyHedJQ=;
        b=t8FGwLOwdgsGObhOPPhUxwHQo3M4NfnijTdr+GS952XDwjWTSvLTAjpUG4hffC0Ybb
         jIa8+xSzYTOH1i9pAs+Agt1va9+6rNeyGqOkr3CHetcWADttBJ7JKCL2nzCjXiHBMren
         R8YQYUOoUy2OovbrXArhVIvEIhPZb2NbDPwRax/1ww+KcpeNyXaxeaOlZspVnPfodfEO
         jUNnGkA1mLOfsFzZbD322jGNbMq5k2t0F6UgX/CB7fcr0Ncdd0sRPr6QQEGFF76x2fIe
         b/dUGRiSksR8KLxTUivF/VgCTNy7WcbYIVAbeZTSYw2PskT9PyyAcQz2HqTKn2vA/wxx
         Mdrw==
X-Gm-Message-State: AOAM531Cbc2CC322PPfHd5k2fY4cse6cyDKK8p9LJd3q+WeEBtH4Cc6O
        HMAbUzTOZviXtNIKALV8UDnJWw==
X-Google-Smtp-Source: ABdhPJzLh8QWqb6t7LN/bIJ2Bx9v84RwevI1yawLpJgTb5mA0YA9lIcxzQ+ainiIvHZ6F4jr/Q+fXA==
X-Received: by 2002:aa7:91ce:: with SMTP id z14mr7473320pfa.241.1598505861790;
        Wed, 26 Aug 2020 22:24:21 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id mp1sm858405pjb.27.2020.08.26.22.24.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 22:24:21 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: No need to verify cpufreq_driver in show_scaling_cur_freq()
Date:   Thu, 27 Aug 2020 10:54:15 +0530
Message-Id: <906198d77aa73613a1b588425aa45e5025ee60cb.1598505843.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"cpufreq_driver" is guaranteed to be valid here, no need to check it
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02ab56b2a0d8..47aa90f9a7c2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -703,8 +703,7 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 	freq = arch_freq_get_on_cpu(policy->cpu);
 	if (freq)
 		ret = sprintf(buf, "%u\n", freq);
-	else if (cpufreq_driver && cpufreq_driver->setpolicy &&
-			cpufreq_driver->get)
+	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
 		ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
 	else
 		ret = sprintf(buf, "%u\n", policy->cur);
-- 
2.25.0.rc1.19.g042ed3e048af

