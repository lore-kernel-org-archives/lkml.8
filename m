Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E53C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E3B20848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585669406;
	bh=OktgzzRoFbB2+Q3EBG0CEoNLQvlOABgUhrUFImHFEKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fQ0klF0BFbJrSIe7wU3Ag7yPwH0x4V9fFs62bOpf7wmnvFjBbwXYKkFyxVu8RZayv
	 Xmz46lbR7XLMsePerm9q0cHMA2gmhI5qEtd+lTDYi4Ias8wPgk6w6ZvXimOzngjY8k
	 b500vHbnyg1tPiZcCxocHx4op5ZhLU+q/UD9yYRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgCaPnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgCaPnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:43:25 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2274C20786;
        Tue, 31 Mar 2020 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585669404;
        bh=OktgzzRoFbB2+Q3EBG0CEoNLQvlOABgUhrUFImHFEKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PeTlIkihMUQSl1fzt6bf9JU+SmVAEet9Cj/AWXJPBekLA186FpUEXi2LoVzV0U2OC
         gfEjz/S5rf4T2MVMZVYtjBARwzBPtpZL+NYlGshvTRHD7EzFCm7Dz3sRhjB3Mmb/SL
         M8J2QSHmUn4Anp+IB9nA/IxC3Pke4dhVogOR5vLc=
Date:   Tue, 31 Mar 2020 17:43:22 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [patch 3/3] isolcpus: undeprecate on documentation
Message-ID: <20200331154321.GB6979@lenoir>
References: <20200328152117.881555226@redhat.com>
 <20200328152503.271570281@redhat.com>
 <20200331152217.GT20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331152217.GT20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:22:17PM +0200, Peter Zijlstra wrote:
> On Sat, Mar 28, 2020 at 12:21:20PM -0300, Marcelo Tosatti wrote:
> > isolcpus is used to control steering of interrupts to managed_irqs and
> > kernel threads, therefore its incorrect to state that its deprecated.
> > 
> > Remove deprecation warning.
> > 
> > Suggested-by: Chris Friesen <chris.friesen@windriver.com>
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > Index: linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> > ===================================================================
> > --- linux-2.6.orig/Documentation/admin-guide/kernel-parameters.txt
> > +++ linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1926,7 +1926,6 @@
> >  			Format: <RDP>,<reset>,<pci_scan>,<verbosity>
> >  
> >  	isolcpus=	[KNL,SMP,ISOL] Isolate a given set of CPUs from disturbance.
> > -			[Deprecated - use cpusets instead]
> >  			Format: [flag-list,]<cpu-list>
> >  
> 
> It's still an absolute horrible piece of crap though. nozh_full piling
> more and more shit on it doesn't make it more shiny.

Right. I still plan to propagate it to the cpuset mountpoints at some future
so that this becomes mutable.
