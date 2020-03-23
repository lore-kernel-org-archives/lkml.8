Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21887C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032172072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgCWNvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:51:32 -0400
Received: from foss.arm.com ([217.140.110.172]:49492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbgCWNvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:51:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EA171063;
        Mon, 23 Mar 2020 06:51:31 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44E783F52E;
        Mon, 23 Mar 2020 06:51:30 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 04/17] arm: Don't use disable_nonboot_cpus()
Date:   Mon, 23 Mar 2020 13:50:57 +0000
Message-Id: <20200323135110.30522-5-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323135110.30522-1-qais.yousef@arm.com>
References: <20200323135110.30522-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

disable_nonboot_cpus() is not safe to use when doing machine_down(),
because it relies on freeze_secondary_cpus() which in turn is
a suspend/resume related freeze and could abort if the logic detects any
pending activities that can prevent finishing the offlining process.

Beside disable_nonboot_cpus() is dependent on CONFIG_PM_SLEEP_SMP which
is an othogonal config to rely on to ensure this function works
correctly.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Russell King <linux@armlinux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/arm/kernel/reboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index bb18ed0539f4..58ad1a70f770 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -88,11 +88,11 @@ void soft_restart(unsigned long addr)
  * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
  * kexec'd kernel to use any and all RAM as it sees fit, without having to
  * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
- * functionality embodied in disable_nonboot_cpus() to achieve this.
+ * functionality embodied in smp_shutdown_nonboot_cpus() to achieve this.
  */
 void machine_shutdown(void)
 {
-	disable_nonboot_cpus();
+	smp_shutdown_nonboot_cpus(0);
 }
 
 /*
-- 
2.17.1

