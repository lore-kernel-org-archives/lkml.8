Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D40C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E79320836
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K52oErQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgBRDN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:13:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37862 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgBRDN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:13:27 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so356920pjb.2;
        Mon, 17 Feb 2020 19:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QXKDYwEJ0FxdOMnutv0vajM2YUai+A8MQR7DaSJ50D8=;
        b=K52oErQHhH1VOS2rZN6/4aypLstAfecJCe/0dHwYOQxReOfbBeAgIk5iOrwuR74dut
         +X4DBNOJOcu+bps5CMA+Pe8icIX0UTJdE6qrDS+z0pGqyDPmelDdMDYCF+W+shvYFEz2
         +t+GGcxWW22TPi20RBvTajOpA6i2HyzmN2CoFtrOaTC+AEVrV96UuSnFBNNR2vZ4oPA9
         tvTUVR2QXobydoifr/ioajA2AEwqlDacsKGHnJ99+Xc2pt1rUF20T9ovZYryNlTnvIle
         bFhww5NrHBPB9J6qMFEIL2hFukX5LzQ0Eb3dIr82CPhEKNvWyrGS2ImGVXcVC+zxdu5Q
         pnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QXKDYwEJ0FxdOMnutv0vajM2YUai+A8MQR7DaSJ50D8=;
        b=mNFqRAuYUcytMwVhhKvGh+W9g1DP4Zif78+1Z8hfvTRgOwt/J4h3qLJpJv9znKRPcn
         O3qf/0XPrvaOgkjMSl8GWJK5/ikZwlJK3H5hHwb8/XInrkge9Wuzs2o7fibb16QRdckm
         rXHOj65u+Pydhewoc/x8axDyhc6pmkF2SESvSaTbu73EV5UpYumK0dC5bo8TQhsiGYF2
         YdeYEsb1FgCes3Ptu9t0iMUcMBNEaf5G8VBsNXovq/6jgWUBCPgjecjSvT5HPpRp7QSL
         OnnjLDKSebapNcqrrVW4HNwFwJ26MtfG8hdA7Z4qWDCVnSJvM2L7T3uct3OzF3EBxSZr
         Ob7A==
X-Gm-Message-State: APjAAAW5pT1KwageJR+G8UifVIBKNjmSJ5OK72pOcJ5Op1ouScug/wws
        jNQVsa4NvQGcTGAr/g+MFsc=
X-Google-Smtp-Source: APXvYqzx47gOz8vXOv1dcSyG2JwaSWwuAN6y+jr/G/nNBvxWFvH/XiVUGGsbruxEO9r6tVblvxUqLg==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr17940779plf.50.1581995605202;
        Mon, 17 Feb 2020 19:13:25 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:180::6f94])
        by smtp.gmail.com with ESMTPSA id b18sm1812595pfd.63.2020.02.17.19.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 19:13:24 -0800 (PST)
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
Subject: [PATCH v3 0/5] aspeed-g6: enable usb support
Date:   Mon, 17 Feb 2020 19:13:10 -0800
Message-Id: <20200218031315.562-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series aims at enabling USB Host and Gadget support on AST2600
platforms.

Patch #1 replaces hardcoded vhub port/endpoint number with device tree
properties, so that it's more convenient to add support for ast2600-vhub
which provides more downstream ports and endpoints.

Patch #2 enables ast2600 support in aspeed-vhub usb gadget driver.

Patch #3 adds USB devices and according pin groups in aspeed-g6 dtsi.

Patch #4 and #5 add vhub port/endpoint properties into aspeed-g4 and
aspeed-g5 dtsi.

Tao Ren (5):
  usb: gadget: aspeed: read vhub properties from device tree
  usb: gadget: aspeed: add ast2600 vhub support
  ARM: dts: aspeed-g6: add usb functions
  ARM: dts: aspeed-g5: add vhub port and endpoint properties
  ARM: dts: aspeed-g4: add vhub port and endpoint properties

 arch/arm/boot/dts/aspeed-g4.dtsi           |  2 +
 arch/arm/boot/dts/aspeed-g5.dtsi           |  2 +
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   | 25 +++++++
 arch/arm/boot/dts/aspeed-g6.dtsi           | 45 ++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c  | 79 +++++++++++++++-------
 drivers/usb/gadget/udc/aspeed-vhub/dev.c   | 30 +++++---
 drivers/usb/gadget/udc/aspeed-vhub/epn.c   |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c   | 26 ++++---
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h  | 23 +++----
 10 files changed, 178 insertions(+), 62 deletions(-)

-- 
2.17.1

