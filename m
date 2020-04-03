Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAC3C2BA18
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3882077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr+nvzcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391073AbgDCOWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:22:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35816 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390940AbgDCOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:22:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so6449765wrx.2;
        Fri, 03 Apr 2020 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eO7X7pq9711SintqFPgETXqv2Z2n0tdDbbm4z7qxhxQ=;
        b=mr+nvzcL9deyVcXVL/g1iirSVwK3iqndoX+uC5K0N8OLS2lWwJzFG9Jw2Us/+fDJpW
         brLw+fuh6Ak35u+NuycplcSpqr82DZbcL0hLTZu/+IUeMfHv70EY85g6KjszihMlq5iA
         lSHDCK302Ag022kI1mIAq4N+ho3T7qHlcGZNzQvXl2zDPWFa/vGS/tAnUZqurLVHM11r
         WiZbq3t67mum6LuNLEe/neZ2QBJEXLMGOK8/86HtQtVT40k8OfRnx0CMngdy3mKuFtbT
         3V4NR93kIMMp7AZIbDs2j6RSLe193oXCWnU1L3yihX4G5Xlj/0HCPorjdSQgpacir6kO
         h8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eO7X7pq9711SintqFPgETXqv2Z2n0tdDbbm4z7qxhxQ=;
        b=BspySNqG+4jmDrhr1uPKAzkiZeUG8n6mBsXVT+jt5SmhlNkOvbHdTAh4Bh4zhdhm0l
         O9DIvQmDr/BLulWcOwi5qan23QOPTnmAd2TC21VQVCWXyAh4ZNzotQ5OYg9zCcuxZEao
         jySFdsoln2eeadcBIjldTiU7XT+YCF8NK4TculHOWNf5B5U5fqoA0X19n844Bn9hSxjv
         1WKttaM/S0RHH+xEbPstOcgi1Of+Y41Ecw6jbiJwRLgI4Sq9kXAy7pAY1om3Q7/bT5pu
         okVPCdAN4HUg8cPT0ITZWG7egh9HhidHqfHR4Pyk9vW+Yg3rJ93IdmGff36jEY5KNNUa
         ELuA==
X-Gm-Message-State: AGi0PuZdzo4l/aX40P3iZfecLM2Fvvuva/bXB810LMRnwT/vwFBxftsB
        SrOMMjtROTLFZUAOig/oUNpkUV9R
X-Google-Smtp-Source: APiQypKqvGkEBCSrGQT9ZsOFXHyYXGCO7wGvqTuF8jcFlGkZFIKO0QpJ3Mhc4I2GDp3Z3cr8LBDI5Q==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr9559333wrq.345.1585923765447;
        Fri, 03 Apr 2020 07:22:45 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u16sm12132223wro.23.2020.04.03.07.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 07:22:44 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] dt-bindings: display: rockchip-vop: add additional properties
Date:   Fri,  3 Apr 2020 16:22:35 +0200
Message-Id: <20200403142235.8870-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403142235.8870-1-jbx6244@gmail.com>
References: <20200403142235.8870-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the old txt situation we add/describe only properties that are used
by the driver/hardware itself. With yaml it also filters things in a
node that are used by other drivers like 'assigned-clocks' and
'assigned-clock-rates' for rk3399 and 'power-domains' for most
Rockchip Socs in 'vop' nodes, so add them to 'rockchip-vop.yaml'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v5:
  Add reviewed by
---
 .../devicetree/bindings/display/rockchip/rockchip-vop.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
index 42ee2b5c3..1695e3e4b 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.yaml
@@ -75,9 +75,18 @@ properties:
       A port node with endpoint definitions as defined in
       Documentation/devicetree/bindings/media/video-interfaces.txt.
 
+  assigned-clocks:
+    maxItems: 2
+
+  assigned-clock-rates:
+    maxItems: 2
+
   iommus:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -94,6 +103,7 @@ examples:
   - |
     #include <dt-bindings/clock/rk3288-cru.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/rk3288-power.h>
     vopb: vopb@ff930000 {
       compatible = "rockchip,rk3288-vop";
       reg = <0x0 0xff930000 0x0 0x19c>,
@@ -103,6 +113,7 @@ examples:
                <&cru DCLK_VOP0>,
                <&cru HCLK_VOP0>;
       clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+      power-domains = <&power RK3288_PD_VIO>;
       resets = <&cru SRST_LCDC1_AXI>,
                <&cru SRST_LCDC1_AHB>,
                <&cru SRST_LCDC1_DCLK>;
-- 
2.11.0

