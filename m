Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEFD206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lbJ/D6GG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgEOQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:01:42 -0400
Received: from mail.efficios.com ([167.114.26.124]:45108 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgEOQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:01:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E905A2B0445;
        Fri, 15 May 2020 12:01:40 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WvDpZCgW7c8G; Fri, 15 May 2020 12:01:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7EB7E2B02F4;
        Fri, 15 May 2020 12:01:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7EB7E2B02F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589558500;
        bh=/aqNzZiWyuXVYAibug7RythgCs3Q8Lsdz16EIlb5Tyc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lbJ/D6GGU42tlfpmNiHbQmDA2jyTSVHkD/r+v0Ne6vau2uECkEqiFySquEg8nEv1D
         2AdQRYRiVjNh4N+VOr+gQuozwq0PAEyDjRC9blnkdYY+TTXLKY6xywrtaBCSI8EEeE
         qqODC6wnpJNxyN4RxClpXpoi68+XowlC9eyVuQFxDvFf1Llpeogc/wj/VwhZb7aXxW
         uvD603+ZbHACpuc54Kred4ERD9IcIsD56scysS/I5aaDwNMZTU9oYofyIf9NOvaXQ/
         LG7wjA+KRmEzQs2LANQrbTQGMZjg7a26S1S48aZACJqU6qk1ttlH5bJTkEmDjkmON8
         Pg96C+qJ+uDGQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yIvyBPwYL-ii; Fri, 15 May 2020 12:01:40 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6B6552B0798;
        Fri, 15 May 2020 12:01:40 -0400 (EDT)
Date:   Fri, 15 May 2020 12:01:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Catalin Marinas <catalin.marinas@arm.com>, maz@kernel.org
Message-ID: <1964654436.22367.1589558500351.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200515154525.GA23334@willie-the-truck>
References: <20200505131602.633487962@linutronix.de> <20200505134100.771491291@linutronix.de> <427895535.20271.1589412514423.JavaMail.zimbra@efficios.com> <20200515140438.GA5974@lenoir> <20200515154525.GA23334@willie-the-truck>
Subject: Re: [patch V4 part 1 27/36] arm64: Prepare arch_nmi_enter() for
 recursion
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: arm64: Prepare arch_nmi_enter() for recursion
Thread-Index: Vn2wlOV3s1hSS0xvlByawy7gmci5vg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 15, 2020, at 11:45 AM, Will Deacon will@kernel.org wrote:

> On Fri, May 15, 2020 at 04:04:39PM +0200, Frederic Weisbecker wrote:
>> On Wed, May 13, 2020 at 07:28:34PM -0400, Mathieu Desnoyers wrote:
>> > ----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:
>> > 
>> > > +#define arch_nmi_enter()						\
>> > [...]							\
>> > > +	___hcr = read_sysreg(hcr_el2);					\
>> > > +	if (!(___hcr & HCR_TGE)) {					\
>> > > +		write_sysreg(___hcr | HCR_TGE, hcr_el2);		\
>> > > +		isb();							\
>> > 
>> > Why is there an isb() above ^ ....
>> > 
>> > > +	}								\
>> > > +	/*								\
>> > [...]
>> > > -#define arch_nmi_exit()								\
>> > [...]
>> > > +	/*								\
>> > > +	 * Make sure ___ctx->cnt release is visible before we		\
>> > > +	 * restore the sysreg. Otherwise a new NMI occurring		\
>> > > +	 * right after write_sysreg() can be fooled and think		\
>> > > +	 * we secured things for it.					\
>> > > +	 */								\
>> > > +	barrier();							\
>> > > +	if (!___ctx->cnt && !(___hcr & HCR_TGE))			\
>> > > +		write_sysreg(___hcr, hcr_el2);				\
>> > 
>> > And not here ?
>> 
>> I have to defer to Will on this detail...
> 
> I think it's because we have to make sure that the register update has
> taken effect before we can safely run the NMI handler (and so an ISB is
> needed), but on the return path the exception return back to the interrupted
> context has an implicit ISB so there's no need for an extra one here.
> 
> Make sense?

Sure, as long as instructions executed between write_sysreg() and return
from exception do not care, which I think should be the case.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
