Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D728EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B393F216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vqZ6OC7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgEAQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEAQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:11:00 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68BBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 09:10:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u22so3783351plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xdO5wD3Bx1i8JRnNljwYHSueh/B8sCLYrPuXu53UeUc=;
        b=vqZ6OC7HOM6GWFUeSf8I3NezyvilDwd9mxilvXgb5nGWSB0MUuVyqxArXNA0FuQwVH
         NsonTpK6dUjqBPyS0dST+qeFfh544JfNVraL6s0Ce7+yflbncUd5idFUxIROyrSQVx0Q
         m/yc/xukAAxaT/FrC3iHSOvu/rlYicvvEltN+9qCl3MyR7oWYaFPCZ3tAZ3sgotNfFiK
         ZYnA1ZMOLG20DH2b/8FVZQjAjAs4brvOG5/0LuqLDod2DJEpVC4Bn+EPddxMVhaNcRfz
         JayxHhqf6g4hGjqDab/kught3AssPwgs1prh65+MjNJx35zzitSlRT0okzPhB4h4K8vK
         MAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdO5wD3Bx1i8JRnNljwYHSueh/B8sCLYrPuXu53UeUc=;
        b=cmfMl4C2j3V9T3HPYAVLbc2P38oQm76fP52g6xtFDKr4QM240bjZy9rC6e2zohqpz0
         dS01MzdWywwLZAMxJAe/3Tir+2Zt5QpNGoQxxtk12+kojxW2mfovZ5VU3yRs/gIi/CMZ
         tNeKSZiZ3nhP7p4DIJqTJ37P6M0mMQD8od0r655v6+9POthrdtTMdHP0YLlsf42MT05o
         dH7OAu4WvF0z6tXGiqHDGtYHPUnYTL7kdFbT+abUQXlz4uTEDEZPfZUu1XoTIdnW+Oyt
         tU3cehwZWozPKg1hOjI+lXJ/wNB82xggzP4vo4oD0iW6Gnqsl40Ppftb07W2nsZ1QKRq
         E63g==
X-Gm-Message-State: AGi0PuYNlsI2P+DJj5B6vOb3SyUgRIjhLWRu13f5Z6AhruKgxKiikiHS
        HkEeEyCF4cjzo19juYaOHWjhcQ==
X-Google-Smtp-Source: APiQypL4+6fWY4XfVQC3YneLOyCw4Dw7j8fSl0sS5EdWkvEyOa5dhirJ8xL1ol975BMqqobgDTPb1Q==
X-Received: by 2002:a17:90a:fa8d:: with SMTP id cu13mr340518pjb.27.1588349458185;
        Fri, 01 May 2020 09:10:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y14sm2553223pff.205.2020.05.01.09.10.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 09:10:57 -0700 (PDT)
Date:   Sat, 2 May 2020 00:10:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <Al.Grant@arm.com>, James Clark <James.Clark@arm.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] arm64: perf_event: Fix time_offset for arch timer
Message-ID: <20200501161050.GA16001@leoy-ThinkPad-X240s>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
 <4d924f705245c797a19d3a73eb0c1ba0@kernel.org>
 <20200430160436.GC13575@hirez.programming.kicks-ass.net>
 <20200430161815.GE25258@willie-the-truck>
 <20200501151448.GA9650@leoy-ThinkPad-X240s>
 <20200501152609.GA17646@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501152609.GA17646@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:26:09PM +0100, Will Deacon wrote:

[...]

> > > > Let me try and understand your particular problem better.
> > > 
> > > I think the long and short of it is that userspace needs a way to convert
> > > the raw counter cycles into a ns value that can be compared against values
> > > coming out of sched_clock. To do this accurately, I think it needs the
> > > cycles value at the point when sched_clock was initialised.
> > 
> > Will's understanding is exactly what I want to resolve in this patch.
> > 
> > The background info is for the ARM SPE [1] decoding with perf tool, if
> > the timestamp is enabled, it uses the generic timer's counter as
> > timestamp source.  SPE trace data only contains the raw counter cycles,
> > as Will mentioned, the perf tool needs to convert it to a coordinate
> > value with sched_clock.  This is why this patch tries to calculate the
> > offset between the raw counter's ns value and sched_clock, eventually
> > this offset value will be used by SPE's decoding code in Perf tool to
> > calibrate a 'correct' timestamp.
> > 
> > Based on your suggestions, I will use __sched_clock_offset to resolve
> > the accuracy issue in patch v2.  (I noticed Peter suggested to use a
> > new API for wrapping clock_data structure, IIUC, __sched_clock_offset
> > is more straightforward for this case).
> > 
> > Please correct if I miss anything.  Thank you for reviewing and
> > suggestions!
> 
> I don't think you can use __sched_clock_offset without selecting
> HAVE_UNSTABLE_SCHED_CLOCK, and we really don't want to do that just
> for this. So Peter's idea about exposing what we need is better, although
> you'll probably need to take care with the switch-over from jiffies.
> 
> It needs some thought, but one possibility would be to introduce a new
> variant of sthe ched_clock_register() function that returns the cycle
> offset, and then we could fish that out of the timer driver.

Thanks a lot for you and Marc for correction.

> If we're
> crossing all the 'i's and dotting all the 't's then we'd want to disable the
> perf userpage if sched_clock changes clocksource too (a bit like we do for
> the vDSO).

To be honest, one thing is not clear for me is how the perf tool to
update the arch timer's parameters in the middle of tracing after
disable and re-enable per userpage.  I will note for this and look
into detailed implementation for this part.

Thanks for sharing comprehensive thoughts!

Leo
