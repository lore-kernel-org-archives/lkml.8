Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D76C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F41A20725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 05:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RSbkRiSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgGKFIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 01:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgGKFIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 01:08:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E7C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SNdeIhO20g1dCYhSdQnHMhLVd7r+ZRAUPhqvcQ+JzSM=; b=RSbkRiSzmVUPGDT6xMmhDTVBv5
        1dHwWLR/eygiTMOYGUnTLn3k7BMJOo8LAEKGpgX4gu9VTKCBoNFO7bdh69xmrdUQvEID0sSR+CgyR
        fXfm1nzxbG0a9La6u9LZFxNCNomq6/6Xhh11Lop0ndNXs9i8sH/MBD+KX3WDUK6/MkCh6TWywCScD
        rbgO5AqacjdQbprd3Cv3/rBE7ZYBx1mkLTJE8z+MyHWDOK1WzkNPx0YMXcGU83RuGJL4ss/xT5NVV
        tKlYBXT9Yxd+A99IgxRzLLvwQdbiNCTeP1fGo8Bu+Yb/FZI4wFOD3a4q2wuEzFe5xMVBmVIJsBQC8
        bQe3lQcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ju7kW-0005qk-T2; Sat, 11 Jul 2020 05:08:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C39B73059C6;
        Sat, 11 Jul 2020 07:08:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5A962B85DD2B; Sat, 11 Jul 2020 07:08:31 +0200 (CEST)
Date:   Sat, 11 Jul 2020 07:08:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 15/17] static_call: Allow early init
Message-ID: <20200711050831.GY597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134337.036717190@infradead.org>
 <20200710211426.298a3d94@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710211426.298a3d94@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:14:26PM -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2020 15:38:46 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > In order to use static_call() to wire up x86_pmu, we need to
> > initialize earlier; copy some of the tricks from jump_label to enable
> > this.
> > 
> > Primarily we overload key->next to store a sites pointer when there
> > are no modules, this avoids having to use kmalloc() to initialize the
> > sites and allows us to run much earlier.
> > 
> 
> I'm confused. What was the need to have key->next store site pointers
> in order to move it up earlier?

The critical part was to not need an allocation.
