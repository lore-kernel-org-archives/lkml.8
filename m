Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55F2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1328206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oEydEtGu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fDlGQij2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHSMdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:33:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgHSMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:14 -0400
Date:   Wed, 19 Aug 2020 12:33:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3u3kLp4sAK5g6kqOKqttRQub8cj8+jsysGqclBHbZ14=;
        b=oEydEtGuJ+4hmvtngmlwjmoqrdrkgHUZLrMzdGA20lOcYv56NcN/mwieSZVMkTT7ub7ZJ0
        KBgGkwcBCQAyP3jiAO/CaWS+Jet0gXJ2iRoRQ7Yl7E/J75sqkbalkNj7Mn7hvwJVvcA1FT
        ekKryLS790nWWO9AzM5qsX6UB8VHb7MuYY9be2D8SiwAcklRVI3Om9do5+JAI6zpjdQwWI
        bPvmSAo1uXKcgcyHv9ldC0/mds04dnrAY3VREh9oyAfwx33nxi2hbr5ALQcyPdA9jNWWNO
        LjqW69CtJ/EHprqGWVutMrYW7VjX+gUuBLzNnFGTcKRAVk6qk/GLquQDhU5New==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3u3kLp4sAK5g6kqOKqttRQub8cj8+jsysGqclBHbZ14=;
        b=fDlGQij27xnrzZgpeSXFMJRMLUdUK8SEPFKKxj4KDstIgBfrKQKofuDfP62IPKwCWq38G1
        x/Vin/3yVNs/jqCA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add struct rdt_membw::arch_needs_linear
 to explain AMD/Intel MBA difference
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-8-james.morse@arm.com>
References: <20200708163929.2783-8-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784038975.3192.16283518251900554647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     41215b7947f1b1b86fd77a7bebd2320599aea7bd
Gitweb:        https://git.kernel.org/tip/41215b7947f1b1b86fd77a7bebd2320599aea7bd
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:26 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Aug 2020 09:34:51 +02:00

x86/resctrl: Add struct rdt_membw::arch_needs_linear to explain AMD/Intel MBA difference

The configuration values user-space provides to the resctrl filesystem
are ABI. To make this work on another architecture, all the ABI bits
should be moved out of /arch/x86 and under /fs.

To do this, the differences between AMD and Intel CPUs needs to be
explained to resctrl via resource properties, instead of function
pointers that let the arch code accept subtly different values on
different platforms/architectures.

For MBA, Intel CPUs reject configuration attempts for non-linear
resources, whereas AMD ignore this field as its MBA resource is never
linear. To merge the parse/validate functions, this difference needs to
be explained.

Add struct rdt_membw::arch_needs_linear to indicate the arch code needs
the linear property to be true to configure this resource. AMD can set
this and delay_linear to false. Intel can set arch_needs_linear to
true to keep the existing "No support for non-linear MB domains" error
message for affected platforms.

 [ bp: convert "we" etc to passive voice. ]

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-8-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 3 +++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 8 +++++++-
 arch/x86/kernel/cpu/resctrl/internal.h    | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 9225ee5..52b8991 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -260,6 +260,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	r->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
+	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
 		r->membw.delay_linear = true;
 		r->membw.min_bw = MAX_MBA_BW - max_delay;
@@ -267,6 +268,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	} else {
 		if (!rdt_get_mb_table(r))
 			return false;
+		r->membw.arch_needs_linear = false;
 	}
 	r->data_width = 3;
 
@@ -288,6 +290,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
+	r->membw.arch_needs_linear = false;
 
 	r->membw.min_bw = 0;
 	r->membw.bw_gran = 1;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 934c8fb..e3bcd77 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -33,6 +33,12 @@ static bool bw_validate_amd(char *buf, unsigned long *data,
 	unsigned long bw;
 	int ret;
 
+	/* temporary: always false on AMD */
+	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
+		rdt_last_cmd_puts("No support for non-linear MB domains\n");
+		return false;
+	}
+
 	ret = kstrtoul(buf, 10, &bw);
 	if (ret) {
 		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
@@ -82,7 +88,7 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
 	 */
-	if (!r->membw.delay_linear) {
+	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
 		rdt_last_cmd_puts("No support for non-linear MB domains\n");
 		return false;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1eb39bd..7b00723 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -372,6 +372,7 @@ struct rdt_cache {
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
  * @delay_linear:	True if memory B/W delay is in linear scale
+ * @arch_needs_linear:	True if we can't configure non-linear resources
  * @mba_sc:		True if MBA software controller(mba_sc) is enabled
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
  */
@@ -379,6 +380,7 @@ struct rdt_membw {
 	u32		min_bw;
 	u32		bw_gran;
 	u32		delay_linear;
+	bool		arch_needs_linear;
 	bool		mba_sc;
 	u32		*mb_map;
 };
