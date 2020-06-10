Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7EAC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C2020734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="d0gmA+SX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgFJJHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFJJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:07:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F15C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:07:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so844719pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tV8bIAKkwRNCkckVOYeoYlebWo0ebt4dV9pe/7DB+wY=;
        b=d0gmA+SXA5MhEmNQkobfbSzB0bc1wk6GXWffGFVKkkVjlFYV7rTvNNqSeuKazD2eOb
         qvprZ9QGvxPQNw2aIZzNzycenLIp7znKJ7y+cH7XQ3eyunqrr7LaQLf9eTzIxYcfztvz
         GsYspG0NeiDtRz/Z93hX7HDkmtn6ePW4RSa08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tV8bIAKkwRNCkckVOYeoYlebWo0ebt4dV9pe/7DB+wY=;
        b=VLT9Dco3xDtd6NWImnVDAbBh1Q/fYjV5uCSAjIneDu9EjeijUP0Mtpp3xAUegsQGIZ
         7lrqmF/8hvtk+yE6bTZQDID+t3FVYJ+ttxDoxnOjX6fRU+cDsBiMNmhyc6WOfoH6Togw
         1PD8Je+FQW+sJHZw46YraY8ReBjH4CgPcn4+CTLHX34R7VTPNl53aQHa/28Mi5aZwnEb
         NlwxRY8GmK3QXr8C6NbMK88KqRvMMtArP80clm10sIFqL7ES4X1JqAcomV8fxq9Tf8NM
         94hMnDK40Ih7R7zRREXvJrs9Sdmm/JT4mVYlMUiUzXTuMhH8kHVVlBtHrOBRrxWju7CG
         My6Q==
X-Gm-Message-State: AOAM533ax447ZprvM80nhBqp1GT1m9B/7tMlAJFCPBpyt2+pFJfQ3WK9
        nabajBTgbEr6eWqDa3jBNXeOEw==
X-Google-Smtp-Source: ABdhPJzGBt+BpcpNsPtkyLtX6Fhe6c/50y9943yUlx9gwDZf978+h///xXi53aR8z+77tF1GSG3Klg==
X-Received: by 2002:a63:5644:: with SMTP id g4mr1760871pgm.381.1591780055442;
        Wed, 10 Jun 2020 02:07:35 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id nl8sm5191620pjb.13.2020.06.10.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 02:07:34 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, tim.bird@sony.com, daniel@0x0f.com,
        devicetree@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Initial MStar/Sigmastar ARMv7 SoC support
Date:   Wed, 10 Jun 2020 18:03:58 +0900
Message-Id: <20200610090421.3428945-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20191014061617.10296-2-daniel@0x0f.com>
References: <20191014061617.10296-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds initial support for MStar/Sigmastar's
ARMv7 based SoCs. There is just enough here to get to a shell
with an initramfs but support for a lot of the hardware is
in progress and will follow.

MStar also shipped chips with MIPS cores and ARM9 etc which
are incompatible so I've tried to make the distinction in the
code that this is strictly for the ARMv7 based chips.

Differences from v1:

1. v1 only really supported two specific chips that were known
at the time of submitting that patch series. Since then it's
become apparent that there are a few families of SoCs based
on the same ARMv7 core, clk blocks, interrupt controllers etc
and this v2 attempts to make support more generic so in the future
more SoCs from this lineage can be added. Support for some other
chips is already in progress and will follow.

2. v1 only added support for the BreadBee boards that I have been
working on. v2 also adds support for a readily available car dash
camera.

3. Support for the BreadBee board has been split into two top level
dts to cleanly support if either the msc313 or msc313e is mounted on
the board. The chips are pin compatible but some of the internal
hardware is different. The u-boot port for these SoCs can detect
which chip it is running on and select the right dts so the user
doesn't have to care which chip is mounted on their board.


Daniel Palmer (5):
  dt-bindings: arm: Initial MStar vendor prefixes and compatible strings
  ARM: mstar: Add machine for MStar/Sigmastar infinity/mercury family
    ARMv7 SoCs
  ARM: mstar: Add infinity/mercury series dtsi
  ARM: mstar: Add dts for msc313(e) based BreadBee boards
  ARM: mstar: Add dts for 70mai midrive d08

 .../devicetree/bindings/arm/mstar.yaml        | 30 ++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  6 ++
 MAINTAINERS                                   | 10 +++
 arch/arm/Kconfig                              |  2 +
 arch/arm/Makefile                             |  1 +
 arch/arm/boot/dts/Makefile                    |  4 ++
 .../dts/infinity-msc313-breadbee_crust.dts    | 25 +++++++
 arch/arm/boot/dts/infinity-msc313.dtsi        | 14 ++++
 arch/arm/boot/dts/infinity.dtsi               | 10 +++
 .../boot/dts/infinity3-msc313e-breadbee.dts   | 25 +++++++
 arch/arm/boot/dts/infinity3-msc313e.dtsi      | 14 ++++
 arch/arm/boot/dts/infinity3.dtsi              | 10 +++
 .../boot/dts/mercury5-ssc8336n-midrive08.dts  | 25 +++++++
 arch/arm/boot/dts/mercury5-ssc8336n.dtsi      | 14 ++++
 arch/arm/boot/dts/mercury5.dtsi               | 10 +++
 arch/arm/boot/dts/mstar-v7.dtsi               | 71 ++++++++++++++++++
 arch/arm/mach-mstar/Kconfig                   | 26 +++++++
 arch/arm/mach-mstar/Makefile                  |  1 +
 arch/arm/mach-mstar/mstarv7.c                 | 72 +++++++++++++++++++
 19 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mstar.yaml
 create mode 100644 arch/arm/boot/dts/infinity-msc313-breadbee_crust.dts
 create mode 100644 arch/arm/boot/dts/infinity-msc313.dtsi
 create mode 100644 arch/arm/boot/dts/infinity.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e-breadbee.dts
 create mode 100644 arch/arm/boot/dts/infinity3-msc313e.dtsi
 create mode 100644 arch/arm/boot/dts/infinity3.dtsi
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n-midrive08.dts
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n.dtsi
 create mode 100644 arch/arm/boot/dts/mercury5.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-v7.dtsi
 create mode 100644 arch/arm/mach-mstar/Kconfig
 create mode 100644 arch/arm/mach-mstar/Makefile
 create mode 100644 arch/arm/mach-mstar/mstarv7.c

-- 
2.27.0.rc0

