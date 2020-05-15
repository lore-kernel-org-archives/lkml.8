Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EFDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E5F206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589551484;
	bh=EEX+c10pvx1tTgNdD7lS1Z94pCP3SSWPPV1YZ5LkrVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QP0gnDKQZYnJY+blO9BjFVW2T9R6/b86du+NJX4PGe25uYqTkV6dUpYn8lfiCoqKN
	 IxLbSACyGLtfD9m6gl7PYS3agm9tb1hRXZrYXZPxbwMko9gF/iwD59WakyLhwr/RWX
	 awVyux910SR7Aannghb0H+/KvuENIQdspEpviTfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgEOOEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOOEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:04:42 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DA220671;
        Fri, 15 May 2020 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589551482;
        bh=EEX+c10pvx1tTgNdD7lS1Z94pCP3SSWPPV1YZ5LkrVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dD0OXKZZGwAE3FiOGLamkc51twhUdCT/JYhFF+nX+NQmvUFlaDQ7i+PMfYCP58zxO
         3igUJomFLiAXxPeq5nNpM09MdQV+033lu92WfCqWFcj57fM49XJsw6a1G+gdkGHkB4
         zAmeRR0DrAJGlT2pQF4ZIk1gwllANpAYQfZiRh8s=
Date:   Fri, 15 May 2020 16:04:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch V4 part 1 27/36] arm64: Prepare arch_nmi_enter() for
 recursion
Message-ID: <20200515140438.GA5974@lenoir>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.771491291@linutronix.de>
 <427895535.20271.1589412514423.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427895535.20271.1589412514423.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 07:28:34PM -0400, Mathieu Desnoyers wrote:
> ----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:
> 
> > +#define arch_nmi_enter()						\
> [...]							\
> > +	___hcr = read_sysreg(hcr_el2);					\
> > +	if (!(___hcr & HCR_TGE)) {					\
> > +		write_sysreg(___hcr | HCR_TGE, hcr_el2);		\
> > +		isb();							\
> 
> Why is there an isb() above ^ ....
> 
> > +	}								\
> > +	/*								\
> [...]
> > -#define arch_nmi_exit()								\
> [...]
> > +	/*								\
> > +	 * Make sure ___ctx->cnt release is visible before we		\
> > +	 * restore the sysreg. Otherwise a new NMI occurring		\
> > +	 * right after write_sysreg() can be fooled and think		\
> > +	 * we secured things for it.					\
> > +	 */								\
> > +	barrier();							\
> > +	if (!___ctx->cnt && !(___hcr & HCR_TGE))			\
> > +		write_sysreg(___hcr, hcr_el2);				\
> 
> And not here ?

I have to defer to Will on this detail...
