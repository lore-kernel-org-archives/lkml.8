Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE294C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCA120748
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX9pzLac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgFGPn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgFGPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 11:43:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF27C08C5C3;
        Sun,  7 Jun 2020 08:43:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s1so17436563ljo.0;
        Sun, 07 Jun 2020 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iCdWrRbDH2WvQ48Wr/CMcqJb4o5FuxourEqY9JNpJE=;
        b=LX9pzLacgmX3hvFov09WFvcxT/XiRXuNuKOUhSaRZuXfbO9zJBONnio4kKoIhUYpOW
         WlxzW2bweqhuY5GHdCVZiN/T+QC53aMC6ykamNYAVO8IVKDougGO0RZvWCIWEaJrq0CY
         WehMe1Wo7I7jlN9/u1s9zqV57Mpocow/VhM4Rrzl1B9viQR74Ck2dxHhb9b2EvLhN6zA
         Hd06xY2/GLNUOudb0MrY9PpGM2VATUcVBjdVIxFADJ7zgKutfjE7LX2ryy/gdyblfxLo
         IsrxQIBD5wrjO8TStxacYX0BKYXMAMCyi3J+qFeSgtJ4sCktJuY4a0Yee4j16DXCVH2c
         pgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iCdWrRbDH2WvQ48Wr/CMcqJb4o5FuxourEqY9JNpJE=;
        b=i5ZQ3bCXGJM8OUXr96MOK7Px99lGfViUxQRXr+v0cPXJEArFvwUgcBlZ3KOuFCry2I
         g/MRvGqhOB1SHDhZ7BHeG+HFqyNl08vTbFdymgcy30zFVVtKOO+5HpMCeIa0uWqszGpq
         E4bgWpIvuIulK72MdSZU25z2z/uh+KVXWiDpSRQQvYXDjfAIIhCdvX90a0vfQNFOaesy
         hr94tHI74wVXmbgW+pab20ht5eFkB1L2NaW3lb+2cliMVi5NJi9vhYYThDVkVRrAJebj
         SJ2dxbpFVVDcxRPTjGOERLF8ekf00Ty4p2T/PZf757fpoWNY7KLuVS8dCzBmAj9VqNpQ
         WY8g==
X-Gm-Message-State: AOAM5317qiVVtVwItKSy7+yEtWA+lTCQYVse2CxtC+f7WfCWmLAbm+Su
        Dj0L0l6qVb5wFYBdlLj2S7A=
X-Google-Smtp-Source: ABdhPJw1E2nFSA+kcmvwVy7FG1ppIFTXWWHu4/gDQM0b0L6pqTrgvHyPFRVPYgkZNR0z+TD5KqwcoQ==
X-Received: by 2002:a2e:b814:: with SMTP id u20mr9773498ljo.261.1591544629131;
        Sun, 07 Jun 2020 08:43:49 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id a7sm3592234lfm.4.2020.06.07.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 08:43:48 -0700 (PDT)
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
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Date:   Sun,  7 Jun 2020 18:43:26 +0300
Message-Id: <20200607154327.18589-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607154327.18589-1-digetx@gmail.com>
References: <20200607154327.18589-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra30-based ASUS Google Nexus 7 tablet device.

Acked-by: Rob Herring <robh@kernel.org>
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

