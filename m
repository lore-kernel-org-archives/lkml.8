Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44331C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B4720657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIYma6QY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgGOI0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbgGOI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E36C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so4679665wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMXxo9aOlmaJXA2Fa0TTzO8LQVMEninajvd8D9uCCWE=;
        b=RIYma6QYVJVX6sqCjeZBICMdCBquDgYeFce4Jjorpqiq7zVo3szfhUm4pDcZJS/EP2
         MgHKxk8sbYqPhINXT+ihq7Z+FPUL88ygpZTR9S9keXtmRiQkBEAZU9wOg7IepglGZ5V3
         7Uatq6z9XXTfwuVtrVswMQnZS2m6VM6sc+tdRkNX+ZWjljHPeHVXCfTCLd47ZSHaf3wP
         ITNYuyx5yxK4Z8HU14+yXtYr7qEePdUPEPa7trGn7u2t6HuscGs4dP6QwfwbGpQIOblg
         V8VevTZOBiVo6MxkEFM/i/sakGOYb4E9xmukn6RPywOIHyTwKTuAomGD/vQRObzaHIuF
         HWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMXxo9aOlmaJXA2Fa0TTzO8LQVMEninajvd8D9uCCWE=;
        b=fbNjJ6wMHkX6bZaUeSw9Oo3YwGWPxevF+Dv8TUz2rCAiZl1sWZFcRYYerwzEtMtvjc
         oDI7objJFzGUeccG+hCmSpXz9whYdvrXrN2NIoOA8bfIW2js65mKs4Bc+U+WQyUnaIwD
         xty+i1jBsTel499JbwC8bY1LnfxDCHDZ0LofQhA2MON4xjN0ELTBVeTD5SWNZmZrk4lz
         poZWHCLxDssFmWudjT2XdKEMgNRGLJUvRv1v0RNW6SYhBztODapSUZ/ckxUuhnCVrzzM
         np3Y2bvlGAGINRF7HD3yf6Co8G+ScrczGjSv94Capj4Wa6ktfSyUBfvTtbGdPqC2Hr1v
         5O4Q==
X-Gm-Message-State: AOAM5331n9Lp5TKU8QPd46RxxV6evTTvdQLz9FR7IyeYakFlbyotnHUF
        eucmnbT0D8eeeV7wq3rsLZxk8A==
X-Google-Smtp-Source: ABdhPJyCnyWAqwU40ixVBQHiLrpni7isN58Y6lCuAZSqR0npV55Xqhe8wF3lYeKfhxhebjg5JL4nHA==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr7405874wmc.109.1594801603021;
        Wed, 15 Jul 2020 01:26:43 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Pal Singh <ajitpal.singh@st.com>
Subject: [PATCH v2 04/13] cpufreq: sti-cpufreq: Fix some formatting and misspelling issues
Date:   Wed, 15 Jul 2020 09:26:25 +0100
Message-Id: <20200715082634.3024816-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc format for attribute descriptions should be '@.*: '.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/sti-cpufreq.c:49: warning: cannot understand function prototype: 'struct sti_cpufreq_ddata '

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Pal Singh <ajitpal.singh@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/sti-cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 8f16bbb164b84..a5ad96d29adca 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -40,11 +40,11 @@ enum {
 };
 
 /**
- * ST CPUFreq Driver Data
+ * struct sti_cpufreq_ddata - ST CPUFreq Driver Data
  *
- * @cpu_node		CPU's OF node
- * @syscfg_eng		Engineering Syscon register map
- * @regmap		Syscon register map
+ * @cpu:		CPU's OF node
+ * @syscfg_eng:		Engineering Syscon register map
+ * @syscfg:		Syscon register map
  */
 static struct sti_cpufreq_ddata {
 	struct device *cpu;
-- 
2.25.1

