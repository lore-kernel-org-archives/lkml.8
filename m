Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85131C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3D220771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCZEK4jB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGGM3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGM3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:29:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F45C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:29:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so49622809ljv.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHAnUb6aF5kllaqPnNoNljlloJ2RxzK0FxITSIwEHzE=;
        b=XCZEK4jB/rKmggy82uEAksA1XX4mwe1TBmbyF0sI4z2a/vWBqBB/GNye00Ugqvw0/y
         ygO/xQWFGvUXhYDKwdR/rAJKDf6lef68VA6LT82rYKVZ+B8YTbwiZ93HNb0c0cAfBVZr
         Kn1jU9CNPLv+L6C8Lq3fRqv4edDk6d/0QGj8dE1AgzuMcPjNhOqxJlHHVLVMZ2/BPkjB
         RhCZe1xmRHJt/CtWN1nTC/U0U6/Styyvi9ovSP4wsjNs5sVYz5RoxT0ufwvXOPDNKWca
         UBEXAZk3/eOMKl0hkC5Dg0yxm/jcVttpVk6sdObxHc0Uky7Gu46NJ0VYOXYM1wMdoUVb
         3MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHAnUb6aF5kllaqPnNoNljlloJ2RxzK0FxITSIwEHzE=;
        b=BLiJGrFalsBFAWRm8aYS7uemUDzh2IAGBsS3qtqNVobfKDvWTRf9XzM2qOorrPtmRs
         VaMSF8gAgaqb84qrea8OtFQMtZSZfYICvzK0PO2UqyWphmIqh/s2+/cG3O5sllSJzJrL
         Z8mz/OqHo5GjO+Hxci1Ums3KiCTaotBpuN6HdJTyYQ2ju9JkkNyRWQvxwv4jbR8hHudP
         JF3j1HAaH0XLnNIJXuJa0De+igTWHwx0pm5tG1RF1KiGJHelDPvYibM1GJJTDrINbZqc
         V/GTjHifmo+4UjqB+cZidpHdJ6CnztGb6Alx1ypSfLoOVq4zqprj87bd3Yv5OoIKKtb9
         C/8w==
X-Gm-Message-State: AOAM531P7xOni8VKT5sWCAJCZw9rmtXXZnIvgO1ssyv0hOzxufe+3fiW
        CjLheEVWuJ6LVZBFe5H1iz+TTrNDxSGPbR1Kaf1B5A==
X-Google-Smtp-Source: ABdhPJzjVcQ0GZwYrDbUTyQefKVVX3Cr8wOOK2MrwCuUdHF6B+gOQGDzRsMizW5LEzxHKLe8vCRaSqLKVgpWfo1rJis=
X-Received: by 2002:a2e:8059:: with SMTP id p25mr14214091ljg.156.1594124990477;
 Tue, 07 Jul 2020 05:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200630112123.12076-1-qais.yousef@arm.com> <CAKfTPtCjTCBbGN0gN_=7MJdiY3N-PPy0ApZWH5xd7KDQ9=0yMg@mail.gmail.com>
 <20200706104111.yfopcjm3kiqlxhx2@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200706104111.yfopcjm3kiqlxhx2@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 7 Jul 2020 14:29:39 +0200
Message-ID: <CAKfTPtDKb0Co5wEcKu3ZE2cJZs87Pma2oQaNQvRq8da26_xjcg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] sched: Optionally skip uclamp logic in fast path
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 at 12:41, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 07/03/20 14:09, Vincent Guittot wrote:
> > I have run the perf bench sched pipe that have have already run
> > previously with this v6 and the results are similar to my previous
> > tests:
> > The impact is -1.61% similarly to v2 which is better compared the
> > original -3.66% without your patch
>
> Thanks Vincent.
>
> Can you afford doing a capture of `perf record` and share the resulting
> perf.dat with vmlinux (with debug symbols)?

Will try to make it by end of the week

>
> Having a before/after capture would be even better.
>
> Not sure if we can do  much about this -1.61% in your case, but it'd be good to
> understand why if possible. perf bench sched pipe is very sensitive to tiniest
> of changes which could be due to binary-to-binary differences.
>
> Thanks
>
> --
> Qais Yousef
