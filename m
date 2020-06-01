Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE493C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69052074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgFANNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFANLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:11:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9157DC061A0E;
        Mon,  1 Jun 2020 06:11:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfkEC-00075v-Us; Mon, 01 Jun 2020 15:11:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 89FF01C0244;
        Mon,  1 Jun 2020 15:11:44 +0200 (CEST)
Date:   Mon, 01 Jun 2020 13:11:44 -0000
From:   "tip-bot2 for Dejin Zheng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] drivers/clocksource/arm_arch_timer: Remove
 duplicate error message
Cc:     Dejin Zheng <zhengdejin5@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429153559.21189-1-zhengdejin5@gmail.com>
References: <20200429153559.21189-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Message-ID: <159101710442.17951.7304564845428445332.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d1b5e55208fd8e1c73876ab6ad1ce93485e3f5a2
Gitweb:        https://git.kernel.org/tip/d1b5e55208fd8e1c73876ab6ad1ce93485e3f5a2
Author:        Dejin Zheng <zhengdejin5@gmail.com>
AuthorDate:    Wed, 29 Apr 2020 23:35:59 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 22 May 2020 23:58:56 +02:00

drivers/clocksource/arm_arch_timer: Remove duplicate error message

The function acpi_gtdt_init() prints a message in case of
error. Remove the error message after testing if the function fails,
otherwise it is a duplicate message.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200429153559.21189-1-zhengdejin5@gmail.com
---
 drivers/clocksource/arm_arch_timer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d53f4c7..befe54a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1577,10 +1577,8 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
 
 	ret = acpi_gtdt_init(table, &platform_timer_count);
-	if (ret) {
-		pr_err("Failed to init GTDT table.\n");
+	if (ret)
 		return ret;
-	}
 
 	arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI] =
 		acpi_gtdt_map_ppi(ARCH_TIMER_PHYS_NONSECURE_PPI);
