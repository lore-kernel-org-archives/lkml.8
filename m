Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A30C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD3820730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKBy0zWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgDHSOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:14:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36748 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgDHSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:14:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so9007466wrm.3;
        Wed, 08 Apr 2020 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nfNQgNtQAg8qEd3YfpmUEUM6hqbe1jSnmEXqTthUlGo=;
        b=oKBy0zWkNE3f3+Aw1LTIpTIKx5THvuUniYaMhc8J+bF5tPPECKv+gbotL3zb+LbInt
         NHycZpwb78/78wFednuCFqZNqQSFnmnRx/v19E4ILvremO8TKGvbhb0HXHoaA15Kaem9
         XAyxsozgsZ3phf171+nmO7SH1R+MGNHUotYs6p5qYnfLCaO+BGA8VqKDfLrxvqN5Xnm9
         wAn9PqSX0O/+xtSx+QVVJYwoX+9fwDf5ijXXNDZR8RmuoXzOjlR1vosa5iU+16dSWLdm
         AbzcXKSe5vKJtc30HXUSHeT2k2rERNuUUmtv3L/hpwJ7hYSzTqSDIJsgY4MQnVc8LkC8
         SjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nfNQgNtQAg8qEd3YfpmUEUM6hqbe1jSnmEXqTthUlGo=;
        b=JqRbxrjM+rheWtKsHPwnlG244bxD4KHJXJOF803agypb207cXmToflTP35ljqO9IKL
         zEe9GC4f00CQR+/1fEpzWJHoopq9OsAPb2kmT+3p6w6ezSu6SqvFP8vPhf51KYHVYXKD
         p2ddq5u1OB7/NCw8K9xiSafLL3TfZxv6ztWx8/75LbBx5KjM9huDa2GL6JZz3CCL4nBZ
         1gRh7kyNkLAbubiJGv85fT2kikhOHG4ZEjEdWVCKYGSOSTgQGmlEEpsGNQs1Ub4ToxoL
         ObcF/JhVdhTml9UwrBmKTtgl8v80magoDdZiBCvh7Y1TlnRLMs/+RgLh+P52u7eCWxjW
         kj+g==
X-Gm-Message-State: AGi0PuZzMTtC7qdQe4kDjhOk3pm2eLJvKy4M8Nb/e91NJ03K507aqGxf
        VK60Q85wZnpHfkzAXytdaJhP91bsnVA=
X-Google-Smtp-Source: APiQypKf3JZv0ROL5cDNc4n8T6CAE/lHMB+eiuBup5E52/fQc3z//oDc9gqQWAD7WjydkOOxe7/8Jg==
X-Received: by 2002:a5d:5688:: with SMTP id f8mr954304wrv.245.1586369680901;
        Wed, 08 Apr 2020 11:14:40 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n124sm441700wma.11.2020.04.08.11.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:14:40 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Wed,  8 Apr 2020 14:14:02 -0400
Message-Id: <20200408181406.40389-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

