Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496EDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA232166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc6n75Ej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgCCGXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:23:50 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55459 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCCGXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:23:49 -0500
Received: by mail-pj1-f68.google.com with SMTP id a18so876895pjs.5;
        Mon, 02 Mar 2020 22:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6UPltCTph8JATwkMOr1U3Yp5FDDP+y4EAKaRm5ThBwE=;
        b=Kc6n75EjJhEh37Mawk55/f0mK1B/wLSfInD/iqmAB9GjGvp7CcQnF4DXEkCoxp55Ig
         KrLPGwAArvdTmZFYkk5iVpqzRLPpS96ZfzN1rSIqHWXCm2y0oNRUzUQJOr5oGEypb3UG
         40jhd6lOd5DEopyFqpQvqkUDCYkvqAW5NuXkzHMDh7DUsZSNrmxIO0U8AFigqmr95pe6
         je8schRmyv8m0fMmf+MclOWJN/Z8DQWTqK+pmtjfX+bYABPd4pIp4A5pXghYZQko9lBv
         54WZidUTxOvI/mGKRMYrTLUt+/tMFWQDQD1O5KCFRxGy586WB9e1v+RDNyfqDZuT9X9X
         EXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6UPltCTph8JATwkMOr1U3Yp5FDDP+y4EAKaRm5ThBwE=;
        b=B3JQpEw6CWK03mdgIIScTgYGa9zNdZSJVoIRpC5VDT3JX8FlH/HeXG4TxPIddWwckN
         bT0jFlAtUBU2DvNS4rGhEdJL9AEKtBDxuOw2v6ixzT04ucycPAkZI0CWF6Ih+BU5YJQu
         P69Ldwf+th6hkDEnWT02NWueZaSuyVFQLCkcY3Ivt/cXCsuw5dRStwzYiVtcILkXlfrg
         vLpnyLx0ooH5h7Q856kNskJ+1dW2FDhMRPxn0NKY4X+wZtXBqR9sU0Cn8EzQcOeFuGJV
         xo5PQs0X5Q/4NCPnLYWECDhN6P6AM3+4VorJDiRDkmj0T7XJ7VU7hNpIhNwMsbzInxlu
         z4vA==
X-Gm-Message-State: ANhLgQ3F3mieBVyXAyV13AwHuaBW/PdD5zHFUigaBdHqfIxO7MsVzMSC
        KQf2OFtQut22i7IYCAYUTa8=
X-Google-Smtp-Source: ADFU+vuvnRBHKecc4wMxbN//ecC5JbcdApulYoDZF/PxrhdgfqOSTO1/rFV2BRvLmaCdLXOUQIXFFQ==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr2783485pls.23.1583216626144;
        Mon, 02 Mar 2020 22:23:46 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id k5sm7453526pfp.66.2020.03.02.22.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 22:23:45 -0800 (PST)
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
Subject: [PATCH v7 0/7] aspeed-g6: enable usb support
Date:   Mon,  2 Mar 2020 22:23:29 -0800
Message-Id: <20200303062336.7361-1-rentao.bupt@gmail.com>
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

 .../bindings/usb/aspeed,usb-vhub.yaml         | 77 +++++++++++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi              |  2 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |  2 +
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi      | 25 ++++++
 arch/arm/boot/dts/aspeed-g6.dtsi              | 45 +++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig    |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c     | 71 ++++++++++-------
 drivers/usb/gadget/udc/aspeed-vhub/dev.c      | 30 ++++++--
 drivers/usb/gadget/udc/aspeed-vhub/epn.c      |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c      | 58 +++++++++-----
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h     | 43 +++++++----
 11 files changed, 290 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml

-- 
2.17.1

