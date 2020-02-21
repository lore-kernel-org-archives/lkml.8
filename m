Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC8C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E50207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QVp/FC2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgBUFiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:38:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35727 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgBUFiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:38:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so623413pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 21:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xR1GRxFdUV2TwDvxuNR/pK3VYzRWJYZmKivDEUcKc5w=;
        b=QVp/FC2NiAc3rBycqqqlyoa0rlWBGhP8nW8nvvVd1pRXp9Io6ugF1YFhOrlCramk4m
         maGakRF1l77Fn3JdI/QLF3uqnkV56NYnLn0ct7McCl8jjFS/RuIzCVK4rKwS0eMsanTp
         JJZ6xUxzRnD685IHKwcVyvWnx6ogkbaou6bhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xR1GRxFdUV2TwDvxuNR/pK3VYzRWJYZmKivDEUcKc5w=;
        b=raNCCWwU/65UhAlLl4YVwt8wxPgS5kT0NX91TcxKyoBSLT1kTAV9DEY4pXxL3S44bw
         pgLkb99EvI/SQSVakk+brQDD7GWy9jAiyn6XxbGj7Qg6bksZNLp+WBMjBkkMU7HD49xc
         KOnaJGGlweVekegIHMs9eAQNEzN5IgpL2eWdxyw0k6TbcwHFljAuvUXzbshoRxs6YV9K
         PlwIAcHNXFwQ2jFzaMuKz6aFl4maOWZUO/dY2HnUO4+/QiOgoLrckfw6B7U4ry1I91lW
         W+GfNQnDrdoilDNIJd6tTrAvpYam/EFA/4Yms2+hJtqfMzIxzygZU165zLQPLwghlcTd
         M1eQ==
X-Gm-Message-State: APjAAAWM7gea3Ps/6pnLZrmdlzRK9xpHn72ZuT5BZkR6BW4NdGkC5zz+
        1oNIOFbZ6cJ0cuC9GlsWDFkIUfZEJOWaRA==
X-Google-Smtp-Source: APXvYqwNbEeASGO4ArQ+KQ49tlopvldlo5/I0QneTu45MVpD2X1Vvxvy9falEjB7Hs8GL48/Mzv+xA==
X-Received: by 2002:a62:486:: with SMTP id 128mr36207829pfe.236.1582263499298;
        Thu, 20 Feb 2020 21:38:19 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:1105:3e8a:838d:e326])
        by smtp.gmail.com with ESMTPSA id b25sm1329060pfo.38.2020.02.20.21.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 21:38:18 -0800 (PST)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     jwerner@chromium.org, Evan Benn <evanbenn@chromium.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 0/2] Add a watchdog driver that uses ARM Secure Monitor Calls.
Date:   Fri, 21 Feb 2020 16:38:00 +1100
Message-Id: <20200221053802.70716-1-evanbenn@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is currently supported in firmware deployed on oak, hana and elm mt8173
chromebook devices. The kernel driver is written to be a generic SMC
watchdog driver.

Arm Trusted Firmware upstreaming review:
    https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405

Patch to add oak, hana, elm device tree:
    https://lore.kernel.org/linux-arm-kernel/20200110073730.213789-1-hsinyi@chromium.org/
I would like to add the device tree support after the above patch is
accepted.

Changes in v2:
- Change name arm > mt8173
- use watchdog_stop_on_reboot
- use watchdog_stop_on_unregister
- use devm_watchdog_register_device
- remove smcwd_shutdown, smcwd_remove
- change error codes

Evan Benn (1):
  dt-bindings: watchdog: Add mt8173,smc-wdt watchdog

Julius Werner (1):
  watchdog: Add new mt8173_smc_wdt watchdog driver

 .../bindings/watchdog/mt8173,smc-wdt.yaml     |  30 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/watchdog/Kconfig                      |  13 ++
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/mt8173_smc_wdt.c             | 160 ++++++++++++++++++
 6 files changed, 212 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mt8173,smc-wdt.yaml
 create mode 100644 drivers/watchdog/mt8173_smc_wdt.c

-- 
2.25.0.265.gbab2e86ba0-goog

