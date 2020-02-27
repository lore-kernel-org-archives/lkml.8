Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3746C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811F32072D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgB0HMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:12:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727336AbgB0HMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:12:02 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9B7E8BFD2EB74ED299E8;
        Thu, 27 Feb 2020 15:11:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 15:11:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ralf@linux-mips.org>, <paulburton@kernel.org>,
        <tglx@linutronix.de>, <sboyd@kernel.org>,
        <geert+renesas@glider.be>, <f4bug@amsat.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] MIPS: pic32mzda: Drop pointless static qualifier
Date:   Thu, 27 Feb 2020 07:05:02 +0000
Message-ID: <20200227070502.106762-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to have the 'struct device_node *node' variable static
since new value always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/mips/pic32/pic32mzda/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pic32/pic32mzda/time.c b/arch/mips/pic32/pic32mzda/time.c
index 754924f26089..7174e9abbb1b 100644
--- a/arch/mips/pic32/pic32mzda/time.c
+++ b/arch/mips/pic32/pic32mzda/time.c
@@ -23,7 +23,7 @@ static const struct of_device_id pic32_infra_match[] = {
 
 static unsigned int pic32_xlate_core_timer_irq(void)
 {
-	static struct device_node *node;
+	struct device_node *node;
 	unsigned int irq;
 
 	node = of_find_matching_node(NULL, pic32_infra_match);



