Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83E9C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B32620771
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgCYMGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbgCYMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nR-0000kG-Hp; Wed, 25 Mar 2020 13:06:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F0831C0470;
        Wed, 25 Mar 2020 13:06:04 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:03 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] arm64: hibernate: Use bringup_hibernate_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-9-qais.yousef@arm.com>
References: <20200323135110.30522-9-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796384.28353.5008410976523485603.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     e646ac5bb88d9480eeb3b0d31d2e3eed056c2638
Gitweb:        https://git.kernel.org/tip/e646ac5bb88d9480eeb3b0d31d2e3eed056c2638
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:51:01 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:34 +01:00

arm64: hibernate: Use bringup_hibernate_cpu()

Use bringup_hibernate_cpu() instead of open coding it.

[ tglx: Split out the core change ]

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200323135110.30522-9-qais.yousef@arm.com

---
 arch/arm64/kernel/hibernate.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 590963c..5b73e92 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -166,14 +166,11 @@ int arch_hibernation_header_restore(void *addr)
 		sleep_cpu = -EINVAL;
 		return -EINVAL;
 	}
-	if (!cpu_online(sleep_cpu)) {
-		pr_info("Hibernated on a CPU that is offline! Bringing CPU up.\n");
-		ret = cpu_up(sleep_cpu);
-		if (ret) {
-			pr_err("Failed to bring hibernate-CPU up!\n");
-			sleep_cpu = -EINVAL;
-			return ret;
-		}
+
+	ret = bringup_hibernate_cpu(sleep_cpu);
+	if (ret) {
+		sleep_cpu = -EINVAL;
+		return ret;
 	}
 
 	resume_hdr = *hdr;
