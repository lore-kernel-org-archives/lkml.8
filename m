Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D5C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F3520656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvNKDJfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgDVKkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbgDVKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:21:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AC6C08E859
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:20:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so1708909wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=123u9I7LwrG7OqauG/EgayFD4qVNvmiu3Wq50pc/uqc=;
        b=GvNKDJfeh4dQsO8mnI588YI2+9PpMuErH9kG2Ok/GZC9xY5NOMt9q1qJZrqmGVMUZK
         R4sR2TNQO5gXPNlLTiiVmKvSNzArGmbUIr9yPqT1Y0dUpt+5Hfh30s8eDZ1nhX+FYHLv
         zNHDnSM9BSKH+LqlQn21ZUSUMVJuesdnj3M6ZsBu5gttTYxuyFN14IGmKUNGGckLRYgy
         /AJAAMCPn5+p7w36EAidIpMXqzdLrfGwZHODddvNxpFzf7YfLjP4K05bRiPrMJwpEftD
         vKHFD7PdJNhNsHpfeIHciBjKhzwVDIlIcTnsHMr0936gNrAhM6aCSewT+xKhNeEIKi/s
         h27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=123u9I7LwrG7OqauG/EgayFD4qVNvmiu3Wq50pc/uqc=;
        b=dg7q2vYN2xHNpACYDJMMwzCnCtwqxVFg2GN62YJiQkCDTGckNwIyGpupWVusHXikUB
         dBST7TlDZNaW4MSlsjMopYUIhbIH7n4cn/KN1KtA8jdkkJ9bnroOVMcfa0/Ov7H+A+0/
         rI9UjoME6j+q2A9dxVa49SbtUnDfxLOr4CowBeJzKe+4H3t8KsUXO4et3HuxZsjJ6y9k
         8gurkuq++hlIbh0RtWQzvVIts1lmD47oo6QNGMwq1tchK2TewCBtZExQyby4gQ0yhXra
         70QVKMEiM7YS7DHiEJorQ/q+DKY+SZTsUkAD2BLEF8F9z9XYWUrizyeJTscM5QNZeChL
         gHlw==
X-Gm-Message-State: AGi0PuZxolE18HVq2dEptCN1Sl64q9iDrUEoG6+ZxJ0nX1vcTmqUOsor
        SztVMv75NopqC9nUafoZexoMyfVstZE=
X-Google-Smtp-Source: APiQypJt2yJqpBjOpfZHuVtBJqDu3oRBOVm+IrdDn08DJb66CNt9BsvawPp+OzA7IVCouOqPrEL82g==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr28404439wrt.407.1587550856176;
        Wed, 22 Apr 2020 03:20:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h10sm7792460wrq.33.2020.04.22.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:20:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] arm64: qcom: c630: fix asm dai setup
Date:   Wed, 22 Apr 2020 11:20:43 +0100
Message-Id: <20200422102044.8995-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"direction" property is only valid for asm compressed dais,
so remove it for non compressed dais

Fixes: 45021d35fcb2 ("arm64: dts: qcom: c630: Enable audio support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 3b617a75fafa..51a670ad15b2 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -359,12 +359,10 @@
 &q6asmdai {
 	dai@0 {
 		reg = <0>;
-		direction = <2>;
 	};
 
 	dai@1 {
 		reg = <1>;
-		direction = <1>;
 	};
 };
 
-- 
2.21.0

