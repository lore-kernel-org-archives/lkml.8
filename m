Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56368C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36748206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGZT2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:28:15 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33859 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGZT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:28:15 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8B183E0004;
        Sun, 26 Jul 2020 19:28:10 +0000 (UTC)
Date:   Sun, 26 Jul 2020 21:28:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: <soc.lore.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: defconfig for 5.9
Message-ID: <20200726192810.GA181818@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here are a few sama5 defconfig changes, mainly adding DSA support for
the switch on an evaluation board.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-defconfig-5.9

for you to fetch changes up to c12b539787efff5b4fc5abac1debf3ea1901348e:

  ARM: configs: at91: sama5: enable CAN PLATFORM driver (2020-07-25 00:13:20 +0200)

----------------------------------------------------------------
AT91 defconfig for 5.9

 - Add ClassD, KSZ ethernet switches, brdige, vlan to sama5_defconfig
 - Reenable CAN support in sama5_defconfig

----------------------------------------------------------------
Codrin Ciubotariu (1):
      ARM: configs: at91: sama5: Enable CLASSD

Cristian Birsan (1):
      ARM: configs: at91: sama5: enable CAN PLATFORM driver

Razvan Stefanescu (2):
      ARM: configs: at91: sama5: add support for KSZ ethernet switches
      ARM: configs: at91: sama5: enable bridge and VLAN filtering

 arch/arm/configs/sama5_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
