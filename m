Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF9EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C0E62075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ESh/+xyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgH1Pwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgH1Pwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:52:31 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC0C061264;
        Fri, 28 Aug 2020 08:52:30 -0700 (PDT)
Received: from allenwind.lan (unknown [IPv6:2a02:169:3df5::4db])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 447C45C95F7;
        Fri, 28 Aug 2020 17:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1598629942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=o6gJHPgz29HyNEp7tVvUTXqsiIrqG4vlD8Mvx37LylM=;
        b=ESh/+xyDYVvJ0e5ntEQbTNpgABcwit7kFnkvpxvH/HXkMmBvKoqsGEMhpd3SetmXSR8hhR
        YB8LxM6gBrlXsQZuPOgXBUBdWYH2M+lzZLHEs/TJykZT9bb+i4ak69GCTxmKryt2N3Q3Ny
        0khkg0/Jv+TIk7HtSOQtsweLLPLHa1A=
From:   Stefan Agner <stefan@agner.ch>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stefan@agner.ch, Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v2] clk: meson: g12a: mark fclk_div2 as critical
Date:   Fri, 28 Aug 2020 17:52:05 +0200
Message-Id: <577e0129e8ee93972d92f13187ff4e4286182f67.1598629915.git.stefan@agner.ch>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
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

Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Tested-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/clk/meson/g12a.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index fad616cac01e..6d44cadc06af 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -298,6 +298,17 @@ static struct clk_regmap g12a_fclk_div2 = {
 			&g12a_fclk_div2_div.hw
 		},
 		.num_parents = 1,
+		/*
+		 * Similar to fclk_div3, it seems that this clock is used by
+		 * the resident firmware and is required by the platform to
+		 * operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) Mark the clock used by a firmware resource, if possible
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.28.0

