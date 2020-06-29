Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36909C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102BE206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATbEp5Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgF2Czf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgF2CzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:55:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C46AC03E97A;
        Sun, 28 Jun 2020 19:55:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t25so11754806lji.12;
        Sun, 28 Jun 2020 19:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iCdWrRbDH2WvQ48Wr/CMcqJb4o5FuxourEqY9JNpJE=;
        b=ATbEp5GcwsxMqVqfi7iK/jmjZ8PUbJdRVCiz9aNh/qXqeyF50BSOBJXTbGRST9Iw8e
         5+ZuYxhXkzYCfO0Qvu1/zPrEx216GhCGUxfimhyhZh4Wp9zGLeHJcHZVgK3BJm4FmmpH
         B/pgooaiJ2VQAbJs6pqTSKb3TquOb64uSqxbluHlmrE5BArrEwkSbuJiEmyqiONJRGdH
         9OGeQhu9yi+iM/DJW+DTsovro9ZTNBuUrVDNfP1JE7oIN0y2DoMyX/HZeUO2YsKoLiIt
         dT+goZiXkAuAhh6jhqw3f16xlJXSUMTf1chWosCjmcEng6/XS5XFqp7wFRHJw1wOo4wv
         O2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iCdWrRbDH2WvQ48Wr/CMcqJb4o5FuxourEqY9JNpJE=;
        b=nIYT5w80KcVnh/SwI65eoezfGiwE7mfZ343IHo2Bu0ElQ+6SYG47uUHlPxjr8fVpEy
         o99pyou0PegBtMDaAl8Te/j8bLC4xsbZlhPA/kRw5dutV/YRjGruUo6szfbXSb98uERl
         oMipO27LNSfXdXO9gl+4YzkI8QurHbpMTi6PBH8MpMrgxB+mA8GkgPVm8puRda8VyL1f
         v3mqIs/lz6aEK7aiAeWz8L31MwBYdmE80bRI+MtFvfv/xQ2FI++pP5UilcrcA2QZS/uM
         0f/ycmkb5RITHxNsX7jJbqy/5Rv/suh9dR5QKER+WARrDUVDfyIZrK79yqq/ZdgEqmce
         ei0Q==
X-Gm-Message-State: AOAM530/2xADCG9fWOcOVW01BPhTJ5YksR4vqQZg9Z/gSBaUUSmrRCFC
        bx1QQYssXISqgi3e0DzPBbw=
X-Google-Smtp-Source: ABdhPJxDEjaK5yx5ZbniWy/KXINVLv2cSkrK3eZvO6BmrtKmn1Swh5GnZymWy3zvaPZ1d58Iozt7qA==
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr7451460ljb.285.1593399321946;
        Sun, 28 Jun 2020 19:55:21 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id o4sm8820527lfb.52.2020.06.28.19.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 19:55:21 -0700 (PDT)
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
Subject: [PATCH v10 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Date:   Mon, 29 Jun 2020 05:54:55 +0300
Message-Id: <20200629025456.28124-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629025456.28124-1-digetx@gmail.com>
References: <20200629025456.28124-1-digetx@gmail.com>
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

