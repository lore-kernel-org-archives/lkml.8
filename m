Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_BL,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AA8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8978207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thnsfHkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgESQok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgESQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:44:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D647C08C5C0;
        Tue, 19 May 2020 09:44:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a2so2939807ejb.10;
        Tue, 19 May 2020 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x55y7NheOCYCR/iiqhGsYzOg4DTF/y3LF/qDoYECs4o=;
        b=thnsfHkv0gxvjmBc79oOPNa2XSk/2n5KFV9FZB7tOa33jiWBZ1goEgBCBwUdrwZ3gj
         OTCkcHhoWCeQ1W2Nh125unX/RglfetrAr5DQQzJrz76pUhOC9BTlo31qcxY+eal1Z18J
         G+eb/Kbx8lFloEz4tj66j3zowbRjicyuqKcaX8cJzzKOgA2in0yampzsSdGccRslDYuP
         dTxIpS0YXYZjzpLBHS3iLdoE6X1YzfUIsLswsmaQdVOIOdl5adc78Sqbe53kVmau7Lmu
         Y0OCL23mG7KsKA9JSvccCLbb484dJ+fBfTRBO65FVFIQxgopISt+qn+kqokAxh66IZPV
         /hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x55y7NheOCYCR/iiqhGsYzOg4DTF/y3LF/qDoYECs4o=;
        b=rZ1oL1ZpH7+U0ZiBM8hfzAZG975YQRKGogOZaRueid/gLAdgHJIyKeuj3m6Ha7afuz
         ErZx2vL8YO8ZdMjfSO9zACfJ0OZKGTA3jXyKXijGrr7Ec90wPnmfm7d+09soFFqjlfqv
         GX8DHEHkbJQEnShOShd0ASraBrDTCWnOZ63BnTn93P3z5y7uvmF9HudxURoGw6EBRA3n
         lBPr2Bf5U7dCU26+G4UtFSFPeX6KLFcgd32+5KMKcv2XWsXCPGceQwFyyGr79ivxd+hg
         ZWWBvI+JmRovv4DMfqJwrW3U5ObgKZYzClp4k5GIgnYujQ8i+u8DtRgMC1lwlYNVsRn4
         +pmQ==
X-Gm-Message-State: AOAM532k9cad84dORSzQtDRcrHRDI681IeonnkKBULrbUJAdKJnIMdaG
        MBhBx9xmxinmPLX95GbOEoeplFbL6TI=
X-Google-Smtp-Source: ABdhPJzyeykMTQLiecg5AXfa/nUcuDFcwIRER9TYnQXDCL+XVixes/FbSGKEiL37/S3TIG69RrvBIw==
X-Received: by 2002:a17:906:f1cf:: with SMTP id gx15mr60051ejb.471.1589906677896;
        Tue, 19 May 2020 09:44:37 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b3sm49627ejq.52.2020.05.19.09.44.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 09:44:37 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, maxime.ripard@free-electrons.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpu: arm,mali-utgard: add additional properties
Date:   Tue, 19 May 2020 18:44:25 +0200
Message-Id: <20200519164425.9729-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the old txt situation we add/describe only properties that are used
by the driver/hardware itself. With yaml it also filters things in a
node that are used by other drivers like 'assigned-clocks' and
'assigned-clock-rates' for some older Rockchip SoCs in 'gpu' nodes,
so add them to 'arm,mali-utgard.yaml'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index 4869258da..2fc97c544 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -95,6 +95,12 @@ properties:
       - const: bus
       - const: core
 
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-rates:
+    maxItems: 1
+
   memory-region: true
 
   mali-supply: true
-- 
2.11.0

