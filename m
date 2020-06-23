Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD99C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0677A20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0gWdjg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbgFWSAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbgFWSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:00:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC9C061795
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:00:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so2042306wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wcyp7xJ9VH6Ce5YmoH+01qglUFlPRs0bPBHrFHPBGrU=;
        b=b0gWdjg9shIjXDAXSuaxcUf0kvXH4yOK4YqHK+9dT9MEpAkVd6umkpXAERDfyobiWl
         iXYdhTzGdCZyETgQEnsKBMRw2uD1/6EG+a2gNOJxd+k6D/sDEhaX6N+anOTYiE5UTlEW
         9guLzwsJbj9ourTGn7rQyP3RVBIwQBwAZ/LZZzmAPQobTh1G7a54oM7BKIaUVWVU7sYR
         92sTnOH08HPqyhu7XVR11xnX2duZHFm8vCQNLqhX6EcurG9VD3S0w6GR/Cq7XgDKoDq9
         1VJ29HZZZHA+0Um8K2+yTGYbKt5FDsWkltk1RndhkdGr1x6j4EAOX4DINZmI1bfl6Cvx
         oAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wcyp7xJ9VH6Ce5YmoH+01qglUFlPRs0bPBHrFHPBGrU=;
        b=kHTfJ2EVy/y0mo4/leTh8hfhoLbq+F7ofqT5PJ53DzJw+AARaATPMQrpfZDBRiZ7N0
         ECWEZN2eF8QqHywSekhfdjYo15FK/OdPekLzIIa3HCWdGGZGIwdC3ix2jTyl+BxWZ+zx
         W+uK3vVaoFn/r+tBBMw6tjb0jkm78lU74wk1RjHhCjzCksCXlqHD5Gvo4HSykKhdSED7
         Dl4UsGfrRhMhZmA4KVfaD+TqNn3rb8YqjkEaoTwdewotezV+iCEEoYqRv4YCVVHRRPGY
         4BSE5ft0aa1Tts3x9wCaXE1UqbgZKC+KZF7Iy3idABGX/ElxEXgGShp4VDOOcvnhLKpF
         qNkA==
X-Gm-Message-State: AOAM532NyueJgt9NEFlA5XYJEFzzT3W4WA8Z7MCva7u/UG81FSuTXXrw
        Vu0q9bCmuh7d2TcWJriEaifEAvKJt6CeOA==
X-Google-Smtp-Source: ABdhPJyBS+rhzsc1deZ1Ay1FOdoRDXOTCxrPOjQRzUCugXkZeGKEC8Ks241Yw7kTMxlqgYm+GZsCyQ==
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr25343911wmj.84.1592935203860;
        Tue, 23 Jun 2020 11:00:03 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id r1sm22986260wrn.29.2020.06.23.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:00:03 -0700 (PDT)
Date:   Tue, 23 Jun 2020 19:59:57 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>, mingo@kernel.org,
        will@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623175957.GA106514@elver.google.com>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623163730.GA4800@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:37PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 06:13:21PM +0200, Ahmed S. Darwish wrote:
> > Well, freshly merged code is using it. For example, KCSAN:
> > 
> >     => f1bc96210c6a ("kcsan: Make KCSAN compatible with lockdep")
> >     => kernel/kcsan/report.c:
> > 
> >     void kcsan_report(...)
> >     {
> > 	...
> >         /*
> >          * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
> >          * we do not turn off lockdep here; this could happen due to recursion
> >          * into lockdep via KCSAN if we detect a race in utilities used by
> >          * lockdep.
> >          */
> >         lockdep_off();
> > 	...
> >     }
> 
> Marco, do you remember what exactly happened there? Because I'm about to
> wreck that. That is, I'm going to make TRACE_IRQFLAGS ignore
> lockdep_off().

Yeah, I was trying to squash any kind of recursion:

	lockdep -> other libs ->
		-> KCSAN
		-> print report
		-> dump stack, printk and friends
		-> lockdep -> other libs
			-> KCSAN ...

Some history:

* Initial patch to fix:
	https://lore.kernel.org/lkml/20200115162512.70807-1-elver@google.com/

* KCSAN+lockdep+ftrace:
	https://lore.kernel.org/lkml/20200214211035.209972-1-elver@google.com/

lockdep now has KCSAN_SANITIZE := n, but we still need to ensure that
there are no paths out of lockdep, or the IRQ flags tracing code, that
might lead through other libs, through KCSAN, libs used to generate a
report, and back to lockdep.

I never quite figured out the exact trace that led to corruption, but
avoiding any kind of potential for recursion was the only thing that
would avoid the check_flags() warnings.

Thanks,
-- Marco
