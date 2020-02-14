Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31620C3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C572082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696193;
	bh=LNZd425aiv0ZyvHJC6f+H2IvIXnySvmj0POmQMGzmiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DRvoQNzHDqgX+um/3wIN8RgSrnIfAHmeSzd9ZgMApaJK9PC2Sm3e0kSp8eeBbb8Vd
	 AhVxtDZooHyev6yhTkBC9JQJxwyegVGXf9LrPYDjn3BanYXP66zi1NEkab7jQze3Y+
	 WO5gK7tytFVTGey3lSZxHYZHidBQUbLJeFW65w4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbgBNQDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:03:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389072AbgBNQCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:02:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B980C2082F;
        Fri, 14 Feb 2020 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696168;
        bh=LNZd425aiv0ZyvHJC6f+H2IvIXnySvmj0POmQMGzmiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoodqutW6eXjNbsQaLHNyAxXySEy1Qlkcpud5eKmCtrt4eQRa4ZxEQPiT80q4cgxB
         y7x2GTh3TW+i0i6P1fn3NXS/itG2KdLeyCGI+hVnoC5ngV+pcPz0luJ/dN/W4zK5nk
         V2RZETq8c3UoxGnVJ+N1h8ozf8XX2HRFB88+jLOQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 043/459] clk: meson: meson8b: make the CCF use the glitch-free mali mux
Date:   Fri, 14 Feb 2020 10:54:53 -0500
Message-Id: <20200214160149.11681-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 8daeaea99caabe24a0929fac17977ebfb882fa86 ]

The "mali_0" or "mali_1" clock trees should not be updated while the
clock is running. Enforce this by setting CLK_SET_RATE_GATE on the
"mali_0" and "mali_1" gates. This makes the CCF switch to the "mali_1"
tree when "mali_0" is currently active and vice versa, which is exactly
what the vendor driver does when updating the frequency of the mali
clock.

This fixes a potential hang when changing the GPU frequency at runtime.

Fixes: 74e1f2521f16ff ("clk: meson: meson8b: add the GPU clock tree")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson8b.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 67e6691e080c1..8856ce476ccfa 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1764,8 +1764,11 @@ static struct clk_regmap meson8b_hdmi_sys = {
 
 /*
  * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
- * muxed by a glitch-free switch on Meson8b and Meson8m2. Meson8 only
- * has mali_0 and no glitch-free mux.
+ * muxed by a glitch-free switch on Meson8b and Meson8m2. The CCF can
+ * actually manage this glitch-free mux because it does top-to-bottom
+ * updates the each clock tree and switches to the "inactive" one when
+ * CLK_SET_RATE_GATE is set.
+ * Meson8 only has mali_0 and no glitch-free mux.
  */
 static const struct clk_hw *meson8b_mali_0_1_parent_hws[] = {
 	&meson8b_xtal.hw,
@@ -1830,7 +1833,7 @@ static struct clk_regmap meson8b_mali_0 = {
 			&meson8b_mali_0_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1885,7 +1888,7 @@ static struct clk_regmap meson8b_mali_1 = {
 			&meson8b_mali_1_div.hw
 		},
 		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
 	},
 };
 
-- 
2.20.1

