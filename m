Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F9C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83212082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu2HVdgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgBLV52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:57:28 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50911 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgBLV51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:57:27 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so1449921pjb.0;
        Wed, 12 Feb 2020 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fnUhPBKcSJIh4dSE9ZDVA1HmaYlN0KtrojiReV2ykb0=;
        b=cu2HVdgFsneUjNAodwp0mnQFtoeN6mjv2Ze87w4aV7ChgNbJ8jExut24J2vW66PS6T
         koVG7aLqf7ULojlqtp726KnUimqivbcuoUV9NtssprL5ko3YprdPY5xvqnlkTdPaIU/r
         8sM5Sd0Qpm6pjQxOwAl9BQbYkjdRX7X68XoEgg8aDvvtGHrTBoVcR05S8hcmY3wT23FZ
         T4Q3nCX9mPO7fNbwnOSAJqdM8mt/maw+2dkLhWpkNJSgWQaOGZTea+Jlfky6SrNUIQ4k
         1gqChzMwo5bt8sp/VLS/L4gnilV6Mhufl+oV3miS3u82WSBHBCTpb3KSoBpHxOn28S+A
         2UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fnUhPBKcSJIh4dSE9ZDVA1HmaYlN0KtrojiReV2ykb0=;
        b=LUNAjQn7kxW/oM/CWKbvsctCcnlup/2QXdaFm/96dFVK0Tect7Y8q1ShhuctNriuad
         uDYiNKhwlgbybZDkyH2zo6UDr7pinw56KYt8Tpuy4+VC0h0m5XnD8Z1gQAXQhu5hP+3p
         eRfnnVr+e+EmJaaaHLIswDP8caWlaBprkfTD7/VT8mZ3t77oOqtSKdWxlkB2AdmMPXvr
         Pb4WdpPvl4rsXTpAlmtL99QZdf/veaAtoDcrs+23cyD+KVt/4BJ373Be8qra5Os8a/Bv
         WTWdONnZyhZ+FvIb4GldTTbBAe1KMxEZK2gFCIqi7jd9LPH1vJXw2NRhDGcgqrD68GO8
         Npfg==
X-Gm-Message-State: APjAAAXItVH4eh7If3DSdsY8HG9prW7VymCJkvdIo/JTgtKw5xsiLXEw
        Js7AkRB7Fw3u4aqz26j3zpg=
X-Google-Smtp-Source: APXvYqyH1U4B5ayiip+FCyTBRMApO8id3his1NPhWKEoZ9RMaWpVNfNcOs6FCRURmy4EYX2Y/41kVw==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr1313325pjb.10.1581544646327;
        Wed, 12 Feb 2020 13:57:26 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::3:533f])
        by smtp.gmail.com with ESMTPSA id r6sm214431pfh.91.2020.02.12.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:57:25 -0800 (PST)
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
Subject: [PATCH v2 0/5] aspeed-g6: enable usb support
Date:   Wed, 12 Feb 2020 13:57:12 -0800
Message-Id: <20200212215717.9474-1-rentao.bupt@gmail.com>
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

Patch #2 and #3 add vhub port/endpoint properties into aspeed-g4 and
aspeed-g5 dtsi.

Patch #4 enables ast2600 support in aspeed-vhub usb gadget driver.

Patch #5 adds USB devices and according pin groups in aspeed-g6 dtsi.

The patch series is sanity tested on AST2520 (Yamp) BMC and AST2600-A0
eval board:
  - AST2520: created 5 gadget devices with 15 endpoints, and all of them
    can be enumerated from usb-host side.
  - AST2600: created 7 gadget devices with 20 endpoints, and all of them
    can be enumerated from usb-host side.

Tao Ren (5):
  usb: gadget: aspeed: read vhub properties from device tree
  ARM: dts: aspeed-g4: add vhub port and endpoint properties
  ARM: dts: aspeed-g5: add vhub port and endpoint properties
  usb: gadget: aspeed: add ast2600 vhub support
  ARM: dts: aspeed-g6: add usb functions

 arch/arm/boot/dts/aspeed-g4.dtsi           |  2 +
 arch/arm/boot/dts/aspeed-g5.dtsi           |  2 +
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   | 25 ++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi           | 45 ++++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c  | 71 ++++++++++++++--------
 drivers/usb/gadget/udc/aspeed-vhub/dev.c   | 30 ++++++---
 drivers/usb/gadget/udc/aspeed-vhub/epn.c   |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c   | 26 +++++---
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h  | 23 +++----
 10 files changed, 170 insertions(+), 62 deletions(-)

-- 
2.17.1

