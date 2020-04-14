Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B09C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5152076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK2i2Qel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbgDNWMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634203AbgDNWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:10:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBEC061A0F;
        Tue, 14 Apr 2020 15:10:08 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 131so997439lfh.11;
        Tue, 14 Apr 2020 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wa5Gj1CyNH01jcBD0o5S75G9jpd9ZtMAtnHB70z9Un4=;
        b=VK2i2QelpzAaBQDz5q4h/4cYpknhPz730Ezzz8HsBnHQOd8b4xGIPqmi9RV/HBXQ+o
         EbWbveK1H/Bqd/hJEIHZxI6C+Z/a8QqVoiq+zZJhgDEHl2gqvb6xpCLl4xBBglcOgzy7
         4n50XMIq1jejGJQeh2PHbxTntqKKfHNmSZ4iEVmyn8D++IqP2MCCSlS6sSvcPblo92Xl
         PRwviTsWQXXcedcAZsiCzZA8F4E5Ttepuodu9RM8LqYEhpLlsytBa4jyLLtiaH9VKlmy
         l2Xd9imwSXbeSjZjt5oBiv/WvhtA1vXvA6lGlrVV4LtvYvhne/1BiNBZ/lxU1WwcEaGT
         nt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wa5Gj1CyNH01jcBD0o5S75G9jpd9ZtMAtnHB70z9Un4=;
        b=P0R0J2GNJ6UBtZNenPb4tJZOALE0ecStNv8bd+qG7sK76oDWBzsE5rbfSh11df38Ea
         f0dDt4COJaLEGH1RWxkHqTba4kYUlqMm1q0BEwRfKIe7hUaBvhqo57fmkxv+BQHj85Tz
         mtnuDV7a4oGnnf9kZuK4luQbE7h+hDEqOyletTMx4eAb+w+8rCQss+Hf6oZk82xpC1KP
         2ATsB5oDeaQUsGJKrZ359mC3hhSrdFwNBeAfrIyEm6Qa3tqB9rFYxvK002Lw8di62HUk
         2Pa8E8A9MjloHoXit4/DM1NrMD3zKBz4CeyjRGt/fn9fcTY4nArXl8z4E8g/3tvaW0IC
         Qe6g==
X-Gm-Message-State: AGi0PuanN3foMKOkGIRVoxNpdSK5VTKVDnu41kcIg651gf80N64lfRX+
        PR6caqslDHgeXSuTN2x/gDo=
X-Google-Smtp-Source: APiQypLC2+NAzd0p67V0ZIpzRZsl2zs8YzoyiZbHMo3J3ef3RhQaFaJ8NcE9hZtfVETlNTMV90xAIQ==
X-Received: by 2002:a19:c194:: with SMTP id r142mr1142673lff.7.1586902206507;
        Tue, 14 Apr 2020 15:10:06 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id w27sm13663044lfn.45.2020.04.14.15.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:10:05 -0700 (PDT)
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
Subject: [PATCH v4 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Date:   Wed, 15 Apr 2020 01:07:56 +0300
Message-Id: <20200414220759.29146-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414220759.29146-1-digetx@gmail.com>
References: <20200414220759.29146-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer is a hardware and electronics corporation, specializing in advanced
electronics technology. Acer's products include desktop PCs, laptop PCs,
tablets, servers, displays, storage devices, virtual reality devices,
smartphones and peripherals. Their web site is http://www.acer.com/.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index bf95079a82da..90c178abfa9e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -27,6 +27,8 @@ patternProperties:
     description: Abilis Systems
   "^abracon,.*":
     description: Abracon Corporation
+  "^acer,.*":
+    description: Acer Inc.
   "^acme,.*":
     description: Acme Systems srl
   "^actions,.*":
-- 
2.26.0

