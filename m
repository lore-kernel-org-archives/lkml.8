Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2995DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06253206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zydCL0If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGGMr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:47:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969EFC061755;
        Tue,  7 Jul 2020 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jt9Vw7V2eb5Wfd+25dzyz7cBSrPrtzGWmd/D/T1Llso=; b=zydCL0If841Za9gWEwqm/EcezN
        SqKEb/AGjCYcshguWG2yRP2/ITIt5Zrnv2DmuwRTttwzHnjT1IAY02Y+G9IwMBu8Urdx+tIKTXLD5
        L5jhjinsjamw2XEsbJ4f+1qv2IQOnCsNaMuQHQ2xBMkh0mJBJQLEjVlMuZ3OjhCw33tzLl9dWpAQ+
        gMF/qvt4q1cRkR3+eZI67VolzCX+CJeG3K2A7QBabqe5K2F9rtl51Tx78HgWE4YHruqWhjsaYJZoi
        JgCIQK1uWy3JgFHLZ0ktUd9kaILZoDZ7Uzc2M/WfqCjsPWf75D2GmzYXINf8kjUNKCr9yRvTdPrdS
        ktdz6Kmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsn0j-0004pA-Vl; Tue, 07 Jul 2020 12:47:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9EAC3013E5;
        Tue,  7 Jul 2020 14:47:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BA02213C65BB; Tue,  7 Jul 2020 14:47:42 +0200 (CEST)
Date:   Tue, 7 Jul 2020 14:47:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 01/20] Documentation: locking: Describe seqlock design
 and usage
Message-ID: <20200707124742.GN4800@hirez.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-2-a.darwish@linutronix.de>
 <20200706210439.GD5523@worktop.programming.kicks-ass.net>
 <20200707101200.GA4102575@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707101200.GA4102575@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 12:12:01PM +0200, Ahmed S. Darwish wrote:
> On Mon, Jul 06, 2020 at 11:04:39PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 30, 2020 at 07:44:33AM +0200, Ahmed S. Darwish wrote:
> > > +Sequence counters (:c:type:`seqcount_t`)
> > > +========================================
> >
> > > +.. code-block:: c
> >
> > I so hate RST, of course it's C. Also, ISTR Jon saying you can leave
> > that all out without issue.
> 
> There you go again.
> 
>   linux$ git grep 'code-block:: c' | wc -l
>   ==>  470
> 
>   linux$ git grep ':ref:' | wc -l
>   ==>  3171
> 
>   linux$ git grep ':c:type:' | wc -l
>   ==>  1533
> 
> In writing this, Documentation/doc-guide/ was followed, and literally
> the thousands of examples above.

Then this is a very bad guide. Jon, why is it recommending such horrible
crap? Should we add another field to MAINTAINERS to indicate RST/TXT
preference? Because I'm getting fed up trying to fix up all this
unreadable gunk.

I'm >< close to writing an script that will unconditionally and silently
convert everything to txt before committing.

> But honestly, I don't want to block merging documentation because of
> this, and the point of making the docs as readable as possible from text
> editors also has merit.
> 
> So... I'll just make that file as "RST-lite" as possible.

Thanks!

