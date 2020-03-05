Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052A9208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0ZdDzYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEWA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:00:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46165 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgCEWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:00:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id w12so3055762pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CfFvioNntMrggtGCDI5jrpVPJ8PPT4+rx+j7q+/B5nM=;
        b=x0ZdDzYjiWorSa3v8XihJmzIhijF8nuLNJ6tbV7nSMhKDJAgnZJb/clz3L4YK2Y/a6
         utsFpaD5XHJ1u5I7XWD5QjA157binNgSDG4UTFh0wAZMZaUGDTH5vhGuH+LVZrzUFGVt
         dfo4w1yAbynOVLBlVNp87UThulMycfrKOZh8nuAuEN75KMqMeLOAhFYo+bjtFRUJVQ8w
         gCRGz+vN/WAbvllaIIZWiURp5HpcQw0IwGO5F5goFX8fhWERWtR3kLUsJSGxCnYSqQok
         +KQ7e25Gmezc7aCZtwtBBvbdZ+CMGhmz4U5czuvr+uFaWda8u1vKDCX7Rj//324XwyH3
         dZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfFvioNntMrggtGCDI5jrpVPJ8PPT4+rx+j7q+/B5nM=;
        b=MwEPbWbo8VKGJPigyX3R5o9mv6IhTYCXO7uD2Wl0/zNAPZBdtRvwkNSZom9RAwch7H
         SRdKx4OhJ0NDAPMUPTw7S8FquZTBubcuH/kM3HommSKOl+6lv7PqWFjfmGBTGw1Y16JF
         lDcJ3kGz09WKYKFYOg59DPkORS45EYMLYzOauyXcPuGU/1s1TNXQEdxWusNmZpq0r0z7
         n/A3cJFoMvxUEe2V/1V9ED3G1DPFXQHyD7qgQdoaA52CT6kDPNl/oPBMOx7lUGX8M+oh
         MDIi1Rx/4ZTvyHt0e6QRfQY3Bu+ErEacIL7NHYie7CTvb+7Jm4hCcnzwXbgfjo0aoCUY
         ddgA==
X-Gm-Message-State: ANhLgQ0TYaHwsHiPwX/nWWn9v15v/yZGvII7bbRf0yZqiXv965G4n4aB
        BR+5hTckEVKhXMoe7hRZliNH+GxpM2Q=
X-Google-Smtp-Source: ADFU+vu9/Ip0YNT9DSKqIM6+MMuTT5h+i0+G0AQRipi+p1ZXgS+BvFJC8M5TPSzO5AMHovunA3hhYQ==
X-Received: by 2002:a17:90a:254d:: with SMTP id j71mr173901pje.169.1583445625135;
        Thu, 05 Mar 2020 14:00:25 -0800 (PST)
Received: from localhost ([103.195.202.232])
        by smtp.gmail.com with ESMTPSA id a3sm9858648pfi.161.2020.03.05.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:00:24 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v1 1/4] dt: psci: Fix cpu compatible property in psci binding example
Date:   Fri,  6 Mar 2020 03:30:12 +0530
Message-Id: <d962c0a5328e72b3dd4a74e138b0f3bd233de373.1583445235.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583445235.git.amit.kucheria@linaro.org>
References: <cover.1583445235.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make -k ARCH=arm64 dt_binding_check shows the following error. Fix it.

/home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
cpu@0: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
cpu@0: compatible: ['arm,cortex-a53', 'arm,armv8'] is too long CHECK
Documentation/devicetree/bindings/arm/moxart.example.dt.yaml
/home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
cpu@1: compatible: Additional items are not allowed ('arm,armv8' was
unexpected)
/home/amit/work/builds/build-aarch64/Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
cpu@1: compatible: ['arm,cortex-a57', 'arm,armv8'] is too long

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 8ef85420b2ab1..de71bbfb185b8 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -199,7 +199,7 @@ examples:
 
       CPU0: cpu@0 {
         device_type = "cpu";
-        compatible = "arm,cortex-a53", "arm,armv8";
+        compatible = "arm,cortex-a53";
         reg = <0x0>;
         enable-method = "psci";
         power-domains = <&CPU_PD0>;
@@ -208,7 +208,7 @@ examples:
 
       CPU1: cpu@1 {
         device_type = "cpu";
-        compatible = "arm,cortex-a57", "arm,armv8";
+        compatible = "arm,cortex-a57";
         reg = <0x100>;
         enable-method = "psci";
         power-domains = <&CPU_PD1>;
-- 
2.20.1

