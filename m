Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2D5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B3220768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rd4LiSgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHNVAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHNVAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:00:18 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E89C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 14:00:18 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k12so8667809otr.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haVemazZULiuV36dwHAxcpTW0ExGKvnYAP0Q5f9mtxc=;
        b=rd4LiSgSzKcMgxiLxmC4FkMLT4vR4LskdS9LN40oqwDp5zCfYM3cMwmiE6LXyV/FfF
         2MKNoH1LqWAV0mPP3drJzJX+zhLFtP6t27pQxXwhV9cPPJ1nJIMCOtmDG3Y/MjGJiZ4W
         o/qD5N6MnExM2PWMHLzc68daMulh/RwXY2PK6+VFnoRWLNQEFW4fAKkPB46/kBffRg0G
         cN2cNmUyMTe2AQVzS3iQvmEHJhB0TzIaJA6BUX78Ztq2Psi5iunQe6N+OSwJYA9XcsJJ
         O55Nyj4EZwxXTu475z5J0nYRYts+cVNGk3tiTE5yPS/t84R8EVd7+/ubObm5V/pxJMK8
         Tnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haVemazZULiuV36dwHAxcpTW0ExGKvnYAP0Q5f9mtxc=;
        b=T8W7Z6X5F2Fx+rC2Fb4TOZaxPCBfp6xV102IWC/8gPfaniRWTSir5+YaH827zCTnD1
         ghTy0hprd6+9RcILhsiC4Vs78p0QSrR4T5ncJ5FhCzZQGDmPL9JdS+6NziNl9Hb6/CQv
         nnX5/HPP2JoToRAOQqtMRm3fI5sh+Gw7KvI8EWcmhAM+kC34FD3ic+Jna7WoKjr7CEol
         MKdXra3VjHSMc4x03jcBYKMESwYNE00sgQSsNQj6e6W1623HulbUuiG1WoafK+d9MuTX
         SBhoXrzMva2xBxzOiTxXYEfLkMAwUuCieEbzNdljHKtDPExXnMqzFXCj3HWpFQQlEcKb
         UK/Q==
X-Gm-Message-State: AOAM530quqsTsALLeJlbMUkOZnXLRVUhDvIJeNBo/zDgx3/TjakZnF2a
        bS94GLwnZGOFd90gmAuv9SPSdLKUIU57229ROW7Hlg==
X-Google-Smtp-Source: ABdhPJwpi1ZJeltZCR6iWWHFOtFiO3feGfWwUEX0ttWIkeBTtDt86+kDGXHO0+Pof/Xs1U8Q3v/11pmj6vVxtUb/JPE=
X-Received: by 2002:a9d:774d:: with SMTP id t13mr3154237otl.108.1597438817570;
 Fri, 14 Aug 2020 14:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200814205527.1833459-1-urielguajardojr@gmail.com> <20200814205847.GK3982@worktop.programming.kicks-ass.net>
In-Reply-To: <20200814205847.GK3982@worktop.programming.kicks-ass.net>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Fri, 14 Aug 2020 16:00:06 -0500
Message-ID: <CAG30Eef1RBj07_=KCJ5G2J0k3_pgL-hM6PiYba0Vf6O16WhnUQ@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: added lockdep support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 3:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Aug 14, 2020 at 08:55:27PM +0000, Uriel Guajardo wrote:
> > +
> > +void kunit_check_lockdep(struct kunit *test, struct kunit_lockdep *lockdep) {
> > +     int saved_preempt_count = lockdep->preempt_count;
> > +     bool saved_debug_locks = lockdep->debug_locks;
> > +
> > +     if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
> > +             preempt_count_set(saved_preempt_count);
> > +
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +     if (softirq_count())
> > +             current->softirqs_enabled = 0;
> > +     else
> > +             current->softirqs_enabled = 1;
> > +#endif
>
> This block is pointless. The only way to get softirq tracing out of sync
> is an unbalanced local_bh_disable(), but then the above preempt_count()
> test will trigger and kill IRQ tracing.

Ahh I see. Thank you.

>
> > +
> > +     if (saved_debug_locks && !debug_locks) {
> > +             kunit_set_failure(test);
> > +             kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> > +             kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> > +     }
> > +}
