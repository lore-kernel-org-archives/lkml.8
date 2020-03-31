Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1480C2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A749D20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QnLhmESE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgCaP5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:57:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgCaP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IR8334MICP/itrXFKZ7XJElA4DTHI+lesZJHs7BI8LI=; b=QnLhmESEiWE/1K1D2B4SbDT/jC
        kDF8e4PDMq1iCBqDKvpaFe9otGx76hwwO6MjPad0nWlQLO+crAZyAaVixKeOpcrWmwgKdK7PGp5Wr
        T0CDkPj0S6tiVlCEyreYIAHDNRzfqDd3J8bMJgNIojozqZIYSEG6qLYjHb7jRRdcHQqyVdCCWm0OG
        RuH6ytrENnYuifNr7UoQfbCg8qOwXr1OfAJKliI4a9rWmDVvR66xrRJUNhBd7FuQJjTt1Ink8eTwY
        hawXhf7LonA/tzC8QHqFc28WkVaudwCcibpoHPbAHnGSiIq4F+K+LXkqlHOC261z02sw7fsvcpw8p
        PjowFyqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJJGJ-00011I-9m; Tue, 31 Mar 2020 15:57:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C83AC3012D8;
        Tue, 31 Mar 2020 17:57:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA8B029D910D5; Tue, 31 Mar 2020 17:57:08 +0200 (CEST)
Date:   Tue, 31 Mar 2020 17:57:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [patch 3/3] isolcpus: undeprecate on documentation
Message-ID: <20200331155708.GU20730@hirez.programming.kicks-ass.net>
References: <20200328152117.881555226@redhat.com>
 <20200328152503.271570281@redhat.com>
 <20200331152217.GT20730@hirez.programming.kicks-ass.net>
 <20200331154146.GA28556@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331154146.GA28556@fuller.cnet>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:41:46PM -0300, Marcelo Tosatti wrote:
> On Tue, Mar 31, 2020 at 05:22:17PM +0200, Peter Zijlstra wrote:
> > On Sat, Mar 28, 2020 at 12:21:20PM -0300, Marcelo Tosatti wrote:
> > > isolcpus is used to control steering of interrupts to managed_irqs and
> > > kernel threads, therefore its incorrect to state that its deprecated.
> > > 
> > > Remove deprecation warning.
> > > 
> > > Suggested-by: Chris Friesen <chris.friesen@windriver.com>
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > 
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt |    1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > Index: linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> > > ===================================================================
> > > --- linux-2.6.orig/Documentation/admin-guide/kernel-parameters.txt
> > > +++ linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -1926,7 +1926,6 @@
> > >  			Format: <RDP>,<reset>,<pci_scan>,<verbosity>
> > >  
> > >  	isolcpus=	[KNL,SMP,ISOL] Isolate a given set of CPUs from disturbance.
> > > -			[Deprecated - use cpusets instead]
> > >  			Format: [flag-list,]<cpu-list>
> > >  
> > 
> > It's still an absolute horrible piece of crap though. nozh_full piling
> > more and more shit on it doesn't make it more shiny.
> 
> Hi Peter,
> 
> Why do you dislike it? What you think would be a decent approach?

Try and reconfigure it after boot.
