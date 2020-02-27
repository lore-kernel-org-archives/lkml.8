Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561DCC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E59A246B7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUEbqJKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgB0SOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:14:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44508 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgB0SOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:14:55 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so103719oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oxqi8ZJKGSPP9IrJM7wDcDY9/uxnfGKdrKcOXfNKqVo=;
        b=BUEbqJKHWNdILrVLHXtZ5xT5VWr7rOcmUEHhKYHyQO1vULqebtFGaJT1fntcqzkh1O
         y9EHLY7mr0JdqOOnivAzlu5Olp4XOgClh3YjsN80VQvh2FyQW3nq6l02ayAJiAnHIL4r
         0Tozt4PovH8Zod95jxhIWhjNHp+wnZ8+MbgtYZ6EWkgO4DveNSUKCYmFbKwU71vT4I3e
         m3kgAxaMEwRnLqhBhSY9SkQ6cCwNuFqv/aAwxatRYWOsHKTGiobq4VXzE2wshfqUQ9cY
         1vnadoWx4n+6gwm2Fpb7qC/KqFsc8/fJAtQo6bgKLNeGZVcN572AO2SLmz0ilyqEZMxs
         bl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oxqi8ZJKGSPP9IrJM7wDcDY9/uxnfGKdrKcOXfNKqVo=;
        b=hylktB3pUmobr9xkXw0shVAgXIT34n5BxBjG5+7V5n6hw3XYz/P0qoL5VGneeiQXfw
         PrFeNRxX936WOM2UMx6hvU/sUTASA3ZyqCjwFNVHEbzZPKKO+LJThnaMqMasB4IyHgE2
         CtcaNf87fdTpcl/CS7bJgKIDFlAd2LVTanRG7m/GJYKS1SBECHcxUUQEO/IswbPXH4Y9
         CAhpqotFCVIA4UMROvsdlEvmryyg+zSMhiGViowEeszED87igrmhu8Lcc19Z6eg/T1Ys
         8GKC5A7tt2z2frn+aepfEKDonQc6XrFoJ/KsD/DOA8P4Jr8fEeb8iKOqX4i+li5yfaUD
         l/AA==
X-Gm-Message-State: APjAAAVpGD5LcQ2SQqKmPfay27TFNGrhXYCz8r53gTM5lHaewsiQrt/7
        Aki/f/3Z0Pzr7VQsmdccDYw=
X-Google-Smtp-Source: APXvYqwLh43Ljb2tbvcdPfcvTFALf59Q/EVN4nwLeA3Jda+ecRo6T5acO4Yz4AX9Wtdduy1gdugViA==
X-Received: by 2002:aca:d03:: with SMTP id 3mr226545oin.69.1582827294709;
        Thu, 27 Feb 2020 10:14:54 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id t203sm2205534oig.39.2020.02.27.10.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:14:54 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Support the Allwinner F1C100s USB stack
Date:   Thu, 27 Feb 2020 12:14:47 -0600
Message-Id: <20200227181452.31558-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner F1C100s has an MUSB-based USB peripheral.  This patch
series implements support for it alongside existing Allwinner support
code.

This series was originally written by Icenowy Zheng for Linux v4.14.
I've rebased and bugfixed that work against mainline and tested it on
both the Lichee Nano and my custom hardware.

George Hilliard (3):
  dt-bindings: Add new F1C100s compatible strings for USB
  phy: sun4i-usb: add support for the USB PHY on suniv SoC
  musb: sunxi: add support for the suniv MUSB controller

Icenowy Zheng (2):
  ARM: suniv: add USB-related device nodes
  ARM: suniv: f1c100s: enable USB on Lichee Pi Nano

 .../phy/allwinner,sun4i-a10-usb-phy.yaml      |  1 +
 .../usb/allwinner,sun4i-a10-musb.yaml         |  1 +
 .../boot/dts/suniv-f1c100s-licheepi-nano.dts  | 16 ++++++++++
 arch/arm/boot/dts/suniv-f1c100s.dtsi          | 29 +++++++++++++++++++
 drivers/phy/allwinner/phy-sun4i-usb.c         | 11 +++++++
 drivers/usb/musb/sunxi.c                      |  8 +++--
 6 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.25.0

