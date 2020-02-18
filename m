Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18143C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5270208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jswkyQD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBRSMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:12:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45336 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBRSMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:12:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so11032712pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+YirIPkJXuIir4GmYePAIggm+McOm90/Zl24VPr8SRk=;
        b=jswkyQD1LeaxGwcvJdqJn4XVZpLtuqcbPeNaccCVCjIcpcOu1rNR8vdETNL96gZ0zh
         RyXsscw4Ue6zgjpT9/vA8qBcST12eb4siBsq/WB/BVDevcco5oXYHfqdHUDGj+hDnuer
         a+fjOaVCL+Mvl+hxpBr9qDGb9Eh0cGPHaT6OFsWumb8OLgipOUEdoWo3HMshBvf/o3fD
         X21CXstzSwaR+bxdSBss8UP1wggaxiNWdklCbT4T9C+Glx9c7fx9upfKRyCfHGj/A5ZS
         9CHh+Fu/vTwCT4XHAOxTLHDBUNpTztJbNVdAaxAqAeqLJb5cixhkQGPaONXZELDELAaM
         d7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+YirIPkJXuIir4GmYePAIggm+McOm90/Zl24VPr8SRk=;
        b=R3Nyl25YpHGlInvqfPOn6XIpD5Io/OmC4ySh0WukKggvUX9jKKuOmRKnnpvBHvy5Vu
         ot1z8tEBtCxMv8ngHPjliE5IYu9+tc2o/4EhB8/27SD5C6ONv0NeNRMM+jYOhr9LaDUj
         q4W7R10Jxj6nTmuSTTOu7Yh06RcbYLBCRGHAHFYctAnYQWmEuP1YI1p31iEZf27M+3ci
         cT5fMuSnzSntiZWAtYif3ls/ouMJCzwf2cnaVsKkVTAauIz2kNfZz4c8gwlmn2KLNeAB
         dFcuGQcsktasSPAvrzaAVz6neHPgtwRwMJNJZATqKzDL4C28BDcBgkDPS11+rcR+YLAV
         7/9g==
X-Gm-Message-State: APjAAAWQnEVVzt+L3WZXt9J/glSJOogecvh6EqrrozeovlmnbFwxhPMx
        IiEPNoHxiAO+8pVzgSMqLww2SEj7/9s=
X-Google-Smtp-Source: APXvYqyZUR7Zba9XFFXCAAR5vcZCiXrM7oXRZZH1QPzTLivsBxopFB1qjAgkaMI4xA0ikxsuf6ZLLg==
X-Received: by 2002:a62:1889:: with SMTP id 131mr22541039pfy.250.1582049556211;
        Tue, 18 Feb 2020 10:12:36 -0800 (PST)
Received: from localhost ([103.195.202.120])
        by smtp.gmail.com with ESMTPSA id b25sm4888300pfo.38.2020.02.18.10.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:12:35 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 4/8] drivers: thermal: tsens: Release device in success path
Date:   Tue, 18 Feb 2020 23:42:08 +0530
Message-Id: <9fa8a4e09b6fcff4b9d4facc9f9e9f8e3c4a41d5.1582048155.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582048155.git.amit.kucheria@linaro.org>
References: <cover.1582048155.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't currently call put_device in case of successfully initialising
the device.

Allow control to fall through so we can use same code for success and
error paths to put_device.

As a part of this fixup, change devm_ioremap_resource to act on the same
device pointer as that used to allocate regmap memory. That ensures that
we are free to release op->dev after examining its resources.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 1cbc5a6e5b4f..013750fff8b2 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -602,7 +602,7 @@ int __init init_common(struct tsens_priv *priv)
 		/* DT with separate SROT and TM address space */
 		priv->tm_offset = 0;
 		res = platform_get_resource(op, IORESOURCE_MEM, 1);
-		srot_base = devm_ioremap_resource(&op->dev, res);
+		srot_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(srot_base)) {
 			ret = PTR_ERR(srot_base);
 			goto err_put_device;
@@ -620,7 +620,7 @@ int __init init_common(struct tsens_priv *priv)
 	}
 
 	res = platform_get_resource(op, IORESOURCE_MEM, 0);
-	tm_base = devm_ioremap_resource(&op->dev, res);
+	tm_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(tm_base)) {
 		ret = PTR_ERR(tm_base);
 		goto err_put_device;
@@ -687,8 +687,6 @@ int __init init_common(struct tsens_priv *priv)
 	tsens_enable_irq(priv);
 	tsens_debug_init(op);
 
-	return 0;
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
-- 
2.20.1

