Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D354C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EFA20731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ0qDzVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgD2UIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2UIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:08:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FBCC03C1AE;
        Wed, 29 Apr 2020 13:08:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so1220410pje.5;
        Wed, 29 Apr 2020 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WOZd7qcxe4gLtfO9RC05iwoT4m60cIyVOvlJ52Dodz0=;
        b=uZ0qDzVIvjQrC6G/nlImR7fsWsAHeptwzaKi+7jjUPUgBIoH4UtRJ5iUQj1ilKogwA
         GKQuSOggGQ6hQa30CIylRuxP10sFrGzYq/fQExmS0+was6M0oYXbEXWsGTSzL+nVa/77
         5lZIgmIiBRBCUeUX6kFQ74auM12c6it9vvG1FwQ5BtfDKoMwiX4KB6I2537L0yyR01+q
         qHpUiFGnRcfrDfyE/CzS9YHmQ99Pu/xhSn4TAE4kgyWzdapZfu9r+b6jQmOxbJD70Hph
         FzmJL/U/Bma0Xp6wRP2fHEcFk3WoqLDHvJtmXDYqemAO/hsEyAcsvB7PbNuXxslTANg1
         lA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WOZd7qcxe4gLtfO9RC05iwoT4m60cIyVOvlJ52Dodz0=;
        b=jGk3j4s4ew5+e4XyfcgInwsFsTFhniM9mGMwAhcs9tipnlkgX8XxzDDYIioNYfgHpq
         Un/VB5666f/LfhZcb/FMmDjiZ7zGw3xL16DZa/NGc4WE2K0EG2sRWY6t9Fvd9Uelmwwa
         IRlIuV2qtMQb+jxtSrtWKtqdbUp1dSDR3c68kxgDylQjv9PhWHksi34CpQABYPXpboFO
         yB2+KcIBvRP06lKzTalHhBCsqvZNm6nW1ezgAx5X33KUHISDTZsdcSvS6ew/k4qJ8E9X
         3XAcCV07afUZ17Z/X5bCsXMaVXISIZbhtsTHbJmOAllLA7SHWmgUYq0bzbZeeMZGyvk+
         Gl5g==
X-Gm-Message-State: AGi0PuYOvq8xmLWIm6sNVr4RfMNxd1n/UYhpmYnZC5SnpfwfIU334Xzg
        vWtKw2+VPsc8S6ARPs7/GXrxeOo2iHQ=
X-Google-Smtp-Source: APiQypIUekAlCRG9AHQxZFGj0HO6s1oQEECvbuzapVx9ziOgexmgfyEn69aMdXM7lBxVlbDphTNklg==
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr203798pja.80.1588190920194;
        Wed, 29 Apr 2020 13:08:40 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z23sm1638957pfr.136.2020.04.29.13.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:08:39 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Wed, 29 Apr 2020 16:08:22 -0400
Message-Id: <20200429200826.20177-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 - Use devm_platform_get_and_ioremap_resource() in ehci-brcm.c
     as requested by Andy Shevchenko.
   - Add pm_runtime_set_active() to ehci_resume() in ehci-brcm.c
     as requested by Alan Stern.

v4 - A few more fixes to the brcm,bcm7445-ehci.yaml dt-bindings
     document requested by Rob Herring.
   - Fixed ordering issue in MAINTAINERS as requested by
     Andy Shevchenko.

v3 - Addressed all of Andy Shevchenko's review comments for
     ehci-brcm.c.
   - Fixed the brcm,bcm7445-ehci.yaml dt-bindings document,
     dt_binding_check now passes.
   - Added the XHCI functionality to xhci-plat.c instead of creating
     new brcmstb files, as suggested by Mathias Nyman.

v2 - Addressed Andy Shevchenko's review comments.
   - Fixed dt_binding_check error pointed out by Rob Herring.
   - Removed pr_info message in ehci_brcm_init as suggested by
     Greg Kroah-Hartman.


Al Cooper (4):
  dt-bindings: Add Broadcom STB USB support
  usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
  usb: ehci: Add new EHCI driver for Broadcom STB SoC's
  usb: host: Add ability to build new Broadcom STB USB drivers

 .../bindings/usb/brcm,bcm7445-ehci.yaml       |  60 ++++
 .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
 MAINTAINERS                                   |   8 +
 drivers/usb/host/Kconfig                      |  16 +
 drivers/usb/host/Makefile                     |  16 +-
 drivers/usb/host/ehci-brcm.c                  | 290 ++++++++++++++++++
 drivers/usb/host/xhci-plat.c                  |  10 +
 7 files changed, 395 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-brcm.c

-- 
2.17.1

