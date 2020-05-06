Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D90DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58552206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="E5Uf9V9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgEFIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:15:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43578 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgEFIPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:15:00 -0400
Received: from zn.tnic (p200300EC2F069600BCEB9C28D5742179.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9600:bceb:9c28:d574:2179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3741B1EC0347;
        Wed,  6 May 2020 10:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588752898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s5RV4o9+46GjRd6gshEq1QxtSsdTZ2fduNFg5bSsMV4=;
        b=E5Uf9V9XzZLS67J1Bqk811UzOJlTMg5M2KNVyQG3LgEvDqsOoUugPOz7QJASIOTKUA2JPp
        ZwZciHNalYt2+yAElzuSBjRgnpMPyk0/56BKkLy6CdVS93vD10JCL3H73+gvj2vVLQG2Rb
        QuEfkvBR0zly36F/hfMV9+wq0k2dRY4=
Date:   Wed, 6 May 2020 10:14:54 +0200
From:   Borislav Petkov <bp@alien8.de>
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
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 02/36] x86/hw_breakpoint: Prevent data
 breakpoints on cpu_entry_area
Message-ID: <20200506081454.GA25532@zn.tnic>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.272448010@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505134058.272448010@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:16:04PM +0200, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> A data breakpoint near the top of an IST stack will cause unresoverable

unrecoverable

> recursion.  A data breakpoint on the GDT, IDT, or TSS is terrifying.

"terrifying" huh? Colorful. :)

> Prevent either of these from happening.
> 
> Co-developed-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/hw_breakpoint.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
