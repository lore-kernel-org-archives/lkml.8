Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD41C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DE220706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMDhHEp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgDVABl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgDVABa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:01:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165A2C0610D6;
        Tue, 21 Apr 2020 17:01:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so344050lje.10;
        Tue, 21 Apr 2020 17:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSop2fRHEeN0n5T5a31s3xV0wqW+LOYJC5cXPalZm5Q=;
        b=EMDhHEp+Peft1yloUd3elD/G40QVs3jZd3mgFoRd3Km2h2zIlvmWlg+W0kM1HzRs7o
         NbX3rqyOTbUkjEse+EDig69a4jrDMzk/+HbPC2rSRI5Hb0W4rYc6VTIwp6cZN7YYOqzI
         fPGRwU7lz5jz5Yb9Wv45DnvRtQrSO6Es+onZiait9dei1BnVPBoUh45IpRa7fE1SYiOZ
         wOos1/KTXivIIQTAA6t3KYj63juTa1dd0CnOPMVTh0jzJfQSi3BUNew/GOwhwj2IxSvD
         DSYtfvhbpuTk6I5L6GxJp0fs8TArErPEhRyHVPO2z0HgQ30yOogSYHUvfoJf7N0DEdUf
         XZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSop2fRHEeN0n5T5a31s3xV0wqW+LOYJC5cXPalZm5Q=;
        b=eb4PrlRIq+Kxw3iLTlKDtlD+nt1C24ma/GR3aLQ7Pvyao+LlFq//GGlEvKGnWCr6mj
         FYu67Jw0AKOAJWk1L2UxCjhrFJfGpSVBHVF7SW0nLJ+8mD/tl0RpVAOrNdRSOP8XBGLO
         mwyyNFXpARZFCkwov/Hx7ivCefRJWvUyoXkHFQC451g3R1DA+BJyJJQOLbeCBzMWnl1v
         rC4a3EjfrTY77Carag2hgrNFC4PrdbJXgLCgdrqnONkmq/oaIntQOdD044tAj8+e0dn0
         g9eX51CoYIBbLyK5+oqI0BtYWIE/7T63qhVt1b8XxRe6VNMpjOrSg4fSfbgYJz7RsM8n
         HaTw==
X-Gm-Message-State: AGi0Pub3fxrOAjieHK4ZzA0ab8yYZpU83+f8WSWzrpzcpfuR4IP9Oxct
        vVtpmp4YERGmq1/m6jIQ7jI=
X-Google-Smtp-Source: APiQypLXDoczTX6/WPl5z1ozxvqYP2lA45zK81XyB/lu7FbyIfB6KBCL8oai+zC+XnvsgD8hHuNEQg==
X-Received: by 2002:a2e:580e:: with SMTP id m14mr15105060ljb.78.1587513688565;
        Tue, 21 Apr 2020 17:01:28 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id y9sm2933425ljm.11.2020.04.21.17.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 17:01:28 -0700 (PDT)
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
Subject: [PATCH v6 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Date:   Wed, 22 Apr 2020 02:59:42 +0300
Message-Id: <20200421235943.13627-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200421235943.13627-1-digetx@gmail.com>
References: <20200421235943.13627-1-digetx@gmail.com>
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

