Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C30B2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+E/pO5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgDIEjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 00:39:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37868 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgDIEjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:39:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so10050739ljd.4;
        Wed, 08 Apr 2020 21:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Q73xNdv2R+z9gFjCSnBmt7b8MZjalwO0UY5qHs4gQ0=;
        b=j+E/pO5oeUTKpHisnXPL4xKYx8rtZwHYf7uJLrXXx/7aWsdlHbu25EFqAjxUeHu4oW
         hMw0Ttm1oy1A3zdktYXHVVUbUMZ+UGfJEvorAWvu6qeexfAdegXTTqL09ClMcXD/MGuD
         wKtgRJHSdp5S9TqxtM6F0YQCPJ7VbNxkhu8t3S8/cGkctWfp77zZErzXhPPOlzkWtMpb
         CNWQ1yJQw90RGX+Q+JLkJHe4CbaW71XwlAMk1991LPlF2WlDwiHbiH6edVPU1/03JLK0
         t36nOoCoYMdmG7iiu+l6Mf0xHcVi8GbJCd0lhfTH3o02AZLMgnVNhSIm50xvMwh7x/4n
         F9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Q73xNdv2R+z9gFjCSnBmt7b8MZjalwO0UY5qHs4gQ0=;
        b=eaH8YFuMWFOjfimLlQA6cnM/3x8yVaOuQZcsep12LmpoUaiuHC71t0fDgEZxaKsvfL
         XR3dTciX+z0rsHKd6KH4LM7uP/xQWyTVhspSs20KCc9bj8BPIkPML1cxM7Sb6gmujtNJ
         Tu5AcfKgxjbbEVKPyA/toRpXDtb967V5gtrxLiR/OxB384bKugWzsbaFS8plzCO5fGUV
         gvyi8zvH2Y89rs4z41SMg4tvNNeK0sCP5zPQZQ7TWKXA1S4E8MoktEcLsbiyMTRx8wp+
         nBCwDPXo79o4qGUrEfZVwJ+j9l/fCUk6gE+FTxhe2GNK5A9Vw2+iUkN7HmdVkKpxI9DC
         UC/A==
X-Gm-Message-State: AGi0PubjgHBznRk3dukzT30BFjE64146GzCPBKNyRxbFZTd2cNGS98+6
        S6gNrbgEczWU7S/GmzfOHUU=
X-Google-Smtp-Source: APiQypLlJZGt/DrfTYvSSeDNeGl8eyvktPcVRIowcz7uFVSwS+hyBJYC/iExJ2JUGA5nxWvIjJPJJA==
X-Received: by 2002:a2e:868b:: with SMTP id l11mr1872978lji.247.1586407156616;
        Wed, 08 Apr 2020 21:39:16 -0700 (PDT)
Received: from localhost.localdomain ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id h23sm12887893ljg.13.2020.04.08.21.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 21:39:16 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Check Point
Date:   Thu,  9 Apr 2020 06:38:46 +0200
Message-Id: <20200409043851.31217-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check Point Software Technologies Ltd. is a company based in Israel and
USA. They manufacture network devices and provide software
products for IT security.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..4033d8b38170 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -182,6 +182,8 @@ patternProperties:
   "^ceva,.*":
     description: Ceva, Inc.
   "^chipidea,.*":
+    description: Check Point Software Technologies Ltd.
+  "^checkpoint,.*":
     description: Chipidea, Inc
   "^chipone,.*":
     description: ChipOne
-- 
2.20.1

