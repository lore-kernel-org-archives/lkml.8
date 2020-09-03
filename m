Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD57C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15CE206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgICGb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:31:56 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:59458 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgICGbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:31:55 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 8CC1ECC002;
        Thu,  3 Sep 2020 14:31:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22906T140609134245632S1599114708716326_;
        Thu, 03 Sep 2020 14:31:50 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ea862483c901b5fde843d05124612d17>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 0/6] clk: rockchip: Support module build
Date:   Thu,  3 Sep 2020 14:31:41 +0800
Message-Id: <20200903063147.10237-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export some APIs for module drivers.
Fix the clock config to support module build.
Fix the clk driver init, add module author, description
and license to support building RK3399 SoC clock driver as module.

Change in V2:
[PATCH v2 1/6]: remove "clk",and check "hw" isn't an error value.
[PATCH v2 6/6]: store a function pointer in the match data.

Elaine Zhang (6):
  clk: rockchip: Use clk_hw_register_composite instead of
    clk_register_composite calls
  clk: rockchip: Export rockchip_clk_register_ddrclk()
  clk: rockchip: Export rockchip_register_softrst()
  clk: rockchip: Export some clock common APIs for module drivers
  clk: rockchip: fix the clk config to support module build
  clk: rockchip: rk3399: Support module build

 drivers/clk/Kconfig                     |   1 +
 drivers/clk/rockchip/Kconfig            |  78 +++++++++++++++++
 drivers/clk/rockchip/Makefile           |  42 ++++-----
 drivers/clk/rockchip/clk-ddr.c          |   1 +
 drivers/clk/rockchip/clk-half-divider.c |  18 ++--
 drivers/clk/rockchip/clk-rk3399.c       |  55 ++++++++++++
 drivers/clk/rockchip/clk.c              | 110 +++++++++++++-----------
 drivers/clk/rockchip/softrst.c          |   7 +-
 8 files changed, 229 insertions(+), 83 deletions(-)
 create mode 100644 drivers/clk/rockchip/Kconfig

-- 
2.17.1



