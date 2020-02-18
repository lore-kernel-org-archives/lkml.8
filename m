Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9721DC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E978207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ktybOmcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgBRVxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:53:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBRVxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TVHpoS6plyzACu0vk9UnX06s7fnOOIPSB1JSNnBqV2c=; b=ktybOmcX5Nbv7T3M2y32Yi1O2c
        aeb5lBs/jS6U8KGZOGpA7gNbiKbw7FoKrh57K4I9mVBW3Cto/eOt67Q3ld2bFeha1lePKmTOe2z/P
        AC70cB1jnhGyO9D6ghtog9/XkqUKpHYYgTlORR1Ychoj3uZ9QN86TrmQCgpNk8pOJJctt8kr7LlA+
        gm1vn6cBSTzS0U1Z6/j0Su+HPcls7Wts8QrYaI0pK1V/Jw5rsS23ZGD6SJYQMSxbD8PkSWqs9DUXu
        dZfTjICtCX8XOolh2PHs3UiMOgwwW0zCMLf+cl+aFsa1Ga41MYkycMkv16hWhea9zKrHn2evMHOzj
        /8i38ggw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Ao3-0000lt-MR; Tue, 18 Feb 2020 21:53:27 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B315E98045F; Tue, 18 Feb 2020 22:53:25 +0100 (CET)
Date:   Tue, 18 Feb 2020 22:53:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, paulmck@kernel.org
Subject: Re: [RFC] #MC mess
Message-ID: <20200218215325.GE11802@worktop.programming.kicks-ass.net>
References: <20200218173150.GK14449@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F57B937@ORSMSX115.amr.corp.intel.com>
 <20200218200200.GE11457@worktop.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F57BDFB@ORSMSX115.amr.corp.intel.com>
 <20200218203404.GI11457@worktop.programming.kicks-ass.net>
 <20200218214904.GD11802@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218214904.GD11802@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 10:49:04PM +0100, Peter Zijlstra wrote:
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index da0af631ded5..146332764673 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -71,7 +71,7 @@ extern void irq_exit(void);
>  		printk_nmi_enter();				\
>  		lockdep_off();					\
>  		ftrace_nmi_enter();				\
> -		BUG_ON(in_nmi());				\
> +		BUG_ON(in_nmi() == 0xf);			\

That wants to be:

		BUG_ON(in_nmi() == NMI_MASK);			\

>  		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
>  		rcu_nmi_enter();				\
>  		trace_hardirq_enter();				\
