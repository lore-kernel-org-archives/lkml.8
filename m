Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACFBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE53F20734
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8pTQ/Wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgENVib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgENViO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:38:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A63C061A0C;
        Thu, 14 May 2020 14:38:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a9so45834lfb.8;
        Thu, 14 May 2020 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iCdWrRbDH2WvQ48Wr/CMcqJb4o5FuxourEqY9JNpJE=;
        b=N8pTQ/WhnOp/+HIY0br2yQWBQm+3bfkLgHqh+VpP2IECb1YLJDxtP4eLSVkvvGTBsd
         gi/Ziu+tWDGuXtETjhr47AMSNEm9bst5AV+xAumIA1Oojy6V7P/qe/q4KodRK2y052zq
         /WYAhqdz03ZW22xbUCJ0WeGLeBwlqmQdUMrdPSlarpa2CBjXkJeSyepO34G1+AUYWQ62
         BwY5IzFYObT7AMftOc99mpQcXCf5RlHHGeSvUDUPl8Ca/skxidngu26D0L7S5t74a7Ed
         P/a9VzMuRqNGBqM47np9yWLPr3iQO7G17bHQ5tmKpcvhppxnJfLDWZlrdOOO25YhPbwD
         vmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iCdWrRbDH2WvQ48Wr/CMcqJb4o5FuxourEqY9JNpJE=;
        b=bZrownKe+gbRYURGvP1oBzts5zXGoqdnwCBiLGq4o2KS/8XIrq72+z3UIoa++MHEb0
         akOEcZuES1x8PdzPvruiSDjYg8YU7PrRexm3l/hxLq2dGPJpaelMtvDnoadPKWJVRjg/
         rXfpSv3mf/RldtqxmWy1bhxrKSXkfEZqSW7UBYAjO4zZ9Q9ktfh5OfyfEbRD0h2ve5Zm
         0gYF6u35aMPQ3RKuXxKT3kt9enWQ+1wX6NVoI1GSPzKpHibmxLrItgGhj+46/CLrZkH7
         /ihJLcX62OBIpsREh2YPRoRLfZbC46e71MgFTBI8Clwzv0sEY+8mL75IA40yRmvkTBAd
         pURg==
X-Gm-Message-State: AOAM530TjlBpOac/k9CoD2OO2U/E9DIj+xsrG9K3zmEHW1+0IJQRVVVf
        ikReXu/mQs92asCxg9Vh+8g=
X-Google-Smtp-Source: ABdhPJyClrLJ3DenDvHGhMrYDx7klSDkrnUQ4dRUWTM6qIDd5vKwcf8iWLOxl6kHb30cPecwcC+vwQ==
X-Received: by 2002:a19:bc4:: with SMTP id 187mr112415lfl.211.1589492292445;
        Thu, 14 May 2020 14:38:12 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a12sm63628ljj.64.2020.05.14.14.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:38:11 -0700 (PDT)
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
Subject: [PATCH v8 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Date:   Fri, 15 May 2020 00:36:53 +0300
Message-Id: <20200514213654.12834-6-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200514213654.12834-1-digetx@gmail.com>
References: <20200514213654.12834-1-digetx@gmail.com>
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

