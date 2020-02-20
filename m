Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39329C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EAA24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs6bb2Cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgBTIgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:36:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40803 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBTIf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:35:57 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so574826pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6yNbKzpeTLMCoypRqoVy0w4NUhztDzPf4ESyfJztWiY=;
        b=Xs6bb2CzAuqxLioQuMk3z0BoJURSkm/VFyMgk9MekRXbneDMAJLoLqZESX5gWejMsr
         Cu7uvtcGmvwcOVjgLW4vs2M/GRrVL+l7AfAYWZ/0Xpni1Z+vJn5DH72vdIhcfRiv98CM
         a0CUL5GVb9Mi1Ef9jPNFdQY7D5wyTTq0Ac42FR4kmum21oWkHRf4YVMGzG7T6ul1IEqW
         ZvKcVueUE7XXr7/C5jY6QTZZEBHSEw7TUfxdKoNmytHRRWBfGSmb/wUrF9hMiFY5fzBH
         Gcr++v6mKxXTsQ4RW6kPbt0XoggG3huxZOk6c/KuE/jt3PawEPB26YBYomLeWiw0zIdw
         ghAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6yNbKzpeTLMCoypRqoVy0w4NUhztDzPf4ESyfJztWiY=;
        b=F8ITZk3f8QGzEVC0QYRrcQ6xs5gdUnNw8hzpcGfndapMPKW4GEnIy7j7MoC2NEJ90T
         VTG7IZIYkNQu12qd5KIfQKmcddzT0DzsXdUstSD8w6Qngu7hb6oC5dsSMu+9TdMxLUNf
         6Ak4Jw0zhSlWPQIRgmgjSm4curM1oHd1gu4NvmzYYF/4G12PukqKlyWgiG8hs0qXB0mW
         qXc1Dh3nQWeIx0lW2qusdgsD9GkOBdP6QsexFqU4FeNJiZI4lqmpsBDpg5jTaxmD31+C
         Tl1EAdBAz7Q8fhPrXRWVCLF6WAT3U5A5LbBBpBgEg0c/YxlM3v7iSb+ijARKK5X14qnh
         jEow==
X-Gm-Message-State: APjAAAUlsUen/b+T64Kut9roDqKLC7Q4HJZYkwGgoj/r49uD7hTmOb1N
        98op8awic9w3CGtTBcevshs=
X-Google-Smtp-Source: APXvYqwKXY5bZ3GJFQYNZpSue+9Mt0J+NmUuqTaB2YessGYgmYwqmvpscnAZijk3U3VpNUJFWCzGNw==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr2349862pjr.74.1582187756393;
        Thu, 20 Feb 2020 00:35:56 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id l13sm2319038pjq.23.2020.02.20.00.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 00:35:55 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 3/6] dt-bindings: Add Guangdong Neweast Optoelectronics CO. LTD vendor prefix
Date:   Thu, 20 Feb 2020 00:35:05 -0800
Message-Id: <20200220083508.792071-4-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220083508.792071-1-anarsoul@gmail.com>
References: <20200220083508.792071-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Guangdong Neweast Optoelectronics CO. LTD

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6456a6dfd83d..a390a793422b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -665,6 +665,8 @@ patternProperties:
     description: Nexbox
   "^nextthing,.*":
     description: Next Thing Co.
+  "^neweast,.*":
+    description: Guangdong Neweast Optoelectronics CO., LT
   "^newhaven,.*":
     description: Newhaven Display International
   "^ni,.*":
-- 
2.25.0

