Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA48CC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849662137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZSUr3yos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgEAM1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbgEAM1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:27:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26930C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AWqcC7IFHGnNKByDv3wbL/TMKc9BXtCe7aekFvCtgxY=; b=ZSUr3yosVEIRLrEcsFyWV5oaCg
        C81OHNmMSZ+wlasKT1KJJ7YehPQOf6r4zPI7JBZOF0XFN7NcbkqR+4JomLCgsBZhL4HTXongDMQxc
        UlQooqewqik84iP7fdPNecxtdhhXy+pIHeCGaGrYorCoCWmQsprvV/IT3yMcrDR8PqClcMeWO++hj
        BoFhMuumJIuH1XYFqBSJhDG+eVlsqIXChLg4yKQvdbTRSSFzeSnsaaYiyJdcoifajGsv/w2wz7d8K
        ubSDkrpLs+MZ536mVXdApeSQsSlehhPE1ovAYMc/R8/Vhks0moZ1GCM0yeHs+w585cULeLkZqp1ph
        NKIZUC0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUUlc-0003vv-Tg; Fri, 01 May 2020 12:27:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A10B3011E8;
        Fri,  1 May 2020 14:27:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 511A729A22695; Fri,  1 May 2020 14:27:43 +0200 (CEST)
Date:   Fri, 1 May 2020 14:27:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200501122743.GB3762@hirez.programming.kicks-ass.net>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
 <20200501002858.4wuiqqv5o32jcvxf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501002858.4wuiqqv5o32jcvxf@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 07:28:58PM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 30, 2020 at 04:05:07PM +0200, Arnd Bergmann wrote:
> > lib/locking-selftest.o: warning: objtool: locking_selftest()+0x117f: PUSHF stack exhausted
> > lib/locking-selftest.o: warning: objtool: ww_tests()+0x1083: PUSHF stack exhausted
> 
> Peter,
> 
> These functions have a bunch of irqs_disabled() checks, which means a
> bunch of PUSHFs with no POPFs.
> 
> Am I reading it correctly that objtool assumes PUSHF is always paired
> with POPF?  irqs_disabled() doesn't do that.

Right, it sorta does. I wonder why this shows up with GCC-10 though, and
not before.

Anyway, the sneaky fix here would be something like this.

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 14f44f59e733..510656c776d9 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1138,7 +1138,7 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 {
 	unsigned long saved_preempt_count = preempt_count();
 
-	WARN_ON(irqs_disabled());
+	lockdep_assert_irqs_enabled();
 
 	testcase_fn();
 	/*
