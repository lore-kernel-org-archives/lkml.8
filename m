Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674ACC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF0220CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DatComwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgAaWWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:22:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44509 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAaWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:22:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so4218885pgl.11;
        Fri, 31 Jan 2020 14:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/HFcoQMFwoF5gwXFjCOgMWeMPSstLjSDHZ4Dum+BpLY=;
        b=DatComwmXGtiPYRomdkOy0XFknlTGW4jw8cqnPXUs3c1PayQQ01hJkqNdNRCG8/3as
         pZ/HWMofmFNsf38uGdGoFb3KtxSkVedmPKnu1jwNA2VWD0/4lpfh7rRv7HJc7BHC4AJa
         O02dRGqtmspUgZGqsDhaanNF5EdARykMjcLg8SgyQktv9O3aCgdAdKUh2t+uFNq/6oBb
         9tKZ9w8vkAtdC8LszUYhH4MUge04bpiWX+0BGuCp8I892FKG/uCFih4C0Sz3kVIhKEqk
         IM6KyEzpAP0RXQ1QsP0P5JnzqdRzaJdfvyMe4Y6yG5V9RDGEL7j/Dw0JyZdCWhnGly0V
         pSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/HFcoQMFwoF5gwXFjCOgMWeMPSstLjSDHZ4Dum+BpLY=;
        b=rMaHTIZKmrRTJ+Z4TuawucBLdRtbxzHaUI4oLWn45kGp6bwxcIqkQJh9Xbc40NPFCK
         RVyYIWoZozaiMl3YDSex7mjhcS16tBtA68yC23Jq0gZFtiRJqpccVBgH5zhl/1ADO/u6
         DYhfFu2TVCTdunlsQHkeV1Yy8jpQsbP84+Q2EmiSRYiFy7Igb7hjvv/wm5TR5P20vk9J
         bylwZiOjnu7WvQTqNE5/JFjbRYWtIYnFV1fQEdANDAoFngYyAFt3y94siud5e31X+d26
         QaMFGDBBSLXpgXA9cPo7DC+hgOJksdDmbEzZtckK/PNsoYXrdkg5wqMnsoO/vcMzm83E
         IC9Q==
X-Gm-Message-State: APjAAAWKmuXW2jpQNhY+qrnvwYGlZ17bnul31l9GHQZs+6MQjOW3Zmnl
        Y0g2kJsns65HVuQst4zd/Ss=
X-Google-Smtp-Source: APXvYqx7oLNYYYIoBn05Sgk8HxhcExQrlyg5hCf0aIq/sj8/mwAJ8Vjgu7X4e0+MgzPbAFocAsrZ6Q==
X-Received: by 2002:a62:ddd0:: with SMTP id w199mr12425962pff.1.1580509327790;
        Fri, 31 Jan 2020 14:22:07 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:200::1:a521])
        by smtp.gmail.com with ESMTPSA id v8sm11201515pff.151.2020.01.31.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:22:07 -0800 (PST)
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
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/3] aspeed-g6: enable usb support
Date:   Fri, 31 Jan 2020 14:21:54 -0800
Message-Id: <20200131222157.20849-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

The patch series aims at enabling USB Host and Gadget support on AST2600
platforms.

Patch #1 moves hardcoded vhub attributes (number of downstream ports and
endpoints) to "struct ast_hub_config" which is then attached to "struct
of_device_id". By doing this, it will be easier to enable ast2600 vhub
which supports more ports and endpoints.

Patch #2 enables AST2600 support in aspeed-vhub gadget driver.

Patch #3 adds USB devices and according pin groups in aspeed-g6 dtsi.

Tao Ren (3):
  usb: gadget: aspeed: read vhub config from of_device_id
  usb: gadget: aspeed: add ast2600 vhub support
  ARM: dts: aspeed-g6: add usb functions

 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   |  25 +++++
 arch/arm/boot/dts/aspeed-g6.dtsi           |  43 ++++++++
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig |   4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c  | 109 ++++++++++++++-------
 drivers/usb/gadget/udc/aspeed-vhub/dev.c   |  30 ++++--
 drivers/usb/gadget/udc/aspeed-vhub/epn.c   |   4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c   |  26 +++--
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h  |  23 ++---
 8 files changed, 191 insertions(+), 73 deletions(-)

-- 
2.17.1

