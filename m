Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F5BC2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E258220578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="SKA3KGVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgC3TsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:48:13 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:38670 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbgC3TsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:48:12 -0400
Received: from localhost.localdomain (80-110-124-168.cgn.dynamic.surfer.at [80.110.124.168])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 7ECCFC44BD;
        Mon, 30 Mar 2020 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1585597690; bh=DfZj97sVXnjdGhg+aqdNjmaXNiEPy6qoTuB6Y4+lNOA=;
        h=From:To:Cc:Subject:Date;
        b=SKA3KGVW6oWyeCHj8W6mTXUeipfKD4f4BiKkm+LGClyDnWLnXreAelFQNdNnEr6y8
         XB4P8NPKeGsHZfIX1RUHHu3tQTLwtcU8SY0hjp3TCPhx35vH4SD7nitAnClHmvcLFE
         ZZcm30xLZ0a62hMjC9OCOOv/XdEr9kWTg644s2Vs=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-leds@vger.kernel.org
Cc:     Dan Murphy <dmurphy@ti.com>, Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 0/2] Add sgm3140 flash led driver
Date:   Mon, 30 Mar 2020 21:47:55 +0200
Message-Id: <20200330194757.2645388-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a driver for the SGMICRO SGM3140 charge pump
used in the PinePhone smartphone.

Luca Weiss (2):
  dt-bindings: leds: Add binding for sgm3140
  leds: add sgm3140 driver

 .../bindings/leds/leds-sgm3140.yaml           |  61 ++++
 drivers/leds/Kconfig                          |   9 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-sgm3140.c                   | 317 ++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
 create mode 100644 drivers/leds/leds-sgm3140.c

-- 
2.26.0

