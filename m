Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF98C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923D3206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kcZN+0zY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PN3AjjWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgHSMe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgHSMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:33:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD8C061383;
        Wed, 19 Aug 2020 05:33:17 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:33:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597840389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HnM0Cp/Yczm9dS+IPIhZH2yi01rE2zx6EwV3mXSdOM=;
        b=kcZN+0zYuAh4iSOGzi2/GYVq5kwyJxwpAPrIazI3h+naT7XhUa1SCvxbHD9i6URcD39Kpn
        GEdHYeDb3tDbUTKiYasRsAghgFAx85xBPwIW6QSAPzxRU6/rHUlPPI3qo4BYIkMlG8mC8+
        EoaP6tFMl7SHTz3TFfdnqlbHtG+i0It7jNWhMU7aoXIjW5RljuWDcVj537IqY2lTa0DQzc
        2LYsAgt0j+ciyHAmPwpaMPD3Tr+5KYqORc2SizOlFEs5BKp1P2odgFXQ+yfPyD7+JYmvMK
        LOIawUx5Y1pnOJ3IrQsXr4U817W7SIU697thSLSJxl56nltc5N+OKJWeoAPQcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597840389;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HnM0Cp/Yczm9dS+IPIhZH2yi01rE2zx6EwV3mXSdOM=;
        b=PN3AjjWy0PXqiytZ4Qi4pfZG72Pd10LR24n9+TdRTByMT/hWU6Kg7d4t7du2Q4js7/r3g2
        4NsByEGcqjC3QzAA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Merge AMD/Intel parse_bw() calls
Cc:     Babu Moger <babu.moger@amd.com>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200708163929.2783-9-james.morse@arm.com>
References: <20200708163929.2783-9-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <159784038909.3192.1172396415139935224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     5df3ca9334d5603e4afbb95953d0affb37dcf86b
Gitweb:        https://git.kernel.org/tip/5df3ca9334d5603e4afbb95953d0affb37dcf86b
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 08 Jul 2020 16:39:27 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Aug 2020 09:38:57 +02:00

x86/resctrl: Merge AMD/Intel parse_bw() calls

Now after arch_needs_linear has been added, the parse_bw() calls are
almost the same between AMD and Intel.

The difference is '!is_mba_sc()', which is not checked on AMD. This
will always be true on AMD CPUs as mba_sc cannot be enabled as
is_mba_linear() is false.

Removing this duplication means user-space visible behaviour and
error messages are not validated or generated in different places.

Reviewed-by : Babu Moger <babu.moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20200708163929.2783-9-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c        |  3 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 57 +----------------------
 arch/x86/kernel/cpu/resctrl/internal.h    |  6 +--
 3 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 52b8991..10a52d1 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -168,6 +168,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.name			= "MB",
 		.domains		= domain_init(RDT_RESOURCE_MBA),
 		.cache_level		= 3,
+		.parse_ctrlval		= parse_bw,
 		.format_str		= "%d=%*u",
 		.fflags			= RFTYPE_RES_MB,
 	},
@@ -926,7 +927,6 @@ static __init void rdt_init_res_defs_intel(void)
 		else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
 			r->msr_update = mba_wrmsr_intel;
-			r->parse_ctrlval = parse_bw_intel;
 		}
 	}
 }
@@ -946,7 +946,6 @@ static __init void rdt_init_res_defs_amd(void)
 		else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_BW_BASE;
 			r->msr_update = mba_wrmsr_amd;
-			r->parse_ctrlval = parse_bw_amd;
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index e3bcd77..b0e24cb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -23,59 +23,6 @@
 
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
- * checked against the minimum and maximum bandwidth values specified by
- * the hardware. The allocated bandwidth percentage is rounded to the next
- * control step available on the hardware.
- */
-static bool bw_validate_amd(char *buf, unsigned long *data,
-			    struct rdt_resource *r)
-{
-	unsigned long bw;
-	int ret;
-
-	/* temporary: always false on AMD */
-	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
-		rdt_last_cmd_puts("No support for non-linear MB domains\n");
-		return false;
-	}
-
-	ret = kstrtoul(buf, 10, &bw);
-	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
-		return false;
-	}
-
-	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
-		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
-				    r->membw.min_bw, r->default_ctrl);
-		return false;
-	}
-
-	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
-	return true;
-}
-
-int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
-		 struct rdt_domain *d)
-{
-	unsigned long bw_val;
-
-	if (d->have_new_ctrl) {
-		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
-		return -EINVAL;
-	}
-
-	if (!bw_validate_amd(data->buf, &bw_val, r))
-		return -EINVAL;
-
-	d->new_ctrl = bw_val;
-	d->have_new_ctrl = true;
-
-	return 0;
-}
-
-/*
- * Check whether MBA bandwidth percentage value is correct. The value is
  * checked against the minimum and max bandwidth values specified by the
  * hardware. The allocated bandwidth percentage is rounded to the next
  * control step available on the hardware.
@@ -110,8 +57,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	return true;
 }
 
-int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
-		   struct rdt_domain *d)
+int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+	     struct rdt_domain *d)
 {
 	unsigned long bw_val;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 7b00723..21f4399 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -471,10 +471,8 @@ struct rdt_resource {
 
 int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	      struct rdt_domain *d);
-int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
-		   struct rdt_domain *d);
-int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
-		 struct rdt_domain *d);
+int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
+	     struct rdt_domain *d);
 
 extern struct mutex rdtgroup_mutex;
 
