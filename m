Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962EEC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F61A20774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1J19SXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgD3LNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgD3LNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:13:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3FCC035494;
        Thu, 30 Apr 2020 04:13:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e26so1382093wmk.5;
        Thu, 30 Apr 2020 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4z8sT9CuILd9aYFGoOvoTvoY8pkzB5UA6DzZlKXbDgY=;
        b=C1J19SXWSrCIMcluHqDbetMtFEYhZVAgKsNikEJsnLCFNNoNG/IRKFoj1UNco9zFmG
         BV6jqKiRXzm36cbS2feaw6nCV0/UlPdh9RmEeODGsVJfybvEcdeOp5DUrj6ZdxhbIp7K
         /vGEKuObNgfRyPZ+7ifu8h3LbNskxoh3B42Lmcb9wGTC69ZtEuc95AK6OyglMRtfUJwL
         cFR4ibIlB6ed+GkLKoHKxhEI/vB8FXUF+V1UOVl/46YqdmQppfg2GBOYksKbKJVLg9AG
         degIn85uZaLbn/ugBq+xEGNdmks35sn5FqRC8h26uWEmFTTuiiQuqVvcz7fOVx8Nn5Vm
         5DEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4z8sT9CuILd9aYFGoOvoTvoY8pkzB5UA6DzZlKXbDgY=;
        b=G5+1Eg1ON6ibb6c+2a8e7GS+s1NL+XG/e9IQHglkCQCZYBu7rJEmZidPS5sor3AvXk
         aSNN0P3nAcBEPVLgIoMovjB7vrK1XKgss0jxxoPiPUsiKa+ntsjwY9t4Rbiq/qyDOt2U
         NnFxhGqi/7fehhdV0dGx+qlH/boXpOSAN2GI6kuY0vh5iOz4HeytGao4+nMpwtE7orla
         ohrG3GrFDU05Q55Cl7a0xWxFdJokDnnhqrRnMQ3qn1N4uUvLywVV6BPGKA9uku2OeD10
         kmwaTsIf4Y83J+DtaVaXHCIkG22cEjlMfpuXbF/MJmEN3ef1U2BABrUFgzsf897ufQ+1
         /eDw==
X-Gm-Message-State: AGi0Pub+450hW7TBNu+EH14cwKJYw7EPwRJVO3QNGiZWgNV+wFpYQjL6
        JIPagNqqE86hJszh1TRh0NXICKARHpE=
X-Google-Smtp-Source: APiQypLSq5LI1RaeU9+A56fFunR4suuVXxjC8TT1B/rCsQCvcfhX07RrnjElEuLsRKAm8GQtVuILCQ==
X-Received: by 2002:a1c:9dd1:: with SMTP id g200mr2574998wme.82.1588245197110;
        Thu, 30 Apr 2020 04:13:17 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 74sm3727077wrk.30.2020.04.30.04.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 04:13:16 -0700 (PDT)
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
Subject: [PATCH v6 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Thu, 30 Apr 2020 07:12:54 -0400
Message-Id: <20200430111258.6091-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6 - Remove "contains:" from compatible section of
     brcm,bcm7445-ehci.yaml as requested by Rob Herring.

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

 .../bindings/usb/brcm,bcm7445-ehci.yaml       |  59 ++++
 .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
 MAINTAINERS                                   |   8 +
 drivers/usb/host/Kconfig                      |  16 +
 drivers/usb/host/Makefile                     |  16 +-
 drivers/usb/host/ehci-brcm.c                  | 290 ++++++++++++++++++
 drivers/usb/host/xhci-plat.c                  |  10 +
 7 files changed, 394 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-brcm.c

-- 
2.17.1

