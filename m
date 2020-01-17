Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C42C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC5A2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579227068;
	bh=3j/tmEtX3KnIVwbhu+H1PKNumOZCZVONmbc3cZ1Z2Is=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zaE3gC/1JoVbNj9jfhuAcQDwVvEe+92cJXzjdbXjwnemGPSbgUrian79zmABPv39a
	 RBiZknfYoGg2sxgO0ZBoxaUUMnG9IW2oz26HsmjL5O/OKdG7NPMcv1mCq0QFHU+Z/P
	 7mE+fYRgT/IcBXu0VAskSytr343auAByeEc8HYto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbgAQCLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 21:11:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgAQCLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:11:06 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E95D2072E;
        Fri, 17 Jan 2020 02:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579227066;
        bh=3j/tmEtX3KnIVwbhu+H1PKNumOZCZVONmbc3cZ1Z2Is=;
        h=From:To:Cc:Subject:Date:From;
        b=pO+cUWye6vjB0MfywsTTR7zjulP8iMtAApu0Cxqagkh5++uCof34JlINA9xVkCEAT
         qik2GlHWjn53YxB4A/zuY4ZPTZvW5wunOxoYo1PNU3ROFrqlzgWMbNzbQKtdLiowNo
         Rz54vX3h9NKSY5YC/ozdwPqRdJq9pXtJQuImH/0k=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.5-rc6
Date:   Thu, 16 Jan 2020 18:11:05 -0800
Message-Id: <20200117021105.253415-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 781d8cea68ac41d11a80df2a5f5babd584f86447:

  clk: qcom: Avoid SMMU/cx gdsc corner cases (2019-12-18 22:02:27 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to a0af2742473425322cc24c79dc4033d74aaf3d81:

  Merge tag 'sunxi-clk-fixes-for-5.5' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes (2020-01-13 09:55:41 -0800)

----------------------------------------------------------------
Second collection of clk fixes for the next release. This one includes a
fix for PM on TI SoCs with sysc devices and fixes a bunch of clks that
are stuck always enabled on Qualcomm SDM845 SoCs. Allwinner SoCs get the
usual set of fixes too, mostly correcting drivers to have the right bits
that match the hardware. There's also a Samsung and Tegra fix in here
to mark a clk critical and avoid a double free. And finally there's a
fix for critical clks that silences a big warning splat about trying
to enable a clk that couldn't even be prepared.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      clk: sunxi-ng: r40: Allow setting parent rate for external clock outputs

Dmitry Osipenko (1):
      clk: tegra: Fix double-free in tegra_clk_init()

Georgi Djakov (1):
      clk: qcom: gcc-sdm845: Add missing flag to votable GDSCs

Guenter Roeck (1):
      clk: Don't try to enable critical clocks if prepare failed

Marek Szyprowski (1):
      clk: samsung: exynos5420: Keep top G3D clocks enabled

Peter Ujfalusi (1):
      clk: ti: dra7-atl: Remove pm_runtime_irq_safe()

Samuel Holland (3):
      clk: sunxi-ng: sun8i-r: Fix divider on APB0 clock
      clk: sunxi-ng: h6-r: Simplify R_APB1 clock definition
      clk: sunxi-ng: h6-r: Fix AR100/R_APB2 parent order

Stephen Boyd (1):
      Merge tag 'sunxi-clk-fixes-for-5.5' of https://git.kernel.org/.../sunxi/linux into clk-fixes

Yunhao Tian (1):
      clk: sunxi-ng: v3s: Fix incorrect number of hw_clks.

 drivers/clk/clk.c                      | 10 ++++++++--
 drivers/clk/qcom/gcc-sdm845.c          |  7 +++++++
 drivers/clk/samsung/clk-exynos5420.c   |  8 ++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 16 +++-------------
 drivers/clk/sunxi-ng/ccu-sun8i-r.c     | 21 +++------------------
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c   |  6 ++++--
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c   |  4 ++--
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.h   |  2 --
 drivers/clk/tegra/clk.c                |  4 +++-
 drivers/clk/ti/clk-dra7-atl.c          |  1 -
 10 files changed, 38 insertions(+), 41 deletions(-)

-- 
Sent by a computer, using git, on the internet
