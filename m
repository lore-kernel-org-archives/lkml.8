Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB15C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66FF20725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHFF2IL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgGKK1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgGKK1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:27:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9486BC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BTWBxIfujYZzc92iXY+CL7Ot0PsWScS2Axjaxv94il0=; b=eHFF2IL1sALbZgnGkCgSy7nhk6
        raqpHtifXSSTAkQbUstvPEuMfdA3o2ytxyAyOUz7Ox5r0K2XX1EUdRe5Na52nmpn2Uhuuwcke5Rr0
        t2slHHdCwnmqI+NJ1XSw6Vbrea4Q/4ovOCVEEtn+YhVtvyCqkZ+SCfwaYZ+Af/j+4haSXa8wp9Iha
        7AqyLIIYss3VdpWLyQSWkXI7L30oYxrmVW7lfOX41nc1yUqOaq5B4LIV2zmTep0azBw1lQ/46aP8N
        5fwOs5PHyQy9R3707v1oF4pqKRaI4Reh82sE73aBPTeXmifQ/ceEqqA0lrJCP/zYfubJGSr9D0kZT
        VBXoQVKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juCim-0000Qk-Td; Sat, 11 Jul 2020 10:27:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1EE83304E03;
        Sat, 11 Jul 2020 12:27:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F383228B57752; Sat, 11 Jul 2020 12:27:02 +0200 (CEST)
Date:   Sat, 11 Jul 2020 12:27:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 11/17] static_call: Simple self-test
Message-ID: <20200711102702.GC597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134336.798619415@infradead.org>
 <20200710184229.3c3f5d8d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710184229.3c3f5d8d@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 06:42:29PM -0400, Steven Rostedt wrote:
> On Fri, 10 Jul 2020 15:38:42 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > +static int __init test_static_call_init(void)
> > +{
> > +	WARN_ON(static_call(sc_selftest)(2) != 3);
> > +	static_call_update(sc_selftest, &func_b);
> > +	WARN_ON(static_call(sc_selftest)(2) != 4);
> > +	static_call_update(sc_selftest, &func_a);
> > +	WARN_ON(static_call(sc_selftest)(2) != 3);
> > +
> > +	return 0;
> > +}
> 
> I wonder if this would be better if we were testing the same static call each time?

Makes sense, I suppose.

> static int __init run_static_call(int val)
> {
> 	return static_call(sc_selftest)(val);
> }

Don't think we need this, or are you afraid of loop unrolling, in which
case you also want a noinline here I suppose.

> 
> static struct {
> 	int (*func)(int);
> 	int val;
> 	int expect;
> } static_call_data [] = {
> 	{ NULL, 2, 3 }
> 	( func_b, 2 , 4},
> 	{ func_a, 2, 3}
> } __initdata;
> 
> static int __init test_static_call_init(void)
> {
> 	int i;
> 
> 	for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
> 		if (static_call_data[i].func)
> 			static_call_update(sc_selftest, static_call_data[i].func);
> 		WARN_ON(run_static_call(static_call_data[i].val) != static_call_data[i].expect);
> 	}
> 
> 	return 0;
> }

Lots of compile errors with that, fixed them all :-)
