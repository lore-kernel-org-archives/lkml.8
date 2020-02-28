Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F2C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF3E24695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxZo9JuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgB1CIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:08:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46685 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbgB1CIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:08:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id o24so836793pfp.13;
        Thu, 27 Feb 2020 18:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z5AIbk2nbOcHqpTmcvhMG9mF23rIvUFPSLJXXgXhGns=;
        b=WxZo9JuHxs2vb8rzf2HkXGaALenOiLW17gU9FV7NRZnQX/R4Snkc7mWGvmDU4MAO7t
         8jVaLqfz7cr3WemoDQyHzihCUa74B7tA2upzRpq3DhB56XOkNZEUAP+diQ8F5pr1mYYy
         /eINOAoaeDTbtQSjkQ7q78GZrG18X6ofyEIevln/VnS7x9LMTG0vZCQ7fdSQAuOm/YSX
         LPE2FMrcSLV42KJJN0Al145sJ40ccNpQSxso2CPCXZfPBYXsZdmZXydPm6TGRv8sxS8X
         IO+MQfO38hqOcgEArnArXh/Imkv8+osKKLguQ/jJgaRUiT+PKDryfxsvWMW27f74d2WQ
         +KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z5AIbk2nbOcHqpTmcvhMG9mF23rIvUFPSLJXXgXhGns=;
        b=KA1Vo/F0zAQs4sY+S3HHKQkAK3JfpNhyVorKqoCL8brqB23u4wBLsWZrlM913wmdpV
         ZS1Ylr4l4lJutkWt0up4d0a4iBw4eZ29sWnPZKeXKfQhLh2/PPuFmBWf1QZMG3dm4Csa
         jt/Ky6toeeGpGd8VktZUxbbiIZzROoBjGZqQy9KhKoTQ+HQ5SbKUj3E1rYEdc8+3jnXD
         HGJdoyL5c2FhC9+1ogro0tjXfZz0Ggt0dEmRG84DZaeRdJUWSg/KBBQa9xe8t5cV5q88
         6jVLMcty/ZBrklGrJSMVz5ighA9etgk5mybVSEQQmTKY8Q5MxLmRxitOxLw039S6xF4s
         Uytw==
X-Gm-Message-State: APjAAAXlXdvJ3bJNI0y9pAYQBwnJRp9Zrj3VWfpoudWGdUG5PXr3T97b
        C+QGWkCFkHMrnvYuq4UOXl4=
X-Google-Smtp-Source: APXvYqzwfsLxTTqt4X5L8xIjUVbm8bxdacPFLrNAwoD4cD1bY8Ry1LYaaB9nFvV5Fr/sOrt1DhrKRA==
X-Received: by 2002:a63:42c2:: with SMTP id p185mr2358809pga.268.1582855687383;
        Thu, 27 Feb 2020 18:08:07 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id k24sm4931972pgm.61.2020.02.27.18.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 18:08:06 -0800 (PST)
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
Subject: [PATCH v6 0/7] aspeed-g6: enable usb support
Date:   Thu, 27 Feb 2020 18:07:50 -0800
Message-Id: <20200228020757.10513-1-rentao.bupt@gmail.com>
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

 .../bindings/usb/aspeed,usb-vhub.yaml         | 73 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi              |  2 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |  2 +
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi      | 25 +++++++
 arch/arm/boot/dts/aspeed-g6.dtsi              | 45 ++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig    |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c     | 71 +++++++++++-------
 drivers/usb/gadget/udc/aspeed-vhub/dev.c      | 30 ++++++--
 drivers/usb/gadget/udc/aspeed-vhub/epn.c      |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c      | 58 ++++++++++-----
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h     | 43 +++++++----
 11 files changed, 286 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml

-- 
2.17.1

