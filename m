Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A370CC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C60721582
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7oMsLLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDWGtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgDWGtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 02:49:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44540C03C1AF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 23:49:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so5419506wrg.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 23:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qh2AKCayNpJpz+3t28lKEbV10G4E1MM67j57xEhM59Y=;
        b=z7oMsLLdQK0XqDuNtQWc0YvoT6k6RBMsN8j1JiCkA/UkpjDALe+OjsSWlqA4KRGMea
         3tWZoyo2Ve0a61d7LFwWTKSjgmyn9EbSO9w9rlnX5wuYV2hgaP0OfKW/A6Mpbto8ybFI
         WO/I8PfABfOWXJqW65tlrr+xrvZieVxeXBwt9g4cftEJ+oSjHM/vaaOgr1DoFyNbYmof
         7VUWmuYRKKIoV1rojbSNCJngaSXLG34jmws5rcMUnZsjRVDjvqXmF7E+ujrf9zxj8AJL
         5rlyPLMdyB2NDsnbl9esIestBWQAKVrjtyYsxoyTD4FkgMF/BnnHNuKKf0TWwUwgBzXu
         3HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qh2AKCayNpJpz+3t28lKEbV10G4E1MM67j57xEhM59Y=;
        b=YlGv6SxNqluyPciSqCoLHRnDoJcHOovTh7naT8NJtHd+f4qPgEj8mSO3kNyz3QREwr
         ERB8y65lAwp+5/u1JhHDdRb6hq0ovP2rv59ILUa0vIT6r+Y+/cXrQxcgFNF2mTHaZAek
         xH7dUvdu5CHjOROcR4ssalRWLIpc7mYgtX30Xhq1j7xJ+WfaA/BJ/80jaBCNVwxnMETr
         aYN3L69U7mwXwbR2NoxErFN73Y65xPXjXZg9lOZgnJe+my01crqnhVb1YWXvDmUHpxeS
         L4vGiFkpeg18P0CkoXw5mUUpivdwh0D63MJKD1B98xTJUBq4YyK0WDxzdK9BdTArfcx/
         Ko2g==
X-Gm-Message-State: AGi0PuYrIBzorfBvgHWh2LVMxBU3p1yGZBCJug/0Dl1JqiGRURR/K/H5
        i7Lt2Tx4FA5FLHnZWhtc1M67nTKuoToDlwEc
X-Google-Smtp-Source: APiQypKI+/Bjxffqi4naeicDwFoM/VTUlD/7nyFUlRtZkzSYxxFE4tKDpfzOF0pl9LKZY1WMQ6ExEw==
X-Received: by 2002:adf:dd07:: with SMTP id a7mr3018134wrm.349.1587624542746;
        Wed, 22 Apr 2020 23:49:02 -0700 (PDT)
Received: from lmecxl0524.lme.st.com (2a01cb058702ff004d8cf526990082b9.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:4d8c:f526:9900:82b9])
        by smtp.gmail.com with ESMTPSA id k17sm2254910wmi.10.2020.04.22.23.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 23:49:02 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH 1/2] dt-bindings: arm: Add secure-clocks binding description
Date:   Thu, 23 Apr 2020 08:48:07 +0200
Message-Id: <20200423064808.10468-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423064808.10468-1-etienne.carriere@linaro.org>
References: <20200423064808.10468-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe how clocks property can leverage secure- property prefix
for clocks handled exclusively or shared by secure and non-secure
worlds.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 .../devicetree/bindings/arm/secure.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
index f27bbff2c780..9bc94921f2a6 100644
--- a/Documentation/devicetree/bindings/arm/secure.txt
+++ b/Documentation/devicetree/bindings/arm/secure.txt
@@ -53,6 +53,25 @@ Valid Secure world properties
    status = "disabled";                             /* disabled in both */
    status = "disabled"; secure-status = "disabled"; /* disabled in both */
 
+- secure-clocks : specifies the Phandle list secure world shall use
+  for the related clocks whereas property "clocks" specifies the
+  clock Phandle list non-secure shall use for the that clocks.
+  This configuration can apply for example when a hardware clock is
+  shared by the 2 worlds and the hardware implements a specific interface
+  for each world, i.e.:
+
+  clocks = <&clk DMA_NS>;	/* NS relies on clock handle DMA_NS */
+  secure-clocks = <&clk DMA_S>;	/* S relies on clock handle DMA_S */
+
+  Another example where use of "clocks" and "secure-clocks" can apply
+  is when hardware implements a clock that secure and non-secure must
+  share, as a shared GPIO bank clock, and secure world relies on clock
+  device driver whereas non-secure world relies on a software service
+  exposed by secure world as SCMI clock device. I.e.:
+
+  clocks = <&scmi_clk 2>;	/* NS relies on SCMI resources */
+  secure-clocks= <&clk 5>;	/* S accesses the SoC reset interfaces */
+
 The secure-chosen node
 ----------------------
 
-- 
2.17.1

