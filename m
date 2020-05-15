Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC82C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F1E2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589578278;
	bh=O2OJcQ2yvuaecdX9dvP5MSICBbljS0c+xz4C+o2FiI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k9i/YjFOuojZNlyRX+ge4cWyuKrvmXHisqqO7B/Fao2RTGlhxXzC9SrwygiSnue5k
	 H9SnNta1w3oi39/M+rRaYPw0Ev4942GgqP/gEWDkhMzplEj8jA/APL9vUyRs2XMMSB
	 X7m1G/doz038VNKVqIbVZvya2LYgcE9Nptzn2uqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEOVbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgEOVbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:31:17 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B97420709;
        Fri, 15 May 2020 21:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589578276;
        bh=O2OJcQ2yvuaecdX9dvP5MSICBbljS0c+xz4C+o2FiI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I99rlMKoPbdlbWCb9h5COafzf6+k54KLOJBDHcVxoYTvgESqR1/Yc4RECzZw4tVY/
         HUUQHcWScYkdYLOo+Zics3ayytm1IEBQccZjNaMkNw66Cm+YNGk4CkU7vgXxPl3bou
         VTesA2N4afQESdI13pR2QlbwwIEUpBaQzj3YWbhk=
Date:   Fri, 15 May 2020 23:31:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch V4 part 1 27/36] arm64: Prepare arch_nmi_enter() for
 recursion
Message-ID: <20200515213112.GB5974@lenoir>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.771491291@linutronix.de>
 <873680evkm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873680evkm.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 11:29:13PM +0200, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > From: Frederic Weisbecker <frederic@kernel.org>
> 
> This changelog was very empty. Here is what Peter provided:
> 
>  When using nmi_enter() recursively, arch_nmi_enter() must also be recursion
>  safe. In particular, it must be ensured that HCR_TGE is always set while in
>  NMI context when in HYP mode, and be restored to it's former state when
>  done.
> 
>  The current code fails this when interleaved wrong. Notably it overwrites
>  the original hcr state on nesting.
> 
>  Introduce a nesting counter to make sure to store the original value.

Nice!

Thanks.
