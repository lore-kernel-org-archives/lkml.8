Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F0520810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="slI6MGhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgE2VhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:37:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgE2VhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oQkfFVC79mZw1IhNTro0VBpFntYmApGpZ1jNVkI7XJc=; b=slI6MGhFSlMbxkVQ/qNm7WIASI
        9f7HjINmLONupwxeM7UAqvPmej1hBiJoPhFtkt0FEM1GYxe20W7j2V6v3nkYQnGpKx1scgh33GlT+
        olb+AZFY8llgEVsTMxYYrorjuaLHCnLDXQiL+lBb1uA+JeRQQ44oRQX7603y4njKwRsJwEN+wRdK1
        rXhplER8Yp6UP3rF0AUj4eEMR2+yEK10f6tdBpO7pgktiBJfsLpXcUJbc7ytZW/7NQrGRACIzUzRe
        Ij7Q6/lEQRRKgma23YKUDmUGRZjFY0T1otAtL3yaEFRKkTwK61ZAqG94xNNi6r8eInei+jms8HgrB
        SwlppjHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeP-0007Iv-V3; Fri, 29 May 2020 21:34:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C63A3069A1;
        Fri, 29 May 2020 23:34:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1FC3720FF0A09; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213320.897976479@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 03/14] x86/hw_breakpoint: Prevent data breakpoints on per_cpu cpu_tss_rw
References: <20200529212728.795169701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

cpu_tss_rw is not directly referenced by hardware, but
cpu_tss_rw is also used in CPU entry code, especially
when #DB shifts its stacks. If a data breakpoint is on
the cpu_tss_rw.x86_tss.ist[IST_INDEX_DB], it will cause
recursive #DB (and then #DF soon for #DB is generated
after the access, IST-shifting, is done).

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200526014221.2119-4-laijs@linux.alibaba.com
---
 arch/x86/kernel/hw_breakpoint.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -255,6 +255,15 @@ static inline bool within_cpu_entry(unsi
 		if (within_area(addr, end, (unsigned long)get_cpu_gdt_rw(cpu),
 				GDT_SIZE))
 			return true;
+
+		/*
+		 * cpu_tss_rw is not directly referenced by hardware, but
+		 * cpu_tss_rw is also used in CPU entry code,
+		 */
+		if (within_area(addr, end,
+				(unsigned long)&per_cpu(cpu_tss_rw, cpu),
+				sizeof(struct tss_struct)))
+			return true;
 	}
 
 	return false;


