Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB3E2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="QkOD4DH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgHXIZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXIZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:25:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5F7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:25:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so10783054ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9oTVILcEoKhcccMH8Kmzts+hEsa+rrjmDS9KdukcGo=;
        b=QkOD4DH+C9AvSJExM71LMV3f244OyhiicXeduasp62I8qmFlrSclVkwx0QwJsQGHL2
         NGG2RrO18R+b5uXDL22fmvCAPYHavaR3egODQD1s6QaqNmP3YjycrVzZAc6FsHtc2mEx
         NJHUVF6/Rs/UfneP286oOLUvkFY8+++cVH6WwLdEJwdtVxkKZQmGr6sY6tytXjjMcpGv
         FgtoKg9GOKrWuLfMPP6f3Jhu3DjlauKIbKjzWnCK/IaPUmzIdN4caVYrFrMYoZljIH2N
         Corlf1y90A+lUgLdyiWex/Me+GPs97dMj4/B/ChAVpuxF445QiZLRk9OYlV2RF5tRXoL
         mY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=z9oTVILcEoKhcccMH8Kmzts+hEsa+rrjmDS9KdukcGo=;
        b=M69pn9okdMmHuKSFqHi5y5lDwM/mhsaTedYdcM/rteGhpBHCiVbXdctJMj/fdXkyCr
         4phEWImzFK2yq8l2p4faig/LfsZTt/LdQzg1A6wXoP1Ob/Fh+2cBdCyHG215FppFPno2
         tlXbxpP8/u3Wmxjwx36PleJrjEXeKWxIYdRHNpES2YzsuZCF9iriACn7+WNLGwYgjXNZ
         50UrfNoNmaCYUjVPXGtRZr/GCagIDSlhsT8jw0gdxKJb3fFE3Dv/u6O+WfwX3ZIPf+Mr
         h6GQRMv5qpGZbLUXLE5DYcd9OuBxageBKgYmBt+Ka7T9mzcVReME4ioE4PC9rg6IZp9T
         1VSQ==
X-Gm-Message-State: AOAM5326KSEYEKU53rJE4J8JMwUxKsLdP/ueAjqf43yFVsvhDrYea7Xa
        Xy/eFE/kHQUZ5jnuF/9vK0+BAUeS3g4iUg==
X-Google-Smtp-Source: ABdhPJx/gRQO+lspQ0C4EzCH2fjjj+XXJGCT3s18ptH3clpVXsV8/k/VYVvJrLU9MzryHM8VVndp6w==
X-Received: by 2002:a17:906:840c:: with SMTP id n12mr4288944ejx.246.1598257529645;
        Mon, 24 Aug 2020 01:25:29 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id ar2sm9248075ejc.61.2020.08.24.01.25.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 01:25:28 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, manish.narani@xilinx.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Add missing description for clk_in/out_sd1
Date:   Mon, 24 Aug 2020 10:25:23 +0200
Message-Id: <aef586778921c93377ec2f31c86e151b6e93f6c7.1598257520.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a8fdb80f4d47 ("arm64: zynqmp: Add ZynqMP SDHCI compatible
string") added clock-output-names for both SDHCIs before DT binding yaml
conversion. But only clk_in/out_sd0 clock names have been covered by
DT binding which ends up with dt yaml checking warnings as:
From schema: .../Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
... mmc@ff170000: clock-output-names:0: 'clk_out_sd0' was expected
... mmc@ff170000: clock-output-names:1: 'clk_in_sd0' was expected

Fixes: 16ecd8f33c6e ("dt-bindings: mmc: convert arasan sdhci bindings to yaml")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../devicetree/bindings/mmc/arasan,sdhci.yaml          | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 5887c917d480..58fe9d02a781 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -30,9 +30,13 @@ allOf:
     then:
       properties:
         clock-output-names:
-          items:
-            - const: clk_out_sd0
-            - const: clk_in_sd0
+          oneOf:
+            - items:
+              - const: clk_out_sd0
+              - const: clk_in_sd0
+            - items:
+              - const: clk_out_sd1
+              - const: clk_in_sd1
 
 properties:
   compatible:
-- 
2.28.0

