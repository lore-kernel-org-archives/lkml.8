Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548FFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FA222D03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suqfnUGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgGTLYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbgGTLYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:24:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B7FC0619D2;
        Mon, 20 Jul 2020 04:24:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so17494339wrp.2;
        Mon, 20 Jul 2020 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8r3eNl6j3T4v2U6O3JJJF4Ex4h6zCF/renLSyvXQkg=;
        b=suqfnUGQUSsjeyteMRhtMVj2+6Mk+wB+eheOoF6rfreFWqdm5IYKoSpgl4EupGdF1Z
         hIz/1Yf6HqMb/NilAaZ9x17yhYwyqbc29DfuvU+OWU94VxCzpmusOuqvEUdHS0zdDN0i
         z78PmRDutFaIW4+jqQ06iqhe5BTSFCJ3mYjlKpxTGfmj54t16vwNCSsjEAhqsAiwIQnN
         eMfDMTSiZzY8yF+c74dEQdfOkR+Vis5RmAGWm2C5qYgmrRebx+v09hwtX9Qke4hmG2DK
         GNeDshyIgcl+djy2pkTsDKURlbQCouoKc85PagT/mHorXfrsW713hkjbFWqBtbqppTsQ
         qw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8r3eNl6j3T4v2U6O3JJJF4Ex4h6zCF/renLSyvXQkg=;
        b=VO0LnERpEk20md80ilSo0R7oFeKczSooW0u7Qnfc6WpVeCnbRceFF1tftGLexNLYYX
         cH6tALoo4Hext+tFqihW7n2yeC662wovgZgCxxWOne8inD+XeCMUn0vW9KnmrrJsI56d
         1Jyj8FG4hdqhNLYLHCbRxETEx2hR9ZHIXu8Xk/KKHEGgGch44Bgz2pNXrga+al9+sB0w
         p0YpQeY3lBlLDtCgI9xdiwWlua8p71SoUV+hOrpXfoc1o4vnm259HzTKb6yOD38RrNXV
         DBkT7HFs/ojrbS5NeT6omdo6aFt5GAhKTbXW2Fc2+kK34CwGqY25BemKbiuhaP7guD0I
         x9ew==
X-Gm-Message-State: AOAM532DAliAd4Ayioop8H/BCCeU/LPSi1CPxTvlX6OPs8iOR+3wUhTn
        VaIf7ythC83b8m94/IToGWk=
X-Google-Smtp-Source: ABdhPJydhZV0kitByIYMerDbtPQooJn3EVVTOHpGDjm7KA8Si5+lRAlH7aBoEG8Tw42GeDiPrR1Ikw==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr22014902wru.341.1595244286638;
        Mon, 20 Jul 2020 04:24:46 -0700 (PDT)
Received: from localhost.localdomain ([148.63.172.143])
        by smtp.gmail.com with ESMTPSA id t4sm33452942wmf.4.2020.07.20.04.24.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 04:24:46 -0700 (PDT)
From:   miguelborgesdefreitas@gmail.com
To:     a.zummo@towertech.it
Cc:     baruch@tkos.co.il, linux@armlinux.org.uk,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        miguelborgesdefreitas@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: dts: imx6qdl-cubox-i: enable DSM for the RTC
Date:   Mon, 20 Jul 2020 12:24:01 +0100
Message-Id: <20200720112401.4620-4-miguelborgesdefreitas@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>

The cubox-i is one of the examples in which the necessary filtering
circuit in the VDD pin of the pcf8523 (1 kOhm resistor + 3.3 microF
capacitor) is not available. This leads to failures in the RTC when,
after a power cycle, the voltage drop exceeds the recommended value of
0.7V/ms. The hw is designed to support the battery switch-over
functionality only in direct-switching mode. Hence, this enforces the
option in the cubox-i device-tree.

Signed-off-by: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
---
Changes in v2:
- Added extended commit message for git history
- Separate dt bindings documentation into a single patch

 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index e3be453..a226c4e 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -144,6 +144,7 @@
 	rtc@68 {
 		compatible = "nxp,pcf8523";
 		reg = <0x68>;
+		pm-enable-dsm;
 	};
 };
 
-- 
1.8.3.1

