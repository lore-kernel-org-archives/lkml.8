Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64364C54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4241F214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdonWKi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgEJMll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728360AbgEJMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:41:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19441C061A0C;
        Sun, 10 May 2020 05:41:39 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a21so6443768ljb.9;
        Sun, 10 May 2020 05:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OmLblKHrv112GKxqHbeDQgwgFy094x2GnPIPyu9TDGA=;
        b=gdonWKi/jxShiuLpIiWTUwbr629M/CFCwxIQ7nNWuKyfEA8mlJlqTMG8yjMaOZhV43
         eeKxkFNhTVwDx+LePw0IrZhIHu5mOH4Andud4qWQRpFzFTlacP+xLPbtnwCq0wkFKFcO
         WPw1ieg2/56U/swtCAM+5erpW2l2+X2KlI2ItRr1QLmHq7RqJqQaJ08FbUjvq+uvwRMQ
         Jb+ZhZWqU7YjrtyVWNXamniUfNATihiDjXDgom8q8mXcvM0ZKlJ+ELhK8XXVW9hUitRg
         rShCLVIAg4tWQijE0w2QvRMJywUU5EYhhd2RwaA8Tv315xESz+mhd868911ZokUGfE73
         FMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OmLblKHrv112GKxqHbeDQgwgFy094x2GnPIPyu9TDGA=;
        b=VwphwbPdhXa0DVYqMiBWJZxpAxVSh+YkUjuq/96+Huv95npQla4GAQa6pLCpVWGjJr
         xW9Mibc0B/4RqPp58wN/GxotPvp2gz2r+RuQ6Yi7AbNPZbE8oTg62iRzu/19BcPgarIx
         c1cPXp8ilq4LVrQMPrL9B2TNC+F9ANJuJWrWL7enkyJsPhZIHR7v5v4/G8Fr8IhohU0L
         AYZtDZieYpU77UgN6IyWqbrrOhw85Sbl+NMjkEO9bgvgaZvveS7zOtF68gdY+QNsXOgo
         PitfNGTjldp6QTtAGkzxM0FgxU/GJ0xFXVBXUpJW2eUyv6l048TDhyHrJaCmmE5GpJyj
         Xp+w==
X-Gm-Message-State: AOAM530tOnFEz1POV1rV1/ZG2eS+IwXHJnSgzaVRgChljCJW777wAfdT
        1ViKg7jFZTuAiaE/Ny7aTlQ=
X-Google-Smtp-Source: ABdhPJyM3eroHRn/+jtPGXG+Q+2R58RdtBc0ba7D/6DPJwlIhQ6INwvSdqjUNip+ikryoul/4ns20w==
X-Received: by 2002:a2e:8603:: with SMTP id a3mr7343916lji.153.1589114497541;
        Sun, 10 May 2020 05:41:37 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m11sm7136611lfo.55.2020.05.10.05.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 05:41:37 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v8 1/3] dt-bindings: add vendor prefix for Smartlabs LLC
Date:   Sun, 10 May 2020 12:41:27 +0000
Message-Id: <20200510124129.31575-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510124129.31575-1-christianshewitt@gmail.com>
References: <20200510124129.31575-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smartlabs LLC are a professional integrator of Interactive TV solutions
and IPTV/VOD devices [1].

[1] https://www.smartlabs.tv/en/about/

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..a0adda624fc4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -936,6 +936,8 @@ patternProperties:
     description: Sitronix Technology Corporation
   "^skyworks,.*":
     description: Skyworks Solutions, Inc.
+  "^smartlabs,.*":
+    description: SmartLabs LLC
   "^smsc,.*":
     description: Standard Microsystems Corporation
   "^snps,.*":
-- 
2.17.1

