Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24119C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E7A21D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0syyZEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgIHIF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbgIHH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:57:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D690C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:57:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so4719348pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jp1JbuEONyh0D3c15mdIEQg1E4rtcuX67btWSgzEVZ0=;
        b=q0syyZEHC6UJrwegi0WqqL8cvZWfYs02KO3ti/PWcyksi9BW0jaJbDN6ApeYHBSjDv
         mOeziD6tiK1Xbu3Hnybyo3dlcmP+1cVCyZKh/pj5kWXZMEeV3CwfkhuYVFAA7cE1utQ5
         /vCcD4Sk3/BmKlFk8tyf6Kga/Wb42ORnQXm0zNctna93YZKwGX7vb+b9HSWbJatO+XUY
         sMor/KOYzLcUfeVq3q03J1iFdKxOE665GPxtFlBmHJuGQuCn42XgO8m6J2cruiI1HLhs
         KAwCBh+a9fqyntz4TOp8iPC82h+tL9jE1s8WsJOECElZs5qL9aNsMs6Anxo0CrByE4f/
         u5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jp1JbuEONyh0D3c15mdIEQg1E4rtcuX67btWSgzEVZ0=;
        b=FcQIa0KXYv44Leh9+jsmeKodxvEt/sHbW7QcZtBt8JGOrEbHslMA94TDXZO0UF+k4x
         pYMt2HWr4YQl/n701AwGsJYL2HATNodGdZLOH5u/rSX140yTsUPJrxG3SriNEFsRVnYd
         qg+BlR2bIu6z8/L/jmwZcUsX4LEYobdYSxiryc9P1ZhEqPylbmojCUpPLoUsHoCVdkZt
         oDUuLewOrSZfFqTTbYhZb9pqKUvHRK1HvMT1r8vN3Qm6Wxtpi10Ii5hmQspL8I2x1A6P
         Vb87IFrtmQeBvg9O9Ob5n3ASxAvqMCqZ/gJWndxrXKSGaY6uh7uk0qvQorLxgMF7sM6a
         vk/Q==
X-Gm-Message-State: AOAM533/cIFEM0+XJPuZApUSl60/zvK8iBbBcRjDgB8rJYA0z/qlzU3Q
        f7bMYnXSErDThFpHspOmWKt3BgeXfXKvemg=
X-Google-Smtp-Source: ABdhPJxKmEuz+uZ0bUmp4YnY8M63J+6oLAHi4IgbNQqubssEsG00n14g7ib0k0+hUHZoOE0Ou6oSpA==
X-Received: by 2002:a17:90a:f992:: with SMTP id cq18mr2899411pjb.136.1599551854565;
        Tue, 08 Sep 2020 00:57:34 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id m21sm7560154pfo.13.2020.09.08.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:57:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     amitk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        tdas@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/7] dt-bindings: cpufreq: cpufreq-qcom-hw: Document SM8250 compatible
Date:   Tue,  8 Sep 2020 13:27:10 +0530
Message-Id: <20200908075716.30357-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
References: <20200908075716.30357-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8250 SoC specific compatible for Qualcomm Cpufreq HW. The
hardware block which carries out CPUFreq operations on SM8250 SoC is
called EPSS.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
index 33856947c561..aea4ddb2b9e8 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
@@ -8,7 +8,7 @@ Properties:
 - compatible
 	Usage:		required
 	Value type:	<string>
-	Definition:	must be "qcom,cpufreq-hw".
+	Definition:	must be "qcom,cpufreq-hw" or "qcom,sm8250-epss".
 
 - clocks
 	Usage:		required
-- 
2.17.1

