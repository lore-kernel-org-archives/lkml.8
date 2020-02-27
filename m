Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6684C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B74246B0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H74j+Lew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgB0SO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:14:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46045 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgB0SO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:14:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so25047otp.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGljD+kg3lGUw+qrriqk7js900WesZXIV0yY3y9iUng=;
        b=H74j+LewwCUFS7Zm04eQx7CQ625ZpH6rmqBMr8vlOGbO6n+Kbi3jvk1CtInh6YiGZn
         gZGMN6/6PkiUGjONQLLbn+bdhIlgbAa4h6Ar86MySHjFiwWi1IHiO2n/TNkQzWxaK3fo
         gCNDJ1l/dJp+Ib3sj70EtZs6Qwq3hGyddYxMuJqaDYwIY1HIhgHWq4G1acPO6TdH4+u3
         1G5F6dpdW9SXOgJp01Yfnx+CYZaiR3DHflJ+3xu7DGJy4E88w5VzbHdlWSpD3a5ZROYn
         xG0Q7caXMCMZCtFW9L4gheqOzzq2rATMONxhxbk6sAO+i0JZHT6s+gwWcJnSb9/l3tLj
         nuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGljD+kg3lGUw+qrriqk7js900WesZXIV0yY3y9iUng=;
        b=uIM7YCESMKVJ3F0TC0oL/NSgA938NZnjmohFILUgscgjK4fWUm9tBNo7ScM8IbQpji
         WwjQ7uAKLo7V/nihx5RVsKp6DCXvCpunxUwy5wzUyUFNzNQXZmEXj3ILRevCB0kelLel
         BOWzCz+ZiTIRcS0x8uqyIOpY1LDtE9kivjgz+zcTvUfbuFy5FHT8BBskYkPCovX4GLI9
         s0gxHp041JVNyeAWGuePbck47PHxTCodE2rMXi7+rq7rNECDtDU6dFIzcXTx7B/aEACf
         8067s6DfiUev3YQwgHuh6KEAeQLjWMR1dHeNpa0ZjjUHApIK3Dk7+h3Jt5oylOb78kgJ
         /WNw==
X-Gm-Message-State: APjAAAWr5HLz53e6HTLqio1f4fdoucEioM7jRKEulVBk1GzdDpSPjD8L
        wYnVm45MNTo1LvdJWKdttXI=
X-Google-Smtp-Source: APXvYqwqvB2lpmkY6lLE1EwDpWECH7nx3+KkcGcBdXe2lef2n38Ptsyf4cgjxk3ZuS5a1oSShJeZ8w==
X-Received: by 2002:a05:6830:10da:: with SMTP id z26mr137796oto.27.1582827295998;
        Thu, 27 Feb 2020 10:14:55 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id t203sm2205534oig.39.2020.02.27.10.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:14:55 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: Add new F1C100s compatible strings for USB
Date:   Thu, 27 Feb 2020 12:14:48 -0600
Message-Id: <20200227181452.31558-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227181452.31558-1-thirtythreeforty@gmail.com>
References: <20200227181452.31558-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This chip contains variants of the already-supported peripherals present
on other Allwinner parts.  Add a new compatible line for them.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 .../devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml     | 1 +
 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
index 020ef9e4c411..1762a302c594 100644
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
2.25.0

