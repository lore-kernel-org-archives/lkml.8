Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119DBC38A2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE16520857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr/rl32Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504007AbgDPQLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392983AbgDPQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:11:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC76C061A10;
        Thu, 16 Apr 2020 09:11:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j3so7972380ljg.8;
        Thu, 16 Apr 2020 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSop2fRHEeN0n5T5a31s3xV0wqW+LOYJC5cXPalZm5Q=;
        b=Rr/rl32YZBcAaMdSeiVeUA3zX3g3uCw/fIa84SjVVZ11lBTT774xj3bcq0R4CM+G/6
         axV/qiZxLOi1U8sZXU+H+988g7aF/g069+P+gtaHehLtD280JXtyvPE+nxK1yxxU/UUi
         ib7elNuam5q6dyhgo2uARJ9TnBldVt4/D5Z7a7CkxoJiO3+x/ayBTIaXqNB5lvJFxxOc
         3aBRW2eGWS0D3Qus5aFFDSM4yFxVhtXRYHw8xVafdcB1/eJ5+3i90Zw+yaC1zUGlLR+Z
         1rRAB7SQ6sPzxAg2xo3YZ4F2VAurbBXOS1qar0+OB/z9o9PHxcm+7mZqMWAMVyqPQHJR
         MoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSop2fRHEeN0n5T5a31s3xV0wqW+LOYJC5cXPalZm5Q=;
        b=U5V1njOEvBDEQcCHlVTkMWWTsi+aiMySp+/Uyopt3uJbEc9s4qU+YIdtCE8Md3QfMA
         pP/gHy776qOJQzz/xA7Wh9kfFAk0Xbxlg/OCtJmB1Mc4pBRhd6cWHxCIvYyziV6me1zL
         Mr6R2r5m3KPsCD7c61Icw1Pa+6I7shWaNC77zEkkmOtTXbWon5zAvOS3KXTAoyREfpVZ
         aWBhdLfdPhwVYNW+gIHEpZ8uz52L/NC11pqO/hix2aojIF3gjjYpNNj+MXVkImTfQ0m+
         CKugPCHLtLH/5xOskiavSn22+nr5JSo4Os1PYfSGUJeCZgdAoK6m2QKaojJaS1UUu5bi
         6hqg==
X-Gm-Message-State: AGi0PuZxqZQZH+8qZDGWI6m5zc7WPyTyy9aRYMgPSAYhkRJVaC+1V0Uj
        DCHbpkxq6wsakS0a5PAowUo=
X-Google-Smtp-Source: APiQypJaxKO5vs98n9b63E7t4P7CsdyuoUkwWsxhKgYnFlEeVEbRaRIttZv9Vkz8qDTnIKJPFDKLVA==
X-Received: by 2002:a2e:9f16:: with SMTP id u22mr6595667ljk.202.1587053475405;
        Thu, 16 Apr 2020 09:11:15 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id 125sm15702234lfb.89.2020.04.16.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:11:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Date:   Thu, 16 Apr 2020 19:09:55 +0300
Message-Id: <20200416160956.16468-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416160956.16468-1-digetx@gmail.com>
References: <20200416160956.16468-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra30-based ASUS Google Nexus 7 tablet device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 7fd0b66c69b2..fb3bbf7a5fb4 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -62,6 +62,13 @@ properties:
               - toradex,colibri_t30-eval-v3
           - const: toradex,colibri_t30
           - const: nvidia,tegra30
+      - items:
+          - const: asus,grouper
+          - const: nvidia,tegra30
+      - items:
+          - const: asus,tilapia
+          - const: asus,grouper
+          - const: nvidia,tegra30
       - items:
           - enum:
               - nvidia,dalmore
-- 
2.26.0

