Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5E1C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7057E24655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="QHSn0XjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBSBKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:10:01 -0500
Received: from vps.xff.cz ([195.181.215.36]:54202 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgBSBKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582074599; bh=Aeuv5iYbaAp7rr6i5ZST/n1JdcOfY/hR+2BNrgy8C+E=;
        h=From:To:Cc:Subject:Date:From;
        b=QHSn0XjACs3lffkvnSFb2Pb78S1/c0rmc4BVbXsaxeakyWxv3Mh/uhDOckugdgAqZ
         FcC8PID+c6c6kZWMrj4KvwtCzGJHnr4igAaFwpP17DnZYrxwk+t60tjSDIqWrlF0aD
         UjWgeF7tQbJzZPcmQflTg7yTojktxGRiFa4KFSkY=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] bus: sunxi-rsb: Return correct data when mixing 16-bit and 8-bit reads
Date:   Wed, 19 Feb 2020 02:09:50 +0100
Message-Id: <20200219010951.395599-1-megous@megous.com>
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
---
 drivers/bus/sunxi-rsb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index b8043b58568ac..8ab6a3865f569 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -316,6 +316,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 {
 	u32 cmd;
 	int ret;
+	u32 mask;
 
 	if (!buf)
 		return -EINVAL;
@@ -323,12 +324,15 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 	switch (len) {
 	case 1:
 		cmd = RSB_CMD_RD8;
+		mask = 0xffu;
 		break;
 	case 2:
 		cmd = RSB_CMD_RD16;
+		mask = 0xffffu;
 		break;
 	case 4:
 		cmd = RSB_CMD_RD32;
+		mask = 0xffffffffu;
 		break;
 	default:
 		dev_err(rsb->dev, "Invalid access width: %zd\n", len);
@@ -345,7 +349,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 	if (ret)
 		goto unlock;
 
-	*buf = readl(rsb->regs + RSB_DATA);
+	*buf = readl(rsb->regs + RSB_DATA) & mask;
 
 unlock:
 	mutex_unlock(&rsb->lock);
-- 
2.25.1

