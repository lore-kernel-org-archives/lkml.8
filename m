Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC128C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B0F206B5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930544;
	bh=x2EdT82fe7GeAYl9x+JFtiof54LVZjz/+2qJUuXzK6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yFN7xIwvcZkAjwO7/ZZiquDxQZcEtCU2e/RU+9MleLPZ8Zp4/51o2awfFd1P/JHDZ
	 TinxGO++XEVorxAUIEiFPBzH8xMQ70yLaqs1eSzhWCo0eDpyaKIM/RnSqkEJnJ1hKW
	 PD0GnbbOGF/MdwjvSkt2DbRYRqee6L9pbmvMkiJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgHHXs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgHHXhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:37:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A609520825;
        Sat,  8 Aug 2020 23:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929834;
        bh=x2EdT82fe7GeAYl9x+JFtiof54LVZjz/+2qJUuXzK6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POxEnQl47KqTB1BryCZ85LRpRWdQJxmBWk1o0pfJTVJH/OS3iKbqTr4cEwUNGoUFp
         1q3oQPGN8QUfUNPMCUVcRHp1kvaWZ9yz10d8ywlL0l29bmPSYX+OsIsnvcni2+JTWA
         Rqkv/i9NFijamnHngsrcZFJykvF71xcfSkUjC2Z8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 65/72] irqchip/irq-bcm7038-l1: Guard uses of cpu_logical_map
Date:   Sat,  8 Aug 2020 19:35:34 -0400
Message-Id: <20200808233542.3617339-65-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 9808357ff2e5bfe1e0dcafef5e78cc5b617a7078 ]

cpu_logical_map is only defined for CONFIG_SMP builds, when we are in an
UP configuration, the boot CPU is 0.

Fixes: 6468fc18b006 ("irqchip/irq-bcm7038-l1: Add PM support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200724184157.29150-1-f.fainelli@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-bcm7038-l1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index fd7c537fb42ac..4127eeab10af1 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -327,7 +327,11 @@ static int bcm7038_l1_suspend(void)
 	u32 val;
 
 	/* Wakeup interrupt should only come from the boot cpu */
+#ifdef CONFIG_SMP
 	boot_cpu = cpu_logical_map(0);
+#else
+	boot_cpu = 0;
+#endif
 
 	list_for_each_entry(intc, &bcm7038_l1_intcs_list, list) {
 		for (word = 0; word < intc->n_words; word++) {
@@ -347,7 +351,11 @@ static void bcm7038_l1_resume(void)
 	struct bcm7038_l1_chip *intc;
 	int boot_cpu, word;
 
+#ifdef CONFIG_SMP
 	boot_cpu = cpu_logical_map(0);
+#else
+	boot_cpu = 0;
+#endif
 
 	list_for_each_entry(intc, &bcm7038_l1_intcs_list, list) {
 		for (word = 0; word < intc->n_words; word++) {
-- 
2.25.1

