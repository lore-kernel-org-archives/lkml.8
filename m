Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F38720771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBSWTnQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgGWPYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGWPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:24:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F63C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:24:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so5589093wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ECUeWXBnH6Ls28u3v/vFokxJ6Lu+MnV78i4ugGzpyXg=;
        b=mBSWTnQ0+ij26HSOgetG7KoPPONHCmzcu36q3QRa+gK7mf4lCVdG+9bNA+RRC8QEOi
         sMH4eA41PxJramrpIT2VBGltHP2N24Fhte5hLnfK9rQsZI/UC0a27PvdhD0Fj7nuZa7X
         UiIp8DTZxaCv2V98TLIxN4Omo7CR76KxfS3PVcTn73GjFzQTNe4e3UZa1U3IRQ6rtEqP
         VS2Oc+ECzN6Cf9qa/pgrBaExdAx6ba7crtzDpV23jCAVQ7wVRGUprmIdJhDjDJ35w+YT
         t2qPNNdUOEMyCXcqATt+meabstLIEdwexo3CQvE4CGFna3Czg06EkD4n+enVRAxcNUfl
         D/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ECUeWXBnH6Ls28u3v/vFokxJ6Lu+MnV78i4ugGzpyXg=;
        b=bPHWG9uopZDqacS7++ZFSd4/YemCoUdKR/4n2YjpCZm7Q+zuJL/kToJoxqu8iEY+q7
         LlWpQNxH42+JoIxD8EBgVA3Ah/X106rNztqM/kWflnvHXk2CQh9Ek0fEAmHfv/xBjUNa
         DToWL8Jqzr1BRKNyFaVTFCC8OOASdop8wl9cFy7BXAhCQFH+BBQy8kHu1WQ5mjXlZf9u
         DlqexEdsW/Yjde+/AYCGPFDn2CK7Bozo8G7t5fMeVYriNZpZxDMgQQxjpi2BJDd1Dlea
         4idHbGjOfLC6fN4juKLKaqNCVlRcUj339fd5dJHya3kBOJnNW22uDwMnetur6IGWVoRJ
         mdpg==
X-Gm-Message-State: AOAM533+f8APMwPJ5ctdFL4bY0up0AezXmggCPub60Aqijy0i8yaWGcE
        3OHanYRzuE1UrnZbIFdWaOB9MQ==
X-Google-Smtp-Source: ABdhPJwKRVlltMvJgs8RzbIAXNM8uDIewInYaBXqPcxnHJQLCeeCGXcVMfmBay137X8LDBTFMGsPjw==
X-Received: by 2002:adf:df91:: with SMTP id z17mr4954984wrl.149.1595517890903;
        Thu, 23 Jul 2020 08:24:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:dca7:8d30:33fa:daac? ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.googlemail.com with ESMTPSA id g3sm4689193wrb.59.2020.07.23.08.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 08:24:50 -0700 (PDT)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Anson Huang <anson.huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drives for v5.9
Message-ID: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
Date:   Thu, 23 Jul 2020 17:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 809eb4e9bf9d84eb5b703358afd0d564d514f6d2:

  dt-bindings: timer: Add renesas,em-sti bindings (2020-05-23 00:03:37
+0200)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.9

for you to fetch changes up to 5ecafc120bbea614c9d29d0ee2cbb77bbb786059:

  clocksource/drivers/ingenic: Add support for the Ingenic X1000 OST.
(2020-07-23 16:58:09 +0200)

----------------------------------------------------------------
- Add sama5d2 support and rework the 32kHz clock handling (Alexandre
Belloni)

- Add the high resolution support for SMP/SMT on the Ingenic timer (Zhou
Yanjie)

- Add support for i.MX TPM driver with ARM64 (Anson Huang)

- Fix typo by replacing KHz to kHz (Geert Uytterhoeven)

- Add 32kHz support by setting the minimum ticks to 5 on Nomadik MTU
(Linus Walleij)

- Replace HTTP links with HTTPS ones for security reasons (Alexander A.
Klimov)

- Add support for the Ingenic X1000 OST (Zhou Yanjie)

----------------------------------------------------------------
Alexander A. Klimov (1):
      clocksource/drivers: Replace HTTP links with HTTPS ones

Alexandre Belloni (8):
      dt-bindings: atmel-tcb: convert bindings to json-schema
      dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible
      ARM: dts: at91: sama5d2: add TCB GCLK
      clocksource/drivers/timer-atmel-tcb: Rework 32khz clock selection
      clocksource/drivers/timer-atmel-tcb: Fill tcb_config
      clocksource/drivers/timer-atmel-tcb: Stop using the 32kHz for
clockevents
      clocksource/drivers/timer-atmel-tcb: Allow selecting first divider
      clocksource/drivers/timer-atmel-tcb: Add sama5d2 support

Anson Huang (1):
      clocksource/drivers/imx: Add support for i.MX TPM driver with ARM64

Geert Uytterhoeven (1):
      clocksource/drivers/sh_cmt: Use "kHz" for kilohertz

Kamel Bouhara (1):
      ARM: at91: add atmel tcb capabilities

Linus Walleij (1):
      clocksource/drivers/nomadik-mtu: Handle 32kHz clock

周琰杰 (Zhou Yanjie) (3):
      clocksource/drivers/ingenic: Add high resolution timer support for
SMP/SMT.
      dt-bindings: timer: Add Ingenic X1000 OST bindings.
      clocksource/drivers/ingenic: Add support for the Ingenic X1000 OST.

 .../devicetree/bindings/mfd/atmel-tcb.txt          |  56 ---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml        | 155 ++++++
 .../devicetree/bindings/timer/ingenic,sysost.yaml  |  63 +++
 .../bindings/timer/ti,keystone-timer.txt           |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  12 +-
 drivers/clocksource/Kconfig                        |  15 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/ingenic-sysost.c               | 539
+++++++++++++++++++++
 drivers/clocksource/ingenic-timer.c                | 182 ++++---
 drivers/clocksource/nomadik-mtu.c                  |  11 +-
 drivers/clocksource/sh_cmt.c                       |   2 +-
 drivers/clocksource/timer-atmel-tcb.c              | 103 ++--
 drivers/clocksource/timer-ti-32k.c                 |   2 +-
 drivers/clocksource/timer-ti-dm.c                  |   2 +-
 include/dt-bindings/clock/ingenic,sysost.h         |  12 +
 include/soc/at91/atmel_tcb.h                       |   5 +
 16 files changed, 990 insertions(+), 172 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644
Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
 create mode 100644
Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
 create mode 100644 drivers/clocksource/ingenic-sysost.c
 create mode 100644 include/dt-bindings/clock/ingenic,sysost.h

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
