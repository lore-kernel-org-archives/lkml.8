Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C756C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6870220735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4AfkeRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgDVABo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgDVABa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:01:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E22C0610D5;
        Tue, 21 Apr 2020 17:01:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so388708ljl.2;
        Tue, 21 Apr 2020 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTx/eaYAn2EOObOw5K1yoeTPkB5owPl9cMTn96Ty+/g=;
        b=t4AfkeRPcA85flYD/e+w4oEPwjRtL/S6Id8zDKtdWPfj0yjiFgwEi3h7qZ2IfcbXyR
         6nTRygObBHQ2QIw+BuqxMzoTB4GuCPN+LuotD7m66xpLH0aVz5bVYw+UDJFuEbYnnM2/
         7jQO9zN5VDvT7opGV09EaTu1hIY4vgaW1a7QUDkJBYwenaPYJBM+o8y2fOERKVGlJz31
         dw0OdEaJtn33FOWGZlTW/cBZTNoZahtsZaoXgdHZdnx8bQMifs1z8UitvkbQGbYt2gFo
         B4DU2GLW9U77RXqBjh3MW376tPDWU152aTcddIRw8xcS0USt57DpbTMoEy0gUeFjfmPG
         zu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTx/eaYAn2EOObOw5K1yoeTPkB5owPl9cMTn96Ty+/g=;
        b=h0IpzocyPYA5nw9Uy+2o19Q8BkRp91yLUp0SdMYn1B1ieKaE2/mQt2xDOn8V/NDDEg
         2e04bT1OO37/B12hchZKbHhG9VInwBiPlU194vXpiUjTBbOUudWubpTr6rK4TysUa+A7
         kSkMVOFlFurC+F/nmM+tCLaV6qRRFGXJhFnDvmTbfsCfFmJzivPFLWefV53eNNs6Orqe
         IEUxKVO4HOC0JpaGd1L7qZ5rY+W8Kw8Nz9+xVFG/NbSnJAyVc+8hTNRGvpk5seyDX0tR
         DS5uAnJ1SQiXppM6cpzFPJtoqZ4BG8KaKRyKSUbgCMKhFUozFPopQVCvUyL4WZnajt1Q
         m0zw==
X-Gm-Message-State: AGi0PuZErxJ0m9tvcT1GbrxXOZgsgjs6whfER82EqFifUta8p4JB+yqO
        l1JTJFnzlcZodUV4WDIuV+4=
X-Google-Smtp-Source: APiQypKIcFR+dfBFZ7RDd3C0dn8R1SWhNhOaoEA1KZ8gZTSFhc52Q4lEoh7sxd2527kDLAsDXCTDnw==
X-Received: by 2002:a2e:7610:: with SMTP id r16mr11404437ljc.156.1587513687357;
        Tue, 21 Apr 2020 17:01:27 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id y9sm2933425ljm.11.2020.04.21.17.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 17:01:26 -0700 (PDT)
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
Subject: [PATCH v6 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Wed, 22 Apr 2020 02:59:41 +0300
Message-Id: <20200421235943.13627-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200421235943.13627-1-digetx@gmail.com>
References: <20200421235943.13627-1-digetx@gmail.com>
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

