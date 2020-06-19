Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365C4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130CA20890
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="hbsAZmXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbgFSJHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbgFSJGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:06:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77301C061797
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:06:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so9405206ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EF3uQr3RQED1YKYkNKEVE2Xoq5JyRRd7hiTR6pRsTG4=;
        b=hbsAZmXNE2TaOrADyfhZ4LncxAlKOcWNbKLbDeF2rsahruJQCNzLprdZsGdbsUDjbq
         qrzTvHV7mlFcoGs5wRL1DmgYNtpfTYJn4yUmv3wLcxZn6ifXoTmBYaKDalxxjprE4H75
         OFcrYnlQQb3DyBgekcLt/QElT7wo5S4Fx2JoOrZuAHEe640Rad0m9k1WfJvRz++zkTS7
         c4Xc2hdrnjqNTUCgQk4kqi9gGZAT/y0MHgN+y3t734xefMs29v8NjuC/JpsypOd6R2t4
         Si6ZesNDYvk6F49qAjkeO/QV73MqqosehLo+mhVjGQDVaAiRozB3VWBJFDg8zbopksMe
         ClXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EF3uQr3RQED1YKYkNKEVE2Xoq5JyRRd7hiTR6pRsTG4=;
        b=EoLOODwDCMea+ATanbOihz/UbJJ7Zdl63xBIp/G6tEMRlZJVTWSud+Jvw/s/y/Rd+F
         vqjhDN86Ws4kMNUtPUu326BlQq/ZKb3alivueYm9kojGspsTZbPt+ZaqI42An481xpCK
         d69XJ04IwfBf+gpMaE/QoeQKDhC3TXFI5dy/1/A1dHdu5Cy9YrdIva5uA7dV65aaXymh
         qGFjDjhYaMkBzwBXx/JvGsard215+GOy2HdPvtmz1xLbvBhjgmvMczsVj5GB4JqAGA+s
         g4azK8gQvEJmwAfOKIFqZ7OFRHL8NpfKpvKFD5B4M9DtwaZXAKKy4bqhMQS7bFaElycN
         U2Aw==
X-Gm-Message-State: AOAM531gnGSza3ssXP/+l8hNUBdKsvehALjSzpWMlAg4l0FOoRCzEGtN
        w+LbHHvqzUT0NHcjVHtVtJTC5Q==
X-Google-Smtp-Source: ABdhPJwcHprUUq00PuchIFIQbAmYwvW8uI0PLiIJTeBXZedE5iHqZtnO5Gza2w34X9TiFWfp14Ftgg==
X-Received: by 2002:a17:906:2615:: with SMTP id h21mr2624881ejc.84.1592557612232;
        Fri, 19 Jun 2020 02:06:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:16b8:5c68:7901:5c06:6064:338b:4004])
        by smtp.gmail.com with ESMTPSA id dm1sm4653650ejc.99.2020.06.19.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 02:06:51 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v2 2/3] ARM: dts: am33xx-l4: change #pinctrl-cells from 1 to 2
Date:   Fri, 19 Jun 2020 11:06:07 +0200
Message-Id: <20200619090608.94948-3-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200619090608.94948-1-drew@beagleboard.org>
References: <20200619090608.94948-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This requires AM33XX_PADCONF macro in omap.h to be modified to keep pin
conf and pin mux values separate.

pinctrl-single.c must also be changed to support "pinctrl-single,pins"
with 3 arguments (offset, conf, mux).

Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 340ea331e54d..f9b99cfa93b6 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -290,7 +290,7 @@ scm: scm@0 {
 				am33xx_pinmux: pinmux@800 {
 					compatible = "pinctrl-single";
 					reg = <0x800 0x238>;
-					#pinctrl-cells = <1>;
+					#pinctrl-cells = <2>;
 					pinctrl-single,register-width = <32>;
 					pinctrl-single,function-mask = <0x7f>;
 				};
-- 
2.25.1

