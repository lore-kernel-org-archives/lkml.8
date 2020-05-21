Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69947C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28466207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590095172;
	bh=04b1QXcN35zporxzNipoNmfuohtrbWnj2rPjb21UsbM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=UNyHk5/nH44PUR/3EpVc6gOV3YrLvVJsWFeTv+9HBLCi/LKqa6NGuTsNGnP26+H+a
	 t+PRBWePzTqPUeVbQEXTv9YEQoj7Qhbfo41lnTq/HF87599D5O7hKmDwXj/a9FBLPV
	 gtPe66TeqJPTVQxd3WXm/cKq7HMe69oWJCAKEDRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbgEUVGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbgEUVGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:06:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C17820759;
        Thu, 21 May 2020 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590095170;
        bh=04b1QXcN35zporxzNipoNmfuohtrbWnj2rPjb21UsbM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qXqwtbkZxD/SLNRKHnpt+xYa2jrvDtyspW0jriP+MYQrusPT2GgomuCMf7axt3yiT
         kuAs10QM6yll7CVllwrBtKw0zwNzsuSmV3KTfUHhrsf8aKzrpUGoDYdvZLSKTGyYZf
         LbA0xAPn7+pR4JaaPcBoTZ1nuw8F6+zNQiVuh2oE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 515763522FEB; Thu, 21 May 2020 14:06:10 -0700 (PDT)
Date:   Thu, 21 May 2020 14:06:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V9 04/39] x86/entry: Provide
 idtentry_entry/exit_cond_rcu()
Message-ID: <20200521210610.GA25708@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200521200513.656533920@linutronix.de>
 <20200521202117.181397835@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521202117.181397835@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:05:17PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> After a lengthy discussion [1] it turned out that RCU does not need a full
> rcu_irq_enter/exit() when RCU is already watching. All it needs if
> NOHZ_FULL is active is to check whether the tick needs to be restarted.
> 
> This allows to avoid a separate variant for the pagefault handler which
> cannot invoke rcu_irq_enter() on a kernel pagefault which might sleep.
> 
> The cond_rcu argument is only temporary and will be removed once the
> existing users of idtentry_enter/exit() have been cleaned up. After that
> the code can be significantly simplified.

And yes, I see that the sole call to rcu_irq_enter_check_tick() does
have instrumentation turned on, so good!  ;-)

							Thanx, Paul
