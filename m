Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E42C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD372078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgFKJLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:11:43 -0400
Received: from 8bytes.org ([81.169.241.247]:47084 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgFKJLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:11:43 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C9944936; Thu, 11 Jun 2020 11:11:40 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Richard Henderson <rth@twiddle.net>
Cc:     Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] alpha: Fix build around srm_sysrq_reboot_op
Date:   Thu, 11 Jun 2020 11:11:39 +0200
Message-Id: <20200611091139.8525-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The patch introducing the struct was probably never compile tested,
because it sets a handler with a wrong function signature. Wrap the
handler into a functions with the correct signature to fix the build.

Fixes: 0f1c9688a194 ("tty/sysrq: alpha: export and use __sysrq_get_key_op()")
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/alpha/kernel/setup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index f5c42a8fcf9c..53520f8cb904 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -430,8 +430,13 @@ register_cpus(void)
 arch_initcall(register_cpus);
 
 #ifdef CONFIG_MAGIC_SYSRQ
+static void sysrq_reboot_handler(int unused)
+{
+	machine_halt();
+}
+
 static const struct sysrq_key_op srm_sysrq_reboot_op = {
-	.handler	= machine_halt,
+	.handler	= sysrq_reboot_handler,
 	.help_msg       = "reboot(b)",
 	.action_msg     = "Resetting",
 	.enable_mask    = SYSRQ_ENABLE_BOOT,
-- 
2.26.2

