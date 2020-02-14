Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D8C3B1A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7EC222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695519;
	bh=xzcDHUr0AgOeeRhMZggU0VLWyxXQOHzz4fX3m50JerA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6NfIPq2udMBtE6wjfPVwBDnGd9HIHhJc3oL9dwHaH2eOcRhob/8kx8v/vfJOIix7
	 qR7T1M3YtET5DAFIWmnyT1JZZMsahPqDkehCKAQjVEnq/GXaLqWcivwMsDziTKMsB+
	 upwtRUD67qaPTWYN5PGcPgBM29T2iYuRqVCqwP0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgBNPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:51:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730847AbgBNPvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 108A224686;
        Fri, 14 Feb 2020 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695504;
        bh=xzcDHUr0AgOeeRhMZggU0VLWyxXQOHzz4fX3m50JerA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j80lsGFn8D5uyG60r7xR9LEQlxbqB9ZGC6+GIv+cU9dneXVOnFkyXpyvFrTDaNQd8
         TQ+ICBRNyDJESXVv3vYSDXdOxzYH3Ss3GpMSxxzz+SerkzpG2QG/JjF/ygYCgbznPW
         4xyWcDycFNfiS7ELqGfjOAqYnUOf1LUijfnYVGlk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 130/542] clk: qcom: rcg2: Don't crash if our parent can't be found; return an error
Date:   Fri, 14 Feb 2020 10:42:02 -0500
Message-Id: <20200214154854.6746-130-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 908b050114d8fefdddc57ec9fbc213c3690e7f5f ]

When I got my clock parenting slightly wrong I ended up with a crash
that looked like this:

  Unable to handle kernel NULL pointer dereference at virtual
  address 0000000000000000
  ...
  pc : clk_hw_get_rate+0x14/0x44
  ...
  Call trace:
   clk_hw_get_rate+0x14/0x44
   _freq_tbl_determine_rate+0x94/0xfc
   clk_rcg2_determine_rate+0x2c/0x38
   clk_core_determine_round_nolock+0x4c/0x88
   clk_core_round_rate_nolock+0x6c/0xa8
   clk_core_round_rate_nolock+0x9c/0xa8
   clk_core_set_rate_nolock+0x70/0x180
   clk_set_rate+0x3c/0x6c
   of_clk_set_defaults+0x254/0x360
   platform_drv_probe+0x28/0xb0
   really_probe+0x120/0x2dc
   driver_probe_device+0x64/0xfc
   device_driver_attach+0x4c/0x6c
   __driver_attach+0xac/0xc0
   bus_for_each_dev+0x84/0xcc
   driver_attach+0x2c/0x38
   bus_add_driver+0xfc/0x1d0
   driver_register+0x64/0xf8
   __platform_driver_register+0x4c/0x58
   msm_drm_register+0x5c/0x60
   ...

It turned out that clk_hw_get_parent_by_index() was returning NULL and
we weren't checking.  Let's check it so that we don't crash.

Fixes: ac269395cdd8 ("clk: qcom: Convert to clk_hw based provider APIs")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Link: https://lkml.kernel.org/r/20200203103049.v4.1.I7487325fe8e701a68a07d3be8a6a4b571eca9cfa@changeid
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/clk-rcg2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 5e0f7d8f168dd..cecdb07ce13ba 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -217,6 +217,9 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
 
 	clk_flags = clk_hw_get_flags(hw);
 	p = clk_hw_get_parent_by_index(hw, index);
+	if (!p)
+		return -EINVAL;
+
 	if (clk_flags & CLK_SET_RATE_PARENT) {
 		rate = f->freq;
 		if (f->pre_div) {
-- 
2.20.1

