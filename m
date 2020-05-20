Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA6CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584942065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuE0Wnos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETJgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETJgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:36:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFA5C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:36:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so2399043wrt.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bl2Z9rwd9yHv4ZpH+5LCcErhhFtMaEj+8e37h0oPQpc=;
        b=QuE0WnosJ6J52vDdOA3INb6M2D/urfQeKgVAIc2+q2dNGq0Wq/5IWiFlaj7Slg/BcQ
         UkRNgOmg57DHE5ZkeRPYdeTJmyl792iWRXudp5mLZW7GYT5f6Z75JC2tEh5cP16AK9mM
         9OnhPiI+UzhVdzV372P9zNs8q0kNWC1QBhUm9nyeYgCiUdJM1byYFPmrB323ixUXyigO
         Ms3mLPgYlvOQN/g4/7YyWLcb6IoaHawUgmFpsrT3A4H6ezgCPc6ft59u62qw45qlzcJz
         PBDLrO/odZOjfn9GKDEZ92HbhH6TPhps3ypWSCfeRlzhtDjPzsTKCioPhSukD6/ku64U
         zSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bl2Z9rwd9yHv4ZpH+5LCcErhhFtMaEj+8e37h0oPQpc=;
        b=UnALLgrjpJRt7fDc5YPG7ClS1M5h3NCwvK7bqV3AKV2WKLhhuS6qchrBfpLb41OiyX
         /B1dGvOcxjm2PvMW7LZ8P657vAxgnsPG1Q0F6Ej6aTdoTkXtym/7UGXSjkAK4LbuWg45
         sFklQoe7t5+phyxLUJaCuIY9ywNPI3dd+N0ah2cdI2L3JFVPn8+I/VoIisxhvJiy7U3a
         VokUjwtxa4IW+l2WJC5pPBKk7AIeBTfuke/YNR/fvvabZq2aBrX6Jqi04/DXGMQTRBil
         wYehTCcZXIxk0ZueuLbsyROocF2DMKRcSHtRRJ7xGZqNybNbam52Xk2ZN8VJIPILfl1F
         TLBg==
X-Gm-Message-State: AOAM530bY4sZaIuCiAAZZM9AVIYxxl3m61yFNpbLGXtGdGhB+T1yIAqs
        2DScHCyfSOU2U+QuwjXeot2hBA==
X-Google-Smtp-Source: ABdhPJwwOpwo1mP3WPWm+13T7s8/2dqpT8dfFYb3l/48EJ787rro1deSw2krhQQ+/T4/nODPrdVJYg==
X-Received: by 2002:adf:e752:: with SMTP id c18mr3306165wrn.353.1589967360615;
        Wed, 20 May 2020 02:36:00 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g140sm2076523wmg.47.2020.05.20.02.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 02:35:59 -0700 (PDT)
Date:   Wed, 20 May 2020 10:35:57 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>, Sumit Garg <sumit.garg@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200520093557.lwwxnhvgmacipdce@holly.lan>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <20200515134806.5cw4xxnxw7k3223l@holly.lan>
 <20200518092139.GK7340@linux-b0ei>
 <20200520042102.GA938@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520042102.GA938@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 01:21:02PM +0900, Sergey Senozhatsky wrote:
> On (20/05/18 11:21), Petr Mladek wrote:
> [..]
> > > > Is this guaranteed that we never execute this path from NMI?
> > 
> > Good question!
> > 
> > > Absolutely not.
> > > 
> > > The execution context for kdb is pretty much unique... we are running a
> > > debug mode with all CPUs parked in a holding loop with interrupts
> > > disabled. One CPU is at an unknown exception state and the others are
> > > either handling an IRQ or NMI depending on architecture[1].
> > 
> > This is similar to the situation in panic() when other CPUs are
> > stopped. It is more safe when the CPUs are stopped using IRQ.
> > There is higher danger of a deadlock when NMI is used.
> > 
> > bust_spinlock() is used in panic() to increase the chance to go over
> > the deadlock and actually see the messages. It is not enough when
> > more locks are used by the console (VT/TTY is good example). And
> > it is not guaranteed that the console will still work after
> > the hack is disabled by bust_spinlocks(0).
> 
> Good point. It's not guaranteed to help, but bust_spinlocks() does
> help in general, many serial drivers do check oops_in_progress and
> use a deadlock safe approach when locking port lock. I don't see
> bust_spinlocks() being used in kdb, so it probably better start
> doing so (along with general for_each_console() loop improvements,
> like checking if console is enabled/available/etc).

Agree.

I am also interested in whether we can figure out a way to match
consoles and polling drivers. It is better to use the polling
driver rather than the console since the polling drivers "know"
they will execute from all sorts of crazy places. For the most common
use cases this would also result in no console handler ever being
called.

BTW for those asking how this issue an submarine for so long I think
the main factor is that not all architectures implement NMI.

There are exceptions but kdb is typically only useful when either:

1. We have a real (e.g. not USB) serial port, or
2. We have a real (e.g. not USB) keyboard

On x86, where the SMP peers are rounded up using using an NMI, the
above grows increasingly hard to find (although they are certainly
still here). Combined with this very few commonly embedded
architectures round up using an NMI so these problems cannot occur.

This has allowed kdb to fall rather far behind the rest of the kernel
w.r.t. NMI robustness whilst not being entirely useless.

Sumit's recent work to exploit NMIs on arm64 is bringing some of our
debt to the surface... happily I think that will also help us to tackle
it!


> [..]
> > > > If so, can this please be added to the commit message? A more
> > > > detailed commit message will help a lot.
> > 
> > What about?
> > 
> > "KDB has to get messages on consoles even when the system is stopped.
> > It uses kdb_printf() internally and calls console drivers on its own.
> > 
> > It uses a hack to reuse an existing code. It sets "kdb_trap_printk"
> > global variable to redirect even the normal printk() into the
> > kdb_printf() variant.
> > 
> > The variable "kdb_trap_printk" is checked in printk_default() and
> > it is ignored when printk is redirected to printk_safe in NMI context.
> > Solve this by moving the check into printk_func().

Maybe a "Currently" thrown in we switch from general background
information to describing the problem the patch is about to fix helps us
read it:

  Currently the variable "kdb_trap_printk" is checked

But other than that LGTM.


Daniel.

> > 
> > It is obvious that it is not fully safe. But it does not make things
> > worse. The console drivers are already called in this context by
> > kdb_printf() direct calls."
> 
> This looks more informative indeed. Thanks!
