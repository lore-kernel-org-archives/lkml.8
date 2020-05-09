Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DFDC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FA520CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEIIcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:32:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbgEIIb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:31:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A473988AA014325E9833;
        Sat,  9 May 2020 16:31:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 16:31:48 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <linux@armlinux.org.uk>, <gregkh@linuxfoundation.org>
CC:     <alexios.zavras@intel.com>, <tglx@linutronix.de>,
        <allison@lohutok.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH -next] arch/arm: use scnprintf() in l2x0_pmu_event_show()
Date:   Sat, 9 May 2020 16:35:39 +0800
Message-ID: <20200509083539.113156-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snprintf() returns the number of bytes that would be written,
which may be greater than the the actual length to be written.

show() methods should return the number of bytes printed into the
buffer. This is the return value of scnprintf().

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm/mm/cache-l2x0-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
index 993fefdc167a..d20626451a2e 100644
--- a/arch/arm/mm/cache-l2x0-pmu.c
+++ b/arch/arm/mm/cache-l2x0-pmu.c
@@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
 	struct l2x0_event_attribute *lattr;
 
 	lattr = container_of(attr, typeof(*lattr), attr);
-	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
+	return scnprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
 }
 
 static umode_t l2x0_pmu_event_attr_is_visible(struct kobject *kobj,
-- 
2.20.1

