Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35657C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD1A20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGJWmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgGJWmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:42:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9C52065F;
        Fri, 10 Jul 2020 22:42:30 +0000 (UTC)
Date:   Fri, 10 Jul 2020 18:42:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 11/17] static_call: Simple self-test
Message-ID: <20200710184229.3c3f5d8d@oasis.local.home>
In-Reply-To: <20200710134336.798619415@infradead.org>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.798619415@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 15:38:42 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/Kconfig         |    6 ++++++
>  kernel/static_call.c |   28 ++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -103,6 +103,12 @@ config STATIC_KEYS_SELFTEST
>  	help
>  	  Boot time self-test of the branch patching code.
>  
> +config STATIC_CALL_SELFTEST
> +	bool "Static call selftest"
> +	depends on HAVE_STATIC_CALL
> +	help
> +	  Boot time self-test of the call patching code.
> +
>  config OPTPROBES
>  	def_bool y
>  	depends on KPROBES && HAVE_OPTPROBES
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -364,3 +364,31 @@ static void __init static_call_init(void
>  #endif
>  }
>  early_initcall(static_call_init);
> +
> +#ifdef CONFIG_STATIC_CALL_SELFTEST
> +
> +static int func_a(int x)
> +{
> +	return x+1;
> +}
> +
> +static int func_b(int x)
> +{
> +	return x+2;
> +}
> +
> +DEFINE_STATIC_CALL(sc_selftest, func_a);
> +
> +static int __init test_static_call_init(void)
> +{
> +	WARN_ON(static_call(sc_selftest)(2) != 3);
> +	static_call_update(sc_selftest, &func_b);
> +	WARN_ON(static_call(sc_selftest)(2) != 4);
> +	static_call_update(sc_selftest, &func_a);
> +	WARN_ON(static_call(sc_selftest)(2) != 3);
> +
> +	return 0;
> +}

I wonder if this would be better if we were testing the same static call each time?

static int __init run_static_call(int val)
{
	return static_call(sc_selftest)(val);
}

static struct {
	int (*func)(int);
	int val;
	int expect;
} static_call_data [] = {
	{ NULL, 2, 3 }
	( func_b, 2 , 4},
	{ func_a, 2, 3}
} __initdata;

static int __init test_static_call_init(void)
{
	int i;

	for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
		if (static_call_data[i].func)
			static_call_update(sc_selftest, static_call_data[i].func);
		WARN_ON(run_static_call(static_call_data[i].val) != static_call_data[i].expect);
	}

	return 0;
}

-- Steve


> +early_initcall(test_static_call_init);
> +
> +#endif /* CONFIG_STATIC_CALL_SELFTEST */
> 

