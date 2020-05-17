Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE79C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369E2207E8
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589737717;
	bh=Q5mp8b6C2Vhyekeuu4yeHZX3Zj7dHJRcQuLzeMYZu7U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RDBqcBFYMdwAyMORzq4nX+HBsQi0uQx+bnN8dyFx0XxbIqVFG6tOLP0rCg4rXQJq3
	 T9ON4ULbVuzuTZEQkRvqOZubObEPNSgsTEB0bP4Rd+9UfJtI0Ee/uwoM4Ci+1g8Puu
	 fb2L4ULUWbahcBrmzVnMaHqIAACLFPhK0/YiI5p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgEQRsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 13:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgEQRsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:48:36 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80BF2207E8;
        Sun, 17 May 2020 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589737715;
        bh=Q5mp8b6C2Vhyekeuu4yeHZX3Zj7dHJRcQuLzeMYZu7U=;
        h=From:To:Cc:Subject:Date:From;
        b=Rmi0mj+4K1lqTW5+VbBurce9v/rZOtldzK/3o4ob80LuRVKrz6ydVL+pBWMz6mFVD
         wmrVeTRXZjXgQUD3k/cS4tIsC916C1mmGxX0AICcW3kzWou1J9eOPZy9LB9ZQOPlYl
         P3NZmuPgJ0hQoqpquFmpUIvSpJSHEwq8M1pluc1Q=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.7-rc5
Date:   Sun, 17 May 2020 10:48:34 -0700
Message-Id: <20200517174834.126920-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ca6df49d62d7cc4c1653a4d9b1ecc61ecd530e02:

  clk: sprd: don't gate uart console clock (2020-04-13 12:20:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 852049594b9af58fa2972103699fd58a7ac165c6:

  clk: ti: clkctrl: convert subclocks to use proper names also (2020-05-12 20:18:19 -0700)

----------------------------------------------------------------
Some more clk driver fixes for the merge window and one core framework
fix:

 - A handful of TI driver fixes for bad of_node_put() and incorrect
   parent names
 - Rockchip rk3228 aclk_gpu* creation was interfering with lima GPU work
   so we use a composite clk now
 - Resuming from suspend on Tegra Jetson TK1 was broken because an audio
   PLL calculated an incorrect rate
 - A fix for devicetree probing on IM-PD1 by actually specifying a clk
   name which is required to pass clk registration
 - Avoid list corruption if registration fails for a critical clk

----------------------------------------------------------------
Justin Swartz (1):
      clk: rockchip: fix incorrect configuration of rk3228 aclk_gpu* clocks

Linus Walleij (1):
      clk: impd1: Look up clock-output-names

Marc Zyngier (1):
      clk: Unlink clock if failed to prepare or enable

Stephen Boyd (1):
      Merge tag 'v5.7-rockchip-clk-fixes1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-fixes

Tero Kristo (3):
      clk: ti: clkctrl: Fix Bad of_node_put within clkctrl_get_name
      clk: ti: am33xx: fix RTC clock parent
      clk: ti: clkctrl: convert subclocks to use proper names also

Thierry Reding (1):
      clk: tegra: Fix initial rate for pll_a on Tegra124

 drivers/clk/clk.c                 |  3 ++
 drivers/clk/rockchip/clk-rk3228.c | 17 ++-----
 drivers/clk/tegra/clk-tegra124.c  |  2 +-
 drivers/clk/ti/clk-33xx.c         |  2 +-
 drivers/clk/ti/clkctrl.c          | 99 +++++++++++++++++++--------------------
 drivers/clk/versatile/clk-impd1.c |  1 +
 6 files changed, 58 insertions(+), 66 deletions(-)

-- 
Sent by a computer, using git, on the internet
