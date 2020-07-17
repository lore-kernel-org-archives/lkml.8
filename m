Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD2C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360802070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGQBtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:49:20 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:38798 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGQBtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:49:19 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id B5E5CCA8A3;
        Fri, 17 Jul 2020 09:49:12 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P17843T139819799787264S1594950550837667_;
        Fri, 17 Jul 2020 09:49:12 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7adf7b4f5507eeb3cdc7f0c4ffd94f42>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     heiko@sntech.de, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kever.yang@rock-chips.com,
        david.wu@rock-chips.com, Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 00/13] pinctrl: rockchip: prepare work for split driver
Date:   Fri, 17 Jul 2020 09:48:55 +0800
Message-Id: <20200717014908.13914-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serial patchs include 12 codingstyle patches and 1 bug fix (enable
gpio pclk for rockchip_gpio_to_irq).

Also it's prepare for split driver work.

Jianqun Xu (13):
  pinctrl: rockchip: add nr_pins to rockchip_pin_ctrl
  pinctrl: rockchip: modify rockchip_pin_ctrl to const struct
  pinctrl: rockchip: make driver be tristate module
  pinctrl: rockchip: enable gpio pclk for rockchip_gpio_to_irq
  pinctrl: rockchip: create irq mapping in gpio_to_irq
  pinctrl: rockchip: do codingstyle
  pinctrl: rockchip: do codingstyle
  pinctrl: rockchip: do codingstyle
  pinctrl: rockchip: do codingstyle
  pinctrl: rockchip: do codingstyle
  pinctrl: rockchip: do codingstyle
  pinctrl: rockchip: define common codes without special chip name
  pinctrl: rockchip: do codingstyle by adding mux route definitions

 drivers/pinctrl/Kconfig            |   2 +-
 drivers/pinctrl/pinctrl-rockchip.c | 933 ++++++++---------------------
 2 files changed, 261 insertions(+), 674 deletions(-)

-- 
2.17.1



