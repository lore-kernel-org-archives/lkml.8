Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5324C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D36B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgBLKIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:08:43 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:49806 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgBLKIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:08:41 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id 1m8Y2200H5USYZQ01m8YUq; Wed, 12 Feb 2020 11:08:39 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1owa-0001EO-IO; Wed, 12 Feb 2020 11:08:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1owa-0000LV-FB; Wed, 12 Feb 2020 11:08:32 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Heiko Stuebner <heiko@sntech.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/7] ARM: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Wed, 12 Feb 2020 11:08:23 +0100
Message-Id: <20200212100830.446-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

The OF clock helpers were moved to <linux/of_clk.h> a while ago.
Hence code that is not a clock provider, but just needs to call
of_clk_init(), can (and should) include <linux/of_clk.h> instead of
<linux/clk-provider.h>.

All these patches are independent of each others, and thus can be
applied by the corresponding subsystem maintainers.

Thanks!

Geert Uytterhoeven (7):
  ARM/time: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  ARM: mediatek: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  ARM: mmp: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  ARM: rockchip: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  ARM: shmobile: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  ARM: sunxi: Replace <linux/clk-provider.h> by <linux/of_clk.h>
  ARM: zynq: Replace <linux/clk-provider.h> by <linux/of_clk.h>

 arch/arm/kernel/time.c                   | 2 +-
 arch/arm/mach-mediatek/mediatek.c        | 2 +-
 arch/arm/mach-mmp/mmp-dt.c               | 2 +-
 arch/arm/mach-mmp/mmp2-dt.c              | 2 +-
 arch/arm/mach-rockchip/rockchip.c        | 2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 2 +-
 arch/arm/mach-sunxi/sunxi.c              | 2 +-
 arch/arm/mach-zynq/common.c              | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
