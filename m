Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5004C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4D72078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kWTF9IXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFMNz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:55:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EA5C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:55:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f18so11756589qkh.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P46+vTDp7JYJov+F0libzNKgpY7HwAGkSOwN20KITY4=;
        b=kWTF9IXHl0Z+7CBmQeyaW2OZ0rrrei+4ArMWmRFP+JD5h/y7mpiV+cj6SK6qdapzJq
         daCpJzcYLixOygK0f8hcTVw0kb/U2eoEDKWghkSUs5ywmVpd5Zj60n1xzwfFrH33kJ99
         7iiVQ8GXNEUdbs1bKAlLP/kjxczunrye4ZlmpBgJHJ2mR/oFePgqAZS1y9BTO+PGha4a
         40V12/03K4d1PgOzNmZP7kqaVryhUcZn1GMNGZkJqws1f9txqXMyKQusPCvAh4bjltHo
         i2ZsmDK0vzPnO2ZKpF3pUNfSAk4HMtxFJ2hr3bJf3F2AqGYVxcRUqDz9BpftNZOi1VG2
         X9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P46+vTDp7JYJov+F0libzNKgpY7HwAGkSOwN20KITY4=;
        b=LzX+qJpiU4OPtCzXqgQvxpABTyfFiQD6X1ZMuCu6NwTYoa64PRjGA3g+auejnAFMH7
         Vik1tU+9R2lBj56Y78r1r142f4fWbbUYPPMJN5utxJ39cgVDzAqWnhZK60ztl2QrmfrX
         fjbaxhwnhAEyfbuxDydonT4o5ta8TONHRQGNReQiSe2Bd0le5uEnfAqcEG0ZJmZu81Eg
         8ZyJcSbhNgEQif4OvA00yo92EyVmQZGnTEt7b9aYEPBxy/pciehzCcxUjQWbWrQIlwiO
         1RSLCmWiGirjPLicnwWDq8AX0zI4owd7ezPMN+xQrnDMIZNzW+pzMLxrNiPUXBWzePdR
         Lmfw==
X-Gm-Message-State: AOAM530ikDMricsMWdEQ/++WTHzGlG/AhmdqCYNk2lyeSltZlu/ZmtNY
        FrxrTc1BgfIv7NkEj1GfzH5xOw==
X-Google-Smtp-Source: ABdhPJyLJxrjswk8POfZOYW5zmO/6EYR0kS53WZTtyYtgYLbGEcLVy95Fe4khgZreO0F0rYxopup5g==
X-Received: by 2002:a37:813:: with SMTP id 19mr7396684qki.362.1592056556288;
        Sat, 13 Jun 2020 06:55:56 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c58sm7787498qtd.27.2020.06.13.06.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 06:55:55 -0700 (PDT)
Date:   Sat, 13 Jun 2020 09:55:47 -0400
From:   Qian Cai <cai@lca.pw>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [patch V9 10/39] x86/entry: Provide helpers for execute on
 irqstack
Message-ID: <20200613135547.GA992@lca.pw>
References: <87zh9cnfmg.fsf@nanos.tec.linutronix.de>
 <87wo4gnetx.fsf@nanos.tec.linutronix.de>
 <20200610123833.GD954@lca.pw>
 <87h7vig17z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7vig17z.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 09:38:56PM +0200, Thomas Gleixner wrote:
> Qian Cai <cai@lca.pw> writes:
> > On Tue, Jun 09, 2020 at 10:50:50PM +0200, Thomas Gleixner wrote:
> >> Thomas Gleixner <tglx@linutronix.de> writes:
> >> >> BAD (after oom02)
> >> >> # cat /sys/kernel/debug/stackdepot/info
> >> >> Unique stacks: 140476
> >> >
> >> > That's indeed odd. I try to reproduce and figure out what really breaks
> >> > here.
> >> 
> >> I checked your config file and I think I know where this comes from. Can
> >> you plase disable KASAN just for testing purposes and compare before
> >> after again?
> >
> > It turns out I'll need a few days to be able to get ahold of those
> > affected systems again. I'll be reporting back as soon as possible.
> 
> I figured it out. It has nothing to do with asm_call_on...(). It's also
> unrelated to page_owner. It's purely a KASAN issue.
> 
> KASAN trims stack traces with the help of filter_irq_stacks() which
> relies on __irqentry_text_start/end
> 
> The entry rework moved the interrupt entry points out of the irqentry
> section, which breaks that filter function.
> 
> I made it work again. Here are the numbers which make that obvious:
> 
> Mainline:
> Unique stacks: 23403
> Depot index:   244
> Depot offset:  4208
> 
> x86/entry:
> Unique stacks: 38835
> Depot index:   464
> Depot offset:  7616
> 
> x86/entry + fix:
> Unique stacks: 23607
> Depot index:   247
> Depot offset:  14224
> 
> So with the non-working trimming this generates more unique stacks and
> because they are not trimmed they become larger and eat more storage
> space. The resulting average per stack shows that:
> 
> Mainline:           171 bytes per stack
> x86/entry:          195 bytes per stack
> x86/entry + fix:    172 bytes per stack
> 
> I'll point you to a test branch shortly.

Thomas, I get ahold of one of the affected systems now if you want some
testing there.
