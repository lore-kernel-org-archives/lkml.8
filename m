Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4EAC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BBC20CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbgDAPff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:35:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59624 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbgDAPff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:35:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: myjosserand)
        with ESMTPSA id 7831A283D19
From:   =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>
To:     heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, mylene.josserand@collabora.com,
        kernel@collabora.com, kever.yang@rock-chips.com,
        geert@linux-m68k.org
Subject: [PATCH v2 0/2] ARM: Add Rockchip rk3288w support
Date:   Wed,  1 Apr 2020 17:35:11 +0200
Message-Id: <20200401153513.423683-1-mylene.josserand@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Here is my V2 of my patches that add the support for the Rockchip
RK3288w which is a revision of the RK3288. It is mostly the same SOC
except for, at least, one clock tree which is different.
This difference is only known by looking at the BSP kernel [1].

Currently, the mainline kernel will not hang on rk3288w but it is
probably by "chance" because we got an issue on a lower kernel version.

According to Rockchip's U-Boot [2], the rk3288w can be detected using
the HDMI revision number (= 0x1A) in this version of the SOC.
Not to rely on U-Boot about the compatible, the patch 01 will handle
the detection of the HDMI version.

In this V2, the revision's detection is done using soc_device
registration. Thanks to that, in case of other differences than the clock
tree, it will be possible to detect rk3288/rk3288w using the 'soc_device_match'
function.
The main issue was an ordering issue: my rk3288 driver was
registered too late to be able to act on the clock tree. This is fixed
by using an initcall in the clock driver. One possible way would be to
convert the clock driver into platform_driver but, as it is using
some common functions to all Rockchip's drivers, it would have been
necessary to update all others. Instead, using an initcall to post-pone
hclkvio clock's registration is enough to make everything work correctly
without a big change on the clock driver.

Changes since v1:
   - As suggested by Geert, update the HDMI detection by using all
   'soc_device' functions
   - Use 'soc_device_match' function to detect the revision in the
   clock driver
   - Create a function that registers hclkvio clocks later than others
   to be sure that RK3288 revision is read.

Best regards,
Mylène Josserand

[1] https://github.com/rockchip-linux/kernel/blob/develop-4.4/drivers/clk/rockchip/clk-rk3288.c#L960..L964
[2] https://github.com/rockchip-linux/u-boot/blob/next-dev/arch/arm/mach-rockchip/rk3288/rk3288.c#L378..L388

Mylène Josserand (2):
  soc: rockchip: Register a soc_device to retrieve revision
  clk: rockchip: rk3288: Handle clock tree for rk3288w

 drivers/clk/rockchip/clk-rk3288.c |  36 ++++++++-
 drivers/soc/rockchip/Makefile     |   1 +
 drivers/soc/rockchip/rk3288.c     | 125 ++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/rockchip/rk3288.c

-- 
2.25.1

