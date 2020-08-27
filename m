Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B8C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D482075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="S+DqJmoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgH0Vn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Vnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:43:55 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0363C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:43:55 -0700 (PDT)
Received: from allenwind.lan (unknown [IPv6:2a02:169:3df5::4db])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 450AF5C246D;
        Thu, 27 Aug 2020 23:43:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1598564628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=9JtOjhabbWIc8Ze4vQoeOAqSEJ2W24d6AiC6SaHT6FY=;
        b=S+DqJmoUOw7rynz3V6Z/5czgjniVBUNcFlPi9jafL5jRjc2WRXzbdRaf4SkRnbtDE3c14f
        YRqnqepPP0QVd3V3FnftbWaYEtkh412UyU4ikzbs6nWz98e4sPV715EabbDRfuiLyXCJa5
        8E+2iIb5yGAfJ5wpwwgVzsearP2GpF8=
From:   Stefan Agner <stefan@agner.ch>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefan@agner.ch
Subject: [PATCH] clk: meson: g12a: mark fclk_div2 as critical
Date:   Thu, 27 Aug 2020 23:43:44 +0200
Message-Id: <c33df0ebe8be16b56741ce7f873221ab9087a0a6.1598564619.git.stefan@agner.ch>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Amlogic Meson G12b platform, similar to fclk_div3, the fclk_div2
seems to be necessary for the system to operate correctly as well.

Typically, the clock also gets chosen by the eMMC peripheral. This
probably masked the problem so far. However, when booting from a SD
card the clock seems to get disabled which leads to a system freeze.

Let's mark this clock as critical, fixing boot from SD card on G12b
platforms.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/meson/g12a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index fad616cac01e..2214b974f748 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -298,6 +298,7 @@ static struct clk_regmap g12a_fclk_div2 = {
 			&g12a_fclk_div2_div.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.28.0

