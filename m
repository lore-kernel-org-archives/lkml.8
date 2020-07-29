Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB76C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22656206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNQAOjeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgG2Mv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2MvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:51:25 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23681C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:51:24 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id l27so10234292oti.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IkNVCqZ8o62b1wJv+jsExiR+ROIhSQLBLR6U6CMFFk=;
        b=XNQAOjeJVIaf7vQSbZVECk3+qvpDSBC2IbcvR41S6kgx6tK2ZHaWVh4I9Uib0hKOM3
         LsMk8XDRlA1JixiXG6O9LfAIbIYXGeUG8iGj0xe6m04xWNDxaFFb+A0qz75B7TrKfSBs
         fL0PSmvWUxtQWM84U/Av8QjIzx+lbJ6vT98DaIRUML53AfyxQBgzfiJ7riUjscEmZTg2
         0nmlV3fGjOZZVlYFSQjs/dh7YtVQE1ih/t2wpBpJBC0Tr31Kj+GhPtmQQICmgxq67lOc
         Jwk4oeUkmYA4P9u7nIM2dVZdqqQv7yPPsmHa9t6ANVGTVwm9pk6cGc1Ws5lmmZLb2Bd+
         MAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IkNVCqZ8o62b1wJv+jsExiR+ROIhSQLBLR6U6CMFFk=;
        b=k2TRiFWqiMoBQtmpvD92YR7oZV6yuc2jduLfdRRxUkHcK0H2+QedKDJ+XZrMwXumgU
         073fTF/Qu1oWWQvo5lURCFF6ZNLQZbbvHWbRRaxEp9Udn5Qh3upI/XLJm1iKo+z0boQN
         C5rYFxTRLwBcXG/z/UqhE1IwVMvhZn1Sx6dmXsdPbZqyV5z78VgQnGawKRKeUdC8vO8g
         5oHLxMnrR4DKs7wACLr8LRLExPteIV2ocZVyQQiOLQFoaApju/lyCfYS0zlivhcCtbTz
         iSupR5jAPC9VFjEqz5Q44i6KDi0WUyrlS0fC//b6S7UjBpn4p3yoEUJweaHeDO9gqi3D
         mYZQ==
X-Gm-Message-State: AOAM530yYIGTf51oq/gjwPW6CLpOjSYcn51cbE1FFGOm5n8UsGLCVXtc
        syfFpCIVZD3TvMcMRFKMrGi4G98itc+Ch54EKAs=
X-Google-Smtp-Source: ABdhPJz8TnbQD2dwQDSSWQww4p19bG44RgDDgB5mq3L4ftn4BIxMU+Q5kHuWq1o+6G0aFBIAmW0QE99u1jgZwLrIXe8=
X-Received: by 2002:a9d:25:: with SMTP id 34mr2147274ota.343.1596027083558;
 Wed, 29 Jul 2020 05:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com>
 <87sgddaru7.fsf@nanos.tec.linutronix.de> <CAKc596+vF4eYa4h55P2cssQbRKqBV_-9c_v35SXVMdonP3HBHA@mail.gmail.com>
 <87v9i6a53n.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9i6a53n.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Wed, 29 Jul 2020 20:51:12 +0800
Message-ID: <CAKc596+sH3RN-5T_ajzLbxs-BagR60uOHF2ZVQzqTHbVM5+PkA@mail.gmail.com>
Subject: Re: [PATCH V4] Softirq:avoid large sched delay from the pending softirqs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 8:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Qian,
>
> jun qian <qianjun.kernel@gmail.com> writes:
> > On Mon, Jul 27, 2020 at 11:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > +                     or_softirq_pending(pending << (vec_nr + 1));
> >>
> >> To or the value interrupts need to be disabled because otherwise you can
> >> lose a bit when an interrupt happens in the middle of the RMW operation
> >> and raises a softirq which is not in @pending and not in the per CPU
> >> local softirq pending storage.
> >>
> > I can't understand the problem described above, could you explain in
> > detail.
>
> Oring a value to a memory location is a Read Modify Write (RMW)
> operation.
>
>         x |= a;
>
> translates to pseudo code:
>
>         R1 =  x      // Load content of memory location x into register R1
>         R1 |= a      // Or value a on R1
>         x = R1       // Write back result
>
> So assume:
>
>    x = 0
>    a = 1
>
>    R1 = x  --> R1 == 0
>    R1 |= a --> R1 == 1
>
> interrupt sets bit 1 in x       --> x == 0x02
>
>    x = R1  --> x == 1
>
> So you lost the set bit 1, right? Not really what you want.
>
wow, thanks a lot, i got it.

> >> There is another problem. Assume bit 0 and 1 are pending when the
> >> processing starts. Now it breaks out after bit 0 has been handled and
> >> stores back bit 1 as pending. Before ksoftirqd runs bit 0 gets raised
> >> again. ksoftirqd runs and handles bit 0, which takes more than the
> >> timeout. As a result the bit 0 processing can starve all other softirqs.
> >>
> > May I use a percpu val to record the order of processing softirq, by the order
> > val, when it is in ksoftirqd we can process the pending softirq in order. In the
> > scenario you described above, before ksoftirqd runs, bit 0 gets raised again,
> > ksoftirqd runs and handles bit 1 by the percpu val. just like a ring.
>
> Yes, you need something to save information about the not-processed
> bits. Keeping track of which bit to process next works, but whether
> that's going to result in efficient and simple code is a different
> question.
>
ok, i will modify it in the next version.

> Thanks,
>
>         tglx
>
