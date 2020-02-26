Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B319CC4BA11
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F4420714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBrP0h2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgBZIKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:10:51 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:43893 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgBZIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:10:47 -0500
Received: by mail-pg1-f171.google.com with SMTP id u12so914294pgb.10;
        Wed, 26 Feb 2020 00:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UNDrMK3Cuph8hAawynxP4ClnMYdwocSlmGrvdp+XI7U=;
        b=TBrP0h2wisco9iwCPRUPdbzfKPQaem8N0CCbkufM0ubNMvNGPVi7J4OrKi6XaCKbH6
         hh3Y+bgMR/KAzZy3SJxpHSn/W55kTsTGse062SF7bXdc1s6lOwPqxkWqbnhYBTrOOQRL
         P5UEoGPV5IsF76w8fyduRaTE03AV7RIeG3tdyzE6dWtIWMgpvpx224lpnK6HQOTLFKGx
         8NN0VzAznR0u0zIR0NAXJZCtJ32GmXNwAp/DudApysZdxoB5XwxmgmLNpboYi0ogxMJL
         H4NuemzoK00dffBEXYJVCaGEH3TCcpoSWqSDpn+UxmqlsA7Meikom5RyLGooaap33bAj
         PsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UNDrMK3Cuph8hAawynxP4ClnMYdwocSlmGrvdp+XI7U=;
        b=dIp/KxCVRW33bX72PodaeDJoLE8FwV6+sNyz/dKhN83q+fOGmKQ9rh0x7zScDM7/aD
         nJ50i0F0qrpDMcZYoxlBQ4TPxMOQM1pfu5lGhyj6xoh+vXVWmzYV2Zy5jSFdHacRQPdr
         XET30f4r3ylJ5rAU2KnY9D3CdEIGZ/0GAeJeWoOCcALwVzqlt9Z+WWNCXz/kU1tqA1GA
         71dEHJPUt0X+TWAPeTPMiOXIP0jr9XlrCLRnjyUuyWgDlE7G+YPHGNz7bxLSNaWBYC0Q
         vm6W11PDCbXgARCK+0smwOeOn3odKfEfcGnCFTOun1a1MR7ht7bKg+2BP0VPdo/DqaQK
         CWHw==
X-Gm-Message-State: APjAAAXki+dAGpDWHfHHcPfUw+YzdKSb155ZgO7xezBaIkhruUqVrCxT
        O1VdOVZeFMnEaqtFOYoN8nU=
X-Google-Smtp-Source: APXvYqx16ATSH0Ri7QydUSr5etiFpP7VXGwv2ajzCwfEDuf3Fsc6V5gruuHjTDm3C4cjgRnxu80rnQ==
X-Received: by 2002:a63:42c2:: with SMTP id p185mr2844380pga.268.1582704646751;
        Wed, 26 Feb 2020 00:10:46 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v7sm1679230pfn.61.2020.02.26.00.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:10:46 -0800 (PST)
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
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 4/6] dt-bindings: display: simple: Add NewEast Optoelectronics WJFH116008A compatible
Date:   Wed, 26 Feb 2020 00:10:09 -0800
Message-Id: <20200226081011.1347245-5-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226081011.1347245-1-anarsoul@gmail.com>
References: <20200226081011.1347245-1-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds compatible for NewEast Optoelectronics WJFH116008A panel
to panel-simple binding

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 8fe60ee2531c..0e5d01ac32e1 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -39,6 +39,8 @@ properties:
       - boe,nv140fhmn49
         # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
       - giantplus,gpm940b0
+        # NewEast Optoelectronics CO., LTD WJFH116008A eDP TFT LCD panel
+      - neweast,wjfh116008a
         # Satoz SAT050AT40H12R2 5.0" WVGA TFT LCD panel
       - satoz,sat050at40h12r2
         # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
-- 
2.25.0

