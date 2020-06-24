Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA51FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D8920823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593015772;
	bh=F7FThAUWM2suM9UBU5Zps+b+iKCaAQglp7yyAJnlP8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UOt6zN+U39ZwE9aYt2crCke3fxd3N3hiWl67ooyhL8ANjHTMm5D912eWJqMMxHSo3
	 3chOANhZ5lwVKlpiSnZMM4ctHr2AihcCS4qxIf98oKLUFOwYzglzAl3bA1ixCGZzsp
	 Gj0LjhLgmZ6L0HUHPsyRRVdm5nF1TJ6PwSWGf7fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404901AbgFXQWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404501AbgFXQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:22:50 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B02CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:22:50 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d7so1580031lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVfJ3/8w7du0tKWX74vyXNJsLqBbJUDIP9gIYl79Uu4=;
        b=ZFVwBdAWzJCix9LITimENMxt5VR8k5D2IPPhn9czte1BP2WDySPpcyGmZtYsziAjTi
         68ZZdVCuy2UyrJ3t24fFy1rf+R/2kN1MQ+FvF1GrwSyHvTZFF7BePvfH9E6Yr+jXCQ8d
         WKdaksHaT9hghxbEAENLaQ2ZUYHydFftmsazs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVfJ3/8w7du0tKWX74vyXNJsLqBbJUDIP9gIYl79Uu4=;
        b=lbzxuicgTqcX9yPdVIv1B787JQCBthRXUXB1WMf7PudtSSxMbbp+/Az11iMsxU+NrB
         BJY3nYUY4wDJ1XKTCmxtR7UL+dD6WtuX3N7zj9woQyWLDxTGx5dZgRVPvLSpTtdK+fr5
         o1pkXpRSoM0kn9ShX0w19vfcOriRw61CWqsqWExIF+1UjtRjM+sc09YBAHOV3ROo8ULG
         gWc2IvzbWj05UG/Qd4ZE/+25apjAYXspkSPsdPoyfHZRUDtjAXS9vkmS346Hyev+znDO
         k/1XaqVEW/UGrz0VDkr/F0muNRZrtz8UqTq7Nif0rE8HwEzY25MXQmwdgfEJjGa76N7v
         huDQ==
X-Gm-Message-State: AOAM530QrwcpuGJ8JMoIWqQDCKW2oWsCY831GLMGxZwQJRrkbmAAKM8W
        iKFxjFFrg1o9XYJcEvk9IOlaC+fOh7E=
X-Google-Smtp-Source: ABdhPJx1nkXn/PXJ++JOJLKt5W9ytDeLbdFKAk+wRDdenRp9ju2/1+Oh+7mvGDRm1vBngENJ6QsiqQ==
X-Received: by 2002:a19:4cd:: with SMTP id 196mr11831558lfe.136.1593015767855;
        Wed, 24 Jun 2020 09:22:47 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id f129sm5298523lfd.6.2020.06.24.09.22.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 09:22:47 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id o4so1600192lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 09:22:46 -0700 (PDT)
X-Received: by 2002:a19:11:: with SMTP id 17mr16089267lfa.125.1593015766527;
 Wed, 24 Jun 2020 09:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200624161142.GA12184@redhat.com>
In-Reply-To: <20200624161142.GA12184@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 09:22:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqnKdrjZx0kO+f1vyFQFcb-HZsbHFw6_jAeuQmNsTsbQ@mail.gmail.com>
Message-ID: <CAHk-=wjqnKdrjZx0kO+f1vyFQFcb-HZsbHFw6_jAeuQmNsTsbQ@mail.gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss wakeup?
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 9:11 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> T1 checks signal_pending_state() and returns EINTR.
>
> T2 will sleep until another thread does lock/unlock ?

Yeah, this is a nasty pattern with any exclusive wait, we've had this
bug before where an exclusive wait exits without taking the event or
waking up the next waiter.

That said, I'm not entirely happy with your patch.

The real problem, I feel, is that

                if (likely(bit_is_set))
                        io_schedule();

anti-pattern. Without that, we wouldn't have the bug.

Normally, we'd be TASK_RUNNING in this sequence, but because we might
skip io_schedule(), we can still be in a "sleeping" state here and be
"woken up" between that bit setting and the signal check.

                 Linus
