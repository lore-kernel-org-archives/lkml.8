Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C59C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39465214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdFEi2Fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgA3N1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:27:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45347 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgA3N13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:27:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so1481636pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 05:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LlTOqa7aJHLIIA8wM9T5y4yWDZPqvXEMyPc1NafC2uQ=;
        b=TdFEi2Frmszieg86oOD2LCWLCg4E0GtJkmryHCl6IjbDA7EYELAoVIoZMlEP7W26Lv
         ybBx6uaIq9O8sDRXOWRV2SiK8SPFs+IHW4z6vKVpTUu2E85oS8K5jufdqSbPxwp2duK9
         +UtWqwSgPOqI5THsCSBqyDmZCgPJCqZZTKC9kUQcMqPv49v9n5BYj4UGVbXP3DL6koHI
         Ph/TeuAhQN+Kjv6URJj9jkNGHO7VONP0o4z9ovj05WkJlP9kAR2Y3KVTjSRhQ5vxV4zy
         5VpHRKX83Kt/Agm+gVCxE6ndEhtYhFhE3WKJcuBDb3bt+wz5mUOA0I0SY2hguuHIXrwK
         46vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LlTOqa7aJHLIIA8wM9T5y4yWDZPqvXEMyPc1NafC2uQ=;
        b=RgcIKEBY85S/lK/+3fr3s/3X19IludYINeNtqAJMcdwGSt1okjXt+dUoWobmBPISzg
         bZAOSHp4cFpvxDzz6dF3dCZlyAAgRTTLQXoZsFaFUpK40gsTR270XanoIvRE/zR8FPvE
         hrmLfOAZvLUT5+mmtEuWJqkSxg8hHcGv6q/Flg7s5qQqRjgoZl391IEcJaL/YV3rUV3G
         IUEqTFX9RlYcRIUZ4gGyqf+gQ0eZRyrIgXP7SSBjK9NhpRrQnzQUiBjwqWVR0vWu98lt
         YQ5zFPrEPFWQGZs0Ppxjfpf22jyj2izOybScW1y2jEqqXn0mHCnJULFCs8jv9i42Cum4
         HzHg==
X-Gm-Message-State: APjAAAU814DT5C/74MdqjGbc24OiD14BeUa2ProWCbnm/85TIc+QhAp0
        voF7FAXyPvCFdAAgI33oejCXFSWxVu1hKw==
X-Google-Smtp-Source: APXvYqw5xncpx1fmf3yrnaXvl84AGEyCPAkxltvfdhVRdIUqx8JmWlvspCXIiBJt+XS5krsc1s/SWg==
X-Received: by 2002:a63:d14:: with SMTP id c20mr4564044pgl.77.1580390848719;
        Thu, 30 Jan 2020 05:27:28 -0800 (PST)
Received: from localhost ([45.127.45.97])
        by smtp.gmail.com with ESMTPSA id o184sm6543006pgo.62.2020.01.30.05.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 05:27:27 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 3/7] drivers: thermal: tsens: Release device in success path
Date:   Thu, 30 Jan 2020 18:57:06 +0530
Message-Id: <332d79312d2618c96adaa0f125ea033e49f0af5d.1580390127.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1580390127.git.amit.kucheria@linaro.org>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
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

