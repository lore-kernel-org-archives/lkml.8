Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64415C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F4F2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582311952;
	bh=EUk3R/gMyLl1hXD5SfHRYQkTbuwsqyEOIo+TCyS6K9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Rc3LLopkj7bRic2eqAhn8KGU6hRfEqstTDLrXxgLqdtfLktiADvczLiUR2wtmzGad
	 +sFjGtwl+czc+aLJWKMw3kp0dDRmIc71hkQKwsktkNaYnqWKkAMqLMgU95R1fHRMSp
	 YgtBWGMTIAFOhy0XQ3wZlYHHYrWGlwqtyuwE8IXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgBUTFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgBUTFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:05:50 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC9172467C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582311949;
        bh=EUk3R/gMyLl1hXD5SfHRYQkTbuwsqyEOIo+TCyS6K9E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PU44+Eewl03OV5iiIV+9G/6+vfWvg1k28krJW1mHlv8q2DjPbe/mEz97KR8pFb9Ub
         h/qVJNVcIypuRDNAKp2CuvDkhoGRdE6Ys939cnPtsT9L1MlYNuWWg4Kn7FQslZIOaP
         9kBCOBGpA6+2rBuWMjFhmn4dZqk+di7JsFyEEYzE=
Received: by mail-wr1-f43.google.com with SMTP id c9so3213017wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:05:49 -0800 (PST)
X-Gm-Message-State: APjAAAX1T4QmWounxgpH+JBChjSr+KcifqScbLB6qWRBBIJZfjt6EEyi
        pFKfViLk3VACXcvI9AtIOX7cfiUyJxJvSrIzmAPZsw==
X-Google-Smtp-Source: APXvYqwMoYkvcRLnGjPgfcSeF411c9uXNu2ry9pwq5gixLImSPcIGRSJov5Ai+0nwEhxIwUNn27Gxuh/motCSmpg8IQ=
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr22620055wrw.184.1582311948012;
 Fri, 21 Feb 2020 11:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20200221133416.777099322@infradead.org> <20200221134215.328642621@infradead.org>
In-Reply-To: <20200221134215.328642621@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 21 Feb 2020 11:05:36 -0800
X-Gmail-Original-Message-ID: <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
Message-ID: <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 5:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> A few exceptions (like #DB and #BP) can happen at any location in the
> code, this then means that tracers should treat events from these
> exceptions as NMI-like. We could be holding locks with interrupts
> disabled for instance.
>
> Similarly, #MC is an actual NMI-like exception.
>

> -dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
> +dotraplinkage notrace void do_int3(struct pt_regs *regs, long error_code)
>  {
>         if (poke_int3_handler(regs))
>                 return;
>
> -       /*
> -        * Use ist_enter despite the fact that we don't use an IST stack.
> -        * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
> -        * mode or even during context tracking state changes.
> -        *
> -        * This means that we can't schedule.  That's okay.
> -        */
> -       ist_enter(regs);
> +       nmi_enter();

I agree with the change, but some commentary might be nice.  Maybe
copy from here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/idtentry&id=061eaa900b4f63601ab6381ab431fcef8dfd84be
