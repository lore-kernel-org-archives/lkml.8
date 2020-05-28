Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED27CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C126E2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YCi6ijN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436641AbgE1Vgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:36:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41384 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436617AbgE1Vgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QlshC6gNAQ84Jg7sG8LMSxcNh/c4GplyKF73dIOQFK8=; b=YCi6ijN3pGULzfF+31weHP5c1Y
        mt+THn+KrHN4bkDtu7YeWBkGeXwGJ/CRcnDzKP+ue7d4zzFo+kAhA9jOt+6GWUG2m2Db0mrExRJvn
        YxL18deMBr92DIza/L2yx6EtkxEZa0RC/cZ2dwNrKkxOfDK4DxqB1B1yoQTUevnUSY1NlsZcj9cEs
        wMEYkNlGJj9tJWMapQ+RfDXPk+iKlEO6ydoxs0hbaMLV5K7QpCEySkjhVvJzLEkorpxEzt5atLlUN
        vg8lBq5McTbKekMA5Z7IaTdjkyhNMbbCjnCOsk3hqce8hVrhADRs93LpygNWIk5X6tcWQafwLoD0W
        iHn3habg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeQA2-0005Qg-S1; Thu, 28 May 2020 21:34:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B2449836F8; Thu, 28 May 2020 23:33:52 +0200 (CEST)
Date:   Thu, 28 May 2020 23:33:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, daniel.thompson@linaro.org
Subject: Re: [PATCH 1/6] x86/entry: Introduce local_db_{save,restore}()
Message-ID: <20200528213352.GC4496@worktop.programming.kicks-ass.net>
References: <20200528201937.038455891@infradead.org>
 <20200528202328.418625592@infradead.org>
 <17e097f5-f92c-bd7e-fb1d-ee08c4169dbe@citrix.com>
 <20200528211550.GR2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528211550.GR2483@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:15:50PM +0200, Peter Zijlstra wrote:
> On Thu, May 28, 2020 at 09:52:30PM +0100, Andrew Cooper wrote:
> > On 28/05/2020 21:19, Peter Zijlstra wrote:
> > > --- a/arch/x86/include/asm/debugreg.h
> > > +++ b/arch/x86/include/asm/debugreg.h
> > > @@ -113,6 +113,31 @@ static inline void debug_stack_usage_inc
> > >  static inline void debug_stack_usage_dec(void) { }
> > >  #endif /* X86_64 */
> > >  
> > > +static __always_inline void local_db_save(unsigned long *dr7)
> > > +{
> > > +	get_debugreg(*dr7, 7);
> > > +	if (*dr7)
> > > +		set_debugreg(0, 7);
> > 
> > %dr7 has an architecturally stuck bit in it.
> > 
> > You want *dr7 != 0x400 to avoid writing 0 unconditionally.
> 
> Do we have to have that bit set when writing it? Otherwise I might
> actually prefer masking it out.

I'm an idiot, we write a plain 9..

> > Also, API wise, wouldn't it be nicer to write "dr7 = local_db_save()"
> > rather than having a void function returning a single long via pointer?
> 
> Probably.. I started with local_irq_save() and .. well, n/m. I'll change
> it ;-)

How's this?

---
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -113,6 +113,36 @@ static inline void debug_stack_usage_inc
 static inline void debug_stack_usage_dec(void) { }
 #endif /* X86_64 */
 
+static __always_inline unsigned long local_db_save(void)
+{
+	unsigned long dr7;
+
+	get_debugreg(&dr7, 7);
+	dr7 ^= 0x400;
+	if (dr7)
+		set_debugreg(0, 7);
+	/*
+	 * Ensure the compiler doesn't lower the above statements into
+	 * the critical section; disabling breakpoints late would not
+	 * be good.
+	 */
+	barrier();
+
+	return dr7;
+}
+
+static __always_inline void local_db_restore(unsigned long dr7)
+{
+	/*
+	 * Ensure the compiler doesn't raise this statement into
+	 * the critical section; enabling breakpoints early would
+	 * not be good.
+	 */
+	barrier();
+	if (dr7)
+		set_debugreg(dr7, 7);
+}
+
 #ifdef CONFIG_CPU_SUP_AMD
 extern void set_dr_addr_mask(unsigned long mask, int dr);
 #else
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -727,15 +727,7 @@ static __always_inline void debug_enter(
 	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
 	 * includes the entry stack is excluded for everything.
 	 */
-	get_debugreg(*dr7, 7);
-	set_debugreg(0, 7);
-
-	/*
-	 * Ensure the compiler doesn't lower the above statements into
-	 * the critical section; disabling breakpoints late would not
-	 * be good.
-	 */
-	barrier();
+	*dr7 = local_db_save();
 
 	/*
 	 * The Intel SDM says:
@@ -756,13 +748,7 @@ static __always_inline void debug_enter(
 
 static __always_inline void debug_exit(unsigned long dr7)
 {
-	/*
-	 * Ensure the compiler doesn't raise this statement into
-	 * the critical section; enabling breakpoints early would
-	 * not be good.
-	 */
-	barrier();
-	set_debugreg(dr7, 7);
+	local_db_restore(dr7);
 }
 
 /*

