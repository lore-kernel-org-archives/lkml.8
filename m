Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F245EC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CBE20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="fUZBkk0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgDCTS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:18:57 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43780 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgDCTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:18:57 -0400
Received: by mail-wr1-f41.google.com with SMTP id w15so3580789wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=N0ZrXQIKqbDhYM8K0a95EEPnDOREAzkDY3xwjR3QE9g=;
        b=fUZBkk0PhNTb+ey56oINy9UW+39P1UcXUkAHpMEExuHv0oozUZ0Nu9FCVz46WwbsHY
         f8k9KaVfKH9JIWaMMYz6eCskEHxh56tJRQw4ZGTzb/eBQf04BlaMitXapYqwSmf/TQIO
         gSxv0fqg4+Ms1yEEIQavDNirll1KAujBFn2Q7/+6MrZYAml0f2ZO39eHK4opPOUk/WrL
         x60gXgzRbKwLaW7PgqHy+tfGHmecpG59DFC7LhzjdwYqpSqvM4YXam1K24GVVw1Ege5f
         5M1ypTcd3MwXyahJarMx9cTzNCg//SFZLW41HXZWutY4xpED45Wpf4t19LAfTYHlHHyf
         gXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N0ZrXQIKqbDhYM8K0a95EEPnDOREAzkDY3xwjR3QE9g=;
        b=NxR8NmblI6we8Do4yK4gPeu6a09e+2ryEuWWf7Kl3Y80h6WeXmuRjmrz1WQ2ZW8btk
         zPViSkXXMHGcmf3h/jtAKTzM2jHKiMYtWU8iEZthbj7WsaTbzickEta5eagR/eFvUyN9
         o7c3A4B9hXZ3YZfKcaV0zrvomwxJoqjniNO0Ib3VzBsnW/TSzj6qcL1NeqSLpHZOq3tO
         5heLSffNF/Z39B/2h/AYTgBJCKhlUbvMAMLlQ1yeaFB7R3wg9HSIx9jNgJG/Ubfbs4TX
         fy23pfS6/IpGdru0oKXNPEv8pemTkLWH6Z6/s/mw8fs/6FPQGvh76t6TAvLXuiScZ3vY
         ITjA==
X-Gm-Message-State: AGi0PuYuHT14RzAQH0uLUfqSchZHVBVZ5e9oP7zuVP+P3qyNUPdg+dfA
        kioKAKlvnr8EcvhQHFIaDt//MA==
X-Google-Smtp-Source: APiQypLAxu26bg9htF93iWKRV7HD6fnYqKlOaLwxLqdv49TjyzgBXtUE1jbFaf66McWWDRTLBWjVXA==
X-Received: by 2002:adf:ee8b:: with SMTP id b11mr10390353wro.404.1585941533898;
        Fri, 03 Apr 2020 12:18:53 -0700 (PDT)
Received: from x1 ([2001:16b8:5cf5:3201:5571:c686:dfa8:6662])
        by smtp.gmail.com with ESMTPSA id 25sm7539904wmf.13.2020.04.03.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 12:18:53 -0700 (PDT)
Date:   Fri, 3 Apr 2020 21:19:31 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     devicetree@vger.kernel.org
Cc:     Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org,
        Caleb Robey <c-robey@ti.com>, Jason Kridner <jdk@ti.com>
Subject: [PATCH v4] dt-bindings: Add vendor prefix for BeagleBoard.org
Message-ID: <20200403191931.GA31296@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for BeagleBoard.org Foundation

Signed-off-by: Jason Kridner <jdk@ti.com>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
Changes in v4:
  - rebase on robh/for-next branch

Changes in v3:
  - add SoB from drew@beagleboard.org
  - email patch from drew@beagleboard.org

Changes in v2:
  - Use 'beagle' rather than 'beagleboard.org' to be shorter and avoid
    needing to quote within a yaml regular expression.
  - Assign 'from' to author e-mail address.
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 65e78b25715f..e26785f5cc38 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -143,6 +143,8 @@ patternProperties:
     description: BIPAI KEJI LIMITED
   "^beacon,.*":
     description: Compass Electronics Group, LLC
+  "^beagle,.*":
+    description: BeagleBoard.org Foundation
   "^bhf,.*":
     description: Beckhoff Automation GmbH & Co. KG
   "^bitmain,.*":
-- 
2.20.1

