Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BF1C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0C1217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYshfHHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgBNHnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:43:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40232 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgBNHnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:43:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18so9611482ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvJYH2MyEwOmoRDTW33GT1X1UiFAr3wzvG5eLryUgnQ=;
        b=pYshfHHXjrzDrzndltn8xGCx7SnafQI6R+CZmDK8RJ1YjHSuOujJ22SyvJtwo+x3tr
         VZDEZw3Lo4/q9SZ+yDhUa/BBM35jZpf5K3SSno7BMf7lctmjyRJt3w4bye8FlVKGG/zl
         r+fKJG4wtwTtxBvYHKhC23ztBvMrOOpjt7caTUdByAUsN99AczzI72rH/TiEYgHjrOGI
         DbQhumjej7KxGN14riV0eqflX1N9CW6I4XPe8rBsPq3CULTC5BoYvzixcQcFkhfOZZAm
         1KzfPshq6gx+naYwkNYmdST896DdcM+ETp4+pVxrSeUioPlQM3Jvga1YHZaPMVp8NArY
         xHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvJYH2MyEwOmoRDTW33GT1X1UiFAr3wzvG5eLryUgnQ=;
        b=K9gCjztEePWAGDbvEwcNkjRHWwlRjHl+3B3BoE6ar2xizqS+JLXc2qnUycLxSRMZhT
         9f2T6kPPncUJ+iCi8hHKlCPbZBjxxYCqfUF2NmJZN59OwEC8hCGD2ESnmdl2t5uLYvCj
         fCzIKm7oJmalOI0/6SWN9QrHEy4yHqTo4a+FyrixLX7rFzl+L2p9DUDmWaWWJlduIvc7
         1r2axfoSqMTXtM7hW5AiCYTqSPly9Dzg3eOHc3895t+QMDnvrpFrSIh+gixXsTBMQU4B
         54aZmEV2pkE3WC1xtMmo39anPu11UiiV4jeQU3M5Pb3eDC9sXtKtpQI+0gb/qNSY0CcP
         lo2w==
X-Gm-Message-State: APjAAAVdqD+ToPkJhC4RQqcecadcuJ8Jr2Th2vH10d8aQwymNXVZd0nh
        x+nJR7pw82msnHPI1xeoVz23vIOf2fjKVmsal9Uqf+yrnGk=
X-Google-Smtp-Source: APXvYqwI6CpdrrFSyFeDih+wFFIqfBA88OW4d98kr0AHi+c1sN/Uks74G/afERWgfkYNqEGaQedcUMI+/Haw9uc3IgY=
X-Received: by 2002:a2e:909a:: with SMTP id l26mr1135486ljg.209.1581666209033;
 Thu, 13 Feb 2020 23:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-4-vincent.guittot@linaro.org> <20200213173602.GQ14897@hirez.programming.kicks-ass.net>
In-Reply-To: <20200213173602.GQ14897@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 14 Feb 2020 08:43:16 +0100
Message-ID: <CAKfTPtC+Es88ocmUcNveN6bpHAOdZ3s9Zbmtf0zmHiQFA+H+rw@mail.gmail.com>
Subject: Re: [RFC 3/4] sched/fair: replace runnable load average by runnable average
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 at 18:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 11, 2020 at 06:46:50PM +0100, Vincent Guittot wrote:
> > @@ -367,6 +367,14 @@ struct util_est {
> >   * For cfs_rq, it is the aggregated load_avg of all runnable and
> >   * blocked sched_entities.
> >   *
> > + * [runnable_avg definition]
> > + *
> > + *   runnable_avg = runnable%
>
>                                  * SCHED_CAPACITY_SCALE
>
> right, just like we have for util_avg.
>
> > + *
> > + * where runnable% is the time ratio that a sched_entity is runnable.
> > + * For cfs_rq, it is the aggregated runnable_avg of all runnable and
> > + * blocked sched_entities.
>
> Which is a verbatim repeat of the runnable% definition for load_avg,
> right? Perhaps re-arrange the text such that we only have a single
> definition for each symbol?

yes . will do

>
> > + *
> >   * [util_avg definition]
> >   *
> >   *   util_avg = running% * SCHED_CAPACITY_SCALE
>
> Can you please split this patch in two? First remove everything
> runnable_load_avg, and then introduce runnable_avg.

ok.

>
> I didn't quickly spot anything off, and you're right that runnable vs
> util is an interesting signal.
