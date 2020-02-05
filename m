Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744ABC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3672072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wI13iTub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgBELWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:22:39 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46553 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbgBELWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:22:39 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so1515363ilm.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 03:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pgwocbE6mhkA+OKhecgcAoXn10XYW3UASVoDr7OU9dI=;
        b=wI13iTubTuBMBiK5CXbDSnV98whJDiMVXtwTTvmUaPOouESwx7uSl+JRcgxKUj+5eT
         kJMfS4c0Wfmp0CUmxUH/AAmuoXPMshDoAXSsbdkRrl41dw5zes7AuPiBnqIb0t/heFqj
         vDL96yT5Z4hxVyycq/s0PPzY9Bpv1i0SR066Sd+d5Qk3fr8dxdqoiX3sg5oX36Ww6RiV
         JlYudq4/zIx+rlzxMBX20EwN224Ii5I9NfpFGhTTI+RSLmTnqzEfrOh9eyvUfI+QSbQD
         MppFNlKOlfnjy+btwdiXoyT+3vHlqJdVUHfXWn+ZXcT1KOv7iM+crNqzTlM/PYC5e39C
         aDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pgwocbE6mhkA+OKhecgcAoXn10XYW3UASVoDr7OU9dI=;
        b=h7LzRRH6ClFOyYxLBd4LvKlFFmTfUjpJzHbbnUhMz4nAOoCrAA2ydRpFuHkuxJ4GBR
         z2kx5bSPleUXlJuEN+OBnoWRAs0UdpsOMqJhfdNKwcYrGC9jfbERBdDjWALSDdciVj/8
         iejuyQQ+wKiKtoQjT19YM9DaBrn4No39z+TkgiM+52MGaXp0Domx5txMngm1DwBqSilY
         1IBNzpptDtF2oCCf1eZpsYWkzPqNzOWgOpPh7KateiMvOl0JSX7HZsbfO1liuJ25j5NF
         oIvrnoaSteAf21ysM7w4N0ZnFGxz5YHIemydfAt+Ajx9N3OBIgunZ9eNxZJOSPdhuatp
         diVQ==
X-Gm-Message-State: APjAAAV6kZfh00u1Xa61StM+ocxd548WpeG2GhUwuNI70vnVlieDv0tC
        3bmToD5L0BpbaB1r7buyaSKAX0FUqu2R1Kif7IrDxg==
X-Google-Smtp-Source: APXvYqy/kucw9v8LMt0yJ4yjVyQ+82M1lz79DGqFguBC4nALluWsrP7cO1udl64OTrIrvtxDczxczFGsY1Y1pVHmmiE=
X-Received: by 2002:a92:990b:: with SMTP id p11mr11299858ili.254.1580901758511;
 Wed, 05 Feb 2020 03:22:38 -0800 (PST)
MIME-Version: 1.0
From:   Nicolas Belin <nbelin@baylibre.com>
Date:   Wed, 5 Feb 2020 12:22:27 +0100
Message-ID: <CAJZgTGF2ihuu_bSzQ93iBTf1YQ4_NM29S4iBFM8Fhd_RUaw2vQ@mail.gmail.com>
Subject: [PATCH] pinctrl: meson-gxl: fix GPIOX sdio pins
To:     linus.walleij@linaro.org
Cc:     Kevin Hilman <khilman@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the gxl driver, the sdio cmd and clk pins are inverted. It has not caused
any issue so far because devices using these pins always take both pins
so the resulting configuration is OK.

Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 72c5373c8dc1..e8d1f3050487 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -147,8 +147,8 @@ static const unsigned int sdio_d0_pins[]    = { GPIOX_0 };
 static const unsigned int sdio_d1_pins[]       = { GPIOX_1 };
 static const unsigned int sdio_d2_pins[]       = { GPIOX_2 };
 static const unsigned int sdio_d3_pins[]       = { GPIOX_3 };
-static const unsigned int sdio_cmd_pins[]      = { GPIOX_4 };
-static const unsigned int sdio_clk_pins[]      = { GPIOX_5 };
+static const unsigned int sdio_clk_pins[]      = { GPIOX_4 };
+static const unsigned int sdio_cmd_pins[]      = { GPIOX_5 };
 static const unsigned int sdio_irq_pins[]      = { GPIOX_7 };

 static const unsigned int nand_ce0_pins[]      = { BOOT_8 };
--
