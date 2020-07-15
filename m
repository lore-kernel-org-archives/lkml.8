Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EA5C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D68420657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljxiYm+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgGOI0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgGOI0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23D8C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so1515914wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LJ0wihOBVHPIGemJGX58TPrv3uF5xWaa7cKhOONWPg=;
        b=ljxiYm+vN9KkU8J2YlA1xo2jW+OJL7zYylIepuzU7NoryNA4YAXH7bYPteN60yXtEn
         hfSFIN/cOX7tEUohsIXs0F/GgCd3GKKtuthbueKyvrI1U/lxQEF4VvR8A2tjQyvXbR2R
         VeSPnORSvMphuW5BfwzDDB5TIOmffT1Kk0oGb8oZbmBbVIvPtfWh6RXPfPZnfdrGylZs
         9b2iHT6/rWMNnkB9bbJbfe35FsmMQ5d1t09jupstSL7KFJx1lmivT8f3uPRgmmxso48w
         ATJ17hH8EV/Bpj6CFqYI2jgsmsxIlQy3Swwqkz4YM03QiYDyBspOyHnFL7VuYHDX83cp
         f2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LJ0wihOBVHPIGemJGX58TPrv3uF5xWaa7cKhOONWPg=;
        b=GibeWeR9wE8Tm3AGR3e+6UUYPaK9EIRiYFEHBhQ9TnJiMWcibC9vufOUdnNMwPon8A
         7PoyMUeTMcordGSwtfXPaWPSUwzNYTttLtzbeeTHrxyAEL3Hx6D0ocrf8FMg6xZ+ejha
         KG6gvb4lUaluKEFutxgAX0yx7RFMsyGaubGQfpseySMr8YYJP97f3PThpNLoSs75oG9h
         Sq5XooZtmSZ/0bvHC5jh8VabWchQjBtE0IhhqeiAs8MnTq9/pYYKXoIoe4J4HWnTHf6u
         gXwf2ZLC3lmNSvQxS8zzHp7WsT64dFYXv7TvHwRebIgOMXJaiDlaFww5NKynZ6CXDi9/
         vK3A==
X-Gm-Message-State: AOAM532s4RnV5/S5Oe/QZ/lPjZSRLzRPo5U4++ROqfxuWcOI3emAM9Js
        WJBmobkNamI4h/oVFIjmafOd5g==
X-Google-Smtp-Source: ABdhPJzcOOGWhEpLdUwy55/6zbutR/7JAw/U/qyLamUdWJ+qquIDGdIzfYQX+nQnfGZXlKDRzrkowQ==
X-Received: by 2002:a5d:698e:: with SMTP id g14mr10754265wru.301.1594801599673;
        Wed, 15 Jul 2020 01:26:39 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Dominik Brodowski <linux@brodo.de>
Subject: [PATCH v2 01/13] cpufreq: freq_table: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Wed, 15 Jul 2020 09:26:22 +0100
Message-Id: <20200715082634.3024816-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715082634.3024816-1-lee.jones@linaro.org>
References: <20200715082634.3024816-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/freq_table.c:229: warning: Function parameter or member 'policy' not described in 'show_available_freqs'
 drivers/cpufreq/freq_table.c:229: warning: Function parameter or member 'buf' not described in 'show_available_freqs'
 drivers/cpufreq/freq_table.c:229: warning: Function parameter or member 'show_boost' not described in 'show_available_freqs'
 drivers/cpufreq/freq_table.c:269: warning: Function parameter or member 'policy' not described in 'scaling_available_frequencies_show'
 drivers/cpufreq/freq_table.c:269: warning: Function parameter or member 'buf' not described in 'scaling_available_frequencies_show'
 drivers/cpufreq/freq_table.c:281: warning: Function parameter or member 'policy' not described in 'scaling_boost_frequencies_show'
 drivers/cpufreq/freq_table.c:281: warning: Function parameter or member 'buf' not described in 'scaling_boost_frequencies_show'

Cc: Dominik Brodowski <linux@brodo.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/freq_table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index e117b0059123e..f839dc9852c08 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -221,7 +221,7 @@ int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_get_index);
 
-/**
+/*
  * show_available_freqs - show available frequencies for the specified CPU
  */
 static ssize_t show_available_freqs(struct cpufreq_policy *policy, char *buf,
@@ -260,7 +260,7 @@ static ssize_t show_available_freqs(struct cpufreq_policy *policy, char *buf,
 struct freq_attr cpufreq_freq_attr_##_name##_freqs =     \
 __ATTR_RO(_name##_frequencies)
 
-/**
+/*
  * show_scaling_available_frequencies - show available normal frequencies for
  * the specified CPU
  */
@@ -272,7 +272,7 @@ static ssize_t scaling_available_frequencies_show(struct cpufreq_policy *policy,
 cpufreq_attr_available_freq(scaling_available);
 EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
 
-/**
+/*
  * show_available_boost_freqs - show available boost frequencies for
  * the specified CPU
  */
-- 
2.25.1

