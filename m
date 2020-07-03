Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1AFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B12D2220A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YExb5ZVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgGCTer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgGCTel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:34:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8106CC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WzmtxrUO4Ple/7+YgsF3RUJqdfZS1ARciQH0T44RBVE=; b=YExb5ZVWksVTapEWchkSOLXJB5
        +0jofWFlJ2srFX5b/we3bdjgR5MZVdFap8C0hbES+jfAWD7dg725JcyO/NRGDUnUkzyVkLt0XDS6m
        +QJl3LF9jHDB4R2/J+hN9ID+Bco9uv5UXmLUrYU0bKoqPg5HLAphd/Ba1KkstuFuxUeLDa0qJMPGQ
        YON8oFy1j3sLhP5EslqDEs0tTJtEMuBLIhetniD4zedJzfsxeTEikZSQfiGp7PiQHPCqlT5itbLV9
        Ll8IIYcNeBJUoedLEpcXgzSo6moEgEJ1SUbrWntysq4yTh2C/dU1EyyBdCIfyjliW+MnWZDJ9hYMI
        FtWzf0og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrRRr-0001zI-QJ; Fri, 03 Jul 2020 19:34:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37C6E984C50; Fri,  3 Jul 2020 21:34:08 +0200 (CEST)
Date:   Fri, 3 Jul 2020 21:34:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH V3 00/23] Support Architectural LBR
Message-ID: <20200703193408.GH2483@worktop.programming.kicks-ass.net>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So far so good; I'll merge in these little changes.

I have one more question, but I'll reply for that seperately and we can
do that on top if so.

---
Index: linux-2.6/arch/x86/events/intel/lbr.c
===================================================================
--- linux-2.6.orig/arch/x86/events/intel/lbr.c
+++ linux-2.6/arch/x86/events/intel/lbr.c
@@ -411,7 +411,7 @@ static __always_inline u64 rdlbr_info(un
 	return val;
 }

-static __always_inline void
+static inline void
 wrlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
 {
 	wrlbr_from(idx, lbr->from);
@@ -420,7 +420,7 @@ wrlbr_all(struct lbr_entry *lbr, unsigne
 		wrlbr_info(idx, lbr->info);
 }

-static __always_inline bool
+static inline bool
 rdlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
 {
 	u64 from = rdlbr_from(idx, NULL);
Index: linux-2.6/arch/x86/events/perf_event.h
===================================================================
--- linux-2.6.orig/arch/x86/events/perf_event.h
+++ linux-2.6/arch/x86/events/perf_event.h
@@ -775,7 +775,7 @@ struct x86_perf_task_context {

 struct x86_perf_task_context_arch_lbr {
 	struct x86_perf_task_context_opt opt;
-	struct lbr_entry  entries[0];
+	struct lbr_entry entries[];
 };

 /*
@@ -787,17 +787,15 @@ struct x86_perf_task_context_arch_lbr {
  * Do not put anything after the LBR state.
  */
 struct x86_perf_task_context_arch_lbr_xsave {
-	union {
-		struct x86_perf_task_context_opt	opt;
-		u8					padding[64];
-	};
+	struct x86_perf_task_context_opt		opt;
+
 	union {
 		struct xregs_state			xsave;
 		struct {
 			struct fxregs_state		i387;
 			struct xstate_header		header;
 			struct arch_lbr_state		lbr;
-		};
+		} __attribute__ ((packed, aligned (XSAVE_ALIGNMENT)));
 	};
 };

Index: linux-2.6/arch/x86/include/asm/fpu/types.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/fpu/types.h
+++ linux-2.6/arch/x86/include/asm/fpu/types.h
@@ -253,7 +253,7 @@ struct arch_lbr_state {
 	u64 ler_from;
 	u64 ler_to;
 	u64 ler_info;
-	struct lbr_entry		entries[0];
+	struct lbr_entry		entries[];
 } __packed;

 struct xstate_header {
@@ -280,8 +280,8 @@ struct xstate_header {
 struct xregs_state {
 	struct fxregs_state		i387;
 	struct xstate_header		header;
-	u8				extended_state_area[0];
-} __attribute__ ((packed, aligned (64)));
+	u8				extended_state_area[];
+} __attribute__ ((packed, aligned (XSAVE_ALIGNMENT)));

 /*
  * This is a union of all the possible FPU state formats
Index: linux-2.6/arch/x86/include/asm/perf_event.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/perf_event.h
+++ linux-2.6/arch/x86/include/asm/perf_event.h
@@ -283,7 +283,7 @@ struct pebs_xmm {
 };

 struct pebs_lbr {
-	struct lbr_entry lbr[0]; /* Variable length */
+	struct lbr_entry lbr[]; /* Variable length */
 };

 /*

