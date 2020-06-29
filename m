Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2ABC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69D920768
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593464857;
	bh=/yquSOXHUSX0WMYJM8Ct5M6u/+o+EQ73rUrDH7s2lWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0/BjMp/jOorcWURWHRstSpNRHE3T1hjcJwCaXc8jPcKimJRlRRlralVBoRWTeNcRA
	 wlXjMwtoo1kPPOHFveTlgvNfNx5Ir3ja7fWLoK+813I/mn58Kyjc73yNKTo3Cr+0w/
	 e3iqNOP8kbWSmcX2xlWHLQAv6ZbX5fMjGPq/HiNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390372AbgF2VHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbgF2TKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2042825498;
        Mon, 29 Jun 2020 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445993;
        bh=/yquSOXHUSX0WMYJM8Ct5M6u/+o+EQ73rUrDH7s2lWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faea7LZl5wzlVkOWAWdf7ZdZ6WeVZ0wmx7zW3877yxnOXviit4u+fbUgBICc5ix5a
         Y7mNAficGIXp3kbsetz2MCrYuHqtcgk6E9apulhfeQYRILfwW5ZawevQDYek8VGlB6
         8xDOrj3ZjU58O9utfMStEushL+FZ8cM63kQHG7yw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 002/135] clk: sunxi: Fix incorrect usage of round_down()
Date:   Mon, 29 Jun 2020 11:50:56 -0400
Message-Id: <20200629155309.2495516-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rikard Falkeborn <rikard.falkeborn@gmail.com>

[ Upstream commit ee25d9742dabed3fd18158b518f846abeb70f319 ]

round_down() can only round to powers of 2. If round_down() is asked
to round to something that is not a power of 2, incorrect results are
produced. The incorrect results can be both too large and too small.

Instead, use rounddown() which can round to any number.

Fixes: 6a721db180a2 ("clk: sunxi: Add A31 clocks support")
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 9c79af0c03b21..2cec9e83831fd 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -311,7 +311,7 @@ static void sun6i_a31_get_pll1_factors(u32 *freq, u32 parent_rate,
 	 * Round down the frequency to the closest multiple of either
 	 * 6 or 16
 	 */
-	u32 round_freq_6 = round_down(freq_mhz, 6);
+	u32 round_freq_6 = rounddown(freq_mhz, 6);
 	u32 round_freq_16 = round_down(freq_mhz, 16);
 
 	if (round_freq_6 > round_freq_16)
-- 
2.25.1

