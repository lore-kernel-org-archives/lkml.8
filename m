Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAFAC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F3D21D6C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vBZqRin9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgGNOvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgGNOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:50:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597CC08C5DE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:50:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so22174445wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMXxo9aOlmaJXA2Fa0TTzO8LQVMEninajvd8D9uCCWE=;
        b=vBZqRin9ErymR0h6YWFtX6OzZP7QsHPxUOwJ1TB67Z1qz2iAYJvnsWx2gcLuhJy4lb
         hDDc4aeOkm27SRzf8X1k2WIAObsAJND5revrzkP/m7ZCMP80546Bxq3T3UndYTS8OzUC
         JRsd6UB7YHbFJbx8g2t1uiz5Y+e8rX83mYC50waDpkpo5tPFH0kwV8nCXZvv/pkzP297
         KtwmqwGgdm6Um5BEKSCxhXmSf67vT0WeoxDQQEouLXVk2MTiwej9lYE4yeXcO2AgZFPY
         1n2hO29e3beuwFoHJWMa6cOWi5ut2YKBxpnhv1OpHJLS9ZZ8+unvn3Q7bOKY5dKnNGed
         ooaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMXxo9aOlmaJXA2Fa0TTzO8LQVMEninajvd8D9uCCWE=;
        b=FQBAILmzqgXQ2EjsyGFWdJN5YSfdQ3oses1ork6oFE8mOpkpJkIhEsK+6Nsq2GaICR
         YaB2BG6CMnHItFyQMGbAN08Zu9YC2c6dac9f8uaReqfEVUc+Hwz4PWzYpcTM/vRPd/Vd
         S47RVJkW91D9htvNm8R4GGbXB9WoRLEbgqx9Evx7GIVXfEYrpICDb8M0dNV+Fm3Bv9aY
         wAnqHGz5/+5aLKaW8lY9bDdDGzYDvw250M1ABotCI9sKX3e4ZZ34XwMvwM11PjAsWGsu
         phtuBsSznEpgmntGe4H30mlrKIFxV4l8K185RWgeqixCkKZcTU+rYCsaQh4SPPR09jTP
         9ddw==
X-Gm-Message-State: AOAM533VjSG9FERWmGO87+7dfbEtq+w02SA4gOhFyizDWku2K3EmKrb+
        dW9/AN/rww68/Anpp77TLe0IMA==
X-Google-Smtp-Source: ABdhPJwYqf/NbTXIZQ6P2+Ae9aB7yAhOCiew0QjfGjYt6pXaaft/XHPCaQXykUjtuNfRA79JvHAIRA==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr6172511wra.348.1594738256436;
        Tue, 14 Jul 2020 07:50:56 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:50:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Pal Singh <ajitpal.singh@st.com>
Subject: [PATCH 04/13] cpufreq: sti-cpufreq: Fix some formatting and misspelling issues
Date:   Tue, 14 Jul 2020 15:50:40 +0100
Message-Id: <20200714145049.2496163-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
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

