Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2FDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A24921655
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPrKSehf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgFQQsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgFQQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82BC06174E;
        Wed, 17 Jun 2020 09:48:15 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id f7so3129084ejq.6;
        Wed, 17 Jun 2020 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q34Y2snjopHwNQ74AGxcHnVzaHh2qjmnA2d9PONlV04=;
        b=OPrKSehf0MFx28o+aNEqj4LJJTauxVCv00Q/h3M3OPKl/6AOTvwNWkretELWVKyFTy
         xJlegLy30bt9LQPQHdcfDB3obegYVkw1ta/RQeaceoqjnHYMfw8wSdEafxRdNVGjEMy1
         /Y+8tNNz6TJs02LaKQT62bi8uhBMpC8L5UOJqWPDbnlFDknWvgjO0Ce5nUjtyh/UqYZc
         +kuRvm3Ib1nuy/okhNdCHJbF2ewQoMPQIhybsI1ZdEge1ytuMjzMtI0/sNzZXDy7K7oC
         LjK9VxPxqfzeuJ4x8Iblm9K35UEgiZssSE74C6j8bIoyt7PbufjdxrdZWPwcOI2nt1Io
         nSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q34Y2snjopHwNQ74AGxcHnVzaHh2qjmnA2d9PONlV04=;
        b=GvtZNbuO1QvW4z91XA9yhG461ildZPwlxB9nvliPV5gFGN4S36giB4PGXv6587aGyS
         0rQoTvo2FLMRdox8or38n9rb8Eby3yTeyMI/Hn3qHxfp+gK9ZyfnSuS7pJHFpf9+aTCg
         ygOZXHU/rWnZsXB0llcv6DaF498LkUe8F8NNGJWvxC9hvIKbaD/qkoOD3flShMEqU4TJ
         RVt6Fej7F/N/fbFP2I2EZTppOM+92Qg1ruQYMJkwgWwwt/q+v2XJsVIlL+L27zTdl8+D
         OqeL4Nlfm5QOrGwuHuFTSYvgxh17RQ1G4vi5itT5LH/Qj6haqvmGHKij/NMDJI2J5wj8
         rZaA==
X-Gm-Message-State: AOAM532ANOtfUhAUnXWXCgDoNsGm98KQjIMHMgo12nwcJLCBBgJOcDaM
        gDV6jCGxVLDXkhOH1/KlGH0xHnjvbKI=
X-Google-Smtp-Source: ABdhPJyZatZxHVj5zHwF4eo7MjFxocOQ44vCToszH8NPTWTtgA4gZ/ivNelY2eQU9Tb/wgMQ+O5gWQ==
X-Received: by 2002:a17:906:f189:: with SMTP id gs9mr38790ejb.203.1592412494696;
        Wed, 17 Jun 2020 09:48:14 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:14 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-actions@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 00/11] Add CMU/RMU/DMA support for Actions Semi S500 SoCs
Date:   Wed, 17 Jun 2020 19:48:00 +0300
Message-Id: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves the existing implementation of the Clock
Management Unit for the Actions Semi S500 SoC, by adding support for
some missing clocks, like DMAC and GPIO.

Additionally, it enables the UART nodes in the common owl-s500 DTS to
use the clock provided by the CMU. That means the S500 based SBCs can
now get rid of their (fake) UART fixed clock and, as a matter of fact,
this has been already done here for RoseapplePi, the new board which
is going to be supported (hopefully) via the following patchset:
https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/

Eventually, the patchset adds support for the Actions Semi S500 SoC's
DMA controller and Reset Management Unit. Please note the already
existing Actions Semi Owl SoCs DMA driver seems to be fully compatible
with S500, even though this is not explicitly mentioned in the source
code. For the moment, I have just enabled the DMA controller node in
owl-s500 DTS using the "actions,s900-dma" compatible string.

In the upcoming patch series I will provide a pinctrl driver and enable
access to MMC and I2C.

Thanks,
Cristi

Cristian Ciocaltea (11):
  clk: actions: Fix h_clk for Actions S500 SoC
  arm: dts: owl-s500: Add Clock Management Unit
  arm: dts: owl-s500: Set UART clock refs from CMU
  arm: dts: owl-s500-roseapplepi: Use UART clock from CMU
  dt-bindings: clock: Add APB, DMAC, GPIO bindings for Actions S500 SoC
  clk: actions: Add APB, DMAC, GPIO clock support for Actions S500 SoC
  arm: dts: owl-s500: Add DMA controller
  dt-bindings: reset: Add binding constants for Actions S500 RMU
  clk: actions: Add Actions S500 SoC Reset Management Unit support
  arm: dts: owl-s500: Add Reset Controller support
  MAINTAINERS: Add reset binding entry for Actions Semi Owl SoCs

 MAINTAINERS                                   |  1 +
 arch/arm/boot/dts/owl-s500-roseapplepi.dts    |  7 --
 arch/arm/boot/dts/owl-s500.dtsi               | 37 ++++++++
 drivers/clk/actions/owl-s500.c                | 91 ++++++++++++++++++-
 include/dt-bindings/clock/actions,s500-cmu.h  | 77 ++++++++--------
 .../dt-bindings/reset/actions,s500-reset.h    | 67 ++++++++++++++
 6 files changed, 235 insertions(+), 45 deletions(-)
 create mode 100644 include/dt-bindings/reset/actions,s500-reset.h

-- 
2.27.0

