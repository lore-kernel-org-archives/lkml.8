Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49E0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1C820775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4qPuOSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgFZG6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgFZG5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:57:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58EC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so8307781wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPP/UO1S0fFlAO//S91M0USmj0hNvysUxqLwY/EHMpU=;
        b=o4qPuOSqulK9KuVSnsgC92nheOHo5sPkiZnIT04OlBWs0kqtIAb1N4z9yQia5M2icA
         guTWlRhrkyCoWzC3edxywWhCMB3kYYXx9d8LTrmQCGfjb/QaOR6ps5jq6FstBy2QKQJb
         plyMLcEJmAyltVcNPygxskIaJ7VzzxZD4OsFPUEhxq4+1VRKnED8SBVFGi4HWn9pUxx+
         tLSKSQgUHmlCfWhnt7UMwcLy7gfDfBLZbhv5ML1APO4aygCLEAPPS0iKzMTl7AMxCCSl
         d7BR7Lw8RUp82W2CZ80jxbfRBZ1g1YuuLsfxPW4NCtWVmtct5JlmAwZ+yoIeeDj7kiuO
         Werg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPP/UO1S0fFlAO//S91M0USmj0hNvysUxqLwY/EHMpU=;
        b=Ehg9INHn+2bE7HPB9vASCfane/A+CoWrsgOT9urGbQP4pMugXNoKCrSw561FYgoY4S
         fR3EPw7Yqwi1VwgeUlMpcwQZDd3ilDXZkgiShzsQNODYvSqujR4Q0ZBmzwrueO/kT/qx
         L764cRinE5elcRL9IFcb2fmwT1rTb4ARp4tZzC/RoHOvZxZ6wYcm6oQ+POzNMGNseljl
         cIv4nuFOinQTiMslbiD97rigN4ez77KsY6z/cd3OSnJR2IosxNUbxsJNrD5Oo0nTEvx5
         ZsGZv34naSg5LVEBM+aE2CW5OtkN2qjPbd5TXrIgYMs7FprfOcBmmyuFhc8VjCZG6k7f
         75Lg==
X-Gm-Message-State: AOAM533Ut2MjuqSDhGdnrzcEMjs+xvr8uC8DDkQHtkDSjPvVjeYmI4aL
        ppH2StsJMv/vQ2Tl2o+SHsMKog==
X-Google-Smtp-Source: ABdhPJx/RXJWJ6f3locg3j1C1CnDGokvk4hRTKSjAebqtaEGNZhKkk9x/cjUDtFriHU5yMFzH+64dQ==
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr1906640wmb.105.1593154672520;
        Thu, 25 Jun 2020 23:57:52 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm15355269wmi.35.2020.06.25.23.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:57:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 9/9] regulator: qcom_smd-regulator: Remove unused 'struct regulator_desc pmi8994_boost'
Date:   Fri, 26 Jun 2020 07:57:38 +0100
Message-Id: <20200626065738.93412-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626065738.93412-1-lee.jones@linaro.org>
References: <20200626065738.93412-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was an upstreaming error.  Remove it as it's not to be used.

Fixes the following W=1 kernel build warning:

 drivers/regulator/qcom_smd-regulator.c:477:36: warning: ‘pmi8994_boost’ defined but not used [-Wunused-const-variable=]

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/qcom_smd-regulator.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 53a64d856926f..4c0a469d8a115 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -474,15 +474,6 @@ static const struct regulator_desc pmi8994_bby = {
 	.ops = &rpm_bob_ops,
 };
 
-static const struct regulator_desc pmi8994_boost = {
-	.linear_ranges = (struct linear_range[]) {
-		REGULATOR_LINEAR_RANGE(4000000, 0, 30, 50000),
-	},
-	.n_linear_ranges = 1,
-	.n_voltages = 31,
-	.ops = &rpm_smps_ldo_ops,
-};
-
 static const struct regulator_desc pm8998_ftsmps = {
 	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
-- 
2.25.1

