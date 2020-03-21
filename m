Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5944C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 13:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7F320754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 13:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qBE3lA1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCUNRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 09:17:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgCUNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 09:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PK/VmxcGeKFBjdt5UuClaNyaFMRmhddz5q967bbSnbs=; b=qBE3lA1ErCdZydq9Lr+5wIewWb
        pqe8Pe1djK5LkG/FvkG1QhEl7t4AeyNHc5KJPqI9yHtq4MtgphTvfGKj0ubRUyD6LXruyjdkxl8rs
        NPQu+ZrcefJm+rJQxXXfRsFNFO1400bo7Yxt4iH1Gj0bLH5gTcCTLTtZexJ0nYXQHj0aZqnGlduTA
        HfBoNUR+VXrEMKVqWGhSHIWhX3Jj0znYpJNb+j35LrOFEZUaNdoaDe0MC1IXppjr6jV15YiqR524P
        aH9eV3uFHY/w57WSgiHgeAgFq0AThBgxSs8CDTmrY821MrnBPlRK+uMVJdD/XmqeUcIWcFKfQslUA
        96QSJUpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFe06-0005uT-SX; Sat, 21 Mar 2020 13:17:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D211230018B;
        Sat, 21 Mar 2020 14:17:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B38D028B4E0D4; Sat, 21 Mar 2020 14:17:15 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:17:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 01/17] notifier: Fix broken error handling pattern
Message-ID: <20200321131715.GH20696@hirez.programming.kicks-ass.net>
References: <20200320213844.817147179@infradead.org>
 <20200320215942.500789386@infradead.org>
 <20200321122419.GD17494@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321122419.GD17494@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 01:24:19PM +0100, Borislav Petkov wrote:
> On Fri, Mar 20, 2020 at 10:38:45PM +0100, Peter Zijlstra wrote:
> > The current notifiers have the following error handling pattern all
> > over the place:
> > 
> > 	int err, nr;
> > 
> > 	err = __foo_notifier_call_chain(&chain, val_up, v, -1, &nr);
> > 	if (err & NOTIFIER_STOP_MASK)
> > 		__foo_notifier_call_chain(&chain, val_down, v, nr-1, NULL)
> > 
> > And aside from the endless repetition thereof, it is broken. Consider
> > blocking notifiers; both calls take and drop the rwsem, this means
> > that the notifier list can change in between the two calls, making @nr
> > meaningless.
> > 
> > Fix this by replacing all the __foo_notifier_call_chain() functions
> > with foo_notifier_call_chain_robust() that embeds the above pattern,
> > but ensures it is inside a single lock region.
> 
> "robust" huh? Sure reads funny :)

This has been around the bike-shed a few times already.

> So if the "normal" notifier_call_chain() usage is buggy, how about we
> prepend its name with "__" and call the new one with the rollback,
> notifier_call_chain() ?
> 
> Instead of adding the "robust" set of interfaces?

Well, it depends on the usecase. The robust one can deal with failure,
the other ones are fine (and preferred) if failure is not an option.

This robust variant ensures that all the notifiers that succeeded prior
to the one that failed get a second callback with another state. Some
notifier chains don't care, but a few clearly did and did it utterly
broken.

> Btw, the indentation in that notifier.* files is yuck.

Yeha, wasn't going to fix that.

