Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CEEC3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCF224699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3uxW57B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgB0XFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:05:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43838 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgB0XFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:05:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id u12so442841pgb.10;
        Thu, 27 Feb 2020 15:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Bk/8S/Z3TX6gpAJL/01qav03pWjPrUS9+WLbM4tWfRA=;
        b=D3uxW57B0O2ZCS13ox+7bG3kfYJ5dm/5SQnmvP4FvWhMrFCseDKD7aHRX77YVxLIeK
         QmXQXLgi+BnIuBKkThmncjPPcuDErTVpgwIJInw2WrOKFBUl74O14clRUCo0uKUasRG2
         jHFO9WNnbVQI5EgXyYuRbBazh7hxKpeywV9Pewb4YiMMN3rsNkp3XDAXHVyhCAFV0b/J
         HkE3e7EbQif7P6K7MEumvanCMAPKGqR7osu4IrHNXTFkYZUgtnm6eDQA9i0SF0BaiHuF
         umwDNdSfJi8ud1Yac4Hu2BOp6j2iWu8BmIrGqz9CXAgOBxaG3LPsdKXZWCRQRhJMU7aj
         kBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bk/8S/Z3TX6gpAJL/01qav03pWjPrUS9+WLbM4tWfRA=;
        b=DEhascdTjvS1ytbfMw8zRWZL3NhIxMyrFF7yB/KZRBxd+ShlGNPwRK1ZBL2/okI+Jv
         b1NUMBYoyyQV+us53wx+of3++gLaNQqKJbhDhocrmjZUcLG0BrSfkodmAiNviNyMmPHy
         EEIe8BPV2MRv3kxIdwqvK27wry4nKxK+JwasABdCCrTkyPRf40taAVPhWpcYytCDolCq
         KpeFSrzVg4AYvC7jxisXJqIrMYavr6OqqOddIwXSKXd+ObNNtGF97jjVGl+H/zDlxzGV
         qkw4X2BLRXn59MG7tEHlYGFAWS4qB8zRbZZrg0/vCZQ2/cMtzdeMLmc+fsxC2J22ngzG
         wwfQ==
X-Gm-Message-State: APjAAAVnKUECtFSn6s9rbhXYYigIsIG4WB8hJOG2MoIPBQR/WiR2Ii2I
        BelNOBC8cWrrC0KawPY48IgXJDKlv1w=
X-Google-Smtp-Source: APXvYqyDK8WIIeHKpc/60SN35zdliyQ2V/wsC3lesIYegLPHI6ky6j9GatyILA/aeOM6XAgy1Jjrng==
X-Received: by 2002:a63:5fd5:: with SMTP id t204mr1541214pgb.265.1582844715754;
        Thu, 27 Feb 2020 15:05:15 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id w2sm8275975pfw.43.2020.02.27.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:05:15 -0800 (PST)
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
Subject: [PATCH v5 0/7] aspeed-g6: enable usb support
Date:   Thu, 27 Feb 2020 15:05:00 -0800
Message-Id: <20200227230507.8682-1-rentao.bupt@gmail.com>
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

