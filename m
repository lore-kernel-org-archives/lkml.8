Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E6C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF3120714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqFr2Xde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBZIKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:10:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32927 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgBZIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:10:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so998206plb.0;
        Wed, 26 Feb 2020 00:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEnVySXBYfW3b1su9MemqgqPSinDbCdHAw5n+ZVHXKA=;
        b=ZqFr2XdedoNMMzSdc2eWipJbPoWCSoIWOaxz1zsBu+w5FRw0nlJVp7B9aMcVR/ECrM
         fWpYYrpUhtSvO1rGsvHH3i7x8JxpD2QgM4DK0weubmj2twGyNSOa9Gvtg6KWDj0oARIV
         ossJG+QlPSs1QhoRE2faVAv1lrRd7/LwUBqX6m+LwRkGl9SmUJ5qeccTbXxGKO/jke+J
         hejsi+GJu4wBCG1LLI2Rb9i3hLwtSZ88dY/P2BygJXrOuCX1Xh6+4AO3P044cgvoby3X
         oVgYppEgNor2/7HskWoAIOtOe2teNJqCPhYgfnRcBTVY+U0Ce7WQEZmjOKtWi3whIYeH
         uQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEnVySXBYfW3b1su9MemqgqPSinDbCdHAw5n+ZVHXKA=;
        b=KmHwCHBk99hld3fSlUuy58HxpU0gcIIwApW6mU45Jsurl1nWFKFCltChBOzWrA7hKl
         eMf6zlllvv6Q2T1xCwChQOAwEvrzYjcuXINe808cY1T6i7LSyhqNlcndyLyHr6R4pVTh
         5rScNPFlP2OSBM/UJQCY0OFtLtHf0swWOjA5lpxj0oNXtaJ7KGgWQe9v3jSDX/TrixSh
         Jb+pvOc1z4QZeUJ5f7CyMPEV7Ptf3DswpXTF5bNiiwGiOfEXtRaB9rXgaaM3e5v372Sa
         F8IKnNq81NeGqkepk60Nb55OjPFfmPx5BZfJda08xBGMpx6YCPAT2NZt0/F03ZDnOn6E
         O87A==
X-Gm-Message-State: APjAAAWGDeR58vza/uv2zcdMZ9/eXXnY0On6NNPJrzh6rZc1iEqC1GW7
        6icpq/KDs62zyw6/mphO+YU=
X-Google-Smtp-Source: APXvYqySsTMpSDO1lKEob5Z3qPaMibUnculbDtGi+2b/LHKNJPcUDEb49L+OdYHplPurgC0YCZJGNA==
X-Received: by 2002:a17:90a:32e4:: with SMTP id l91mr3675046pjb.23.1582704645464;
        Wed, 26 Feb 2020 00:10:45 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v7sm1679230pfn.61.2020.02.26.00.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:10:44 -0800 (PST)
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
        Torsten Duwe <duwe@suse.de>, Icenowy Zheng <icenowy@aosc.io>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 3/6] dt-bindings: Add Guangdong Neweast Optoelectronics CO. LTD vendor prefix
Date:   Wed, 26 Feb 2020 00:10:08 -0800
Message-Id: <20200226081011.1347245-4-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226081011.1347245-1-anarsoul@gmail.com>
References: <20200226081011.1347245-1-anarsoul@gmail.com>
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
index 6456a6dfd83d..5dfbad67aa81 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -661,6 +661,8 @@ patternProperties:
     description: Netron DY
   "^netxeon,.*":
     description: Shenzhen Netxeon Technology CO., LTD
+  "^neweast,.*":
+    description: Guangdong Neweast Optoelectronics CO., LTD
   "^nexbox,.*":
     description: Nexbox
   "^nextthing,.*":
-- 
2.25.0

