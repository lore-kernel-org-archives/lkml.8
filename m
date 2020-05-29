Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFD0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1BA20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l8HD+vPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgE2Ve7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgE2Ve5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:34:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0954C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2Pch7EH6zzoux565RhZ0to5gekvdho7r+giUY0g/P0Q=; b=l8HD+vPv/mHkxKjeNh99MlxZna
        vwlc1MUhM1T7EbB48HYwjoleTCeU+AenIQpv9bphoK1ULCYiSEWdxiFP3CfSLwB6fqyQwS6s1c4iA
        sho1o08oa+RFi+JPHYchyTnNC7UXvCErHpfry5HawEdMlkeGsqLexYCOiMYVmN8T7H9TlwYbVZQtc
        /IchHQdvVedPvqGZOeQr+bCROeBbxeBisRA11YiPD1bd8m1w2IAAlV46rzTFJtUz09sbYYhPMmnCy
        EbhzwQvNVGoU9K1yRBe5ULzR2XH5JJd5b/UvANvUPWgyJqFvElj4iHnBCZvhGq2XTVhlpVCKbDQps
        LEUxT+sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeO-0000La-TZ; Fri, 29 May 2020 21:34:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38239302814;
        Fri, 29 May 2020 23:34:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A5FA2021AF7A; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213320.784524504@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 01/14] x86/hw_breakpoint: Add within_area() to check data breakpoints
References: <20200529212728.795169701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

within_area() is added for checking if the data breakpoints overlap
with cpu_entry_area, and will be used for checking if the data
breakpoints overlap with GDT, IDT, or TSS in places other than
cpu_entry_area next patches.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200526014221.2119-2-laijs@linux.alibaba.com
---
 arch/x86/kernel/hw_breakpoint.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -228,13 +228,22 @@ int arch_check_bp_in_kernelspace(struct
 }
 
 /*
+ * Checks whether the range [addr, end], overlaps the area [base, base + size).
+ */
+static inline bool within_area(unsigned long addr, unsigned long end,
+			       unsigned long base, unsigned long size)
+{
+	return end >= base && addr < (base + size);
+}
+
+/*
  * Checks whether the range from addr to end, inclusive, overlaps the CPU
  * entry area range.
  */
 static inline bool within_cpu_entry_area(unsigned long addr, unsigned long end)
 {
-	return end >= CPU_ENTRY_AREA_BASE &&
-	       addr < (CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_TOTAL_SIZE);
+	return within_area(addr, end, CPU_ENTRY_AREA_BASE,
+			   CPU_ENTRY_AREA_TOTAL_SIZE);
 }
 
 static int arch_build_bp_info(struct perf_event *bp,


