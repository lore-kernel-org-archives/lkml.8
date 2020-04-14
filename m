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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F4BC38A2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A852076A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2py/2FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634258AbgDNWLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634207AbgDNWKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:10:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17EDC061A41;
        Tue, 14 Apr 2020 15:10:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so1516515ljn.7;
        Tue, 14 Apr 2020 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSop2fRHEeN0n5T5a31s3xV0wqW+LOYJC5cXPalZm5Q=;
        b=a2py/2FAfrZLuxoCDH4HxZ9tMAtoDgAUFHDtAX3R3eeCWnR/FO5HOJ5T0sOOzsTKqm
         mJOAHuh2o4zrvpS+kLd2BcHsxeWz6b6KTfaDhSKli68zlsi3fDyTJ9+3aLsRkcH0sNuN
         b5NXblqClaF+9+kBLVmHp3RDoNjrJwwKEepBsFaF6x4tqiDdOblq894nNi+llCoSZEal
         /Zlc29atgGE97MT7i4nDtYpIGdzKXvCfOUzU7AlHEg0DurKbhto42uju2x6RqJxdG7IO
         C7OmJlO9cNviMTiZb8tGLXGATvIuAyUQ2rFnJtX6HfPgRkHvUhzsZuGmgoq4CJimHMnE
         888w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSop2fRHEeN0n5T5a31s3xV0wqW+LOYJC5cXPalZm5Q=;
        b=Jjr3EuS/kkCq89uKZ6F22JBRPyezGwSygNXhorsk4qv28KbduAYZud2LcAN8/l9aKx
         X9i2KOTVZrkPfTqUfUcROPQqCQc/rvp949OuIO83fceZJiQXjFDmXA3Eq8Hvu0zx9eKN
         ru4D52w9hPuPIzSlF0VQn2aWNKGMGdKkK4hlsvX36Tf6rWtSpHnkdMmX3d8L0C2DFD5r
         X3LUObTDPoo2+Kcjn1MbqdNP18+A3m2Alp/0QtpJ13m42D6DCiWZYo1Q2rVlMqmAEYmG
         z/rPNo4ctRHGb358JIH6qfQr2SpFzZ6wljX+LglClkKNzCybRgNHUARqS3CngrFVgriL
         Ex1A==
X-Gm-Message-State: AGi0PuZc+66nsassjQDw+1G7h6dNL4EACCPhBY0nite46xByX5189bMq
        6kPz9PP6tWGuKiO62HoQ4wI=
X-Google-Smtp-Source: APiQypJShCEnh6i4AC9mC3/EsPC+BSONeHTSPxNm9mVVKag8PST7G/K1FdtZE5MWUw5iM24kmyfXow==
X-Received: by 2002:a2e:b177:: with SMTP id a23mr1352934ljm.174.1586902209465;
        Tue, 14 Apr 2020 15:10:09 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id w27sm13663044lfn.45.2020.04.14.15.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:10:08 -0700 (PDT)
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
Subject: [PATCH v4 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Date:   Wed, 15 Apr 2020 01:07:58 +0300
Message-Id: <20200414220759.29146-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414220759.29146-1-digetx@gmail.com>
References: <20200414220759.29146-1-digetx@gmail.com>
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

