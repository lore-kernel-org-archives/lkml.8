Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3617C2BA17
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 11:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0E420659
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 11:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ1elwuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgDDLwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 07:52:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53574 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgDDLwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 07:52:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id d77so9861609wmd.3;
        Sat, 04 Apr 2020 04:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NEH69Or2hzeYwgynW/zdgYOrxtAvoDOcH/4r2+cx3GQ=;
        b=IQ1elwuQfrv7z7KBKqsfXe+nJtZ9EpUmkp/QEgxZh1eGAsSzPCh4Pw9aelJPkO1lwd
         GeHg5B8Yg8SksRakKG3s5qyUWai+DwoUPCZzPAX9VG59mZ3lxjpIlgM0qT2LqFV6RMDS
         EzQPLB+oY5i/+g/hbAt3vmNL/foVckzdilsQWAa85V+uD0PM+vwECrMcaaBiGOvtVXMO
         aOuDKZxfO2lKiCVnsOC0uXYKUNBEplAHX6PjShJbIFLpuaLTL+JD2FH7FdjUgA778seH
         R9zIV+cnmbX28Q/5I+reBqMmD5G6QBn6dCZ1GnBrfcinWAFvtlhPJuY7FBJqNa7HtoEE
         ZlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NEH69Or2hzeYwgynW/zdgYOrxtAvoDOcH/4r2+cx3GQ=;
        b=CScyksfgGWtBMX2o2o2X6QYA3cwetP7tkp+MgMd707/wf7SdOFSiycMBTm5lwYwvjm
         HR4FZNvGXP9NpBcYGXGR0MmGaZO6GbeHJ7QlKEkyBllVR27KlvazlP5H+d+8vJVM6i1c
         jbYaSiD1aVfAVL4zU02GsH2Y+bTWZGp0qIsrn8h1TplCjFw/i3jlXB/h97V+Ym+IuXsw
         i5igjHcYMjNTzjZaSu88+g3521k6fpVd1/R/GOeU7s6KlniwuJU0tpMfxyLMXGIuKFZ7
         VFYB+aaO4QTXKlqD2lT0NUIvjKsIyMyh0fbOofhComw4WV+BW3bUctKnmq/WWyKhFbPk
         KvyA==
X-Gm-Message-State: AGi0PubmRkJPFyk/JL3d/p9I97iC9pF2YET5Tv6qyQkG3/BhpP4inLar
        hzPzRJkEV+6qesEQ8p7XPgI=
X-Google-Smtp-Source: APiQypLsS+luw94/uZOvPuvg8cKZwf3UNkI9eP06vdLN8Yj2UZWLbMLjom9VgzDkuQr2GPlhAP/WPg==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr13428237wmb.39.1586001153735;
        Sat, 04 Apr 2020 04:52:33 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g186sm16183276wmg.36.2020.04.04.04.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2020 04:52:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: sound: rockchip-spdif: add #sound-dai-cells property
Date:   Sat,  4 Apr 2020 13:52:24 +0200
Message-Id: <20200404115225.4314-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200404115225.4314-1-jbx6244@gmail.com>
References: <20200404115225.4314-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to 'rockchip-spdif.yaml'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes v3:
  Add reviewed by
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index bfd44fd8e..f381dbbf5 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -57,6 +57,9 @@ properties:
       The phandle of the syscon node for the GRF register.
       Required property on RK3288.
 
+  "#sound-dai-cells":
+    const: 0
+
 required:
   - compatible
   - reg
@@ -65,6 +68,7 @@ required:
   - clock-names
   - dmas
   - dma-names
+  - "#sound-dai-cells"
 
 if:
   properties:
@@ -90,4 +94,5 @@ examples:
       clock-names = "mclk", "hclk";
       dmas = <&dmac1_s 8>;
       dma-names = "tx";
+      #sound-dai-cells = <0>;
     };
-- 
2.11.0

