Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE07C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1ED206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpwFnppq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgDHUlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:41:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42569 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728970AbgDHUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:41:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so9109033ljp.9;
        Wed, 08 Apr 2020 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMH1Nn5N++bI82vIh9Zeuiq3h9nQ3Tmnp6S+rKl7EQQ=;
        b=BpwFnppqcLZOPMRxvow1AbvcXuw+LGJXXW3YesZitK0ee3meIpNyhFQSaN6lKc2E3e
         QdqeRZbSO1mhtl1vNx8CDU0cePi/UMCD82sMpGvEJoy+gUY9DSbDgxRtm8u721XZykxN
         Vc/7OcSl52+VKP8OI2V89pLXOU231Ua3zn3wpElhj9476Bw5xpE+6GoOQiG8Lrg9yBR4
         FIykuxoZlnbg0E3L9X7Oouc4GwTVvJiSotpWaMjXC1h4kbL5Os0M5YuyV24j0b5NOvfA
         tyFmGVVqDsjFXuhiBQ+bJjzCqB2ywzYv0PutfO5UDbom9CAFrsC1qgdRVdU3vsSrLYQW
         0S8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMH1Nn5N++bI82vIh9Zeuiq3h9nQ3Tmnp6S+rKl7EQQ=;
        b=UJ4Ngw3sAGZu9LnpYsD8EoIuGeGfKeDW7tKyLd72mdYJGfVBp3a3Wp+HUF+eLWgVnQ
         JkXWC10bcNjdDgJzmg/EIY17S0uSVZeEwbR0kGRsXkOMuTd7ve9wzPBdluTUkaPiCu7e
         TRvzdpXPOuYIsxTgjF1jCh0aowaIwHf0u5/VkZYhbzCQYMJLiyXQADuAcrTgwHaICdNo
         fEmeuxTRk09PBa+V6/SD/ljxUYdgalhnldJURyGHIsGvTzBHKbqAMoE7ShxZMBa/m+YG
         LnPqYyKeoW/+yWHh80w6LySMB4jEAsVIAG5uLoYRpKMWyrejpTsOChwzE2rFX2SDSlvV
         /KSg==
X-Gm-Message-State: AGi0Pua21mxtCStAeEZDKrrX4psHsk8p1gZ5fL81IAM2xNTWHvRgVk61
        JPDmFF6vtwEG/NVDsir3D1o=
X-Google-Smtp-Source: APiQypKf0vBdDq3CrSKg/wNsyqgATcaa9BpFhUQ8ohV3RW3Xy+aaXR9CF0tG3AcI7mKPUjvKhOMCNQ==
X-Received: by 2002:a2e:5844:: with SMTP id x4mr5899665ljd.40.1586378468632;
        Wed, 08 Apr 2020 13:41:08 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id p14sm13189727lfe.87.2020.04.08.13.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:41:08 -0700 (PDT)
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
Subject: [PATCH v3 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Wed,  8 Apr 2020 23:39:43 +0300
Message-Id: <20200408203945.10329-5-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408203945.10329-1-digetx@gmail.com>
References: <20200408203945.10329-1-digetx@gmail.com>
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
2.25.1

