Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987C6205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="suLVGZAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbgEMX2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:28:37 -0400
Received: from mail.efficios.com ([167.114.26.124]:37512 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbgEMX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:28:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 08A0C2BFD05;
        Wed, 13 May 2020 19:28:35 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q7eHZ_Uh7AUj; Wed, 13 May 2020 19:28:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8146C2BFA78;
        Wed, 13 May 2020 19:28:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8146C2BFA78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589412514;
        bh=WrNlzCQnwQTJkIfoFCGHXRb1q82eLGvIeiggDQd4tos=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=suLVGZALQoL/eMiGSC4QggspCvllOvDtOIlUteKy66CGRD8s1osxTt5FbiJ0K7hWm
         GMpaDT1NP9899xmhHXXGdSrO/imP0fq52jweVhUC2xYa5N6GJwUrOTE9gwbN37lM88
         LnZ22Eijy1/MxO7iqVsqdnDQHKze/fMcMbA1FmEu2wF152vavISm9P6fJlfQzZSInL
         MQ8avheNYjWRDP5MtBazkvKETT/3ZlWLlbyp/fOq9NYv6JW2ae7G1m63QMbIUX2oU1
         KXBEnVDjrjl68bMcPFx0a/4YPb88TtBpzjO0TZQqrQdcn8pSQnJTnacM8nBj7L+P3p
         nURW5MeipiZ6A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3cKMG-_yieWw; Wed, 13 May 2020 19:28:34 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6B9C32BF9E1;
        Wed, 13 May 2020 19:28:34 -0400 (EDT)
Date:   Wed, 13 May 2020 19:28:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <427895535.20271.1589412514423.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134100.771491291@linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134100.771491291@linutronix.de>
Subject: Re: [patch V4 part 1 27/36] arm64: Prepare arch_nmi_enter() for
 recursion
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: arm64: Prepare arch_nmi_enter() for recursion
Thread-Index: HUFuyxfL8Q0CtiXkR4klPwSH3xjvAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:

> +#define arch_nmi_enter()						\
[...]							\
> +	___hcr = read_sysreg(hcr_el2);					\
> +	if (!(___hcr & HCR_TGE)) {					\
> +		write_sysreg(___hcr | HCR_TGE, hcr_el2);		\
> +		isb();							\

Why is there an isb() above ^ ....

> +	}								\
> +	/*								\
[...]
> -#define arch_nmi_exit()								\
[...]
> +	/*								\
> +	 * Make sure ___ctx->cnt release is visible before we		\
> +	 * restore the sysreg. Otherwise a new NMI occurring		\
> +	 * right after write_sysreg() can be fooled and think		\
> +	 * we secured things for it.					\
> +	 */								\
> +	barrier();							\
> +	if (!___ctx->cnt && !(___hcr & HCR_TGE))			\
> +		write_sysreg(___hcr, hcr_el2);				\

And not here ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
