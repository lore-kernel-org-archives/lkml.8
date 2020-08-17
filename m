Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B7C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD4A2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684338;
	bh=MJeMwiKIiOMJJoOrCOa3NqWzh8bgWO+X7vMq+16jUAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yFDoP/FrNFiL9JhX0RTjFHdW3dKZcx38AWN4LcQ2i4zipSi0JtY4Ca5RVO+YzgBf6
	 XKJwdhSkV3+1+yRwYW7m1pbLm/X1ZnANt+fj9+TQ2s8E5K+2FRMlujDyi/2hRv7Mgd
	 BEePurfaFDxZ6etOpRIB20+OPcH8r+Cg75EU+AHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbgHQRMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388639AbgHQQLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:11:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8296222B3F;
        Mon, 17 Aug 2020 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680703;
        bh=MJeMwiKIiOMJJoOrCOa3NqWzh8bgWO+X7vMq+16jUAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6nVw2YLgRQKoHyRXANNsMbPdM4zebeIlK4uhbONtp07lImw2LbGXZQyT3D1CPVmB
         nFDEra13Fd5H9qGEuz/MiBNepXPt4A8x81ELPGbbE+6Qcrp6oiG+6fZjzqF/HX25SD
         12Yf0xjSQow+xoafwK/xw/biItZfCtCGtS7Wldzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yu kuai <yukuai3@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/168] ARM: at91: pm: add missing put_device() call in at91_pm_sram_init()
Date:   Mon, 17 Aug 2020 17:15:53 +0200
Message-Id: <20200817143734.833263110@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yu kuai <yukuai3@huawei.com>

[ Upstream commit f87a4f022c44e5b87e842a9f3e644fba87e8385f ]

if of_find_device_by_node() succeed, at91_pm_sram_init() doesn't have
a corresponding put_device(). Thus add a jump target to fix the exception
handling for this function implementation.

Fixes: d2e467905596 ("ARM: at91: pm: use the mmio-sram pool to access SRAM")
Signed-off-by: yu kuai <yukuai3@huawei.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20200604123301.3905837-1-yukuai3@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-at91/pm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index e2e4df3d11e53..21bfe9b6e16a1 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -542,13 +542,13 @@ static void __init at91_pm_sram_init(void)
 	sram_pool = gen_pool_get(&pdev->dev, NULL);
 	if (!sram_pool) {
 		pr_warn("%s: sram pool unavailable!\n", __func__);
-		return;
+		goto out_put_device;
 	}
 
 	sram_base = gen_pool_alloc(sram_pool, at91_pm_suspend_in_sram_sz);
 	if (!sram_base) {
 		pr_warn("%s: unable to alloc sram!\n", __func__);
-		return;
+		goto out_put_device;
 	}
 
 	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
@@ -556,12 +556,17 @@ static void __init at91_pm_sram_init(void)
 					at91_pm_suspend_in_sram_sz, false);
 	if (!at91_suspend_sram_fn) {
 		pr_warn("SRAM: Could not map\n");
-		return;
+		goto out_put_device;
 	}
 
 	/* Copy the pm suspend handler to SRAM */
 	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
 			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
+	return;
+
+out_put_device:
+	put_device(&pdev->dev);
+	return;
 }
 
 static bool __init at91_is_pm_mode_active(int pm_mode)
-- 
2.25.1



