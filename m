Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E76C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C79206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhB4Utg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgIBSMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:12:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C0C061244;
        Wed,  2 Sep 2020 11:12:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s10so146192plp.1;
        Wed, 02 Sep 2020 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3f9lrWEnIT8HUEopKzesuhjDoqNNwJ+zYjj81qDGgk=;
        b=bhB4Utg1ATXtd2Dfd7kZCmepTMUzHRvLckIBrXX5TWBfUJ/erjfgy80A5/gWGYM2U9
         ym4bihNrlVhUadMl6R1Xh6anLk9EciD/mSWAFd7ZcFgLO8rLWdLkS/8MSOUd+chNr4Ep
         8n78vkuGH4YhGmYN7k2SJpkkbzUfqD3UCqnJ6VCUyd3z1cVIJhmKlZ568Fp8e+U4ttKQ
         OFXfgrGiHVvLzhqZTvpdsKtRZh75uS5l0gIQaxcqt8bQQT6QnJBk62mkORcFUQyBQsPT
         Km37lu8JEJ6OfJ42ZjMWTeQT9JyMMilEfzjhhNwPeILP7gwk2IYdb7tyqQoFRIfpgLYf
         s3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3f9lrWEnIT8HUEopKzesuhjDoqNNwJ+zYjj81qDGgk=;
        b=ChGxrApbmtIUQZpBLsEDip+PY4VZwroLnn0jgX6Nor1/cQUKJhX5tYhfiYMD6hosVn
         y4PoCpTgslQI9ESLd2+llTaS7+7wxaKtLTD7GZlvUaa/rN0LD6umXNV/Po8YEybC80x3
         ZHIkzreaPJhgNBIIjYNS3dHb1xyNPd8q1hW7hyHrKIHDE20Lelr1LEjVrL6aZfXIJKPZ
         twQsb1u1ZYnORKpeU2I6UzqYcC36Ov5ATuaS+6skznXth7Ec9+MwSM2jeK26IP3+TaB6
         vwtkZEsmQ+sDoUxplYFh7R1ZBR2jZwj7aD4g8KSQEBXEM5PlfoR8FaLs+dNc4u5y67eZ
         jpcg==
X-Gm-Message-State: AOAM531SSkbNZJ3pcM5EDtYuDnE8dAK9fUZFsQ1ucOxdYhoVOWD3FvQ3
        fAvZr5aFxvm8PGSxg8lJUA2g2Myphxc=
X-Google-Smtp-Source: ABdhPJw0Hl+6859WKV8nvo4KGjdx6+L+6AaUXsSU2feSqDzwvX7zAQRFPC5XKmyfeDam/8LzLXItLA==
X-Received: by 2002:a17:90a:7084:: with SMTP id g4mr3002233pjk.116.1599070362994;
        Wed, 02 Sep 2020 11:12:42 -0700 (PDT)
Received: from localhost.localdomain (cpe-172-112-234-200.socal.res.rr.com. [172.112.234.200])
        by smtp.gmail.com with ESMTPSA id u123sm148993pfb.209.2020.09.02.11.12.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 11:12:42 -0700 (PDT)
From:   lindsey.stanpoor@gmail.com
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, heiko@sntech.de,
        balbi@kernel.org, cnemo@tutanota.com
Subject: [PATCH v4 1/4] dt-bindings: usb: add rk3328 dwc3 docs
Date:   Wed,  2 Sep 2020 11:12:31 -0700
Message-Id: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

Document compatible for dwc3 on the Rockchip rk3328 platform.

Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt          | 1 +
 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index d03edf9d3935..d625cd5966e9 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -25,6 +25,7 @@ Exception for clocks:
     "ti,am437x-dwc3"
     "ti,dwc3"
     "ti,keystone-dwc3"
+    "rockchip,rk3328-dwc3"
     "rockchip,rk3399-dwc3"
     "xlnx,zynqmp-dwc3"
 
diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
index 94520493233b..b41f30a61be6 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
@@ -1,7 +1,8 @@
 Rockchip SuperSpeed DWC3 USB SoC controller
 
 Required properties:
-- compatible:	should contain "rockchip,rk3399-dwc3" for rk3399 SoC
+- compatible:	should contain "rockchip,rk3328-dwc3" for rk3328 SoC
+		or "rockchip,rk3399-dwc3" for rk3399 SoC
 - clocks:	A list of phandle + clock-specifier pairs for the
 		clocks listed in clock-names
 - clock-names:	Should contain the following:
-- 
2.28.0

