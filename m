Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15FFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2F62076A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAuzvTjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634266AbgDNWLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634204AbgDNWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:10:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072FC061A10;
        Tue, 14 Apr 2020 15:10:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k21so1555633ljh.2;
        Tue, 14 Apr 2020 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTx/eaYAn2EOObOw5K1yoeTPkB5owPl9cMTn96Ty+/g=;
        b=pAuzvTjPtDjbuLhl7hh3LnMAH305R8SRXHGuKIKDFHHcXGRusSkjZPDDo9n9WtlIUg
         lHBMHUQuGJ7LAup2wWKLYoNzpLHlNIlc8pudhvgL9B7mGPXRspxHap6domea4tB7/9ZN
         +lvQd5NpXyR2unjFQdYvYR8zHQ0qN0mwQZMhbOUbTxsWWF2Nle6vLzkj6ubbNOJV9v7d
         BsTyUnZkD/KILDCp6+V0cbe94AkEdJnyU5I9eQ0+ZAsvJljuZdkULcpGgYdXqggJ44/A
         5XMNi/yqTplWBMkwf7COHc10MFRUK9qTUT2ycKxsDudkSar0AN3BH1OPXaQK5sxA4l2y
         ODPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTx/eaYAn2EOObOw5K1yoeTPkB5owPl9cMTn96Ty+/g=;
        b=ZENISSd+ZfJMzYiuL4HAUbjD2fuUPbBosFXbwQ6u3R4P7MvYuZknVyX3OPb1Tec1FV
         XE6/exdEmYfWJ+PsqUiNsdljtO74xQiEpZ4R/oDE+lX9ww79W9jH11uV8NtQeYv7cHzq
         +sddBKmn8L01GXmPrS7yyhJjJJfNU6oFNi57+bhdKzfNV0qedQ3orVtC56/034uZ4/dl
         s9yrc84Pj+XzisW2gZpJA9tp/jve2rbW3Keh4OqOCUnNsb5PezYLLrBnEVmyI4rcDpc9
         LT+fOtPd93Fbj2Dkf0ifTJ7pGyannHyzf0jkJKToPJFGyHKW+HAgEORajRO8sMaivd6x
         +zIA==
X-Gm-Message-State: AGi0PubfeBplTTC7cVIOBWbq0V0JeLo+70YjVJwY93u1KQ2pSaomOVAy
        ulYVeOT/OvuplBL0KJlJzu8=
X-Google-Smtp-Source: APiQypJJQ6pI7ueMyuiRqhAE+zMHL/SsFmuPuacSaPcb95DBkHUUuPt2NDoJfsWEt4hQnSomjDj/3w==
X-Received: by 2002:a2e:8612:: with SMTP id a18mr1230687lji.250.1586902208013;
        Tue, 14 Apr 2020 15:10:08 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id w27sm13663044lfn.45.2020.04.14.15.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:10:07 -0700 (PDT)
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
Subject: [PATCH v4 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Wed, 15 Apr 2020 01:07:57 +0300
Message-Id: <20200414220759.29146-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414220759.29146-1-digetx@gmail.com>
References: <20200414220759.29146-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra20-based Acer Iconia Tab A500 tablet device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 60b38eb5c61a..7fd0b66c69b2 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -34,6 +34,9 @@ properties:
               - toradex,colibri_t20-iris
           - const: toradex,colibri_t20
           - const: nvidia,tegra20
+      - items:
+          - const: acer,picasso
+          - const: nvidia,tegra20
       - items:
           - enum:
               - nvidia,beaver
-- 
2.26.0

