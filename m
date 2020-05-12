Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3F1C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8477206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aY69rB+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgELPAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgELPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:00:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C101FC061A0C;
        Tue, 12 May 2020 08:00:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so5490796pls.8;
        Tue, 12 May 2020 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zY6l7Pzo8dnedvQSXEa9BV0T0TX5SB1UpYlmpbsnlxo=;
        b=aY69rB+XNQ8wwcsY3HAr+e0Ju0AYGDRXK+SLIrRK8A5Rv7FhKikttrwEJcoinFah+N
         rvnUwzOTQ4b+4b6c+dWj1ux7ov2pTAER7MQQvNQAemGhgp3+up9tg8Q0ZgZWUheEizMA
         WzEWlGY9yeGrO9e5G8uiQ5mZVceUhOk2iIxjWcVXs5Nj9b4TEnAYNT9SMZIsNfFmgbG5
         RO3Zp/30tTdNgII4qgOl/vxmHojp+s6VyMZxopunLZ2yWstKzryLUe9BLP/m5ca29OT2
         RmASSTOY06SBS8jG6Rczr8cvR4x8Mo902ymSkHDpCSXBDTQZQoGR6331UgTowMahkru3
         Y4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zY6l7Pzo8dnedvQSXEa9BV0T0TX5SB1UpYlmpbsnlxo=;
        b=Wf94hKGgY21fiZJrkTs0sQ76xO2HSw0hPkBow9cstEjQNu3TLzFOV0MufmvAPga2bp
         t41CpH36F3+nGGN4oaRAeHi7u+6NcLMPySE4AFFjipKybZYFxKiqQIzN8MEfZTsGLyRZ
         /0RwKXG5TgodXeT3+Zpqmmn2JPz2H2RSuzyKa2+3g4tQk68tjnlz4wzqinpSPja984jX
         /vdnWOYrLbC/x4/0t7QCDmutluGgUAlOdW3Oxo4/ycUqhZR0vM1yr9qt48kBp8xg91qe
         QZhfGUJSmLsmXEsUHKCek6+uEs2vPTFvYUvSkmGbxNCkaQRD79nB75Uww94HzNR6w8mq
         rqQQ==
X-Gm-Message-State: AGi0PubRJNRPSpdv+y2tLzFOQ5AxUWRAZ1tVGPXtQgP6l2rIjuwCwc2B
        2eKrryz+RBN8ogt7trbCtyFEkWQK4mM=
X-Google-Smtp-Source: APiQypKmZjVS6pLHVWaDrSJr/frJYuIFiE/4qsGhLrwa25HuB2pW3W/srEun1TtAHe/cEWB3VZjSUQ==
X-Received: by 2002:a17:902:c3c3:: with SMTP id j3mr20040157plj.284.1589295638750;
        Tue, 12 May 2020 08:00:38 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c2sm8359779pgj.93.2020.05.12.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:00:38 -0700 (PDT)
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
Subject: [PATCH v10 0/5] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Tue, 12 May 2020 11:00:14 -0400
Message-Id: <20200512150019.25903-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v10 - Fix incorrect error return in ehci-brcmstb.c pointed out by
      Alan Stern.

v9 - Fix minor typos in patch description for ehci driver.
   - In ehci-brcm.c, use ehci_err() instead of dev_err().
   - In ehci-brcm.c, handle zero returned from platform_get_irq()
     by returning -EINVAL for 0 or actual return value for < 0.

v8 - The previous v7 had the wrong version of ehci-brcm.c. This time
     really, really add the changes Greg requested.

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
 drivers/usb/host/ehci-brcm.c                  | 280 ++++++++++++++++++
 drivers/usb/host/xhci-plat.c                  |  10 +
 7 files changed, 389 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-brcm.c

-- 
2.17.1

