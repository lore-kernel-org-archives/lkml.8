Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF0AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822182075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="LhbGWaTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbgFVRc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgFVRcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:32:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AA4C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:32:24 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so18835088ejj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esraNk9vYcbt+aYhCal6Rv+dFZCSdTm7//1cm/DqNAg=;
        b=LhbGWaTFVPf141FJ+VrlM1gm9G0Yx9T8OzJsVp75vXKaqYFoXf5GmC8kpq2EpwwBbc
         WqOxWY+Tg9AsLYgOz1eO/LBiR+MVYTEfOkKxkgHAnxxI/56s2ggpsK/r/j/7SL1++AMP
         SDLZKqsstrA3w9vruCcX1oPVY8uC0Q6yXReSYG9DVhLmm+/Uqq6mmd+e1SYBBXOExrgd
         s9Qnj0Q1Hszp8W0gNV884tUzFLS+cHFswvbroJwNUn1qRoJIz/FwglnYHd4rTywkKgLw
         Q7b6HII+eeMzKJpkWXli3tFONXpY94d5smgvEkrme+nK5Rm88QCngPMJej+Qa3qer9do
         8iyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esraNk9vYcbt+aYhCal6Rv+dFZCSdTm7//1cm/DqNAg=;
        b=OGK9+gjcduRK+eXU4gOSpOfuECfqdrQ6KRiaWp9KhuErN2Ph0juBisffNnCHDUszAQ
         IpKU3oLTE1YlCVb5s9JmH8TVwPb/T3pAJSlLA9q1KcY/co03nPT7BV7CKC69QUhYAclX
         f5/+1F9TQsQLMhYRiWNY8q3puEGoHBExA8u7YBp8hprWP3l+0pQf9owq6lj/LfKSam7g
         +06UXXGzPjG96/Wvv2ozSlD1sj92ZhW024vaCiW5oHEfpUFLuCopwSN5ngZCIPNpxCw6
         7Re/VARVAi1V4fG+9OeR5W7aYJ3zwxLdNk1oiT5QVsjl7CigDnzHKKW3P1TkhPvdZPHt
         M2pg==
X-Gm-Message-State: AOAM533PeaoQsIvfix7si7Ne2IQG9718fky8uZmd9WRsQwfS0QhcXLsv
        8YxcPQYle9jFpKolR72/u9tyQg==
X-Google-Smtp-Source: ABdhPJy+SFPlroEIO3VTMMRuyksrmrJdFlyJ5PCayo2U6g0j3Kq28XVgQDvES259MOoHErSiuzhQNA==
X-Received: by 2002:a17:906:e05:: with SMTP id l5mr17849171eji.318.1592847143378;
        Mon, 22 Jun 2020 10:32:23 -0700 (PDT)
Received: from localhost.localdomain (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id z1sm4747386ejb.41.2020.06.22.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 10:32:22 -0700 (PDT)
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        devicetree@vger.kernel.org, bcousson@baylibre.com,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v3 3/3] ARM: dts: am33xx-l4: change #pinctrl-cells from 1 to 2
Date:   Mon, 22 Jun 2020 19:29:51 +0200
Message-Id: <20200622172951.524306-4-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622172951.524306-1-drew@beagleboard.org>
References: <20200622172951.524306-1-drew@beagleboard.org>
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
index 7ff11d6bf0f2..dafd6e8b42a1 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -278,7 +278,7 @@ scm: scm@0 {
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

