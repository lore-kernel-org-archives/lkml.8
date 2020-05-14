Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8CDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B855E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="B/sOjEXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgENOQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgENOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:16:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D826C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:16:24 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0BBD00DC45039F589BC722.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bd00:dc45:39f:589b:c722])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C712A1EC015C;
        Thu, 14 May 2020 16:16:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589465780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j3imiznRcTcesSved9eAcuXC+pa5ngT+M54jGjyJhLM=;
        b=B/sOjEXBhpV8YUWlTypNzQpxGaJEb+QBrJu20oiBM46w2rubcez3+gujWhltnAg1yO1hJH
        6ejjyRDTpkAijOAKrYplYMaETfO8SM7zo2tHNEsK4YAdaZE1PvsxDjeK7J7c/NKpDmn/X+
        no9h/n9PzV0+H3MuI9UoTo6uqEcD+PA=
Date:   Thu, 14 May 2020 16:16:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
Message-ID: <20200514141616.GC9266@zn.tnic>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.957390899@linutronix.de>
 <CALCETrX=Obqn2ms5EYs7HPxTE_UgnVkmt-HoAoGzB4BajuMwLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrX=Obqn2ms5EYs7HPxTE_UgnVkmt-HoAoGzB4BajuMwLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 11:02:09AM -0700, Andy Lutomirski wrote:
> IOW, if we want to recover from CPL0 #MC, we will need a different mechanism.

Recovering from CPL0 #MC is mostly doomed to failure. Except this mcsafe
crap with the exception handling:

                /*
                 * Handle an MCE which has happened in kernel space but from
                 * which the kernel can recover: ex_has_fault_handler() has
                 * already verified that the rIP at which the error happened is
                 * a rIP from which the kernel can recover (by jumping to
                 * recovery code specified in _ASM_EXTABLE_FAULT()) and the
                 * corresponding exception handler which would do that is the
                 * proper one.
                 */
                if (m.kflags & MCE_IN_KERNEL_RECOV) {
                        if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
                                mce_panic("Failed kernel mode recovery", &m, msg);


Other than that, we iz done.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
