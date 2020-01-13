Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C224BC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95759207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YL1zGWcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgAMJWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:22:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32057 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725992AbgAMJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578907355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vDjgYq7ZyN6ANmr5w8dkEbzgzAr+C/qYxfFwrZDrR80=;
        b=YL1zGWcNZiSehlNRqZqRXZxNVZ8I3N5hhk5wFGDRB7HSfL9SUnR+T/I1d/AOhMVdwhtC1W
        QD1Bn6fIlwFYXUFxbvEvDJX3ll8cPQFtJ611YuGpgEgt5HNADBwhxgFeEiUiDXpC9NboDd
        EVJQvaCt4Be6ej091JZc/hnZjbBnML4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-X4clIU2uPca0kufNyl8HTA-1; Mon, 13 Jan 2020 04:22:21 -0500
X-MC-Unique: X4clIU2uPca0kufNyl8HTA-1
Received: by mail-wr1-f70.google.com with SMTP id i9so4734278wru.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 01:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vDjgYq7ZyN6ANmr5w8dkEbzgzAr+C/qYxfFwrZDrR80=;
        b=YSpyfO9Okss8Ek/v3OkwxsoKAq6Pjn2rv7qPqKk4MG6h38/cnFmCDi+UdbZtahPXDb
         sfppUAcKyChBc5DBu+jZ5VY2uSXXeTeST2TTf71arPtxmcjqogxPVlnNhE/iI7StPjoC
         7ULZh0z85S4YRTEPJVPPg3qZkZaBraLJG8tOKEihLlgPuYby3C7u7jrSOyBUAfsdkHjH
         yZO3Ul1mEWHxIVfV2TudsW6uhtHUCjWmlgCZdwC+xWH8RPG4KAfWMYkxY31/6tNM09mH
         yMiRJYahUEI96Q8RjSxTrWiA0k3MKycGm148QF7f19bz/u1oly/kZa1PSBTZ8FMKgx1j
         +dLg==
X-Gm-Message-State: APjAAAV5misCKXGuFd0gVw0nIdpvC61uf5rPofgXhyM7J9V+i/tdp+Il
        751mKnHe+M/0u+YR9lvltz6JrnHUYGRVtXIQUeodTtlDPH0FAYBZXiRW3HQCS+D936XW3HJZDNf
        lYgJ1pypqVJtCesj81ZChLuwT
X-Received: by 2002:a5d:6901:: with SMTP id t1mr16295619wru.94.1578907340044;
        Mon, 13 Jan 2020 01:22:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqywO43FDSzRFVJXhpE0bMQK15xlBUilu3eCq1gBFqg2KfJ8N1IebpL4B3GFI3sZeXORGEfoWw==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr16295592wru.94.1578907339673;
        Mon, 13 Jan 2020 01:22:19 -0800 (PST)
Received: from localhost.localdomain ([151.29.30.195])
        by smtp.gmail.com with ESMTPSA id a1sm14250274wrr.80.2020.01.13.01.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 01:22:18 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:22:16 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Philipp Stanner <stanner@posteo.de>
Cc:     linux-kernel@vger.kernel.org, Hagen Pfeifer <hagen@jauu.net>,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Subject: Re: SCHED_DEADLINE with CPU affinity
Message-ID: <20200113092216.GA14325@localhost.localdomain>
References: <1574202052.1931.17.camel@posteo.de>
 <20191120085024.GB23227@localhost.localdomain>
 <1a322df842e0dc5646ef1198ea0bbe668d94646e.camel@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a322df842e0dc5646ef1198ea0bbe668d94646e.camel@posteo.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the delay in repling (Xmas + catching-up w/ emails).

On 24/12/19 11:03, Philipp Stanner wrote:
> On Wed, 20.11.2019, 09:50 +0100 Juri Lelli wrote:
> > Hi Philipp,
> 
> Hey Juri,
> 
> thanks so far; we indeed could make it work with exclusive CPU-sets.

Good. :-)

> On 19/11/19 23:20, Philipp Stanner wrote:
> > 
> > > from implementing our intended architecture.
> > > 
> > > Now, the questions we're having are:
> > > 
> > >    1. Why does the kernel do this, what is the problem with
> > > scheduling with
> > >       SCHED_DEADLINE on a certain core? In contrast, how is it
> > > handled when
> > >       you have single core systems etc.? Why this artificial
> > > limitation?
> > 
> > Please have also a look (you only mentioned manpage so, in case you
> > missed it) at
> > 
> > https://elixir.bootlin.com/linux/latest/source/Documentation/scheduler/sched-deadline.rst#L667
> > 
> > and the document in general should hopefully give you the answer
> > about
> > why we need admission control and current limitations regarding
> > affinities.
> > 
> > >    2. How can we possibly implement this? We don't want to use
> > > SCHED_FIFO,
> > >       because out-of-control tasks would freeze the entire
> > > container.
> > 
> > I experimented myself a bit with this kind of setup in the past and I
> > think I made it work by pre-configuring exclusive cpusets (similarly
> > as
> > what detailed in the doc above) and then starting containers inside
> > such
> > exclusive sets with podman run --cgroup-parent option.
> > 
> > I don't have proper instructions yet for how to do this (plan to put
> > them together soon-ish), but please see if you can make it work with
> > this hint.
> 
> I fear I have not understood quite well yet why this
> "workaround" leads to (presumably) the same results as set_affinity
> would. From what I have read, I understand it as follows: For
> sched_dead, admission control tries to guarantee that the requested
> policy can be executed. To do so, it analyzes the current workload
> situation, taking especially the number of cores into account.
> 
> Now, with a pre-configured set, the kernel knows which tasks will run
> on which core, therefore it's able to judge wether a process can be
> deadline scheduled or not. But when using the default way, you could
> start your processes as SCHED_OTHER, set SCHED_DEADLINE as policy and
> later many of them could suddenly call set_affinity, desiring to run on
> the same core, therefore provoking collisions.

But setting affinity would still have to pass admission control, and
should fail in the case you are describing (IIUC).

https://elixir.bootlin.com/linux/latest/source/kernel/sched/core.c#L5433

Best,

Juri

