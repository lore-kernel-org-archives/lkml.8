Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F4BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500732173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QhUCUpWm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3LJkmTo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHFXkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:40:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgHFXit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:49 -0400
Date:   Thu, 06 Aug 2020 23:38:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbU1C4X0lV1GN1HcFt4QXmWuuCwiwsFzKG3FgR70TE4=;
        b=QhUCUpWmK/l7cpdUOGzDeTKeql+ZZuK17qZHhSemGVYfOcwWZpN04t/IqYbcaDECG3FAyO
        RQ0vk7NcK8zBK6hDpBA6FnhLyue6tsQLYQlh536Jda7x8l8qMGbQgSa2L1QHJzjxEEf6L0
        iCvFFIM0RB5vYohvNJZHcYmRoIhf1WEQqQmFIJXrED/qfSzD0M8LtCBIL8MBdXOHgIAedN
        RiqFUYJlxgWzCqmr+Iyy1anJjgHBo0RXxu/BHn983/GIDxldQLBpHusMPTYMuvIzb7xD90
        FJIlrCqoR+vUjCx8ydWIbjmdldRQuqxJElt3tfVmlQe8oYZoxZ4eTZR4K7O9Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbU1C4X0lV1GN1HcFt4QXmWuuCwiwsFzKG3FgR70TE4=;
        b=3LJkmTo2IPV1YI8ga4aI9BkHsxPC36FlLEVXIrByH79VYvAHnpucbnGHcQ1Cp1Bq+xwGeV
        VI+lMvvEmwpNvOBg==
From:   "tip-bot2 for Shuo Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/acrn: Remove redundant chars from ACRN signature
Cc:     Shuo Liu <shuo.a.liu@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806114111.9448-1-shuo.a.liu@intel.com>
References: <20200806114111.9448-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Message-ID: <159675712671.3192.9044142725285189361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4c7bfa383efd837d4ab8f86ef05886959ed8bfe5
Gitweb:        https://git.kernel.org/tip/4c7bfa383efd837d4ab8f86ef05886959ed8bfe5
Author:        Shuo Liu <shuo.a.liu@intel.com>
AuthorDate:    Thu, 06 Aug 2020 19:41:11 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 07 Aug 2020 01:32:00 +02:00

x86/acrn: Remove redundant chars from ACRN signature

hypervisor_cpuid_base() only handles 12 chars of the hypervisor
signature string but is provided with 14 chars.

Remove the redundancy. Additionally, replace the user space uint32_t
with preferred kernel type u32.

Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20200806114111.9448-1-shuo.a.liu@intel.com
---
 arch/x86/kernel/cpu/acrn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 3b08cdf..0b2c039 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -17,9 +17,9 @@
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 
-static uint32_t __init acrn_detect(void)
+static u32 __init acrn_detect(void)
 {
-	return hypervisor_cpuid_base("ACRNACRNACRN\0\0", 0);
+	return hypervisor_cpuid_base("ACRNACRNACRN", 0);
 }
 
 static void __init acrn_init_platform(void)
