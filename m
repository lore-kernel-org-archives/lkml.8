Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB5FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF36A2076F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKdPfBKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCTQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:55:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33499 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCTQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:55:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id r22so127432ljh.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4z5FArRI6ZI9z+YBG6elRHDfEUum94j1AyAov9QzXEc=;
        b=gKdPfBKoMiqquyM9Up2fen6ZThs48b9Mmeg+UT8/jR/AoSyZPYvNRBwyuL3YfND4S/
         fnydcMe4oRsj9VbuICox1eb+NUj9Quef36eoZ46n3YGUsCt7rEHN9Joyo/w2gZ9oNS4M
         RnpL61DVPF5yDugXI1+oZMP6BayEoQZhsYkKJjtzg4v3TR4zWEpo3kwYQs8+owjoy7i7
         xrCvUZ+LT7xpWgqYwjAZpHuBWBGVDLOM+6vdJKrop2ODOUAVJd7ROeje8c7Xl19tY7BC
         xAKTYNbu857fp/m33B5dSEnQhp4PRtNC3bICb2QIi8lCKIyqUMQDu3gQ+7eVrCXzu3py
         si0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z5FArRI6ZI9z+YBG6elRHDfEUum94j1AyAov9QzXEc=;
        b=g1i3rLXUUhUGSr2QmyxtgfFfA3qlzgPt6mOegk04N4rNI7VDygW/incGCIpRvfeyJM
         HQODgTla9O6DPtxPhcRFPF836pIaOKf0/EHfFGjWBuVZ2X7VebFwiyIUAxdvm0DnAxtz
         Z6Amk+iFY+rKgWcZwXOZEIjexc3ujtoIw0pZZ7dr+aTJXlC4mXhzbskv2HnhTmRnL7uy
         0tpBrqKfRn84Uya4QRyfAQBInaLAy6/s3jPH9vlLjRjrJmXelzritHDOZeBDP/CwjvTI
         07Feqn/umQ+YE5paSMfiTGIKgshbzugJrcCerH2AhLITTKPArQ4qiSBd3ZmWuaOmdcpX
         pkyw==
X-Gm-Message-State: ANhLgQ3w31GhFmvylaFaXVJniQhAAjwS5NoJiPUsYdYaB/elxQHpsN6F
        mJtCDAvUaOkhjIjLEyy4BOgBBSKk9dA50WOLnHe5Xg==
X-Google-Smtp-Source: ADFU+vuASp4G6ZHHo5jDF0jF/xUZ57AL2MWTT6WY+xE5mxO6vc/H3VdrUXy6gD1Pmrq2pI7GrzAU87P2VDYkW2xsqjU=
X-Received: by 2002:a2e:9d8c:: with SMTP id c12mr5768012ljj.137.1584723309654;
 Fri, 20 Mar 2020 09:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200320151245.21152-1-mgorman@techsingularity.net>
 <20200320151245.21152-5-mgorman@techsingularity.net> <CAKfTPtAUuO1Jp6P73gAiP+g5iLTx16UeBgBjm_5zjFxwiBD9=Q@mail.gmail.com>
 <20200320164432.GE3818@techsingularity.net>
In-Reply-To: <20200320164432.GE3818@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 20 Mar 2020 17:54:57 +0100
Message-ID: <CAKfTPtBixZKDES_i3Lnsj1eAa_kVi-zHv-0uE8uTsKOBcjmkYg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: Track possibly overloaded domains and
 abort a scan if necessary
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 at 17:44, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Mar 20, 2020 at 04:48:39PM +0100, Vincent Guittot wrote:
> > > ---
> > >  include/linux/sched/topology.h |  1 +
> > >  kernel/sched/fair.c            | 65 +++++++++++++++++++++++++++++++++++++++---
> > >  kernel/sched/features.h        |  3 ++
> > >  3 files changed, 65 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > index af9319e4cfb9..76ec7a54f57b 100644
> > > --- a/include/linux/sched/topology.h
> > > +++ b/include/linux/sched/topology.h
> > > @@ -66,6 +66,7 @@ struct sched_domain_shared {
> > >         atomic_t        ref;
> > >         atomic_t        nr_busy_cpus;
> > >         int             has_idle_cores;
> > > +       int             is_overloaded;
> >
> > Can't nr_busy_cpus compared to sd->span_weight give you similar status  ?
> >
>
> It's connected to nohz balancing and I didn't see how I could use that
> for detecting overload. Also, I don't think it ever can be larger than
> the sd weight and overload is based on the number of running tasks being
> greater than the number of available CPUs. Did I miss something obvious?

IIUC you try to estimate if there is a chance to find an idle cpu
before starting the loop and scanning the domain and abort early if
the possibility is low.

if nr_busy_cpus equals to sd->span_weight it means that there is no
free cpu so there is no need to scan

>
> --
> Mel Gorman
> SUSE Labs
