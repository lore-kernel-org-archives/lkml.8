Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29151C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFB4206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Zp0+uBpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgAPUZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:25:00 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34662 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbgAPUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:24:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so20027546qtz.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 12:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FrKYxGLex7KY55dL8lMxEeBinvzP+LQNyH65PshZEs=;
        b=Zp0+uBpaH3H0gdT2e0qKjUQyxwU7AyZ6QAUooOJGqKQnpYTBgwYSKuk3OGdkdOsdPY
         t5u+d3Lapyj6ThZbdd1RCyWbjUZAcMSTQ9jNlbcv8MxMLQzY7QgQHC68cx/9d3VErCGS
         QOTeVzPheXSW4YCSfGw5keEWNgJtybHXO17xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FrKYxGLex7KY55dL8lMxEeBinvzP+LQNyH65PshZEs=;
        b=mTcypXpPwBLwDGiaoHp7E7Pzn+ByhV0R4IuxZwPhzR8J7XniGBCHz/AF4kvvbp+rmB
         KL0Ka0LaLra5ffAw+aMtLaaLlw//G22TsdE6ecojsywtWzlIPfEzqgAs34hWMGyBC4bT
         6flkwZ8lgiw8P7ZLZWnTYP60PW8yA/05WyB9GzZsnogNNJp0+UGRf7NSwTBQvSExwoeK
         lPy6ZncyRrC9SiXB+Nl1Q6TFJb5sbR0nqDJSnDq6rRFwHX7sgKhhFXrsjX0Cz5EV/oPM
         0Pjhss48SN+BOmyuAcgp3/903Y7mk4Vb/8jvJJ/HIWkB5LwpPb7KRX2UDd/IfzOFkCUo
         kLiw==
X-Gm-Message-State: APjAAAV3vzPRe0eqoD0mSNYNzrKFPTYWxRqvfkSKKMo6rFijzzwWxyog
        1/g59J0AuFbGhBhllhcaGsLCKLJZ7hPGiIax2yYsPg==
X-Google-Smtp-Source: APXvYqxHVblBPwuby3cFHXzmdBwt0WgKSD+6vUDAQK5gqjeHZSLzAhLvh0t7AUkPdufndc7Z/+2/a7B3EoY9PXIJZpQ=
X-Received: by 2002:ac8:187b:: with SMTP id n56mr4252669qtk.173.1579206298474;
 Thu, 16 Jan 2020 12:24:58 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi25Y=zrfdnitT3sSgC3UqcFHfz6-N2YP7h2TJai=JH_zg@mail.gmail.com>
 <20200109161632.GB8547@cmpxchg.org> <CABWYdi1Hs3Jgn5Rq=4X9w2+kG4mfsbGuV=8UMS=6mr=SVjOfVw@mail.gmail.com>
 <20200115165543.GA47772@cmpxchg.org>
In-Reply-To: <20200115165543.GA47772@cmpxchg.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 16 Jan 2020 12:24:47 -0800
Message-ID: <CABWYdi3BrQHaM_Np81W8f=EFU09cqqJARbywEvhq_XWoDqrBPw@mail.gmail.com>
Subject: Re: Lower than expected CPU pressure in PSI
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This definitely helps! It would be nice to add this as a section here:

* https://www.kernel.org/doc/html/latest/accounting/psi.html


On Wed, Jan 15, 2020 at 8:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Jan 10, 2020 at 11:28:32AM -0800, Ivan Babrou wrote:
> > I applied the patch on top of 5.5.0-rc3 and it's definitely better
> > now, both competing cgroups report 500ms/s delay. Feel free to add
> > Tested-by from me.
>
> Thanks, Ivan!
>
> > I'm still seeing /unified/system.slice at 385ms/s and /unified.slice
> > at 372ms/s, do you have an explanation for that part? Maybe it's
> > totally reasonable, but warrants a patch for documentation.
>
> Yes, this is a combination of CPU pinning and how pressure is
> calculated in SMP systems.
>
> The stall times are defined as lost compute potential - which scales
> with the number of concurrent threads - normalized to wallclock
> time. See the "Multiple CPUs" section in kernel/sched/psi.c.
>
> By restricting the CPUs in system.slice, there is less compute
> available in that group than in the parent, which means that the
> relative loss of potential can be higher.
>
> It's a bit unintuitive because most cgroup metrics are plain numbers
> that add up to bigger numbers as you go up the tree. If we exported
> both the numerator (waste) and denominator (compute potential) here,
> the numbers would act more conventionally, with parent numbers always
> bigger than the child's. But because pressure is normalized to
> wallclock time, you only see the ratio at each level, and that can
> shrink as you go up the tree if lower levels are CPU-constrained.
>
> We could have exported both numbers, but for most usecases that would
> be more confusing than helpful. And in practice it's the ratio that
> really matters: the pressure in the leaf cgroups is high due to the
> CPU restriction; but when you go higher up the tree and look at not
> just the pinned tasks, but also include tasks in other groups that
> have more CPUs available to them, the aggregate productivity at that
> level *is* actually higher.
>
> I hope that helps!
