Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073E0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34402071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFQT8yKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgAYVZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 16:25:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33153 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAYVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 16:25:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id h23so5882212qkh.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RyoQxX2wrWS450F9QDMVcABOf0fYwOKCxmXI1Q7gGvw=;
        b=PFQT8yKXocQ+L57g43Jlf9k0Ybre2a9hY+JFbHa8Cp9WMuwoEqWMenRgD+A8kI+7sM
         Mz4megJww3/t7FvWlJBUppu8QItRkGWI5k725fj41ZHbE3qVjf1caJ0dk1yAwHgCmQJJ
         +eOGV+lGPk5X4QBp2tiLTl2C3/CLeSGgsExmEmpN5MVfdx/uS0Uj/fBdvgcG9GCVU0rE
         WJKAO7EE7c6vLvANYCi/uE/szqk0nPuTO+euwKQEU26onIniyUumppvvEQ6mo+cRM6kc
         81hKICzabb/Hh7UkjklSpPx7AK7G6SWFCpQENhc89oKeFrvuVTd+S3uylpY/Ma0ztCyH
         eMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RyoQxX2wrWS450F9QDMVcABOf0fYwOKCxmXI1Q7gGvw=;
        b=M+dxPKTOFPgO7d53xGH49KDDsuyZE7Jlr8uyE/txp6QfgoNcF0FF2XzlHg5FTDWBAE
         nN8lptBZWXQ1R2HC4eM0S957a3p3bTI3gK8xgmx4/wXQuTJe0XFnbPmbeCiZQ/3xXDWk
         6Fl0cdyFTFFsM7dLkFvtXXkVfeMycKjL1sZLKRqDbQNYWSCalCok81sI21go8jmT7jRv
         RyoCdhhjz5zWOLE3blkLMWppovya5V5zcBrpFZ07Yo8JZ9H9kfGP5qfA4PTBo44AICYa
         15EMPk3fkQqEumAoMlpUPQzy/o3NptiHGkwl6srbmAjikMYK6lLJVoT+eR5tYCva3+tk
         VvBA==
X-Gm-Message-State: APjAAAVI/gwiXcxw/00PE/44zhMQ57NRL/QVGBtNZy15PPDCQjyCp3jR
        b7ILqzqcZv1aTHmybAH57gQ=
X-Google-Smtp-Source: APXvYqzvIeJghCFpz+CqRKZwvdD/6W+ACf21+UlK9HQ8TV5uz/AuZzcbRSFsu/o/spg99akHuXg8bQ==
X-Received: by 2002:a37:9acb:: with SMTP id c194mr9473129qke.291.1579987527576;
        Sat, 25 Jan 2020 13:25:27 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v1sm5432762qkg.90.2020.01.25.13.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 13:25:27 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 25 Jan 2020 16:25:25 -0500
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200125212524.GA538225@rani.riverdale.lan>
References: <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 06:47:27PM -0800, Luck, Tony wrote:
> I did find something with a new test. Applications that hit a
> split lock warn as expected. But if they sleep before they hit
> a new split lock, we get another warning. This is may be because
> I messed up when fixing a PeterZ typo in the untested patch.
> But I think there may have been bigger problems.
> 
> Context switch in V14 code did: 
> 
>        if (tifp & _TIF_SLD)
>                switch_to_sld(prev_p);
> 
> void switch_to_sld(struct task_struct *prev)
> {
>        __sld_msr_set(true);
>        clear_tsk_thread_flag(prev, TIF_SLD);
> }
> 
> Which re-enables split lock checking for the next process to run. But
> mysteriously clears the TIF_SLD bit on the previous task.

Did Peter mean to disable it only for the current timeslice and
re-enable it for the next time its scheduled?

> 
> I think we need to consider TIF_SLD state of both previous and next
> process when deciding what to do with the MSR. Three cases:
> 
> 1) If they are both the same, leave the MSR alone it is (probably) right (modulo
>    the other thread having messed with it).
> 2) Next process has _TIF_SLD set ... disable checking
> 3) Next process doesn't have _TIF_SLD set ... enable checking
> 
> So please look closely at the new version of switch_to_sld() which is
> now called unconditonally on every switch ... but commonly will do
> nothing.
...
> +	/*
> +	 * Disable the split lock detection for this task so it can make
> +	 * progress and set TIF_SLD so the detection is reenabled via
> +	 * switch_to_sld() when the task is scheduled out.
> +	 */
> +	__sld_msr_set(false);
> +	set_tsk_thread_flag(current, TIF_SLD);
> +	return true;
> +}
> +
> +void switch_to_sld(struct task_struct *prev, struct task_struct *next)
> +{
> +	bool prevflag = test_tsk_thread_flag(prev, TIF_SLD);
> +	bool nextflag = test_tsk_thread_flag(next, TIF_SLD);
> +
> +	/*
> +	 * If we are switching between tasks that have the same
> +	 * need for split lock checking, then the MSR is (probably)
> +	 * right (modulo the other thread messing with it.
> +	 * Otherwise look at whether the new task needs split
> +	 * lock enabled.
> +	 */
> +	if (prevflag != nextflag)
> +		__sld_msr_set(nextflag);
> +}

I might be missing something but shouldnt this be !nextflag given the
flag being unset is when the task wants sld?
