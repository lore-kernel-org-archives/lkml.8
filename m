Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D7AC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B49924650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiIqG1tK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBZXED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:04:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35962 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:04:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id i13so391549pfe.3;
        Wed, 26 Feb 2020 15:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Bk/8S/Z3TX6gpAJL/01qav03pWjPrUS9+WLbM4tWfRA=;
        b=iiIqG1tKiFmSLw8ypVAFtG0a/VX8gxPi1TjGNgkgCIZ5Z7qjWdPW9+8K3J2U1skLnT
         XriD3Zl2Sxh5mVPXYsOttA2tMrRBEKKQxeTDuVOrlhQiU6sySvO9bd8fq52EStONOHlq
         C52UbmdpekyXeSt/SIj6TUrMBDVWXxhXdzSm+uaDVzREEtUjyyLy2AyWdJpSvRgR6Lnb
         6Ilh/TDwkwoYBgXez0mR4sZfU+EELlY/vwrUDkjPmHy0LTkn0AHP+zGzsBQ3JchD8hmQ
         oH6cSIRBmiA6O31pnf9/q4rzMBFON1tzp8jO/Rx/QxqMaWVEZdp5K7TaNqlwL6fuWZ1g
         vrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bk/8S/Z3TX6gpAJL/01qav03pWjPrUS9+WLbM4tWfRA=;
        b=W2/sxuUNNaPZ5g+nN/HqTSM8nN8iYgpDztKxDWPVYP3LApHzBcliB6kgJt3ShhDAbF
         AsikI8a+owQ5GLFCl7eHAaypbth9/2hp0QFvoJsRNXnsOp0b7KVNTVA7HkUnp8q2l2qs
         5P5YvCQ707D4JOZD9KCQ8Qk4ZVlC8pbXXvTLzi6lHVwLML094r4aztxkmAtYzvdPBb4I
         CSAMIEGTgWgghU/R4Ium4ml+rlgfxXqrWCe2IBT74H2EeOMsUlY71gWmUYBVdF33GB6T
         q0Y/oItSM1lnzAE5BpZc6EPMAED4IAijqB0vFe3zDkGuGNUyMGstiW6PmSGdnfCyPFvG
         aGrA==
X-Gm-Message-State: APjAAAWw5usw9Lg8WydqipnmR9w7+yifi/DDqHnSNQx5fUUpI51HfHOx
        VGG/KDNQruUfQq0MTmpCKpg=
X-Google-Smtp-Source: APXvYqxd8CY0HsAxhIMeDYkypalVr2YKiVsFuVI43/dN5ulZeTbimHEV3k5WocbbHPlR9VinUUrMDQ==
X-Received: by 2002:a63:b347:: with SMTP id x7mr1087976pgt.275.1582758240225;
        Wed, 26 Feb 2020 15:04:00 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::7:5ebf])
        by smtp.gmail.com with ESMTPSA id 3sm3912621pjg.27.2020.02.26.15.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:03:59 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 0/7] aspeed-g6: enable usb support
Date:   Wed, 26 Feb 2020 15:03:39 -0800
Message-Id: <20200226230346.672-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series aims at enabling USB Host and Gadget support on AST2600
platforms.

Patch #1 includes vhub's usb descriptors in struct "ast_vhub": all usb
descriptor changes will go to the per-vhub instance instead of touching
the global default descriptors.

Patch #2 replaces hardcoded vhub port/endpoint number with device tree
properties, so that it's more convenient to add support for ast2600-vhub
which provides more downstream ports and endpoints.

Patch #3 enables ast2600 support in aspeed-vhub usb gadget driver.

Patch #4 adds USB devices and according pin groups in aspeed-g6 dtsi.

Patch #5 and #6 add vhub port/endpoint properties into aspeed-g4 and
aspeed-g5 dtsi.

Patch #7 adds device tree binding document for aspeed usb-vhub driver.

Tao Ren (7):
  usb: gadget: aspeed: support per-vhub usb descriptors
  usb: gadget: aspeed: read vhub properties from device tree
  usb: gadget: aspeed: add ast2600 vhub support
  ARM: dts: aspeed-g6: add usb functions
  ARM: dts: aspeed-g5: add vhub port and endpoint properties
  ARM: dts: aspeed-g4: add vhub port and endpoint properties
  dt-bindings: usb: add documentation for aspeed usb-vhub

 .../bindings/usb/aspeed,usb-vhub.yaml         | 71 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi              |  2 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |  2 +
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi      | 25 +++++++
 arch/arm/boot/dts/aspeed-g6.dtsi              | 45 ++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig    |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c     | 71 ++++++++++++-------
 drivers/usb/gadget/udc/aspeed-vhub/dev.c      | 30 +++++---
 drivers/usb/gadget/udc/aspeed-vhub/epn.c      |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c      | 58 ++++++++++-----
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h     | 43 +++++++----
 11 files changed, 284 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml

-- 
2.17.1

