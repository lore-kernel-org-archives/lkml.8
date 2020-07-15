Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389F5C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F9B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNLsrisc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgGOI0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbgGOI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7770C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so4708289wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FEE9EyuKEElP2R0dGV5iQicdnI3vcbhmFFoLiz/bvg=;
        b=dNLsriscR4hsRjVJy5HJ61IIk4PpwYkqGkI3F3kDQQeDKRecSXlq3RsNQY2oCbqvYr
         yZK14gsEQVw7xlfvTfZM7JvCMqfvlrQVrrqRtn83MdQ71BOFT0hZL8oC5qbgiEx20dXq
         AhE5zLi6V299vlhGlmf96yVFf+aEYUzYOT21qrkVWe/b5KHV8IjzCsqL+yoJCjR+6QTS
         qoCDhHlD5wC1lXiQlu+TjLdoU+qrC3Egi+XR2EqRUqbwFO56nK2tBacDB/dP9AGYQsp4
         6xzTC0Fl0UxZFy7pe5bgbzmpQWKzHYZ/6nMwAUfRIVIfqPQHKtwzaKcds55p7jwTV7si
         eTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FEE9EyuKEElP2R0dGV5iQicdnI3vcbhmFFoLiz/bvg=;
        b=nURh4+VVxPuUG4WQrPJt+wh/2IXcu8onxUGuM9NhbX+sUoj+ib2Gweq2/TzaoEF/Vw
         8cv0UsmKKA3Ayf7tejonJntCJwGXBhlqLmqrbKy85IQrltwlY/+CCalF8VkowrhHNMny
         Z+Dwi7STOxzro0mjcYFeG2539/5kXw6V8n+L/NB5XhjuRNKkhYx/dzx4LhZAwgdBZCoA
         DoJcUr4V6ZNjnehnSU9YL8+S66Ln33qn9bTnlYV2EiPdqAwFylxDGyAR7yTAwswofA3A
         1gw/2EIVHq72uJjiHfyhhGLjUOH+2A9F0MEPibvZwun7KPSsIIWONQodmSwvxbOGeYEj
         62Ww==
X-Gm-Message-State: AOAM530MjkYef1sIFlcDqmqNKaqepL4eEkh1WUjJrP9BwDDEBZssCz0s
        AuSC+hAFkvbsoQdy8Nq8Dhjfww==
X-Google-Smtp-Source: ABdhPJyFYPMmX9IE6VXwHxqc8TKSlBqseWdICHouNyIBW5KtvQh/NAXsNlCEjrx8/rQmYCNCLa2C6w==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr7896351wmi.114.1594801605457;
        Wed, 15 Jul 2020 01:26:45 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/13] cpufreq: powernv-cpufreq: Functions only used in call-backs should be static
Date:   Wed, 15 Jul 2020 09:26:27 +0100
Message-Id: <20200715082634.3024816-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/powernv-cpufreq.c:669:6: warning: no previous prototype for ‘gpstate_timer_handler’ [-Wmissing-prototypes]
 drivers/cpufreq/powernv-cpufreq.c:902:6: warning: no previous prototype for ‘powernv_cpufreq_work_fn’ [-Wmissing-prototypes]

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 8646eb197cd96..068cc53abe320 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
  * according quadratic equation. Queues a new timer if it is still not equal
  * to local pstate
  */
-void gpstate_timer_handler(struct timer_list *t)
+static void gpstate_timer_handler(struct timer_list *t)
 {
 	struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
 	struct cpufreq_policy *policy = gpstates->policy;
@@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
-void powernv_cpufreq_work_fn(struct work_struct *work)
+static void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
 	struct cpufreq_policy *policy;
-- 
2.25.1

