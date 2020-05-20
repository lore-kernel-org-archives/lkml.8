Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458E9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C0020756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lnio8fro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgETEVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgETEVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:21:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA27EC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:21:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so808555plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLtepNIIFtYJeYE+BCKW9s6RSwXADFckBZfwuNyokFI=;
        b=Lnio8froYfGjhcDR8Oi4V/zbk2yJKl56gLzvoSzlT7BVfoF8DlqX2jBG5i8AiHHOB/
         xZ+q9j9M++RPnht2msBmEJIwIZywFCYVY0lfOkwGW/Yc2StACazmKT0tl1s2yfxuEhOA
         +l2rMXpxit2HfCkDqm953gSguskXH/UOpd43cQjZ9cJYpl2Em6J6iw5o9jhnqmAaNSr4
         PP+4c4qoi2mGZPJd+wpo11evo6JIFpGXBFaKc8viSXvi1YUZ2/AgROj0EoMVD3aS484W
         pFVU5LwL3WEEu8wnYBeslmWBMvNhYMXY0ZclBohCJYYlwUH1JecgAElKOSgnuHEHH7Or
         5cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLtepNIIFtYJeYE+BCKW9s6RSwXADFckBZfwuNyokFI=;
        b=DVZ9JqEFyHBScIlRANWMFwNpCW2Zt+oDju4Sr8oyJnmn6G14k7KAVMIZ9RagCme+pr
         vNPOuuxHulz6PIq2S+XTmAYdQuhtvyYrdnVl9olDZ3vpP1sQUS0owoSmI2bbwfuSVQlT
         SLOhM2ABT4KmzgFg0K4p+ydNP1bW+acmmhDeZmFnVSJYZcqFLU8vk3ebCfnhj5rekCR9
         5yX4wBa9rwC+hzZLF9Y/Q8MPSG2IFZ+s2JJj1ZXEj7f/wsDkuEfjURSzGevN7i0NNCAP
         whochsRenGGR1hkYV+YPN949fCRjqaq7oxTy4v1VLoNlDaBlhUs2rHrrIoGfZtD6No9e
         JMJg==
X-Gm-Message-State: AOAM532jW4vW9ahfYPoAdphEx+fJZMNBRpDyalgo/ovwElSvwuZmjta5
        XsV6CCsSVMcFMxraCRSicXo=
X-Google-Smtp-Source: ABdhPJxKbZMNf3t5yOIP8N0BQUkbDFdAgNMKzKbxa4wLi/hHpoppOI6egVC0nBkgeQds8zhsxFEoPQ==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr2577787plo.230.1589948465026;
        Tue, 19 May 2020 21:21:05 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 141sm832943pfz.171.2020.05.19.21.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 21:21:04 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 20 May 2020 13:21:02 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
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
Message-ID: <20200520042102.GA938@jagdpanzerIV.localdomain>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <20200515134806.5cw4xxnxw7k3223l@holly.lan>
 <20200518092139.GK7340@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518092139.GK7340@linux-b0ei>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/18 11:21), Petr Mladek wrote:
[..]
> > > Is this guaranteed that we never execute this path from NMI?
> 
> Good question!
> 
> > Absolutely not.
> > 
> > The execution context for kdb is pretty much unique... we are running a
> > debug mode with all CPUs parked in a holding loop with interrupts
> > disabled. One CPU is at an unknown exception state and the others are
> > either handling an IRQ or NMI depending on architecture[1].
> 
> This is similar to the situation in panic() when other CPUs are
> stopped. It is more safe when the CPUs are stopped using IRQ.
> There is higher danger of a deadlock when NMI is used.
> 
> bust_spinlock() is used in panic() to increase the chance to go over
> the deadlock and actually see the messages. It is not enough when
> more locks are used by the console (VT/TTY is good example). And
> it is not guaranteed that the console will still work after
> the hack is disabled by bust_spinlocks(0).

Good point. It's not guaranteed to help, but bust_spinlocks() does
help in general, many serial drivers do check oops_in_progress and
use a deadlock safe approach when locking port lock. I don't see
bust_spinlocks() being used in kdb, so it probably better start
doing so (along with general for_each_console() loop improvements,
like checking if console is enabled/available/etc).

[..]
> > > If so, can this please be added to the commit message? A more
> > > detailed commit message will help a lot.
> 
> What about?
> 
> "KDB has to get messages on consoles even when the system is stopped.
> It uses kdb_printf() internally and calls console drivers on its own.
> 
> It uses a hack to reuse an existing code. It sets "kdb_trap_printk"
> global variable to redirect even the normal printk() into the
> kdb_printf() variant.
> 
> The variable "kdb_trap_printk" is checked in printk_default() and
> it is ignored when printk is redirected to printk_safe in NMI context.
> Solve this by moving the check into printk_func().
> 
> It is obvious that it is not fully safe. But it does not make things
> worse. The console drivers are already called in this context by
> kdb_printf() direct calls."

This looks more informative indeed. Thanks!

	-ss
