Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA48C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806322077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ta0+ik8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405880AbgFXRzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405677AbgFXRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:55:04 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC50C061573;
        Wed, 24 Jun 2020 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ITI+6nMfT1OTxjvFBXS8SqWS++zlFeNEzUYzivsKdN8=; b=ta0+ik8IcGl2bYYyUFC54uqCk6
        +qqjbp4JGa3fmCsMN/1XR64QetGWyQS7cOPLkZ8Sd7seu27n2ZU99DG+4ZKeiqVLFi2Rd7wtO2UQL
        GW1uJnydKQdPJ+UYCtnZqxOq3N+MMH4ujD7+ifq6lXpdKwBallQxHrfd/GFtCJ50BRlw/CGboN9pc
        McgLZcB/OlZcMCQsulJ8euQOvryCEFjsKTzMp3VAhwXyIV2SrxsERi8YF8lKPZ3whCYUpdG9ydSSy
        8mm8SW6N3uO4HWb9t4VOVM4mMwpHKHwfG2gwyqBetkNwHqtzniEsgU9+gFIcvhEFRolCmsw5lTQoG
        QoEIkerQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo9aM-0002ji-Rj; Wed, 24 Jun 2020 17:53:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C7B1307966;
        Wed, 24 Jun 2020 19:53:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D2E321AD36DB; Wed, 24 Jun 2020 19:53:20 +0200 (CEST)
Date:   Wed, 24 Jun 2020 19:53:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 6/8] arm: Break cyclic percpu include
Message-ID: <20200624175320.GN4781@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.454517573@infradead.org>
 <20200623090257.GA3743@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623090257.GA3743@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:02:57AM +0100, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 10:36:51AM +0200, Peter Zijlstra wrote:
> > In order to use <asm/percpu.h> in irqflags.h, we need to make sure
> > asm/percpu.h does not itself depend on irqflags.h.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/arm/include/asm/percpu.h |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- a/arch/arm/include/asm/percpu.h
> > +++ b/arch/arm/include/asm/percpu.h
> > @@ -10,6 +10,8 @@
> >   * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
> >   */
> >  #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
> > +register unsigned long current_stack_pointer asm ("sp");
> 
> If you define this unconditionally, then we can probably get rid of the
> copy in asm/thread_info.h, rather than duplicate the same #define.

The below delta seems to build arm-allnoconfig, arm-defconfig and
arm-allmodconfig.

Although please don't ask me how asm/thread_info.h includes asm/percpu.h

Does that work for you?

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index e86e47486b6b1..e2fcb3cfd3de5 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -5,13 +5,13 @@
 #ifndef _ASM_ARM_PERCPU_H_
 #define _ASM_ARM_PERCPU_H_
 
+register unsigned long current_stack_pointer asm ("sp");
+
 /*
  * Same as asm-generic/percpu.h, except that we store the per cpu offset
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
  */
 #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
-register unsigned long current_stack_pointer asm ("sp");
-
 static inline void set_my_cpu_offset(unsigned long off)
 {
 	/* Set TPIDRPRW */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 3609a6980c342..536b6b979f634 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -75,11 +75,6 @@ struct thread_info {
 	.addr_limit	= KERNEL_DS,					\
 }
 
-/*
- * how to get the current stack pointer in C
- */
-register unsigned long current_stack_pointer asm ("sp");
-
 /*
  * how to get the thread information struct from C
  */
