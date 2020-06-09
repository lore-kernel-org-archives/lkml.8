Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A641AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82069206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eo7EGmCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgFIGpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgFIGpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:45:07 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5738C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 23:45:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e9so9863341pgo.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 23:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wG0+Ch0zEKVHYp36DijWu0KUj1hShzvRRIkz+3ay5qE=;
        b=eo7EGmCNTTZuRXco4dtjEewlalbihfhWZ92VRyRlC+hp0KEiurSKf8rbQfi35M3dBk
         og46Fc4s2Zaxy53+xSjIJ3qOqe7rThwMbqWbXpyVVMYCiXGUNXxDyVg650iJMSVrOpnK
         3VafbWDwORzv44nThFbpJyOSZ2j1QV3aN0tbbI1TKtabsidLs6xGT0kkCNQYZNnNOre4
         /piRqfuRpNBzpTHBvwBEDFc8QKZPJ88zCqvkK1fcpXB/L3HhStcOj9JLk1lg2cf/TNGm
         9RgiwJr9ZdL7dkPtxqBLdoNvNyE/KHWf1srG+wPmFsxHFArQB+/A8m5cwnSS5dhRyCHT
         eTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wG0+Ch0zEKVHYp36DijWu0KUj1hShzvRRIkz+3ay5qE=;
        b=VriEdG/6LUnI0yYIBVnQrYvPI76mX5lZVvSlF8oxjR98IVNXeQBtj3Cib8FFdh0i4y
         IPNG8e76zjc8GpKCjNaZ0QP+vEN6ZBN9d9F/wYhmRMEmUfwtQjqyp1uorrT3Gb1b7Dkn
         lRMy+oaNfKUNadV7GFTLy4O+u1tD1odthLPJ+6+7Wl8UFuJzkhJajB0FEUCS2E7qt8gG
         7X9EmLDxqbfxCK/uQKmN2CLoRKxUY2C4Cl62Ulora+5672r/fTC8ejNYkPK/wx7oWF+v
         f/Dr89tfvX5SBbCGswvk/2oXdA1lo5LZAeJet52Fr82lws0XUaUq+Vul3YuT+06KOpYQ
         raug==
X-Gm-Message-State: AOAM533bsbaDNWI1KUbNmzwKo0XDsskMUr9nRk+I5C+52QgFvpbYfJrA
        Ng+oEcb/qfDX/PC6L1XCm8L3mbcL7k4=
X-Google-Smtp-Source: ABdhPJwz7++0CVF/zOZpvNRCw2+dYOuiyk1fQ4vdbnMmIu9rwwTB/PT4eXeZ1O3doDx7mC8j+9ezAQ==
X-Received: by 2002:a63:9304:: with SMTP id b4mr22660320pge.229.1591685105957;
        Mon, 08 Jun 2020 23:45:05 -0700 (PDT)
Received: from localhost ([45.127.45.147])
        by smtp.gmail.com with ESMTPSA id 4sm8830988pfn.205.2020.06.08.23.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 23:45:05 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, sibis@codeaurora.org,
        manivannan.sadhasivam@linaro.org, dmitry.baryshkov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: thermal: qcom-tsens: Add compatible for sm8150, sm8250
Date:   Tue,  9 Jun 2020 12:14:54 +0530
Message-Id: <c3361043e66139812bd4cd85b917659d85e1564f.1591684754.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591684754.git.amit.kucheria@linaro.org>
References: <cover.1591684754.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added tsens bindings for sm8150 and sm8250

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 2ddd39d967662..dee3836a82854 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -40,6 +40,8 @@ properties:
               - qcom,msm8998-tsens
               - qcom,sc7180-tsens
               - qcom,sdm845-tsens
+              - qcom,sm8150-tsens
+              - qcom,sm8250-tsens
           - const: qcom,tsens-v2
 
   reg:
-- 
2.25.1

