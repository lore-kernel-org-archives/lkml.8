Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFFBC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49322071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 08:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wimE45/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDYInI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:43:08 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2915C09B04A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 01:43:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 131so9646580lfh.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymKhdR3sym6qWBgeA4fIYtiq69uqrQtQw9UuLC9sywA=;
        b=wimE45/T2z13zqy3gnIRC8mnALm84IcGSFthoxOi8WafyXtBV+U+chrM3mvQDm8H9W
         3ixBfN/MgV0PtEjdBP1setFQ+VXqgYWKeVZLifeY/krUEHpds1hI3G5jl0BN6hCViZzi
         cF1biaChR3oVN8LpbsC+VqBcQE3+ZIEbrzPtQXmXXR39Y61SL1RSII4RJ9HaBN/zLok+
         jZEJ8Mv0gCsvDthMqvLRt44RIxO+9CCCIJ1U9JaNkKEZffqUmEZUW7Q+62nxRCZRQ49m
         lg3df7OWxhpUlWc72ed13Y824cAKWnmzERD4C2dLeGJkGWwYPm6j5uSuDu1rgERcZhUI
         1jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymKhdR3sym6qWBgeA4fIYtiq69uqrQtQw9UuLC9sywA=;
        b=aoIeN3WXEXNPk4TUNO/KYlDiUi0Suwo1Ltj8QQ4KFwz0Rc+bk5dEGt6yAILmS28Ndd
         dMGvJRdqhqg4r1ntcxeFutO1iae+vRowOcTeHlfj65Xmh8PR3gUOEqQnztDem03E0Fs8
         9nmi4pULiELXf+xvib5c0cSJWzy8bXW9NYw9B9UYhylmRTBXwY5lM/nWT2yImSdmNKO/
         LJ0RcYqIimQp7ShSfm48dxWjIEjrrb49RfZnC5vaf8kPDCGitTstjqq77Qq+Zorjd3lS
         v49ROYr8JPekQNaE4xOGxAybhOnMsU0qFbqRS927OsrNB5hZSUmwOralR2IqqYlpJs5R
         HWjg==
X-Gm-Message-State: AGi0PuaaQx6jFkpW1wTiZOSYoCUjw1RqCZk0UDF+laBqSnQef5jl+f6q
        SA67QHMePBXaQVY8yEXk0y5B5XHUDGOiYgnqGSA01A==
X-Google-Smtp-Source: APiQypJHox3Z2AA2Nx1IckOkSqxv/KmHW2TFlSZVm6DDpcSt6AEVjGbVuhyGCeHtsBMEzfYOPu1zsUabKhCbpqNirhQ=
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr8921259lff.190.1587804186105;
 Sat, 25 Apr 2020 01:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200421004749.GC26573@shao2-debian> <20200425012306.13516-1-hdanton@sina.com>
In-Reply-To: <20200425012306.13516-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 25 Apr 2020 10:42:54 +0200
Message-ID: <CAKfTPtCvnDoDm9J611uk+fpyPqyh=zn1Rbo=L=MrqbD_jMOx5A@mail.gmail.com>
Subject: Re: [LKP] [sched/fair] 6c8116c914: stress-ng.mmapfork.ops_per_sec
 -38.0% regression
To:     Hillf Danton <hdanton@sina.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Tao Zhou <ouwen210@hotmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 at 03:23, Hillf Danton <hdanton@sina.com> wrote:
>
>
> Hi Xing
>
> On Fri, 24 Apr 2020 16:15:45 +0800 Xing Zhengjun wrote:
> >
> > Hi Tao,
> >
> >     Do you have time to take a look at this? Thanks.
> >
> > On 4/21/2020 8:47 AM, kernel test robot wrote:
> > >
> > > Greeting,
> > >
> > > FYI, we noticed a 56.4% improvement of stress-ng.fifo.ops_per_sec due to commit:
> > >
> > >
> > > commit: 6c8116c914b65be5e4d6f66d69c8142eb0648c22 ("sched/fair: Fix condition of avg_load calculation")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > in testcase: stress-ng
> > > on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 128G memory
> > > with following parameters:
> > >
> > >     nr_threads: 100%
> > >     disk: 1HDD
> > >     testtime: 1s
> > >     class: scheduler
> > >     cpufreq_governor: performance
> > >     ucode: 0xb000038
> > >     sc_pid_max: 4194304
> > >
>
> Here is a tiny workaround. If it makes a sense to you see if it helps
> cure the regression.
>
> Hillf
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8744,6 +8744,16 @@ find_idlest_group(struct sched_domain *s
>
>         switch (local_sgs.group_type) {
>         case group_overloaded:
> +               /*
> +                * push the task if it helps cut the imbalance in the
> +                * number of running tasks
> +                */
> +               if (local_sgs.sum_h_nr_running >
> +                   idlest_sgs.sum_h_nr_running)
> +                       return idlest;
> +               else
> +                       return NULL;

Taking into account nr_running when overloaded to bypass load
comparison just break the fairness and the spread of load and will
cause regression for other use cases



> +
>         case group_fully_busy:
>                 /*
>                  * When comparing groups across NUMA domains, it's possible for
> --
>
