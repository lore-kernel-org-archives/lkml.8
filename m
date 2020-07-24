Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBE3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B75022074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595594210;
	bh=GmzDHNH/MTKEvh++Ne8GyQCCiDhWso3CP9dXcqW0eKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kudjmUzjPL8P5e2G0lvkeAI6Am+ceYyDNjyu7ZHk4PwCYr2Ms0hobtn/rEar2BkdD
	 Ujyf1sdXCLzcqfNX9Foeop/FCGKRCO5p6JvwKXgQWYt3088Y+CH+rOFFAGdsVP1lEa
	 ygWrRCm4uM9dQxiXKl4WM9r5/V/NjJoKds9W53V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgGXMgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:36:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7AC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:36:48 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rk21so9845773ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7mBU6Ac57Q5/yJlmum5UkBslB0zc26H7IqmBs4MBNNI=;
        b=MXCMHLcxy+kIuvi0NZVpvfhKetER8O8x94w5dSE0Jm2fD5AUci679ZcsVAo1wUJY0I
         L/zz6i2zXjyUrLy8IssEYWvi0yLYASoQJAQpvOXpLznFHr//r5CMQF8UCpOfb6Mv8tcx
         XP+8eJ5eotN3cH01iT2YIo7jWJyMR7Y6AaB01MaDWsHkEG4uw+1QzLBBjlvZDDjxrJWS
         nozb1UwED82xEIAV36l+u7zpuQQ61cNBuh/Oiy8zvSa8KsgvSdflDHSh9+hp8+EsjgUJ
         jMkf8AulHevlmHyX7Q7hHGKTceLeaczrGpPvl94RQRHnxuH6v5L9tDP8O5s6lprW3N0B
         kJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7mBU6Ac57Q5/yJlmum5UkBslB0zc26H7IqmBs4MBNNI=;
        b=Ge6vaGpCJ7c3Ib/XWv4ihjVb92Lq4R3/RTrdMTjuDAgaYLGp2B6b1nLzjDvLiC7h+c
         HPioB0frUSbejgRejZSKBxdyeo+vxhlvSJVGiGrYXUhU0T7UysJ2r1sijlcdVUBHnK6b
         mRHgUg96HGRTGZuyyp5XkHsPg+9Pb8iLsNIWPRRnLJBeXGegD03dDZT64MQQAaBelKx2
         O1/WQAfhSmhadjKq37BPzjDhglVTMlfcW9ggBgB3QLQU5ps38ekWh0B/8lpPbiQoFxfk
         2DEMPd/n8IWy+nTBResa1tEHeSMPm1PqurqEsVXXMjbytSxGMKNzzC3EfUhWMHjgzY1H
         TbGg==
X-Gm-Message-State: AOAM531dW+7D+3qJopG7WJFc8n4+1rY+ccHgAVm30n02kzspidv2wKpB
        oICjzvz30l8XsgRDHAWUV3I=
X-Google-Smtp-Source: ABdhPJzFrVnpVd9+HsQJA+2RA2wzyzk2g6zZgsq3Kou102GE375x5EHuZCOf4Ts67BifY8SE4KyXWQ==
X-Received: by 2002:a17:906:4b16:: with SMTP id y22mr9021777eju.4.1595594207475;
        Fri, 24 Jul 2020 05:36:47 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id j21sm668912edq.20.2020.07.24.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 05:36:46 -0700 (PDT)
Date:   Fri, 24 Jul 2020 14:36:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Jiang Biao <humjb_1983@163.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Subject: Re: [PATCH] sched/fair: consider sched-idle CPU when selecting idle
 core
Message-ID: <20200724123644.GA634690@gmail.com>
References: <20200723233853.48815-1-humjb_1983@163.com>
 <CAKfTPtCnewaivay7bftUY27+-qB=ct3eSNEoZW=-2Z6k0S4B4Q@mail.gmail.com>
 <CAPJCdBnv4W5+u6OZ4vbAdJ2U8ubhfAU7+Zt0JUFjfxKEDuGJSw@mail.gmail.com>
 <CAKfTPtCXXGEDNG+YxBbRG4vFK1+ig5EBzntmyTxr7MbQw-Q7MA@mail.gmail.com>
 <CAPJCdBm=FJp8K1SubXP4Rfa-POr8hDh320faE+4Cjcjk3BL1JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPJCdBm=FJp8K1SubXP4Rfa-POr8hDh320faE+4Cjcjk3BL1JQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiang Biao <benbjiang@gmail.com> wrote:

> On Fri, 24 Jul 2020 at 18:34, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 24 Jul 2020 at 10:12, Jiang Biao <benbjiang@gmail.com> wrote:
> > >
> > > On Fri, 24 Jul 2020 at 15:24, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Fri, 24 Jul 2020 at 01:39, Jiang Biao <humjb_1983@163.com> wrote:
> > > > >
> > > > > From: Jiang Biao <benbjiang@tencent.com>
> > > > >
> > > > > Sched-idle CPU has been considered in select_idle_cpu and
> > > > > select_idle_smt, it also needs to be considered in select_idle_core to
> > > > > be consistent and keep the same *idle* policy.
> > > >
> > > > In the case of select_idle_core, we are looking for a core that is
> > > > fully idle but if one CPU of the core is running a sched_idle task,
> > > > the core will not be idle and we might end up having  the wakeup task
> > > > on a CPU and a sched_idle task on another CPU of the core which is not
> > > > what we want
> > > Got it. sched_idle task may interfere its sibling, which brings me
> > > another question,
> > > If there's a core with smt1 running sched_idle task and smt2 idle,
> > > selecting smt1
> > > rather than smt2 should be more helpful for wakee task, because wakee task
> > > could suppress the sched_idle task without neighbour interfering.
> >
> > But the sched_idle will then probably quickly move on the idle smt2
> >
> > > And there seems to be no consideration about that currently.
> > > Is it worth improving that?
> >
> > This will complexify and extend the duration of the search loop  and
> > as mentioned above, it will most probably be a nop at the end because
> > of sched_idle task moving on smt2
> Indeed, the complexity is not worth.
> Thanks for the explanation.

BTW., if you disagree then you could add a bit of debug 
instrumentation to measure to what extent it's a nop at the end of the 
search loop, to turn the "most probably" statement into a specific 
number.

Thanks,

	Ingo
