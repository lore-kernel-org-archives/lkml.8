Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD08720768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217792;
	bh=xCCyQH1bUvTAbMsd/r4PqNmTcZ9TF90HvmyWc/+6wI4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0OFUlfNfeyaWmZFKkKU1/I5WqqaxeuzLU1M/4CJ/U0a6eyqBKsF92/bw6aYcF337f
	 ocjWLLJV+85uQ+YG7h4W0/kQAGvO8UgQ4seZvOcYWEUwIQlqOSX0IQGCg4iUxxRCQv
	 zmTQioPemgWOoQvet4eAWsZ+bg56s8+AYUkcNPqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDGADL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgDGADH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:03:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E9720842;
        Tue,  7 Apr 2020 00:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217786;
        bh=xCCyQH1bUvTAbMsd/r4PqNmTcZ9TF90HvmyWc/+6wI4=;
        h=From:To:Cc:Subject:Date:From;
        b=XOvL/Z/RxOOeE+fZBUzO2ngPuydxlxGyVvOqwz06OZ9gRQMZh75o4VHuugdVVzZzG
         Ft8pkRkzKYJDa4Y/VXnm6oq5pnFSXa/77WGchuGax9wkTCpzBJh8krtIEHqWmLAJmR
         5mzhoPpAaKeIP+w8jGjMEmfyxgwrYdS3QfudR4RA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Jirman <megous@megous.com>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 1/5] bus: sunxi-rsb: Return correct data when mixing 16-bit and 8-bit reads
Date:   Mon,  6 Apr 2020 20:03:00 -0400
Message-Id: <20200407000304.17360-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

[ Upstream commit a43ab30dcd4a1abcdd0d2461bf1cf7c0817f6cd3 ]

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
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/sunxi-rsb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 2051d926e3037..4f3d988210b0a 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -345,7 +345,7 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
 	if (ret)
 		goto unlock;
 
-	*buf = readl(rsb->regs + RSB_DATA);
+	*buf = readl(rsb->regs + RSB_DATA) & GENMASK(len * 8 - 1, 0);
 
 unlock:
 	mutex_unlock(&rsb->lock);
-- 
2.20.1

