Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A86C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B22620772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q9RiV1dI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgFDN0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgFDN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:26:38 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D947C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qdNli0NEHd43fwml9PHoxGbEchkTHhQ67oW6OcyjWWg=; b=Q9RiV1dIL5RZNEJrMOBFr4t6Uo
        zQItk4JSKEFB/aQqsDcK8xTCN8m2s0SzrQ4OUAuc1l79u5cEYOhiCCuotAihVSRUtMaCszZSahE+f
        AutRgArbGxQta6BsGc7eJ/Fb+B79A1xO5XR9wtDa/MwnJLsLt2k4/13X+0in/TsxSfx5fPu/1F9ME
        21BbNGa1r0wqAozqh2NY2O7HD6u72Nv2Q+YtYpOOfPhr3+KnuStZU4jWq2L+WOh4hTqqaQQIw6+30
        K/0Tz+ovcG2si5yrovDCs9uSqWxePvk+q4Vk7NMJqXkYMLN0F+ceN98T4qdLj4rKmswfwq/37Aw+h
        PRbFHt0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgpsL-0000mk-4C; Thu, 04 Jun 2020 13:25:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E87E301DFD;
        Thu,  4 Jun 2020 15:25:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDF5B20C333CF; Thu,  4 Jun 2020 15:25:37 +0200 (CEST)
Date:   Thu, 4 Jun 2020 15:25:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
Message-ID: <20200604132537.GA3976@hirez.programming.kicks-ass.net>
References: <20200521200513.656533920@linutronix.de>
 <5e68aa83-feac-2aa7-10ee-aebebc60c83e@citrix.com>
 <20200522211706.GZ2483@worktop.programming.kicks-ass.net>
 <83474edd-195f-f10b-9fe9-8ee168344e29@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83474edd-195f-f10b-9fe9-8ee168344e29@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:18:44PM +0100, Andrew Cooper wrote:

> Well that didn't last long...
> 
> The new ISE (rev 39, published today) introduces BUS LOCK DEBUG
> EXCEPTION which is now a second inverted polarity sticky bit (bit 11) in
> %dr6.
> 
> This one is liable to get more traction than RTM debugging, so something
> probably does want fixing in the #DB handler.

Well that's crap :-(

It being enabled through IA32_DEBUGCTL instead of through DR7 means that
the current code doesn't disable it and this then means we can have
nested #DB again.

Who sodding throught this was a good idea ?! What happened to #AC that
SLD currently uses?

What hardware will this be in and can we get this fixed?
