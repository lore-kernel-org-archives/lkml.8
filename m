Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D9EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B1520810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y/uW4R2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgE2Vhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:37:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54870 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgE2VhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3j+8HW8DRn65B84KwGMDa4sT4LDFXxq3rVrzf2aFY78=; b=y/uW4R2DjxeuIuuoGZ+vO3lsnG
        rJnxmb9i6zZkOyCgLn4TBpGGHnRjRiNJr57WQSFQpQ2UuT2tvgFypnXTbQy4WarufFMzLHKhvW9Uo
        xX+zyMUy0VsDNY3YBrn5q5JbpLCsTfpnNT2nODfaU8mDugwhUAX0yia+DIioZDD08NH55EYCrbG0w
        rOuwwJ0/V/+TlRH4B3Oc/9LfxDD0sqaMYeC+gU7LQfe5V891PxOspqMGh749Sj7KW06g9TLPn91IX
        Lv5ikS/fC422yqQmZWFF6X1bglPEN/74md4viEGRd7/7w7r/juoU6LIcExzCdyEihUDOQag85HkGs
        4t3rHIew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeP-0007Ix-V1; Fri, 29 May 2020 21:34:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39F82306574;
        Fri, 29 May 2020 23:34:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 24EC020FF0A0B; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213320.955117574@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 04/14] x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask
References: <20200529212728.795169701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The percpu user_pcid_flush_mask is used for CPU entry
If a data breakpoint on it, it will cause an unwanted #DB.
Protect the full cpu_tlbstate structure to be sure.

There are some other percpu data used in CPU entry, but they are
either in already-protected cpu_tss_rw or are safe to trigger #DB
(espfix_waddr, espfix_stack).

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200526014221.2119-5-laijs@linux.alibaba.com
---
 arch/x86/kernel/hw_breakpoint.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -33,6 +33,7 @@
 #include <asm/debugreg.h>
 #include <asm/user.h>
 #include <asm/desc.h>
+#include <asm/tlbflush.h>
 
 /* Per cpu debug control register value */
 DEFINE_PER_CPU(unsigned long, cpu_dr7);
@@ -264,6 +265,16 @@ static inline bool within_cpu_entry(unsi
 				(unsigned long)&per_cpu(cpu_tss_rw, cpu),
 				sizeof(struct tss_struct)))
 			return true;
+
+		/*
+		 * cpu_tlbstate.user_pcid_flush_mask is used for CPU entry.
+		 * If a data breakpoint on it, it will cause an unwanted #DB.
+		 * Protect the full cpu_tlbstate structure to be sure.
+		 */
+		if (within_area(addr, end,
+				(unsigned long)&per_cpu(cpu_tlbstate, cpu),
+				sizeof(struct tlb_state)))
+			return true;
 	}
 
 	return false;


