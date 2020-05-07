Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDA3C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8128521473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Uw6oea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEGRea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgEGRea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:34:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F00C05BD43;
        Thu,  7 May 2020 10:34:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so3338615pfd.4;
        Thu, 07 May 2020 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XEz7HnmXuCDzCluvC2ciL1p4XelzoBx3kOa65ITXPbY=;
        b=k2Uw6oeaTUmXWP0RgNbyGpnpPuYiNoHYqdYuYxhX+QUT6YnlL2k6pxSDz4BOu1dUha
         H5suKdKb8C9eHW5tyv9g9HL6OtuptlEv4r2pOwV92yTPBYdstNmcyV1iiGgSAhJBDijK
         vSefMGhwU0lgDWF7Y8q9YJz+yONuCFi+L9UADzcmY5l8BDQN0keg9Mopb+XnMG1EULO0
         YHeOcJLX4ShoiVFBXiCiPHLthWicZzQxypRxKE1Qg5Imp2CHGr3KO7MwN66RfZK9P6T2
         wWUbaZyOy1kpn39ZceUEqVbSibZuVolwIZwYmAJSCCNWCKD/HWHrdi0NIqbvECeeuELT
         H/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XEz7HnmXuCDzCluvC2ciL1p4XelzoBx3kOa65ITXPbY=;
        b=cx6uzKBnOcOINCNTDojnUPG92s5dDoeDFdR40MO8DS//G8Y3BY4Em1tjURuiQNXE89
         kdm2U9IQM6N4jfGHwb4H2tXP1I5+hEIg/bLiSQrglhnfFQq9P+NNHBUEwO/1DDiG27bk
         KT68Z0lhhs0iPAUJ7+EE8WY0kvll85RBd7LHuX3ZNT/4V8gdxPPQDldD/zsWi8bPK/co
         ps+PIy7z965u6Z1JrfIK7FJ8Uo3IZBGMddQY6P/06RM0QWZ4Q26Sr+l9kGHVm+nPsmOI
         0GOC8kdqa2yRcS41HXgDs7IAxSR8bVEeqxZf+87yw7733oVGtrQsq1waELCkLUZV/5ui
         x0mQ==
X-Gm-Message-State: AGi0Pub5hHVCa9mVlKcBsyVxQ53jiNyHnkdYqJWM0LhRuudH7CsD7ZnP
        dGWL1vIoxU1ef8b901rKZUyfV4Nu+os=
X-Google-Smtp-Source: APiQypKWfdSFshYR1R3HDsp46ph6fFoMsTiaEeFvYHETawZEvcn2RK/7+IAcBUp9J3THS0amPDvOQw==
X-Received: by 2002:a63:b11:: with SMTP id 17mr12452336pgl.3.1588872869474;
        Thu, 07 May 2020 10:34:29 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y14sm5368802pff.205.2020.05.07.10.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:34:29 -0700 (PDT)
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
Subject: [PATCH v7 0/5] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Thu,  7 May 2020 13:34:03 -0400
Message-Id: <20200507173408.20754-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v7 - Cleanup ehci-brcm.c as requested by Greg Kroah-Hartman.
   - Split out Makefile re-order change into a separate commit.

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

This adds support for the XHCI, EHCI and OHCI host controllers found
in Broadcom STB SoC's. These drivers depend on getting access to the
new Broadcom STB USB PHY driver through a device-tree phandle and
will fail if the driver is not available.

Al Cooper (5):
  usb: xhci: Change the XHCI link order in the Makefile
  dt-bindings: Add Broadcom STB USB support
  usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
  usb: ehci: Add new EHCI driver for Broadcom STB SoC's
  usb: host: Add ability to build new Broadcom STB USB drivers

 .../bindings/usb/brcm,bcm7445-ehci.yaml       |  59 ++++
 .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
 MAINTAINERS                                   |   8 +
 drivers/usb/host/Kconfig                      |  20 ++
 drivers/usb/host/Makefile                     |  17 +-
 drivers/usb/host/ehci-brcm.c                  | 292 ++++++++++++++++++
 drivers/usb/host/xhci-plat.c                  |  10 +
 7 files changed, 401 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-brcm.c

-- 
2.17.1

