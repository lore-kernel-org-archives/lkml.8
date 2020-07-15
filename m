Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC7BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A510420663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbH8taSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgGOI1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbgGOI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82D8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so4708748wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9K0sP4k999M7LgtJ1hbosTLECoGAC+DHglKiGxOGJ0=;
        b=jbH8taSV1R0R0HA1uoMe9Xx/Wt4K2Uyeqr/sfT7vIKbeXYYPFVmYIBVvgtpcsafHLG
         rL9xG7X3IBgk+gEIVfF/ZgovOEM6oCc06NYJf2yafwTpZpRohRlMIt7UKkYneqnjDzf9
         Q+G9e1TXvwRMMxzsX5PbQPcCfgxEO+7JzBHU7TuqIR+Rd5ooXv1DcoqDaTO8u3qEU4Ys
         IY/PoPKS4GTCsT4uNiHV6kSR5eUvMArOVE7EOoW9TPEGls+Bzpml1UbhrKSY7dfON8y5
         3AE3hMZc830fDz2wNUfDbX2jhKzGlaBP4pX0lFpHa1xt/hCKDU3eDUMdRcJ5eTpmt5al
         +Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9K0sP4k999M7LgtJ1hbosTLECoGAC+DHglKiGxOGJ0=;
        b=LgXIR4vtHt/IUscWQ/xvi2E6MTRNQ0wlOcxSn4OhEAUJfji5mpgXqQKOtXol2RWMZm
         lvJknFWRMd21JINBumpRw86Y9tNVge9xnBARMc3o3eVvAwQrps7BuSc9VjJ4QDnQXj4g
         mQs7495v1jhmU6ia6EwczIMwqjPz6ma16aTJjb7hZ3FE/KthKyuGZSdmRVDHg0bZpzRT
         Kpp3qrydT/FXi+uDB0jDf8DHoLRq/IeB6ZvHB6ittswyJEkKaqg6ESzzxZQupaZsoS/N
         6qvu2AcIqdK1pjVACuLxrSOKHAwWPowvGX5VAPqCvzAtq1b2QXkxa1z+QCjx4f+3gNH/
         l8ig==
X-Gm-Message-State: AOAM5318k+0OWCM8q3n4CKtq9GZrH5bWN6Gk+pVrboC7UiSgAtQYnuH3
        USN3qmkDV/+L28hWQE0fmBG4VA==
X-Google-Smtp-Source: ABdhPJx8hFJwy5mvfeQUMNX/b5bn1VGj7HPDqWqfA7V5iQIi2oISZQihLgJdW/LeiPD/u4P1E/WmVw==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr7281164wmk.138.1594801614566;
        Wed, 15 Jul 2020 01:26:54 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jacob Shin <jacob.shin@amd.com>
Subject: [PATCH v2 13/13] cpufreq: amd_freq_sensitivity: Mark sometimes used ID structs as __maybe_unused
Date:   Wed, 15 Jul 2020 09:26:34 +0100
Message-Id: <20200715082634.3024816-14-lee.jones@linaro.org>
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

ot used when MODULE is not defined.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/amd_freq_sensitivity.c:147:32: warning: ‘amd_freq_sensitivity_ids’ defined but not used [-Wunused-const-variable=]
 147 | static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~

Cc: Jacob Shin <jacob.shin@amd.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/amd_freq_sensitivity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index f7c4206d4c90b..d0b10baf039ab 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -144,7 +144,7 @@ static void __exit amd_freq_sensitivity_exit(void)
 }
 module_exit(amd_freq_sensitivity_exit);
 
-static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
+static const struct x86_cpu_id __maybe_unused amd_freq_sensitivity_ids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_PROC_FEEDBACK, NULL),
 	{}
 };
-- 
2.25.1

