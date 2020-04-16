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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E9CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B03206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="newE/pJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436917AbgDPQLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391640AbgDPQLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:11:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64FEC0610D5;
        Thu, 16 Apr 2020 09:11:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r24so8465773ljd.4;
        Thu, 16 Apr 2020 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTx/eaYAn2EOObOw5K1yoeTPkB5owPl9cMTn96Ty+/g=;
        b=newE/pJ0Ew1eEmed0KAEG0EnIdEI4Iycd/HDOMEgkLIsU1b7rIfEBPf9ld5sAtbtrn
         nAvIbIehZShl6Zx1CDvzTFyY0Af/jx1EvA4NxvJL5AXza8slqp0s1oeWLTRNd8XxbG4d
         6QKMoTEnhZR4b+EeEerlfv9G8HK845b7xtnO9rjwYQl2tFrrRvYpCni1YGyYV879ZvLl
         69T7VFRr3eZEJRvqZx2qcqES2qWt7lucMs2lvT/wN3Y8RK1YIlzf/aLL7o+Hq51BiCDc
         /YU5+YeEOjTTH5eR2JFH3YC0cT5kk+Zpji2EiDbvCqvEUgJtqxKCH//NJE9Mpx4lpM9E
         WP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTx/eaYAn2EOObOw5K1yoeTPkB5owPl9cMTn96Ty+/g=;
        b=NvY5t3hEJB4Z4T/fNLlqq0+cXFvz9/P0PxO1kezJlq1/F/ezrhjcaGo43wFy/3vtwG
         mvaoie8lrCdVD100vjg0Tbio4e61D1z8HCdGjTZwAkAHtHM9yj/G1Ro1kKbn4OPVPJ8X
         +NFih1es9ZVDdj3MFD5UexApfalNU5/3yGteH9+rjfrGDmW67MwRuoid6HMQEBLu61Qj
         fFkhQdBJDzuVEWmLNrWcNqib2Vu6neflg7UrotIWgFwu8bpfKbxOrVp/6A9ggdsOd+Lv
         Eh0ZRoE3FEw0AUVgNfhXKC00Z4vv4UBwsm9B9hOy8zCxWetlJDx9gq95yZRYyawIP0QP
         Xtag==
X-Gm-Message-State: AGi0PuYivrTlV0UXbvmSpeyS6Gwckus6jMps7hSfdBcYzcB5t6rRGtjS
        dedFq2Q9lUcjmDGoDo2hw20=
X-Google-Smtp-Source: APiQypKnkhT0pbqBlCrteK63VUEuVhdpWYHed1I1A5W7sVdYRnpg07cPOCG/Y+wH5cmrJEhlQM2VtQ==
X-Received: by 2002:a2e:a179:: with SMTP id u25mr6889276ljl.192.1587053474404;
        Thu, 16 Apr 2020 09:11:14 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id 125sm15702234lfb.89.2020.04.16.09.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 09:11:13 -0700 (PDT)
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
Subject: [PATCH v5 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Thu, 16 Apr 2020 19:09:54 +0300
Message-Id: <20200416160956.16468-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416160956.16468-1-digetx@gmail.com>
References: <20200416160956.16468-1-digetx@gmail.com>
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

