Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2577C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05FE21927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rv6swKUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBZN3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:29:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40336 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgBZN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CtApP6y0Ei3Ml071F46rWbSRlVBr74tmKr211actlGM=; b=rv6swKULWE7G0/JwG1ln0poiQN
        2pe9Gq+62JZrwG/fFDiDi6k7fT7nG4FgajPxIYbNmpHaiWuSbfuziSd8p3M6Yjtnah0pWydxE4AtF
        esZOqKwdnA4XyjrLch+DGmpXiZS0jQUbaQl0xTNIDrmO7KrPMxAncHXw4kkijHYNDtuF0pGmdhs4n
        yjdqWHeNPMPj7LN0eP/3mAXPqr39aHXA2DV5wMKJrHxhh+aVyHpSqWpol4W0M5JdBBoHAV8mPur3A
        BJKp2tDTLYyOJtWJBTDDZr8l93X9Le0Wi9ehHvbWlPfjstPM/C5QqPtxiJ8NhmozS9bOfZu9HeOfw
        MXiHcDMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6wk8-0005dd-Ue; Wed, 26 Feb 2020 13:28:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5AD8A300478;
        Wed, 26 Feb 2020 14:26:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB1052B26491E; Wed, 26 Feb 2020 14:28:50 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:28:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on
 do_machine_check()
Message-ID: <20200226132850.GX18400@hirez.programming.kicks-ass.net>
References: <20200225213636.689276920@linutronix.de>
 <20200225220216.315548935@linutronix.de>
 <20200226011349.GH9599@lenoir>
 <d9bde3a6-1e19-1340-1fda-bc6de2eb4f7c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bde3a6-1e19-1340-1fda-bc6de2eb4f7c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 09:29:00PM -0800, Andy Lutomirski wrote:

> >> +void notrace do_machine_check(struct pt_regs *regs, long error_code)
> >>  {
> >>  	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
> >>  	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
> >> @@ -1360,6 +1366,7 @@ void do_machine_check(struct pt_regs *re
> >>  	ist_exit(regs);
> >>  }
> >>  EXPORT_SYMBOL_GPL(do_machine_check);
> >> +NOKPROBE_SYMBOL(do_machine_check);
> > 
> > That won't protect all the function called by do_machine_check(), right?
> > There are lots of them.
> > 
> 
> It at least means we can survive to run actual C code in
> do_machine_check(), which lets us try to mitigate this issue further.
> PeterZ has patches for that, and maybe this series fixes it later on.
> (I'm reading in order!)

Yeah, I don't cover that either. Making the kernel completely kprobe
safe is _lots_ more work I think.

We really need some form of automation for this :/ The current situation
is completely nonsatisfactory.
