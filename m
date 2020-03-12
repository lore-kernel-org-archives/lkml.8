Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D696C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CED920716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6RAegYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCLRau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:30:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36201 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLRas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:30:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id s5so8593013wrg.3;
        Thu, 12 Mar 2020 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3OsNYo4WOFc4e3N45xENkSPMvXkKhjC6Ed5es5ifqc=;
        b=g6RAegYueXWuES+iYPK9Gx7ix10quTgc1ud5mKsYb3JnooppxE0lL1gjlhqcSCzaQj
         J/HpKmkgG1HkW6I6eDyzTS7nsc0xqLs9o0Ew4C14V6N+HogqAbYe4OtujhizuUqlpZR5
         rulWdJPyPze13u9HQ9NENF7fALTj1bdbjZDh92TloU9d78F3K8M1khhOakADPAZEffjL
         WquoKWFqAFPYlEHDxJp2bOoe38p89iKuifCU82U5+NdiB3jpZFc6lwfRNiWw8pAi3q0v
         LpnjMSR7EfUQfh8nsNXo+Xg/U2LR+yOVrAVKlQWtk0IuJWsUkKXk8w+1EXbtNOcTURHT
         hCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3OsNYo4WOFc4e3N45xENkSPMvXkKhjC6Ed5es5ifqc=;
        b=QJgynHrxWF+B/giDfziVrKL2CD1dgRoyWRe9Yq2mcG0tp78uhlD4yp0h3Np63t+TbR
         hnvjrHXNzJuYKPEHHK6TRQEbBUnKvmq1D7vwJomjS5ix5iUrkV9Agz4aLbUjJTVqV7MU
         WnhNx8tr76QwdRfzfaPSlwETc1xfZ8YtEWtp3kuB0hApG94QVSJrH4cqdty77seEDqcD
         +vz+c1qmCY6QIM/bDUTWWb1s2JtQ/MGTyUs395bVcELp73Sb7xYr1BGx6i2M/akqYtP4
         PAdScodgnh66Yfo0YgsvINMcsrc1JCV0DHQsN0yIJnS7Qhe/oHsXD18v5KQ7daLN0GWM
         ewfg==
X-Gm-Message-State: ANhLgQ1uXBMqIjQo4u/Io4H1Ih5Xbz22THnIiLFJZuUXJdrdbNrMCPdq
        vUCgna1hvays5oOoG5XeLv4=
X-Google-Smtp-Source: ADFU+vuaSKw7SYbH880phKppaz4MtvoEjwN3be8Iip/jpwF5n3XHQkpzzWFily55uljws4EM4ziA8A==
X-Received: by 2002:a5d:6908:: with SMTP id t8mr12459365wru.92.1584034246665;
        Thu, 12 Mar 2020 10:30:46 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x24sm13170222wmc.36.2020.03.12.10.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:30:46 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: sound: rockchip-spdif: add #sound-dai-cells property
Date:   Thu, 12 Mar 2020 18:30:37 +0100
Message-Id: <20200312173037.21477-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200312173037.21477-1-jbx6244@gmail.com>
References: <20200312173037.21477-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to 'rockchip-spdif.yaml'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index 45c6eea30..39aa0b4f7 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -59,6 +59,9 @@ properties:
       The phandle of the syscon node for the GRF register.
       Required property on RK3288.
 
+  "#sound-dai-cells":
+    const: 0
+
 required:
   - compatible
   - reg
@@ -67,6 +70,7 @@ required:
   - clock-names
   - dmas
   - dma-names
+  - "#sound-dai-cells"
 
 if:
   properties:
@@ -93,4 +97,5 @@ examples:
       clock-names = "mclk", "hclk";
       dmas = <&dmac1_s 8>;
       dma-names = "tx";
+      #sound-dai-cells = <0>;
     };
-- 
2.11.0

