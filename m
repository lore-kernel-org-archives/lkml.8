Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3982086A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqSAg0s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgHTP5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgHTP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:57:06 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668B9C061386
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:57:06 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id j7so514528vkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4d3kdKf0obUvj6BD1aZYTd/t86niyv+Yj9Gy9WROoE=;
        b=YqSAg0s40etVJaOExgte1ifu2Pavm6LhmkJctcS7Eg9t88YKapWGgx/s/ThR4n3gI/
         R7P41936QG3xrZ3aenbnC5iMcteiNtbfCqpJyel+R2T3a3+mmGnzlBu+eeX+G/uQJEKn
         TXM6OdIOs0fbJPDydqUaZTNVwRmplSLNUJhI/nGXOc/ukhJ3Mb/mrOksdinhqE138+jw
         vMEIr2c4YsjkZIz9JZLkdhKkoG1sFY5Xizkj+qcfkOOMqg4M7lmJFWGpLYY0ImbcvhIC
         22rvhHNOcmw5ccAzPcMLQULrXkXH7gQrSt3Z4HLYiv8x9D/WH49eUPC/byTP6D7koGCa
         Tjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4d3kdKf0obUvj6BD1aZYTd/t86niyv+Yj9Gy9WROoE=;
        b=kCU4aNYoxBKOQ2QGq20Ex1fCtVgN+znMLSR1+vXXs7QuwmgQ2WleOa4djahl12r5Zu
         PxOFEHCwe7aZnaVAnm86+xRRJ3Y3VpAKevuYNf3MLPU84XVrOjIO1J8sWrsm6QES8G1Y
         nlVwJyXFU8+9bVlB7grAvnq7aFrh0PXzQWnAe6CNEbXthI8ZU3xZXcMMsncF+Le318kv
         Xkpph6gZlKpdAr547JEV8kyF8NI32QAyQFZ/0H2RHC779X9h1i5TNqRDV6Fft+WP784f
         0xV5huOei4N0VEnXPtflohd8XmAfqmXvIGF8ABHwUhg4+lup/jXs9S5e99GHc5MdC16/
         di6A==
X-Gm-Message-State: AOAM532fJ5p4IpdaF2HlLurrLqlH9afeX2j3RNsrDWfJehfNH00xOHs1
        iSSlnv3v2jP4n+RsP3cnLHwGGIbXxrb6iqBtcRv0nw==
X-Google-Smtp-Source: ABdhPJziweArgy/me/pR4a4bp4DqBBECsdWvARMwhCbGMB4PwffKzdC/k6cgBhYQ/8RdLDMwP6Q8t3VpwQ5VK740eMI=
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr2096168vkb.37.1597939025123;
 Thu, 20 Aug 2020 08:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200820002053.1424000-1-surenb@google.com> <87zh6pxzq6.fsf@x220.int.ebiederm.org>
 <20200820124241.GJ5033@dhcp22.suse.cz> <87lfi9xz7y.fsf@x220.int.ebiederm.org>
 <87d03lxysr.fsf@x220.int.ebiederm.org> <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein> <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein> <637ab0e7-e686-0c94-753b-b97d24bb8232@i-love.sakura.ne.jp>
 <87k0xtv0d4.fsf@x220.int.ebiederm.org>
In-Reply-To: <87k0xtv0d4.fsf@x220.int.ebiederm.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 Aug 2020 08:56:53 -0700
Message-ID: <CAJuCfpHsjisBnNiDNQbm8Yi92cznaptiXYPdc-aVa+_zkuaPhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>, mingo@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com,
        Shakeel Butt <shakeelb@google.com>, cyphar@cyphar.com,
        Oleg Nesterov <oleg@redhat.com>, adobriyan@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        gladkov.alexey@gmail.com, Michel Lespinasse <walken@google.com>,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de,
        John Johansen <john.johansen@canonical.com>,
        laoar.shao@gmail.com, Minchan Kim <minchan@kernel.org>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 7:53 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
>
> > On 2020/08/20 23:00, Christian Brauner wrote:
> >> On Thu, Aug 20, 2020 at 10:48:43PM +0900, Tetsuo Handa wrote:
> >>> On 2020/08/20 22:34, Christian Brauner wrote:
> >>>> On Thu, Aug 20, 2020 at 03:26:31PM +0200, Michal Hocko wrote:
> >>>>> If you can handle vfork by other means then I am all for it. There were
> >>>>> no patches in that regard proposed yet. Maybe it will turn out simpler
> >>>>> then the heavy lifting we have to do in the oom specific code.
> >>>>
> >>>> Eric's not wrong. I fiddled with this too this morning but since
> >>>> oom_score_adj is fiddled with in a bunch of places this seemed way more
> >>>> code churn then what's proposed here.
> >>>
> >>> I prefer simply reverting commit 44a70adec910d692 ("mm, oom_adj: make sure
> >>> processes sharing mm have same view of oom_score_adj").
> >>>
> >>>   https://lore.kernel.org/patchwork/patch/1037208/
> >>
> >> I guess this is a can of worms but just or the sake of getting more
> >> background: the question seems to be whether the oom adj score is a
> >> property of the task/thread-group or a property of the mm. I always
> >> thought the oom score is a property of the task/thread-group and not the
> >> mm which is also why it lives in struct signal_struct and not in struct
> >> mm_struct. But
> >>
> >> 44a70adec910 ("mm, oom_adj: make sure processes sharing mm have same view of oom_score_adj")
> >>
> >> reads like it is supposed to be a property of the mm or at least the
> >> change makes it so.
> >
> > Yes, 44a70adec910 is trying to go towards changing from a property of the task/thread-group
> > to a property of mm. But I don't think we need to do it at the cost of "__set_oom_adj() latency
> > Yong-Taek Lee and Tim Murray have reported" and "complicity for supporting
> > vfork() => __set_oom_adj() => execve() sequence".
>
> The thing is commit 44a70adec910d692 ("mm, oom_adj: make sure processes
> sharing mm have same view of oom_score_adj") has been in the tree for 4
> years.
>
> That someone is just now noticing a regression is their problem.  The
> change is semantics is done and decided.  We can not reasonably revert
> at this point without risking other regressions.
>
> Given that the decision has already been made to make oom_adj
> effectively per mm.  There is no point on have a debate if we should do
> it.

Catching up on the discussion which was going on while I was asleep...
So it sounds like there is a consensus that oom_adj should be moved to
mm_struct rather than trying to synchronize it among tasks sharing mm.
That sounds reasonable to me too. Michal answered all the earlier
questions about this patch, so I won't be reiterating them, thanks
Michal. If any questions are still lingering about the original patch
I'll be glad to answer them.

>
> Eric
>
>
