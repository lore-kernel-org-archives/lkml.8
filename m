Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E98C43445
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B30F20672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDfyeeeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgGOI11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbgGOI0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19273C08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so4683287wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqiGjo2A+JuWYmJhOxUeBH7YynB0Z20iJW99N6uR5uY=;
        b=CDfyeeeQ8Et3gI4BeM9nFnG0rJHPytBjxmubMrji/xwR7Y/4y1u7qdOOK7R0COCM4j
         DixdnjvwrQY/XWYwRHdWwC/lexyC3w/Zw35GVuHu21hHXhW7No33wZJyu4URGeL8PpVJ
         WYR4aiH1P1yPpX0wpis2ygq1Al65X2lq0zbOkuLm8i4Fsj9/Qagc0/HsjhXnyB4R83Pk
         Yx531xndHS0pnQQ097IVLNzLELQIIj1zWpd/xpKcfRZUcF8+RQPusKV8eWdxB4CrJmTy
         DNfP0/wzD8uznhQXNoZkppTa1N8/gXGTe+ygny5+WLNSIX0XJhr4bKlOP7t0zA/MYq60
         r9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqiGjo2A+JuWYmJhOxUeBH7YynB0Z20iJW99N6uR5uY=;
        b=WL5/oAb5IfOA7v5z7OsQMgmcbXVSfobQi247G1eeh6FTVhmP2/4InUIPPZZrMmnIEc
         DAy1ik95FS3fVWDOVDA8FU0mHl1ejjFqwa9ZGA0D6dU2ag0CypYxDU0ccCrR95p9wSVA
         5PnsHsynEiVOV7e+Yd6rkyI2ORrrToqAX//ZUfByA9HrtG8xDZhMozmwenzqbILOT1Nd
         EKsvrTXQqbcGgYak0Oa6XbCRN17khrgPMgkWEwCNystdc3VTAV8fcpXaWY0V6YBTDNWd
         Jg/J9KUMyY3jN2QFH6SIfrdzaFTbGxfKb+MNqMniz8PR8eKsmo1nMIlBXriNijAMb0mL
         +Q6g==
X-Gm-Message-State: AOAM533hgg9j0pU+FGHO4pHaJ8qdjLQ60NIC2YNg46EdsBaDz6klf6lV
        18v3ScywYDlf6M47wrpMinyCcA==
X-Google-Smtp-Source: ABdhPJwdC0CBwfwEFgnMWBs2itS0D4XePO3DqtgB9k/WgQwQPpp6vszxazNlsyxsWskCia0jOGxeZQ==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr8091360wmg.68.1594801601851;
        Wed, 15 Jul 2020 01:26:41 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH v2 03/13] cpufreq: cpufreq_governor: Demote store_sampling_rate() header to standard comment block
Date:   Wed, 15 Jul 2020 09:26:24 +0100
Message-Id: <20200715082634.3024816-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need for this to be denoted as kerneldoc.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'attr_set' not described in 'store_sampling_rate'
 drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'buf' not described in 'store_sampling_rate'
 drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'count' not described in 'store_sampling_rate'

Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f99ae45efaea7..63f7c219062b9 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
 static DEFINE_MUTEX(gov_dbs_data_mutex);
 
 /* Common sysfs tunables */
-/**
+/*
  * store_sampling_rate - update sampling rate effective immediately if needed.
  *
  * If new rate is smaller than the old, simply updating
-- 
2.25.1

