Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81840C35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B34D2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ABTKps/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgBUU1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:27:35 -0500
Received: from vps.xff.cz ([195.181.215.36]:50506 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgBUU1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582316852; bh=RT7hM71ofWAX5CWLAn+N0ibzSMqxRV062cMgGpFPdEY=;
        h=From:To:Cc:Subject:Date:From;
        b=ABTKps/fZEowbJ4P6ipUZh7IvHdAL18b1qHi7B9xvjA4dew8ntVZu250Lsyfvr7Um
         F3VIve3NlowLIq2TDPW1LS3K1cRKaNc/Enw9SsV0fHDml+4XAAWJfjNeZt5xx18L2b
         ElDeR1wr1KktD7WUMc+b3zv4HMZnPUzs6MIS5Z0s=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] bus: sunxi-rsb: Return correct data when mixing 16-bit and 8-bit reads
Date:   Fri, 21 Feb 2020 21:27:26 +0100
Message-Id: <20200221202728.1583768-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing a 16-bit read that returns data in the MSB byte, the
RSB_DATA register will keep the MSB byte unchanged when doing
the following 8-bit read. sunxi_rsb_read() will then return
a result that contains high byte from 16-bit read mixed with
the 8-bit result.

The consequence is that after this happens the PMIC's regmap will
look like this: (0x33 is the high byte from the 16-bit read)

% cat /sys/kernel/debug/regmap/sunxi-rsb-3a3/registers
00: 33
01: 33
02: 33
03: 33
04: 33
05: 33
06: 33
07: 33
08: 33
09: 33
0a: 33
0b: 33
0c: 33
0d: 33
0e: 33
[snip]

Fix this by masking the result of the read with the correct mask
based on the size of the read. There are no 16-bit users in the
mainline kernel, so this doesn't need to get into the stable tree.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bus/sunxi-rsb.c | 1 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index b8043b58568ac..8ab6a3865f569 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -345,7 +349,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 	if (ret)
 		goto unlock;
 
-	*buf = readl(rsb->regs + RSB_DATA);
+	*buf = readl(rsb->regs + RSB_DATA) & GENMASK(len * 8 - 1, 0);
 
 unlock:
 	mutex_unlock(&rsb->lock);
-- 
2.25.1

