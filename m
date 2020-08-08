Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294A7C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013092053B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930237;
	bh=sF5VfJy25+hafkXHOrfSJKp4kxFC0hlEVXFCa6eqSVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GY8R2vlJbbN8VCD9nIPxk+7aCJH7npniLVp74vs8YmwFb6xEPUYAeA5VsdgzJmzjz
	 HuJqU+K28FL0AsClUhq31YczsW2uC6XxAocgzUSLvcsO8nseeP/OvVgaOuM0F9NBIr
	 Oox5wMbWazF/xdvKCpYfbZGXh7pwX4rI4WUPprIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgHHXjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgHHXjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:39:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65FB720748;
        Sat,  8 Aug 2020 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929960;
        bh=sF5VfJy25+hafkXHOrfSJKp4kxFC0hlEVXFCa6eqSVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRu+0oBlPJ8FyMs0uxmnSQzMleSAtGYwM8N1t8GhnzfMGReY51h3g84TFu5oEHIIW
         Qa5VOhso+ZSHbWxxmuq0O28NnD05szq54u7eiwmGwZCf25HCeWmIiRsSVYMWa3GjUQ
         BqpFFsX7z7vz7uCWTdYsKivAhbPFMvfnssSTkJqw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     yu kuai <yukuai3@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 23/40] ARM: at91: pm: add missing put_device() call in at91_pm_sram_init()
Date:   Sat,  8 Aug 2020 19:38:27 -0400
Message-Id: <20200808233844.3618823-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233844.3618823-1-sashal@kernel.org>
References: <20200808233844.3618823-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 52665f30d236d..6bc3000deb86e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -592,13 +592,13 @@ static void __init at91_pm_sram_init(void)
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
@@ -606,12 +606,17 @@ static void __init at91_pm_sram_init(void)
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

