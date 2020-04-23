Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B27C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E9021582
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpbw26kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgDWGtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgDWGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 02:49:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8EC08C5F2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 23:49:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x17so4705039wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kJtJQoG/JQbSqOU2YZRjYN1eoWDg7VtiOaXr4Sl/Q8U=;
        b=lpbw26kluPvvo4DG9FZ3dRRkOUcmUUdlire26yEgBfUb9aVOlpafUTIZ26UFwS32TV
         thVlGVhSFsf3w7GQGb7IUjZPkRltAFRy3DiYbZd9gXLuw6L3iQHIrmxw8R6/IbJp1i6T
         sWWEWgjwyZFvfmJ57jEPMwZoFAmOrV0JghVs7y8w/h/N9vuGeIE4q0vF9vLjXEok+EpQ
         JmG8qCeSopx+O/1RqjN8SLw4WdFbqE3TjGa0yEowO45taB8F8LZMen3G5uwis1pz1bD1
         Ta0jub11B1dukk8bDF/xb4a+9QiM4Di74g/0TNWkCtTgRZKivHp3X7sGOPUn/XREZRPj
         kMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kJtJQoG/JQbSqOU2YZRjYN1eoWDg7VtiOaXr4Sl/Q8U=;
        b=tcP/lTn+dw+ndQ02GYhWeyP9gFJM+Du2L2VGqc3M8bIPaS1lq/expNkVXC75NVjUW1
         lkR2bnDqb4D7a2Hq4cvRnCLa0cRZkdcjG5HCAPd0od9UNT5+OJa4PUpFWBKanEKUM2UM
         wU7UQ1VWkZQgXMEfsjE/OKC1y6trwu3uNSga+vf2opSPqvYINInjbQwqdU2/cApCKhhK
         f5OPMkgA/DCqLB4cqOu8F1pyg/53pfpBzDj8g7qnk8P/7EJ+VR6Y+fAV/QFxh5+GsXO2
         e8DesP5xRO6xt6GcpDN46mybHvnjo6YOufST9BOT7scxK9DU+hOnH/Aq3FpuN/56r9tz
         xGTg==
X-Gm-Message-State: AGi0PuZifSWRcY8ffyBGqk6WqcVAjvFKPIahI2m7sDAMImlthhMw27E5
        TDE2DuUaP7eIfwpUUhFeODHBp1fL+LDJER2a
X-Google-Smtp-Source: APiQypKJk3u22FDAIfAI+TSNr/cAaZn0Vz/zOVsKE6fuiFyHnLMfMQpncVfaMlMhqPktzmkP3N3Wxw==
X-Received: by 2002:adf:f444:: with SMTP id f4mr2986877wrp.376.1587624543700;
        Wed, 22 Apr 2020 23:49:03 -0700 (PDT)
Received: from lmecxl0524.lme.st.com (2a01cb058702ff004d8cf526990082b9.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:4d8c:f526:9900:82b9])
        by smtp.gmail.com with ESMTPSA id k17sm2254910wmi.10.2020.04.22.23.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 23:49:03 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH 2/2] dt-bindings: arm: Add secure-resets binding description
Date:   Thu, 23 Apr 2020 08:48:08 +0200
Message-Id: <20200423064808.10468-3-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423064808.10468-1-etienne.carriere@linaro.org>
References: <20200423064808.10468-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe how resets property can leverage secure- property prefix
for reset controller assigned to secure or non-secure world.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 .../devicetree/bindings/arm/secure.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
index 9bc94921f2a6..f0aa6a5fb436 100644
--- a/Documentation/devicetree/bindings/arm/secure.txt
+++ b/Documentation/devicetree/bindings/arm/secure.txt
@@ -72,6 +72,24 @@ Valid Secure world properties
   clocks = <&scmi_clk 2>;	/* NS relies on SCMI resources */
   secure-clocks= <&clk 5>;	/* S accesses the SoC reset interfaces */
 
+- secure-resets : specifies the Phandle list secure world shall use
+  for the related reset controller(s) whereas property "resets" specifies
+  the reset controller Phandle list non-secure shall use. This
+  configuration can apply for example when a hardware reset controller can
+  only be accessed by secure world and this one opens a software service,
+  as a SCMI reset domain, for non-secure world to access the resource when
+  platform assigns the reset control to non-secure world, i.e.:
+
+  resets = <&scmi_rst 0>, <&scmi_rst 1>;
+  secure-resets = <&rst 5>, <&rst 7>;
+  reset-names = "int", "ext";
+
+  Such device description relaxes constraints on device tree modifications
+  when one, a user or a bootloader, needs to assign a resource to secure
+  or non-secure worlds. Indeed, this allows only "status" and "secure-status"
+  to be set while the rest of the device description in the node remains
+  unchanged.
+
 The secure-chosen node
 ----------------------
 
-- 
2.17.1

