Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68721C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340382073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgCDCH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:07:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727854AbgCDCH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:07:29 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF4DE6D5BE884F4ED440;
        Wed,  4 Mar 2020 10:07:26 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Mar 2020
 10:07:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tytso@mit.edu>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, yuehaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] random: Fix unused function warning
Date:   Wed, 4 Mar 2020 10:07:15 +0800
Message-ID: <20200304020715.2352-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuehaibing <yuehaibing@huawei.com>

drivers/char/random.c:820:13: warning:
 crng_initialize_secondary defined but not used [-Wunused-function]

crng_initialize_secondary now only used in do_numa_crng_init,
which wrapped by CONFIG_NUMA, so move it to fix the warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: yuehaibing <yuehaibing@huawei.com>
---
 drivers/char/random.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index f43f65c..3646ad7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -817,14 +817,6 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
 	return arch_init;
 }
 
-static void crng_initialize_secondary(struct crng_state *crng)
-{
-	memcpy(&crng->state[0], "expand 32-byte k", 16);
-	_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
-	crng_init_try_arch(crng);
-	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
-}
-
 static void __init crng_initialize_primary(struct crng_state *crng)
 {
 	memcpy(&crng->state[0], "expand 32-byte k", 16);
@@ -839,6 +831,14 @@ static void __init crng_initialize_primary(struct crng_state *crng)
 }
 
 #ifdef CONFIG_NUMA
+static void crng_initialize_secondary(struct crng_state *crng)
+{
+	memcpy(&crng->state[0], "expand 32-byte k", 16);
+	_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
+	crng_init_try_arch(crng);
+	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
+}
+
 static void do_numa_crng_init(struct work_struct *work)
 {
 	int i;
-- 
2.7.4


