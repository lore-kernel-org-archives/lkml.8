Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1836C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8179A2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBlxvOFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAMPVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:21:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44265 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgAMPVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:21:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id az3so3926088plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xio3ltsZ5CL1rGBail8nUykniEUKdTJ+MhVEQqazwvU=;
        b=XBlxvOFSWkhf5jOxtE1Jstbl/y1fHgss2bgjBDGytbhH8Aq/6Te18ZGLd92cxH3SoR
         2v/9Y6BkFaLkj56QsKKo9yEBtiWdkZ4Q0D6dhJggBWWJeEH5eWu0N4HSuxaNHkHeWkx5
         69gjs+FOSPISRwpreQg5IlDtCIrtXwVNJXfO3AktEPrG3Rl3rI7ZYx0Ga3PL7MJC/aB8
         skZBN2UPl0R4zMOA/GUVivuDD9wxODbeRXG3IXzjP20npcrKtE7IYOv+cD2vPPMhPEnK
         pia71Duax2cEASLqn+YA9PyqA9Ecf55dHUdPMSp+2fQ7LHJ4zFvhKQ8RpKJstZZeNJei
         610w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xio3ltsZ5CL1rGBail8nUykniEUKdTJ+MhVEQqazwvU=;
        b=XM9y+bGDhdY2LRf/oS1uFZtfkpbXCg59QpwV1JVFo4s/iSg14f5LzWDP0oRbHPA181
         z5VY2DFf4N7vJV4+X+RCplMN9+cqo9AFTPcqvVqyNxIsSXelyzB101Dpl3cdIa+aSDl+
         xz/KfeFWe4W7W6nm5NKKeggvhN0Bmb3m1e6Q6zcPbLltD3mNKxHbIZqBdAV5N618ziTC
         R8KCbtJZx6MQBwU7LUIV1H8rQFNjeIWRp7t2QzVet2jyIEQzYivC4CMvYNE64mrA8/s1
         gLm/NsRyLPVVidTfm8LeOTKnLYovBZ5ACSMFcjNVruaPQGY89IpNVy7h+AvKF56o7E49
         X97w==
X-Gm-Message-State: APjAAAW6fq3cGRxqG1WKsWTNk29MNhBl155i03/rj6wCRwVpaHB5aMg4
        j5mQF0dh66USD97H5J5zF4kSvQ==
X-Google-Smtp-Source: APXvYqyytvMkDTSyPxScTbeP6EkWGYOBA7VViLmMT3aJFn+73OPR2r5RlBpFUBv6hrE0NeeXjZrNQg==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3mr20933451plr.106.1578928872619;
        Mon, 13 Jan 2020 07:21:12 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id w4sm13737264pjt.23.2020.01.13.07.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 07:21:12 -0800 (PST)
Date:   Mon, 13 Jan 2020 23:21:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v4 1/2] perf parse: Refactor struct perf_evsel_config_term
Message-ID: <20200113152103.GC10620@leoy-ThinkPad-X240s>
References: <20200108142010.11269-1-leo.yan@linaro.org>
 <CANLsYkzv2Di-qeU1Q3M4Ro21hQ09eE26FBjeP1A9uSsA_W2Uww@mail.gmail.com>
 <20200109050753.GA24741@leoy-ThinkPad-X240s>
 <20200109163424.GA5721@xps15>
 <20200110150410.GG82989@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110150410.GG82989@krava>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 04:04:10PM +0100, Jiri Olsa wrote:
> On Thu, Jan 09, 2020 at 09:34:24AM -0700, Mathieu Poirier wrote:
> 
> SNIP
> 
> > 
> > If we are to deal with all flields of the union, I think it should be as below:
> > 
> >         union {
> >                 bool            cfg_bool;
> >                 int             cfg_int;
> >                 unsigned long   cfg_ulong;
> >                 u32             cfg_u32;
> >                 char            *cfg_str;
> >         } val;
> > 
> > But just dealing with the "char *" as below would also be fine with me:
> > 
> >         union {
> >                 u64           period;
> >                 u64           freq;
> >                 bool          time;
> >                 u64           stack_user;
> >                 int           max_stack;
> >                 bool          inherit;
> >                 bool          overwrite;
> >                 unsigned long max_events;
> >                 bool          percore;
> >                 bool          aux_output;
> >                 u32           aux_sample_size;
> >                 u64           cfg_chg;
> >                 u64           num;
> >                 char          *str;
> >         } val;
> > 
> > > 
> > > struct perf_evsel_config_term {
> > >         struct list_head      list;
> > >         enum evsel_term_type  type;
> > >         union {
> > >                 u64           period;
> > >                 u64           freq;
> > >                 bool          time;
> > >                 char          *callgraph;
> > >                 char          *drv_cfg;
> > >                 u64           stack_user;
> > >                 int           max_stack;
> > >                 bool          inherit;
> > >                 bool          overwrite;
> > >                 char          *branch;
> > >                 unsigned long max_events;
> > >                 bool          percore;
> > >                 bool          aux_output;
> > >                 u32           aux_sample_size;
> > >                 u64           cfg_chg;
> > > +               u64           num;
> > > +               char          *str;
> > >         } val;
> > >         bool weak;
> > > };
> > > 
> > > > I will let Jiri make the
> > > > final call but if we are to proceed this way I think we should have a
> > > > member per type to avoid casting issues.
> > > 
> > > Yeah, let's see what's Jiri thinking.
> > > 
> > > Just note, with this change, I don't see any casting warning or errors
> > > when built perf on arm64/arm32.
> > 
> > At this time you may not, but they will happen and it will be very hard to
> > debug.
> 
> hi,
> sry for late reply..
> 
> I think ;-) we should either add all different types to the union
> or just add 'str' pointer to handle strings correctly.. which seems
> better, because it's less changes and there's no real issue that
> would need that other bigger change

Thanks for the suggestion, Jiri.

Have sent out patch v5 with following the ideas.

Thanks,
Leo Yan
