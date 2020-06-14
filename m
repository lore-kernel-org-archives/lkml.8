Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A21EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 08:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2700A20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 08:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMopbhSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFNI66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 04:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgFNI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 04:58:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB13CC03E969;
        Sun, 14 Jun 2020 01:58:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so11700064wmh.4;
        Sun, 14 Jun 2020 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pGhe1kLEgAs1t6DKUVK5PIxiFYRJxWc8AEhPU58R/IE=;
        b=pMopbhSP0bywBsSXxLktqm17BX6LQqmOrLquqc61uR95Ixlf00JoKb8PFxlTQvjwjY
         +BdvGySK32VusFW8pWzVjkddIwpJOrqbPGxe0jO0Zoy9MQ2Z16/KM4L9Ka8Dopb2j/3o
         T48sGi5o0ZvVLOZdek8qZ4DnXt3TjzKlSwSJj+pNd2YdDp//Ph6dEuoQtQ3Wz0514w+m
         2jVUWM22okL24pEOjQaxeQBE94aWPmbgtP7EiKReKs8AabrFNFrdHs8kOOHjGvxL0ZVs
         eMMjP+u8/0tB9XTdrpW2paqHQ7XE0vt4YEUmY4HR56lFC6rxIn4pUumwnKO4VQSrh5sg
         4zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pGhe1kLEgAs1t6DKUVK5PIxiFYRJxWc8AEhPU58R/IE=;
        b=NYPPrXuJQUs8U0/YTgMCmjNE58DDQBCtzsv5yBCqEbZYBbZ6IXQs4jOIwUYa1N0RRH
         nhe3dZFYmWKIPIyZLF6LYrUSpKxUfRoOXpBGB3kBeAvYpOiu16cuSKaF3gadFwBUY0Qn
         FfrvuQKUPi0aK+sq7ZQf/0bk23as8GMt0aVtYZeDv1+B7udMVYbnh7g7X0iWVoaUuNVG
         nrv7RRVYzdrE7Byed82b1pcMNA8FZZTrLwu1y+7ir5+LxE3A1DxHfpumVsM99xA98WKw
         7ovUSV2y6e4JZ625Kxw+VB8ec7KA96gq8qQ5dgXIhU72AkqBfoJ+y0qQGpH6DZk9WPFA
         0LNg==
X-Gm-Message-State: AOAM533N6q796+07XjTx12Evd4uaOaay12stKz/0RzuHrgdcVqnzNgDg
        30x+aKMTaFswHozVER2QqUg=
X-Google-Smtp-Source: ABdhPJyxExAUFu4aeOemIjQTWCPgso3VzGshWleuacCZbbw21mlokHF9AhbLJwI0tyjRaQ+zAXq0fA==
X-Received: by 2002:a1c:4143:: with SMTP id o64mr7256914wma.157.1592125135049;
        Sun, 14 Jun 2020 01:58:55 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id u4sm17174043wmb.48.2020.06.14.01.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 01:58:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v5 0/9] bmips: add bcm6345 reset controller support
Date:   Sun, 14 Jun 2020 10:58:43 +0200
Message-Id: <20200614085852.2130147-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613083813.2027186-1-noltari@gmail.com>
References: <20200613083813.2027186-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM63xx SoCs have a reset controller for certain components.

v5: fix kbuild robot error (drop __init).
v4: fix device tree bindings documentation.
v3: using reset-simple isn't possible since sleeping after performing the
    reset is also needed.
    Add BCM63268 and BCM6318 support.
v2: add compatibility to reset-simple instead of adding a new driver.

Álvaro Fernández Rojas (9):
  mips: bmips: select ARCH_HAS_RESET_CONTROLLER
  dt-bindings: reset: add BCM6345 reset controller bindings
  reset: add BCM6345 reset controller driver
  mips: bmips: dts: add BCM6328 reset controller support
  mips: bmips: dts: add BCM6358 reset controller support
  mips: bmips: dts: add BCM6362 reset controller support
  mips: bmips: dts: add BCM6368 reset controller support
  mips: bmips: dts: add BCM63268 reset controller support
  mips: bmips: add BCM6318 reset controller definitions

 .../bindings/reset/brcm,bcm6345-reset.yaml    |  37 +++++
 arch/mips/Kconfig                             |   1 +
 arch/mips/boot/dts/brcm/bcm63268.dtsi         |   6 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi          |   6 +
 arch/mips/boot/dts/brcm/bcm6358.dtsi          |   6 +
 arch/mips/boot/dts/brcm/bcm6362.dtsi          |   6 +
 arch/mips/boot/dts/brcm/bcm6368.dtsi          |   6 +
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-bcm6345.c                 | 135 ++++++++++++++++++
 include/dt-bindings/reset/bcm6318-reset.h     |  20 +++
 include/dt-bindings/reset/bcm63268-reset.h    |  26 ++++
 include/dt-bindings/reset/bcm6328-reset.h     |  18 +++
 include/dt-bindings/reset/bcm6358-reset.h     |  15 ++
 include/dt-bindings/reset/bcm6362-reset.h     |  22 +++
 include/dt-bindings/reset/bcm6368-reset.h     |  16 +++
 16 files changed, 328 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml
 create mode 100644 drivers/reset/reset-bcm6345.c
 create mode 100644 include/dt-bindings/reset/bcm6318-reset.h
 create mode 100644 include/dt-bindings/reset/bcm63268-reset.h
 create mode 100644 include/dt-bindings/reset/bcm6328-reset.h
 create mode 100644 include/dt-bindings/reset/bcm6358-reset.h
 create mode 100644 include/dt-bindings/reset/bcm6362-reset.h
 create mode 100644 include/dt-bindings/reset/bcm6368-reset.h

-- 
2.27.0

