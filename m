Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A516DC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8413E2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgAQIOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:14:08 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:33044 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgAQIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:14:08 -0500
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id F072E8BF33;
        Fri, 17 Jan 2020 16:14:00 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P20995T139699247118080S1579248839183075_;
        Fri, 17 Jan 2020 16:14:00 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5ec44f345caa1a6dbf50f637c1b15412>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: linus.walleij@linaro.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de, david.wu@rock-chips.com,
        kever.yang@rock-chips.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com
Subject: [PATCH 0/2] pinctrl: rockchip: codingstyle for pinctrl-rockchip
Date:   Fri, 17 Jan 2020 16:13:56 +0800
Message-Id: <20200117081358.5772-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c4ec95a7-aaf1-2331-352f-2def319a1c7d@rock-chips.com>
References: <c4ec95a7-aaf1-2331-352f-2def319a1c7d@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do codingstyle for pinctrl-rockchip by spliting driver by SoC types.

Convenienty for reviewing, the first patch only moving
pinctrl-rockchip.c from driver/pinctrl to driver/pinctrl/rockchip/ .

Jianqun Xu (2):
  pinctrl: rockchip: new rockchip dir for pinctrl-rockchip
  pinctrl: rockchip: split rockchip pinctrl driver by SoC type

 drivers/pinctrl/Kconfig                     |    7 -
 drivers/pinctrl/pinctrl-rockchip.c          | 4254 -------------------
 drivers/pinctrl/rockchip/Kconfig            |  126 +
 drivers/pinctrl/rockchip/Makefile           |   16 +
 drivers/pinctrl/rockchip/pinctrl-px30.c     |  224 +
 drivers/pinctrl/rockchip/pinctrl-rk2928.c   |   70 +
 drivers/pinctrl/rockchip/pinctrl-rk3036.c   |   69 +
 drivers/pinctrl/rockchip/pinctrl-rk3066a.c  |   72 +
 drivers/pinctrl/rockchip/pinctrl-rk3066b.c  |   51 +
 drivers/pinctrl/rockchip/pinctrl-rk3128.c   |  161 +
 drivers/pinctrl/rockchip/pinctrl-rk3188.c   |  147 +
 drivers/pinctrl/rockchip/pinctrl-rk3228.c   |  225 +
 drivers/pinctrl/rockchip/pinctrl-rk3288.c   |  210 +
 drivers/pinctrl/rockchip/pinctrl-rk3308.c   |  420 ++
 drivers/pinctrl/rockchip/pinctrl-rk3328.c   |  272 ++
 drivers/pinctrl/rockchip/pinctrl-rk3368.c   |  125 +
 drivers/pinctrl/rockchip/pinctrl-rk3399.c   |  195 +
 drivers/pinctrl/rockchip/pinctrl-rockchip.c | 2063 +++++++++
 drivers/pinctrl/rockchip/pinctrl-rockchip.h |  388 ++
 drivers/pinctrl/rockchip/pinctrl-rv1108.c   |  214 +
 20 files changed, 5048 insertions(+), 4261 deletions(-)
 delete mode 100644 drivers/pinctrl/pinctrl-rockchip.c
 create mode 100644 drivers/pinctrl/rockchip/Kconfig
 create mode 100644 drivers/pinctrl/rockchip/Makefile
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-px30.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk2928.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3036.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3066a.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3066b.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3128.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3188.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3228.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3288.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3308.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3328.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3368.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3399.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rockchip.c
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rockchip.h
 create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1108.c

-- 
2.17.1



