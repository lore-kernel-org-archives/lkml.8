Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C5C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30899208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkEC36zO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgD2Rbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Rbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:31:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBB5C03C1AE;
        Wed, 29 Apr 2020 10:31:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so3544762wrs.6;
        Wed, 29 Apr 2020 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GVaaD4ZP2LsvYrQiC9DHBqhpWsryLH+VB+jrhDKuI+s=;
        b=GkEC36zOMNd8ILoVveJEU2PUQayboQo9mC2ohlKRNRXk/6dqeJbmzlUOBh/wZPmFmR
         CxnHEeRGd61S7ascOca4T5x4mekAjTas0/gy/nW5mCOcO6QFFCpLWSqJ7CVnB+DEfNZM
         Zh+Dbo0o8t1QqiecASrGdsYurN0i+DQiC85V1R1RJOBUSAJlItbDwAjWDh0eiXgBwWWd
         Fwl09k3d7sL/szeN2iKuUz/CXw4KaPi5EoTfcubvAQ7WgQI72DxUtpPIl7bXM+7DYKrL
         5OB/j/aZ4NR2qKSRZbamCbflsg+AE7ZliUUxgxIQjbTEGUMRzZUo5nBz/pam/Y49nMHA
         2aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GVaaD4ZP2LsvYrQiC9DHBqhpWsryLH+VB+jrhDKuI+s=;
        b=B2XZVW3fQ5qwWdoFI3kEOlgA7EqpAXk60WtwBu4YOTYAzDE0vYtuGYs9+8f1bE+Nfs
         3aHUgdVPBQq4ruKRN4OHxbJfY1Xmm1AVSkRwAY3hV4uNP3VdV03FubzItW46ANEI+Jb0
         Dv4HhBViIBdpJ64+eTdKgCsADUTjwS18TBVJgELcZIyLNhxMHL42NIxTrqlfR2TVDlLU
         s3ZRxcGbDlcNBi7sKTWei//ksT7egp+7vRvzpnvR4psAVBXLwR1t/8RlCj2Ydos+spSG
         uRXIDfqAjivkyaYYc2DU1UeAYJgsQuc/CMjr1r2uaj4rtfKHChnDyqgSmIf7Qrw9q8e6
         0dlg==
X-Gm-Message-State: AGi0PuayohWlPXxXTcjotgo6XfJtcG5tfOtHc7eytuVRvdP982GYdctr
        Oax3CXPtn5X4aEi52Ah/pYEDhz+yA/s=
X-Google-Smtp-Source: APiQypJlBVVPtGDroRJN1e3WN+emkpRB4zwgBqzJs7JUEByeTKcELABKlzEjCnufDl1GoWkBZxRceQ==
X-Received: by 2002:adf:a11a:: with SMTP id o26mr39761355wro.284.1588181492142;
        Wed, 29 Apr 2020 10:31:32 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j11sm31177182wrr.62.2020.04.29.10.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:31:31 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Wed, 29 Apr 2020 13:31:08 -0400
Message-Id: <20200429173112.38366-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/usb/host/ehci-brcm.c                  | 286 ++++++++++++++++++
 drivers/usb/host/xhci-plat.c                  |  10 +
 7 files changed, 391 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-brcm.c

-- 
2.17.1

