Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEC320723
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=familie-tometzki.de header.i=@familie-tometzki.de header.b="JVabofa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407053AbgE1UUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406949AbgE1UUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:20:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152BFC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:20:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so687323wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=familie-tometzki.de; s=google;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qe8ip5uiZ6F4MIymU9oIdqkcYsrzQpZvEefGrhU7/fY=;
        b=JVabofa6nK07ybfsbqFZ0jrFpxe7pLgnEucHj/ngLQLb3VPQUzmKVcO3sNaEBGsqa0
         +KYYYVRhMU2I2r7IbFgXKoYvrn0aOpsNd8q0kG9/O2mV3OqJLv5OoHnhOrtlsJmj3H7w
         A78io4w374WoUpI5q8JlIH7uh/3KnoYIuzlYc3T4SN2R362o4bq8PkOjc+8a/a3GHVCa
         Gn4jYff5DyhAg7OeempGCCL9HhgkJCqsmiFJbGFDap5rA6NGYY9vJ9KAF95KmGk+RyJd
         uXRsPm1HqoOLBZb6wBI+Fm3Ns75ggSHlFfSntFcxr3yACx6slixvggta5Frpmc9uhHlu
         4Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Qe8ip5uiZ6F4MIymU9oIdqkcYsrzQpZvEefGrhU7/fY=;
        b=aXU/xRTb6MuGF8q/zyv6+Xnci0fbw283aRtc+3H9+ZCmO6+XDAe3qWM0LkTKtQyntI
         6U4zWBmN51t0H6LCKffxJx/hIcSXGsizaEo8aVCI4RxT9gKrPB8rtsiQk4YdIN/Vh61/
         F8RqHS9oAzTzsepGWCeQaFUhQJFu+h2/Pb4HOLsYTHBk5FlDRjlG+g9QUesDo3HXJG8w
         HUB6Xnv52H944kmBZBIbe3dZsjKp0aXIgDCUXhJnj7JgJEJEa9E5NUaIuB+wZQlVykof
         7GmTBP6ZlV1EEK8yYzI17LI80s+8hUt8NwiLIeGPf0iubFyYmzKyC2rOKDIw3gFqeMq+
         sFYg==
X-Gm-Message-State: AOAM5306Ai7NlYXxN8XfGE0FViNnteZiHib+8kIMsjeHX9NuYm3pMZoS
        sfey6YKGeu3DrobK9qCXq/FyZsqxbMvRSrcl
X-Google-Smtp-Source: ABdhPJw8G47JeiuwM0ypZhmxJRBA8Kju1/YiIJA7e+cht9sS4iiXOVvYNBu4aoo0U4f8Sjn3ndW0Og==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr4989073wru.407.1590697230679;
        Thu, 28 May 2020 13:20:30 -0700 (PDT)
Received: from centos.familie-tometzki.de (p200300e68f26e200549c6bc1c59c398a.dip0.t-ipconnect.de. [2003:e6:8f26:e200:549c:6bc1:c59c:398a])
        by smtp.gmail.com with ESMTPSA id t14sm7469442wrb.94.2020.05.28.13.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:20:29 -0700 (PDT)
From:   damian <damian.tometzki@familie-tometzki.de>
X-Google-Original-From: damian <dti+kernel@familie-tometzki.de>
Date:   Thu, 28 May 2020 22:20:26 +0200
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     damian <damian.tometzki@familie-tometzki.de>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V9 20/39] x86/irq: Use generic irq_regs implementation
Message-ID: <20200528202026.GB3960@centos.familie-tometzki.de>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
        damian <damian.tometzki@familie-tometzki.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, X86 ML <x86@kernel.org>,
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
        Juergen Gross <jgross@suse.com>, Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20200521200513.656533920@linutronix.de>
 <20200521202118.704169051@linutronix.de>
 <20200526183934.GA3960@centos.familie-tometzki.de>
 <87ftbkpevg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftbkpevg.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 28. Mai 11:50, Thomas Gleixner wrote:
> Damian,
> 
> damian <damian.tometzki@familie-tometzki.de> writes:
> > with this patch i got the following build error:
> >
> >   LD      .tmp_vmlinux.kallsyms1
> > /home/damian/kernel/buildroot/output/host/bin/x86_64-buildroot-linux-uclibc-ld: arch/x86/kernel/irq.o: in function `get_irq_regs':
> > /home/damian/kernel/buildroot/output/build/linux-custom/./arch/x86/include/asm/irq_regs.h:19: undefined reference to `irq_regs'
> 
> Can you provide the .config please?
> 
> Thanks,
> 
>         tglx
Hello Thomas,

I found out self the reason. I rebuild the kernel from
scratch again and now it works. 

Many Thnaks
Damian



