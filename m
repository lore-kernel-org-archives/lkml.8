Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BED7C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91CB207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmfnTRRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgEKTX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731372AbgEKTWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:22:18 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BC7C05BD11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:22:14 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so8531989lfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtJ4kxjOq083rsrU7FzbsC8k/UcQfxtvZaNold18Huw=;
        b=NmfnTRRXFR1yC12A035raRR7k2MTzKimuySNTOniX7UHNqNuQxN8JQasmHLs3XWdbw
         93OBXjwFtwBGswh/IO4FZgcD6vkYS1JkzWK1BWaAf3SDuFSAj/z0GHUuFw6+OiJMxZwB
         oACeqNRuIJjoVwkawNLHNJwMBWJqIirLMFIT5VoM8inK5GZXs5ej2qGLD5KIXsWLVSLM
         QVZ7SYC4itObMJHcFnmEKJLMCaGzGzs2n2qzMf+dyjyLTzePNYE1aZbACmyVSs2WYA2p
         MY4DrCmeD7rR4w+G21awH5Cf8xdX2G4Pla59C21t8L7keJGs8kTFr4HAm239FuEyy1S+
         RNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtJ4kxjOq083rsrU7FzbsC8k/UcQfxtvZaNold18Huw=;
        b=WUUHeCYLn4jiH5I+K17OtB0qF+sidZPDzFHYIxKknCrgyOO2EqVfOSW4ufvu5LfbgH
         hh2xr/SeYlTJQtQA/jebcxsZTUr6vE03P3Atu7xuoyv0gkYGAFiQNLxKmccpV+zngUkx
         BO7VQ6O8KjgAYpIXT2m+rf+Mg+iNXdthM0m+nMjzOc+ggFiqc+vMXnDr8fxZt/cLtinG
         D0IuxQLeSCA08johhxBxmk6kY/3iMBwTMmPEXXnvkD5H7DkbqwGiqvUD46Yc+GsBlpRB
         r4ko13KpdR786clwwwHLE+xiSf9iKtSkK2hW5Wme2yowOue35yO0to80xgUPkk4eintq
         XTxQ==
X-Gm-Message-State: AOAM5309/AZG68TSoR1Kjtq74groF0be+uKuIqReBuOaFcMKu6tDwAcg
        Y73TMEdMEwCbtd0GLLpeGGsUvfGbN+EAwX5qO8t08TymOAg=
X-Google-Smtp-Source: ABdhPJxWI7+jzof/hS/myvLB1Kko+0eXaSOvWfVpOKGYGeuuBEE1lt3w2J7TrT2IbzqyDICo4NQlqZN5HOpmpNNPgYI=
X-Received: by 2002:a19:4883:: with SMTP id v125mr11929401lfa.95.1589224933210;
 Mon, 11 May 2020 12:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com> <20200508151515.GA25974@geo.homenetwork>
 <CAKfTPtCeA1VcEierR5iyQJApU5JMFQqkMSR+2JGU4o5cG76opQ@mail.gmail.com>
 <20200508170213.GA27353@geo.homenetwork> <CAKfTPtC_YFEPJukbvdo0TKSke1NW9Cw3VsNQFM5u_o4UPKG8=A@mail.gmail.com>
 <BL0PR14MB37792D0FD629FFF1C9FEDE369AA10@BL0PR14MB3779.namprd14.prod.outlook.com>
In-Reply-To: <BL0PR14MB37792D0FD629FFF1C9FEDE369AA10@BL0PR14MB3779.namprd14.prod.outlook.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 May 2020 21:22:00 +0200
Message-ID: <CAKfTPtCY5t=TVHxjQE2xGSWQAFyO7gUjg8D75W96ZruL5RpkJQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 at 17:13, Tao Zhou <ouwen210@hotmail.com> wrote:
>
> Hi Vincent,
>
> On Mon, May 11, 2020 at 10:36:43AM +0200, Vincent Guittot wrote:
> > Hi Tao,
> >
> > On Fri, 8 May 2020 at 18:58, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
> > >
> > > On Fri, May 08, 2020 at 05:27:44PM +0200, Vincent Guittot wrote:
> > > > On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
> > > > >
> > > > > Hi Phil,
> > > > >

[...]

> > several things:
> >
> > your example above is safe IMO because when C is unthrottle, It's
> > group se will be enqueued on B which will be added to leaf_cfs_rq
> > list.
>
> Sorry for a little late reply..
> I lossed here for B can derectly be added to leaf_cfs_rq and no
> intermediate cfs_rq will have the parent not on the leaf_cfs_rq.
>
> > Then the group se of B is already on_rq but A is throttled and the 1st
> > loop break.  The 2nd loop will ensure that A is added to leaf_cfs_rq
> > list
> >
> > Now, if we add one more level between C and A, we have a problem and
> > we should add something similar in the else
>
> Yes, you are right. If one more level is added, the intermediate cfs_rq
> which is in the throttled hierarchy has a chance that the parent does't
> on the leaf_cfs_rq list. And continue changing tmp_alone_branch leading
> to rq->tmp_alone_branch != rq->leaf_cfs_rq_list. Then hit that assert.
> The tricky here is that the throttled cfs_rq can be added back to the list.
>
> >
> > Finally, while checking the unthrottle_cfs_rq, the test if
> > (!cfs_rq->load.weight) return"  skips all the for_each_entity loop and
> > can break the leaf_cfs_rq
>
> Nice catch.

After more thinking, It's not needed because if load.weight == 0,
nr_running is also 0 because no entity was enqueued or the child
cfs_rq that is associated to the group entity, has been also throttled
and its throttle_count will still be > 0

>
> >
> > We need to jump to the last loop in such case
> >
> > >
> > > Another thing :
> > > In enqueue_task_fair():
> > >
> > >         for_each_sched_entity(se) {
> > >                 cfs_rq = cfs_rq_of(se);
> > >
> > >                 if (list_add_leaf_cfs_rq(cfs_rq))
> > >                         break;
> > >         }
> > >
> > > In unthrottle_cfs_rq():
> > >
> > >         for_each_sched_entity(se) {
> > >                 cfs_rq = cfs_rq_of(se);
> > >
> > >                 list_add_leaf_cfs_rq(cfs_rq);
> > >         }
> > >
> > > The difference between them is that if condition, add if
> > > condition to unthrottle_cfs_rq() may be an optimization and
> > > keep the same.
> >
> > Yes we can do the same kind of optimization
>
> Yes.
>
> Regard,
> Tao
>
> >
> > >
> > > > >
> > > > > Thanks,
> > > > > Tau
> > > > >
> > > > > >
> > > > > >  enqueue_throttle:
> > > > > > --
> > > > > > 2.18.0
> > > > > >
> > > > > > V2 rework the fix based on Vincent's suggestion. Thanks Vincent.
> > > > > >
> > > > > >
> > > > > > Cheers,
> > > > > > Phil
> > > > > >
> > > > > > --
> > > > > >
