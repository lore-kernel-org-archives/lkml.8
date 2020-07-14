Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820B2C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7B22205
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wn2diMwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgGNOvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbgGNOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:51:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so22179838wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1l4G4IRouZ0WTRSlZcy5MrRuoV79BSQEwt+8MDC1zos=;
        b=wn2diMwBztTukWV3a+OQNb47W076q9O5m4hlY8WUNk2ANeNPaT/CQqfi3zwQR1nGOg
         VSSBNKiAlDKVFIJkOH+19zNKugRcw4cpro7kI2dybo1tFgi8XfZSUt3XWqaoBeR3z+Av
         +BpmcNzyT53w8bXQHF125EFE/q99zFhEemyIkgKezuFYO+m6Wrr3L3utp3V8ZyiYB1a+
         o30rqYQ6cOqjoSrfZS3gdzIETNcvOBwh9eiVRnEkHsqSZKnsldi6j2CGj6wyxxwcW7sN
         6DdTvdz7/e/Gkt4GbQ+f9viLiUUW0EP2OA+J4uLKVRwzUHrW9D8fZA2LFwU5mGcjfEJU
         A74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1l4G4IRouZ0WTRSlZcy5MrRuoV79BSQEwt+8MDC1zos=;
        b=H9ROCmI9/yvzq4C/0KRP+oXCdaeaHEdGn5OgaooPtGI0DvBmoTNEwXRZiwnL6i2DnG
         kBsG6qTAXiZf+64vcCqV4F5UaiFVhtS6Jg/P/LI9TsxZ0bXszNr/pl1rlyK/cOoKg2or
         6ikY+CV9gP5MQmcnYGoeezdaFzEiDOypy6K2RrbMuJtly99QdV3L8y0oIhdoaFPr2/wa
         /Fdsic2kEkQhszqYTG5gydBGI9pHZNdg0dJ2V20yPJ0f3n8j3Xa4rVRL+sRNPNhE06dm
         FrR1IOm189D361X5jWxgb1J4COo1f5S754GKKBWPQFAcRghvqNYG7MRnGp8TqDwiKezl
         FNtA==
X-Gm-Message-State: AOAM533y8LjTNlck0YtwpFjn9lpBOpxVD9vi45OD+LBsy3p73VHCT5vU
        INzC/VXzWWhq5LlnMAzwDBPoH0XOgCg=
X-Google-Smtp-Source: ABdhPJxU9G/etho4iPMM3oDyoMPF/f2Brrlm1RMB2kEg+iD0TtRcr3nqndDSPblNhCAw+mZZ27YJig==
X-Received: by 2002:a5d:4845:: with SMTP id n5mr6034582wrs.353.1594738266949;
        Tue, 14 Jul 2020 07:51:06 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id a84sm4653305wmh.47.2020.07.14.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 07:51:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jacob Shin <jacob.shin@amd.com>
Subject: [PATCH 13/13] cpufreq: amd_freq_sensitivity: Remove unused ID structs
Date:   Tue, 14 Jul 2020 15:50:49 +0100
Message-Id: <20200714145049.2496163-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can't see them being used anywhere and the compiler doesn't complain
that they're missing, so ...

Fixes the following W=1 kernel build warning(s):

 drivers/cpufreq/amd_freq_sensitivity.c:147:32: warning: ‘amd_freq_sensitivity_ids’ defined but not used [-Wunused-const-variable=]
 147 | static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~

Cc: Jacob Shin <jacob.shin@amd.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/cpufreq/amd_freq_sensitivity.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index f7c4206d4c90b..a17093729511b 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -144,12 +144,6 @@ static void __exit amd_freq_sensitivity_exit(void)
 }
 module_exit(amd_freq_sensitivity_exit);
 
-static const struct x86_cpu_id amd_freq_sensitivity_ids[] = {
-	X86_MATCH_FEATURE(X86_FEATURE_PROC_FEEDBACK, NULL),
-	{}
-};
-MODULE_DEVICE_TABLE(x86cpu, amd_freq_sensitivity_ids);
-
 MODULE_AUTHOR("Jacob Shin <jacob.shin@amd.com>");
 MODULE_DESCRIPTION("AMD frequency sensitivity feedback powersave bias for "
 		"the ondemand governor.");
-- 
2.25.1

