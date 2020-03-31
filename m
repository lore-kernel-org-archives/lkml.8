Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140ACC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF38F20848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljredR6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgCaRCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:02:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33991 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaRC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:02:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id d3so14991170oic.1;
        Tue, 31 Mar 2020 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACsAvcUB0Ich6sC5ibu9BU0pfyXIA9WospeN5xQtndA=;
        b=ljredR6mDihL+IgzR7kLoBOMHk5LGRM+2HtXgJsPN40/UJ1a7fSmKTEOmKf2qMZn90
         5bIBUBcGMky3seXChX4d7+2WKbHZaa4sj8l3KwAi2KVCOyLF7Fj0CP3/XwbwfDzu29kI
         CP257blmwAP6qBR53OkiqAQujGoTiMuXNxVeKGqjKeg7fHg4qX9UMWEvtYQfN8dDTHdA
         yDS6nZ708UA4Zcn+fq9ppHlzbrih57mBoikBaXwj4G19/hiGy7UmFMvsyyle7PYnSjML
         cBw+1e4DQimdcBwdh6PTlbzapczsG6pkO0T/zZXJEC0/qhYxzTxNjkhSIcH1sRNktxv0
         8veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACsAvcUB0Ich6sC5ibu9BU0pfyXIA9WospeN5xQtndA=;
        b=pYLeseAkhoCsCcK+yzntB2J2UcvJV5K++nfGF1GBxhqWgt94SvKB7BXdunoZOuCSnz
         CB/FZh3uhw3VOwWg7uEUp8GnWH2m3ObjkMbcjZ3OE58NNTqOBu2D60A6roHCgMKTa+RZ
         FAOWz2iYh+ZbSQNlNDDb20ZSE2WDsVOqgosGNSICTr74lKiFdepnqc9u7Xo0rF2/3/wl
         BVn5rJhd+K25IZAtF/mNixOPyFNI2HnhTVMv2qpvWYEHrInmrLm9INVUD4ZV/u9eOx5l
         sVXNIfRSxWhcSeeTbvGhO8yMwcy628wcaP8Kliv2knbDjXDg1lQ58N3/0m8OZ5zt21Fo
         sBOw==
X-Gm-Message-State: ANhLgQ3rYPd0DRehMW3ErNxFQhf4OWjK8c+Ehs6dL6oQK24zOLmYoiUd
        g+RZG2wY6bJHPUuGjzGKbA9lhEIEl7tguw==
X-Google-Smtp-Source: ADFU+vsJg6w+flXYQzAnQxtbYwFwGMu75oHPkSsA/cGgrGKhX+C0nYsb+hviudv7ZA1hh82vQUaIGg==
X-Received: by 2002:aca:f585:: with SMTP id t127mr2826285oih.38.1585674148326;
        Tue, 31 Mar 2020 10:02:28 -0700 (PDT)
Received: from desertvoice.lan ([2601:3c7:8303:2a10::21c])
        by smtp.gmail.com with ESMTPSA id h7sm2952605otk.3.2020.03.31.10.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:02:27 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: Add new F1C100s compatible strings for USB
Date:   Tue, 31 Mar 2020 12:02:15 -0500
Message-Id: <20200331170219.267732-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331170219.267732-1-thirtythreeforty@gmail.com>
References: <20200331170219.267732-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip contains variants of the already-supported peripherals present
on other Allwinner parts.  Add a new compatible line for them.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml     | 1 +
 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
index 94ac23687b7e..4206a0e373b0 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - allwinner,sun4i-a10-usb-phy
       - allwinner,sun7i-a20-usb-phy
+      - allwinner,suniv-f1c100s-usb-phy
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
index d9207bf9d894..d2eea0003b99 100644
--- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
@@ -17,6 +17,7 @@ properties:
       - const: allwinner,sun6i-a31-musb
       - const: allwinner,sun8i-a33-musb
       - const: allwinner,sun8i-h3-musb
+      - const: allwinner,suniv-f1c100s-musb
       - items:
           - enum:
               - allwinner,sun8i-a83t-musb
-- 
2.26.0

