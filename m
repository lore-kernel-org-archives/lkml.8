Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DEDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EA4221EB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443176;
	bh=kCjSyXO6zz3ZUcp39RHJO7Kc3CAczW6G8wj8OXTDw7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E5nMiTG+zuDZ2yBWP0JLbusQfOF1XdTwHA9M7QA4tVfuaXB47edaKnzgeTRCQ9jKB
	 yTMRKBVVB99nZodDfsBFl6CjeVx7sgM06fMd31/o2Yq2WtFEKDE7J46wfH+shB6RKY
	 ClgWHugcS7kjWu0fbR4Nc7rY8rLzF+tWsdXbRClA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgFRBTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgFRBQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:16:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E955B21D79;
        Thu, 18 Jun 2020 01:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442994;
        bh=kCjSyXO6zz3ZUcp39RHJO7Kc3CAczW6G8wj8OXTDw7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pfzm2EiJhiNrUFsB0mLO+NQRo/eNHQz7j4Hd+x7xmyeN70Siv/9VEs/QEWm2uBBBA
         KuV3vnit8GsCPFyGVQBunwSHVhIFVLgegrWvg1cWCCgVdtyzsaLaxSu4gpOSrSvTGD
         kA77t05vH8eKlRDmqo2wqtrJIQN1EuYLfSvNH9hE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 002/266] clk: sunxi: Fix incorrect usage of round_down()
Date:   Wed, 17 Jun 2020 21:12:07 -0400
Message-Id: <20200618011631.604574-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
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
index 27201fd26e44..e1aa1fbac48a 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -90,7 +90,7 @@ static void sun6i_a31_get_pll1_factors(struct factors_request *req)
 	 * Round down the frequency to the closest multiple of either
 	 * 6 or 16
 	 */
-	u32 round_freq_6 = round_down(freq_mhz, 6);
+	u32 round_freq_6 = rounddown(freq_mhz, 6);
 	u32 round_freq_16 = round_down(freq_mhz, 16);
 
 	if (round_freq_6 > round_freq_16)
-- 
2.25.1

