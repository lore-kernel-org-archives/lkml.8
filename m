Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B125FC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE582224E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052203;
	bh=hFO4jLIKH+x5/7ssSNwRO2Wq0ZVgFPUvQpXBS26CSuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rBtNBcSs6l1qWtb+GkfGF0A8fu1jrQx83lFSJmbHSAllVod5CvuQIj/9GfGCrGAwJ
	 4IoQHR7OWxNzYDbUZWaFNRWSr94F8fiXQROi1Vv0GLp+juDK1KJMnvg1LRWlq/0Wul
	 wZzPtftRtIKuYvpiYlBsR3zI9mXzjx6f7c5PLg9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442627AbgDPPuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896636AbgDPNc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:32:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1A822275;
        Thu, 16 Apr 2020 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043949;
        bh=hFO4jLIKH+x5/7ssSNwRO2Wq0ZVgFPUvQpXBS26CSuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvYxr1G0XTSspFH+amOvHCbJXrRE/Xvl/k/GQYZRmxfvXClyZJFGaT2fUtknyws4c
         zAzFP3A4HC2k1H/4qdZN9Ioj6HZkvKbumkYd9etou6gX9lk1Z12gDub7ugmcgeoPHz
         V/bMzdq8Qd0Cdfg2POQWoj5WdUlrcPRwjHksF44s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 002/257] bus: sunxi-rsb: Return correct data when mixing 16-bit and 8-bit reads
Date:   Thu, 16 Apr 2020 15:20:53 +0200
Message-Id: <20200416131326.195454037@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index be79d6c6a4e45..1bb00a959c67f 100644
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



