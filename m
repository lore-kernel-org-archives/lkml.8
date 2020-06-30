Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F60C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBCB20672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2v94f0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgF3MZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbgF3MZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:25:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4901C061755;
        Tue, 30 Jun 2020 05:25:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k18so18286179qke.4;
        Tue, 30 Jun 2020 05:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BRR8i7RJHesVYS8D5y4NlbAdWYIwjYV0Hk1TUaPO3AI=;
        b=M2v94f0iWK1+hCbMfg2iIXYliDBC8wAZui/gdbkWtrhUwG+2z551smPEQbW1ZhBTly
         O20NeIkgX1cozh0q9HlvBR1fQmBsIuny+02eWkNzQ8jkzUjWM1OlaRbZ0E9IsVgopzIW
         5ZWTuObdo/etMAnAfZhfaxGwrbKcIpsGpP8zgMjjQsPp6P3biagHHPtkTCSyR9i5YvZM
         tkJ8VTs5+h2CgunXFwGzOYRZeyOMG+33YFPOV7M9s2vt+K8kKjrtluBvcmS2XJ34z6iY
         gsYOpoLIz1XozK9G1w84lr3GazlI6b1h3RNOS5lT0AjqzterMgxOXEgFPIUnZS6Akm4B
         ujJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BRR8i7RJHesVYS8D5y4NlbAdWYIwjYV0Hk1TUaPO3AI=;
        b=RbRgyaiFXQFH/W4/kuhJB5ebVAh9yPxmba5W+igqKNOGJXXrnE6jYpAP5MWn/zhb5K
         bEZGkzbPazA7PmpvjBMaeg+h+ZvFmZ/kppM2GQ21r+LKIvXUls+oHxvAhXZHwETAe6D/
         r4KfIPIguz92XwpkJDVjh+3/5igx1+GSCS/EY7VSXsOFX+vWqBL4dmAojwesk4PKSl9v
         FjAgvjyew+dlql91mn6pxsRyxeygCwLyDroXS+wyUmYEZzPjqfnjIX9FCfeI3GgIHG8C
         67/iUsefRUZ+g7hGiKlGdiGFY7Z0IHz1ylDkpA//Jj30bxHms+zoAVHsn94V45MZTGtc
         D25A==
X-Gm-Message-State: AOAM530xPdL2ME7PII1EpJPMdCmQ9h1q7kYruZKMbkz5Vif4/trqbnvJ
        EoEqVO/mwrtFZikLKW3wiFU=
X-Google-Smtp-Source: ABdhPJyqU86TejxnQRH01Xd+nYEIEW8xybysprOn1m3Hs/JdkbdqzFXZc9sGRAb26ebqEupffnSwvA==
X-Received: by 2002:a37:689:: with SMTP id 131mr11787583qkg.468.1593519937878;
        Tue, 30 Jun 2020 05:25:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:92b:d42f:2bc1:abe3:59f0])
        by smtp.gmail.com with ESMTPSA id d186sm2877189qkb.110.2020.06.30.05.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:25:37 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     robh+dt@kernel.org
Cc:     j-keerthy@ti.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: thermal: k3: Fix the reg property
Date:   Tue, 30 Jun 2020 09:25:27 -0300
Message-Id: <20200630122527.28640-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the reg property to fix the following warning seen with
'make dt_binding_check':

Documentation/devicetree/bindings/thermal/ti,am654-thermal.example.dt.yaml: example-0: thermal@42050000:reg:0: [0, 1107623936, 0, 604] is too long

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
index 25b9209c2e5d..ea14de80ec75 100644
--- a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
@@ -35,7 +35,7 @@ examples:
     #include <dt-bindings/soc/ti,sci_pm_domain.h>
     vtm: thermal@42050000 {
         compatible = "ti,am654-vtm";
-        reg = <0x0 0x42050000 0x0 0x25c>;
+        reg = <0x42050000 0x25c>;
         power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
         #thermal-sensor-cells = <1>;
     };
-- 
2.17.1

