Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF4CC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29B320707
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rBpfgsrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgH2P7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgH2P6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:58:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87042C06123A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kx11so897123pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCkAIVmETRezSJjOY4Toyyj9ShgR/BokJpWgWd5XZ2o=;
        b=rBpfgsrwCrg5DCD+sfEJoYHz76uGggLFzDD9/31SDDL8PTavT9y9KnGncz8GPKTVOc
         9cs6XdN82vb3WKMFJkJczYbqWEjaoFhz99GnefgcJ0YQxl8Rs0xXlEc/JH8r7a+2jHjH
         I+9mnTOPpJcl4K847EkhR9RUEFe6iLCaY+beU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCkAIVmETRezSJjOY4Toyyj9ShgR/BokJpWgWd5XZ2o=;
        b=N+VtpJOOuIwg0pp+y/E4I7JH5f/s3waacSLSEPw/8X22h+Onnur84DOWs8SgUf1rvt
         SmFRMWFwAErVy07BAWHd7i9tl6PhCrIIv+ERam5WOveB6jdJZC/gB/MwnsRJsegDLfVf
         +ie17bzZZR9GawEnoCuVEQWsm90pzFihw7ZnxxnV0jzYk5elr4Ix/UmzXwSIXxv6Bekn
         jomU/XbBcgnViuNUGTFJQ0PIUQKAYi1co6/2tMYyM1QnFX26UPwRUZFymZcwhxuS1dNq
         H0fzkq4cnHej4RNj4Jslv+fBVrC9M9dB06ZegtL5D+JPpxwmDkircVFxm1caMOOT26Ah
         KFYA==
X-Gm-Message-State: AOAM5318T7NY+YKltNm2S9XVd+7qnq2DYCWJM8gRTIZ+O6/M5VjzEN5Q
        YD0s3ksFNFS2yLO5scJCwHkzaw==
X-Google-Smtp-Source: ABdhPJwbonfq+DZDWgNOg6YSAZSYlISfaCI20n62hHNzKlij6eCzuHJB+HAuxG+v+0lm2+stOJy5WA==
X-Received: by 2002:a17:90a:c917:: with SMTP id v23mr3500041pjt.97.1598716719239;
        Sat, 29 Aug 2020 08:58:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9460:cfb8:90a:fedd])
        by smtp.gmail.com with ESMTPSA id j20sm3131714pfi.122.2020.08.29.08.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:58:38 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
Date:   Sat, 29 Aug 2020 21:28:17 +0530
Message-Id: <20200829155823.247360-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200829155823.247360-1-jagan@amarulasolutions.com>
References: <20200829155823.247360-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.

EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
Evaluation Board from Engicam.

PX30.Core needs to mount on top of this Evaluation board for
creating complete PX30.Core EDIMM2.2 Starter Kit.

Add bindings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes for v2:
- collect Rob A-b

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 7025d00c06cc..bda0f2781890 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -70,6 +70,12 @@ properties:
           - const: elgin,rv1108-r1
           - const: rockchip,rv1108
 
+      - description: Engicam PX30.Core EDIMM2.2 Starter Kit
+        items:
+          - const: engicam,px30-core-edimm2.2
+          - const: engicam,px30-px30-core
+          - const: rockchip,px30
+
       - description: Firefly Firefly-RK3288
         items:
           - enum:
-- 
2.25.1

