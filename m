Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21B4C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D292146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gT7A+bxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgCKMvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:51:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51801 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgCKMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:51:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so1962026wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7TEk00KRvrt3fqESY+Dr/uhZ8TDjILzLnA4sir1MLYk=;
        b=gT7A+bxiCh0yWVbJWXiDUKwtCeWGDafJ5mchK3a6+Goc5k1FbamDZ57ozfvwr/M8j4
         A4r864OherYK7wWqw0tR3tQaGRMkiShA1mgt2EFYAYz7iiDL4KGhgXuevS4Ea7lOky/K
         h3RVntwIqgeaxJYgcsgaORFKlV1/6W3tY43Ly0zRg978gFxqTvMrx0/gZQ/h+wyKbx2J
         heaSSXGQ3w6YJGElmryIF8beBobOItlQNGx2z10Vrae7Iov/sCgPWFu/3hFmEAoWY8sO
         yL3Lzz18MUdIk2/oCd/MVCn3/7mBvNWlrbgR/pQFyLBwOoi+Zvpbkk4PNuQx/12+ORf4
         0KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7TEk00KRvrt3fqESY+Dr/uhZ8TDjILzLnA4sir1MLYk=;
        b=kA/rBjPre985ocv6TVzdCBJoPJj2wKTAdPrwx0BfpKNgRrvR5nmho9t99HH5ga2pIh
         LWh9u2Oz/3f2EV/8z0PWJLDx3leoP2vDGWWeImD8wRL+vWzyHXB1ceeeYJcnfbhl5jEP
         eIWpVS5acPY1HMP6GsbhZRQ6e6x6N0fG685Y3T2p+LYkz2OvdqTKH4o2uVX3fIfUWrF8
         GoZOZ9nXWn/VJQuGxMk+xANh04dePAMwHytxcDlzWd1B65recknyhSnDekT+NLHFg5Pj
         XRuFjCLJMTChA8kKBvsYrRtwoa+l/GO98KhktFeyHpQK3b1JVvah9HpjbLLw5k5ImpL7
         WwtQ==
X-Gm-Message-State: ANhLgQ2OzjEgmeeKTnXpjM9DiW15X7+SWKjlUYYRSlXAQCwKDHxyPbqD
        Bg8REYDGEd34+G2qG9JdZZG8KQ==
X-Google-Smtp-Source: ADFU+vulHpARqePVWhIZW1U/urxTnIw/zeRXfvdwAMhWGWKcYtaPGBAL3+zQX9ckUN8yquvV06X5Bg==
X-Received: by 2002:a1c:59c6:: with SMTP id n189mr3614794wmb.178.1583931103706;
        Wed, 11 Mar 2020 05:51:43 -0700 (PDT)
Received: from robin.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o3sm8843538wme.36.2020.03.11.05.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:51:43 -0700 (PDT)
From:   Phong LE <ple@baylibre.com>
To:     narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, a.hajda@samsung.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, sam@ravnborg.org, mripard@kernel.org,
        heiko.stuebner@theobroma-systems.com, linus.walleij@linaro.org,
        stephan@gerhold.net, icenowy@aosc.io, broonie@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: add ITE vendor
Date:   Wed, 11 Mar 2020 13:51:32 +0100
Message-Id: <20200311125135.30832-2-ple@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311125135.30832-1-ple@baylibre.com>
References: <20200311125135.30832-1-ple@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ITE Tech Inc. prefix "ite" in vendor-prefixes. More information on:
http://www.ite.com.tw/

Signed-off-by: Phong LE <ple@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a2da166df1bc..c2fb444e1900 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -475,6 +475,8 @@ patternProperties:
     description: Intersil
   "^issi,.*":
     description: Integrated Silicon Solutions Inc.
+  "^ite,.*":
+    description: ITE Tech Inc.
   "^itead,.*":
     description: ITEAD Intelligent Systems Co.Ltd
   "^iwave,.*":
-- 
2.17.1

