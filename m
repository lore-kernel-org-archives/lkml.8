Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E333C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F50D2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkuhoMCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbgIARSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732650AbgIARSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:18:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A9C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:18:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id l9so861527plt.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dW7GB60WM2kkdTwVir0X+YeJCT4DzRMmVe7Fu3eHOuE=;
        b=BkuhoMCQPMF9r7IbrTJB856k16mWef66ZLvrE0tI5gwb64pfmFnQ1HDIwhxGhJcGuO
         SB4GYxlcSHw/KjaggedgpPQPVAD5UiMZ5p6u2H/nLBFtCU5LoveZH39Hbb2bFBTHWzNZ
         LrGCy1TC0dlnpz6WnGC+wyajcxUhmxz4TBqJhm9fwOUzBo3UbS46sfgIqkUNXD22RUzm
         3sWtlRULn44JvJ1GuwGccLQWSGOXvpWDlDwFN8oHh4e0+vjIGRPNhLkPYQ4PwwyD/7JQ
         1TI0m8fj0IjTUJtLxEZKFSWgsAzDkJw7mfQeLCKbe9HBedBus8lziMtxUcXAisWO19l4
         BFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dW7GB60WM2kkdTwVir0X+YeJCT4DzRMmVe7Fu3eHOuE=;
        b=TBnf0naNwNP11ZBa399jdBA97ogwlTdGMPJoARFJTx7DCJxWCIhQPuHqpFtqo38kLd
         yaDlEz7aYXSln+tAktjtsTR2wkQlIcJHWGJzuygCGZEKBolzSN+A83uywb91zKMQw+ed
         zcmQW8KdBoV9EdD73rl+QZV5dEdkmtL4SpRkI9939IB7hZjpNHKua1sHWUVuJibhpqEr
         WAjtueOZJqpEvAydP/Wu3r1+xEspLFja1zC+H5LGceBy2yHtQ/5tHEilM0qC7I5geXkJ
         10pAsV2leWUUcAm5oJPLoRtiUDUkl8X8lDMCw+pdyU4ZM9ONd/R8HIZvM0pahdvPCpnD
         7lZg==
X-Gm-Message-State: AOAM533oOjzWTIHuwczw5y+OIiIdpBjkcQ31kmhzasbwN5OHUBACUmkz
        lVhJj5zIKhj78gfnZIi5OTnscOLlMLnIhQ==
X-Google-Smtp-Source: ABdhPJyXHh/LWDGrGPsvzYmoxDsHwlqpFhaZQXh71pUs6QyW6PpXsHAPr3Z5mP+arjHcXouGnHTUtA==
X-Received: by 2002:a17:90a:9292:: with SMTP id n18mr2620785pjo.159.1598980696876;
        Tue, 01 Sep 2020 10:18:16 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b15sm2480105pft.84.2020.09.01.10.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 10:18:16 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:18:14 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org
Subject: Re: [PATCH] coresight: etm4x: Handle unreachable sink in perf mode
Message-ID: <20200901171814.GB236120@xps15>
References: <20200818192931.168584-1-suzuki.poulose@arm.com>
 <20200819192200.GA3845366@xps15>
 <92f6080e-8168-fc6e-ec76-82560b91c36e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f6080e-8168-fc6e-ec76-82560b91c36e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Tue, Sep 01, 2020 at 11:28:55AM +0100, Suzuki K Poulose wrote:
> On 08/19/2020 08:22 PM, Mathieu Poirier wrote:
> > Hi Suzuki,
> > 
> > On Tue, Aug 18, 2020 at 08:29:31PM +0100, Suzuki K Poulose wrote:
> > > If the specified/hinted sink is not reachable from a subset of the CPUs,
> > > we could end up unable to trace the event on those CPUs. This
> > > is the best effort we could do until we support 1:1 configurations.
> > > Fail gracefully in such cases avoiding a WARN_ON, which can be easily
> > > triggered by the user on certain platforms, like :
> > > 
> > > [10919.513250] ------------[ cut here ]------------
> > > [10919.517861] WARNING: CPU: 2 PID: 24021 at
> > > drivers/hwtracing/coresight/coresight-etm-perf.c:316 etm_event_start+0xf8/0x100
> > > ...
> > > 
> > > [10919.564403] CPU: 2 PID: 24021 Comm: perf Not tainted 5.8.0+ #24
> > > [10919.570308] pstate: 80400089 (Nzcv daIf +PAN -UAO BTYPE=--)
> > > [10919.575865] pc : etm_event_start+0xf8/0x100
> > > [10919.580034] lr : etm_event_start+0x80/0x100
> > > [10919.584202] sp : fffffe001932f940
> > > [10919.587502] x29: fffffe001932f940 x28: fffffc834995f800
> > > [10919.592799] x27: 0000000000000000 x26: fffffe0011f3ced0
> > > [10919.598095] x25: fffffc837fce244c x24: fffffc837fce2448
> > > [10919.603391] x23: 0000000000000002 x22: fffffc8353529c00
> > > [10919.608688] x21: fffffc835bb31000 x20: 0000000000000000
> > > [10919.613984] x19: fffffc837fcdcc70 x18: 0000000000000000
> > > [10919.619281] x17: 0000000000000000 x16: 0000000000000000
> > > [10919.624577] x15: 0000000000000000 x14: 00000000000009f8
> > > [10919.629874] x13: 00000000000009f8 x12: 0000000000000018
> > > [10919.635170] x11: 0000000000000000 x10: 0000000000000000
> > > [10919.640467] x9 : fffffe00108cd168 x8 : 0000000000000000
> > > [10919.645763] x7 : 0000000000000020 x6 : 0000000000000001
> > > [10919.651059] x5 : 0000000000000002 x4 : 0000000000000001
> > > [10919.656356] x3 : 0000000000000000 x2 : 0000000000000000
> > > [10919.661652] x1 : fffffe836eb40000 x0 : 0000000000000000
> > > [10919.666949] Call trace:
> > > [10919.669382]  etm_event_start+0xf8/0x100
> > > [10919.673203]  etm_event_add+0x40/0x60
> > > [10919.676765]  event_sched_in.isra.134+0xcc/0x210
> > > [10919.681281]  merge_sched_in+0xb0/0x2a8
> > > [10919.685017]  visit_groups_merge.constprop.140+0x15c/0x4b8
> > > [10919.690400]  ctx_sched_in+0x15c/0x170
> > > [10919.694048]  perf_event_sched_in+0x6c/0xa0
> > > [10919.698130]  ctx_resched+0x60/0xa0
> > > [10919.701517]  perf_event_exec+0x288/0x2f0
> > > [10919.705425]  begin_new_exec+0x4c8/0xf58
> > > [10919.709247]  load_elf_binary+0x66c/0xf30
> > > [10919.713155]  exec_binprm+0x15c/0x450
> > > [10919.716716]  __do_execve_file+0x508/0x748
> > > [10919.720711]  __arm64_sys_execve+0x40/0x50
> > > [10919.724707]  do_el0_svc+0xf4/0x1b8
> > > [10919.728095]  el0_sync_handler+0xf8/0x124
> > > [10919.732003]  el0_sync+0x140/0x180
> > > 
> > > Fixes: f9d81a657bb8 ("coresight: perf: Allow tracing on hotplugged CPUs")
> > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-etm-perf.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > index 1a3169e69bb1..9d61a71da96f 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > @@ -321,6 +321,16 @@ static void etm_event_start(struct perf_event *event, int flags)
> > >   	if (!event_data)
> > >   		goto fail;
> > > +	/*
> > > +	 * Check if this ETM is allowed to trace, as decided
> > > +	 * at etm_setup_aux(). This could be due to an unreachable
> > > +	 * sink from this ETM. We can't do much in this case if
> > > +	 * the sink was specified or hinted to the driver. For
> > > +	 * now, simply don't record anything on this ETM.
> > > +	 */
> > 
> > Can you provide more details on the scenario and the topology of the system?
> > Without either it is hard to wrap my head around the problem to address.
> > Having that information in the changelog would go a long way.
> 
> Sure. This was detected on N1SDP with the following topology, with the
> command :
> 
> 
> $ perf record -e cs_etm/@tmc_etf0/ --per-thread dd if=/dev/zero of=BIGFILE
> bs=1M count=100
> 
> 
> CPU0
>       \
>         Funnel0 ---- ETF0 --
>       /                      \
> CPU1
>                                Funnel2
> CPU2
>       \                      /
>         Funnel1 ---- ETF1 --
>       /
> CPU3
> 
> 
> Basically, a pair of CPUS (0&1, 2&3 respectively) are connected to a static
> funnel followed by a TMC-ETF, before connecting to a main
> funnel which merges the ETMs and the STM on the system.
> 
> In such a case, if the user selects tmc_etf0 as the sink for a perf
> session this could trigger a warning when starting the event on ETM2
> as we haven't been able to create a path. Also the CPU2 is cleared in
> the event_data->cpumask.

Ok, that's the kind of topology I imagined you were dealing with.

> 
> I will add the above to the commit log.

Yes please.

> 
> For now we don't really support multiple sinks for a perf session. This
> will need to be addressed for the per-CPU buffer scenario. But, we
> should fix the current logic until we get there, to avoid triggering
> the warnings, which can be done quite easily on these systems, which
> are not really per-CPU buffers.

I agree that it should fail gracefully.  

> 
> > 
> > I'm sure this is a per-thread scenario because there is more than one CPU per
> 
> Yes, it is a per-thread scenario.
> 
> > event.  I'm also suspecting this is on a system where there is one sink per CPU
> > cluster, and that is not supported.
> 
> No, that is not exactly the case, from the topology above. But not N:1
> either. More of N:M and this is possible on systems with per cluster ETFs.
> 
> > 
> > If I am right on both account I am questionning the "Fixes".  On a system with
> > N:1 topology the code introduced by f9d81a657bb8 will work in the event a CPU is
> > hotplugged in.  The code introduced in this patch is simply to prevent a
> 
> Correct. But, without the above commit, we would have failed while
> creating a path to the sink, because if a CPU was offline then we don't
> care about a path from that ETM. So this warning is essentially
> triggered only after the above commit and thus the Fixes tag.

That is an equally valid argument.

> 
> > warn_on() trace from being generated on systems that aren't supported.  It should
> > have a "stable" tag.
> 
> Cheers
> Suzuki
