Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AB0C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8039D2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588772021;
	bh=v3oyKzRpXKnoipOROeHkbZncbFji/UHgVJbykoFkjj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UgebuNtMxRGlVvCgWM8e28sHGAXzLQFIQJsaaznYHuPzUv7xddlfNfXcnb3jgFw94
	 fFHjrBx4V0VkpwlLmOIRxUix9GGlIVDZ7j+sHdACJp3z3MZwAhpGk313dStMK1P1Rx
	 vk6tiGv6h2kxA6wesSVbP/HYKBL8fyF7cL8Buyt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgEFNdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgEFNdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:33:40 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A9F20575;
        Wed,  6 May 2020 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588772019;
        bh=v3oyKzRpXKnoipOROeHkbZncbFji/UHgVJbykoFkjj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OqHlDNENnw2vLqj3tQkj3Rso6ty0BdOHA3e4bze1MXUn/5aJZlbBIyCIrTK5q+jfO
         LaW8Xa19N0EVyeXfRfzadiGTQe9z5c/PTLkrvOuuh8xoGqrtnp4/XhZvpAg80mJhx8
         Hm8200zS8D0Qd30h7d+uxP+iXAsl0eC5FtWNQlJw=
Date:   Wed, 6 May 2020 14:33:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 06/36] compiler: Simple READ/WRITE_ONCE()
 implementations
Message-ID: <20200506133333.GK8043@willie-the-truck>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.651504242@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134058.651504242@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:16:08PM +0200, Thomas Gleixner wrote:
> READ/WRITE_ONCE_NOCHECK() is required for atomics in code which cannot be
> instrumented like the x86 int3 text poke code. As READ/WRITE_ONCE() is
> undergoing a rewrite, provide __{READ,WRITE}_ONCE_SCALAR().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/compiler.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -313,6 +313,14 @@ unsigned long read_word_at_a_time(const
>  	__u.__val;					\
>  })
>  
> +#define __READ_ONCE_SCALAR(x)				\
> +	(*(const volatile typeof(x) *)&(x))
> +
> +#define __WRITE_ONCE_SCALAR(x, val)			\
> +do {							\
> +	*(volatile typeof(x) *)&(x) = val;		\
> +} while (0)

FWIW, these end up being called __READ_ONCE() and __WRITE_ONCE() after
the rewrite; the *_SCALAR() variants will call into kcsan_check_atomic_*().

If you go with that naming now, then any later conflict should fall out in
the wash.

Will
