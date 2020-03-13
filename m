Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E4C5ACC0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49386206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTxz8xVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgCMOQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:16:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38148 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:16:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id x11so7547123wrv.5;
        Fri, 13 Mar 2020 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mo2SVHU15dhXGmRt8MzBQ/mcodnrQymnm3XWUfS3DkU=;
        b=nTxz8xVul1ywqLBld+tylaeroY2sj051plVUeXnYi2I2/vJmeS9Vh34shb/iY4o10e
         DXFZOxadnKQ2cgfKqdhqDlIeHOzT72GncTsCAOm4UTdlz2lwb5rKmy4h+oXIW8AGIV40
         wS9+D+gvreV3PIk5mFOmiFFphnXOEWFL08MgTjyBB0LuG2OziXwOm1XFFtvyQ1Ci0zAt
         FyKgc1jLDqzIgxhvnKhEYrtk1y2HdgMP/MH818clkv55D77H6vcbGSoaHKHZ5we0TuBx
         pL/Q1HutxYpzoFODv0CY+EkzKlTDSYAlgWGjLOYWBbEL1OeK4lrPRjEjcBo5GFs5cK5O
         X9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mo2SVHU15dhXGmRt8MzBQ/mcodnrQymnm3XWUfS3DkU=;
        b=sREOG9l0/HZmrJW0y/ofnze/c9NrvMLL1kl8IbxbOOPB3Ea2SagBvINu7cLQkYOIxZ
         2oVYHZQ05Z6MFhy3lq1FO6OVh3ASNITKUCaif5tLPfmJe8UatzQfTShRhPruAhohUBiN
         QteDV+aGwcCtQGADaJ8z8olh+0yjerPX7buuXumIv+M99jnIoc6AHfuqvvJ+oM+/eaQA
         qZOAwVaaAUas342EmHTpEzqUjjGOOhs4eTN+Nmi/MFbFaajXuKs837NuTDhXarEnfVkk
         4dV/v7hETzIiz65ItDx40lKFmXLmLAt5FU4AhXgaX6fMNEos01kVAkPHrSo1hk1PQ97N
         MR3g==
X-Gm-Message-State: ANhLgQ2VUm1+MVC557eFfT67a2n14G//y1ep//cFCGZnfAGD+GZLF3Lm
        t5wL4YcCPaPS7iYokL5pzB+NTqG9/Z4=
X-Google-Smtp-Source: ADFU+vuhBW6steYgq55mNvlJHkRG/mYoj+9ZMBf68zvt9Qazn44FCW1mGsZcKw476yIBTTeYrQssZA==
X-Received: by 2002:adf:f2c7:: with SMTP id d7mr18333316wrp.104.1584108976444;
        Fri, 13 Mar 2020 07:16:16 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id l83sm17561422wmf.43.2020.03.13.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:16:15 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Fri, 13 Mar 2020 10:15:41 -0400
Message-Id: <20200313141545.31943-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the XHCI, EHCI and OHCI host controllers found
in Broadcom STB SoC's. These drivers depend on getting access to the
new Broadcom STB USB PHY driver through a device-tree phandle and
will fail if the driver is not available.

Al Cooper (4):
  dt-bindings: Add Broadcom STB USB support
  usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
  usb: ehci: Add new EHCI driver for Broadcom STB SoC's
  usb: host: Add ability to build new Broadcom STB USB drivers

 .../bindings/usb/brcm,bcm7445-ehci.yaml       |  60 ++++
 .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
 MAINTAINERS                                   |   9 +
 drivers/usb/host/Kconfig                      |  20 ++
 drivers/usb/host/Makefile                     |  20 +-
 drivers/usb/host/ehci-brcm.c                  | 288 ++++++++++++++++++
 drivers/usb/host/xhci-brcm.c                  |  16 +
 drivers/usb/host/xhci-brcm.h                  |  16 +
 drivers/usb/host/xhci-plat.c                  |  11 +
 9 files changed, 435 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 create mode 100644 drivers/usb/host/ehci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.h

-- 
2.17.1

