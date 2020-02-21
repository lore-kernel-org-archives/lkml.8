Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1546EC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E58207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SppU/lWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgBUJZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:25:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41684 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgBUJZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:25:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so1450512ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 01:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vK9gXkaq53ofJ49UE1L9Wp4Au3Ns1Czs1X1tFZGqyvc=;
        b=SppU/lWhHyFBcKBlI1jC1V0PLSrtA82cfjWVcef4OOzcR8tLhxYt8Crn3+p0XUY0wG
         dyYTr9wpMHWVydwbMnlcb6IeYkbkdCCWz+GoO3HarWqohf7yIfpr6T+etohRYX4Te9oI
         MQL0C7GoCoHhqKCciY/QpAkzJkWsRgXC+Hvn/4+Jsb9toFmnYhdOInR1VdnUuzifFbrw
         hHk7BnP0XVkN8bfvqnYDKHOQftrJ55yg6JJm/fK9uc+sguZTd++A1SIHBevFBNYffKZy
         47kRIVOX2k8Blc0vlyjgH50ZHGfHmSdeeBHsa8lDvic104R6o7P4bJ9V7AwSo9IyeyZT
         dETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vK9gXkaq53ofJ49UE1L9Wp4Au3Ns1Czs1X1tFZGqyvc=;
        b=Atn4R8mq8yHOkXrhvPjBoveGx8Z4sCXP3//QeoEYdhxkvM4P3IKqkdv1pG1oNP/VB2
         6AO0JldNyQGi4d/cNkpbC3GlVIjaHH/Zun9YnKS02ypfe3WeUIiqEPhnGP0cPa7ftHT5
         mUbUuoDbshCOU4vIh2rrFq2DfI9cQn2d8MMa3wzUxxvAWI8yUsYKKzw8v6WG7oZ3sYCA
         jLzoSYu8e9rf4gI4nsH5lAeDByfnNtfTYLV8EnqhNConheYgu/Xt4egGzIgbX2WHbXP3
         HgKbyG4rfocLGn7dfGJz8odeLbSzYSTItgMX/m8IasUbItq5HhUDGkNsog6lwVBo1QAG
         CxPA==
X-Gm-Message-State: APjAAAVFIhRaTbpHoqHjnyDKGF10IfuQAOC9y8TjF2xbzSzDl/GNROxM
        rX6Z9U0BjvSi6CxTa4aN4QFIiJo/lE8l0MqNnIgF2A==
X-Google-Smtp-Source: APXvYqz8WbILD04N5uuNO+PYQTU6fPK0koydp6uAEyqdTFEIVeCC8yFgx1MXu57Q0VOD7fALQFETNiKVFJYmzgy82ZM=
X-Received: by 2002:a2e:909a:: with SMTP id l26mr20625508ljg.209.1582277139149;
 Fri, 21 Feb 2020 01:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org> <9fe822fc-c311-2b97-ae14-b9269dd99f1e@arm.com>
 <CAKfTPtD4kz07hikCuU2_cm67ntruopN9CdJEP+fg5L4_N=qEgg@mail.gmail.com>
 <d9f78b94-2455-e000-82bd-c00cfb9bbc8e@arm.com> <20200221090448.GQ3420@suse.de>
In-Reply-To: <20200221090448.GQ3420@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Feb 2020 10:25:27 +0100
Message-ID: <CAKfTPtAgyGrYaiUEm-MjLxH+pSYMnk4LFJ+_ogJ=cWVvaHMnsg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
To:     Mel Gorman <mgorman@suse.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 10:04, Mel Gorman <mgorman@suse.de> wrote:
>
> On Thu, Feb 20, 2020 at 04:11:18PM +0000, Valentin Schneider wrote:
> > On 20/02/2020 14:36, Vincent Guittot wrote:
> > > I agree that setting by default to SCHED_CAPACITY_SCALE is too much
> > > for little core.
> > > The problem for little core can be fixed by using the cpu capacity instead
> > >
> >
> > So that's indeed better for big.LITTLE & co. Any reason however for not
> > aligning with the initialization of util_avg ?
> >
> > With the default MC imbalance_pct (117), it takes 875 utilization to make
> > a single CPU group (with 1024 capacity) overloaded (group_is_overloaded()).
> > For a completely idle CPU, that means forking at least 3 tasks (512 + 256 +
> > 128 util_avg)
> >
> > With your change, it only takes 2 tasks. I know I'm being nitpicky here, but
> > I feel like those should be aligned, unless we have a proper argument against
> > it - in which case this should also appear in the changelog with so far only
> > mentions issues with util_avg migration, not the fork time initialization.
> >
>
> So, what is the way forward here? Should this patch be modified now,
> a patch be placed on top or go with what we have for the moment that
> works for symmetric CPUs and deal with the asym case later?
>
> I do not have any asym systems at all so I've no means of checking
> whether there is a problem or not.

I'm going to send a new version at least for patch 4 and 5 using
cpu_scale as initial value and fixing update_sg_wakeup_stats()

>
> --
> Mel Gorman
> SUSE Labs
