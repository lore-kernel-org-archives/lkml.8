Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABEDC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D22920578
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GuhnEH1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgBZTAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:00:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:44458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBZTAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CAFrV/jX2REFdROj2WFmW9nBm7NNscB1OT89QWcHs0s=; b=GuhnEH1adpeERgL5XOpo1papgf
        6i/2avLHdyfXH2/N9OXemsbJMVJzKSSzj7StSKPbDhNXvJENlGc1UNqLo+/s9RjpP9PDB4SItcPQ5
        SFGw1HjhVb1vkjyeiGu/ZkDdOujivbzxWlgBXzCPIlG67W46OYnGZVcTYCUyFK0aHlCtl+DbsJZxw
        vmjQ+JD2Q4mzs6ekgdbpjMpGqbcHc02KWEdAvFdQEC1vyAY1Os050YsM1Mdqxq0ivJDUljUL8Hf5y
        NRvhh9Q74R7Lq1JeDSviGrsA02UyMp1y78zQPG5lQtMOH3FZ0b2uiJsq6grB/9cNzUF5HIXi4HMsT
        7QEY1f9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j71uO-0004Zc-Hc; Wed, 26 Feb 2020 18:59:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 365B5300130;
        Wed, 26 Feb 2020 19:57:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C42422B740B89; Wed, 26 Feb 2020 19:59:45 +0100 (CET)
Date:   Wed, 26 Feb 2020 19:59:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on
 do_machine_check()
Message-ID: <20200226185945.GC18400@hirez.programming.kicks-ass.net>
References: <20200226160818.GY18400@hirez.programming.kicks-ass.net>
 <C06C32B4-BD69-4287-BC67-C3E225061A46@amacapital.net>
 <20200226184237.GB16756@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226184237.GB16756@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 07:42:37PM +0100, Borislav Petkov wrote:
> On Wed, Feb 26, 2020 at 09:28:51AM -0800, Andy Lutomirski wrote:
> > > It entirely depends on what the goal is :-/ On the one hand I see why
> > > people might want function tracing / kprobes enabled, OTOH it's all
> > > mighty frigging scary. Any tracing/probing/whatever on an MCE has the
> > > potential to make a bad situation worse -- not unlike the same on #DF.
> 
> FWIW, I had this at the beginning of the #MC handler in a feeble attempt
> to poke at this:
> 
> +       hw_breakpoint_disable();
> +       static_key_disable(&__tracepoint_read_msr.key);
> +       tracing_off();

You can't do static_key_disable() from an IST
