Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B4FC2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B3E20740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hK5hE4xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbgELUb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725950AbgELUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:31:57 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ED4C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:31:57 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r66so19448153oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERRPuFMN2HOwCuK5VWexEJe+QDtucWJfwhL9QOSpukg=;
        b=hK5hE4xj/RHYqXwzZ9VElO19qhoruIzjPwlshRn15zYs4ggKzCnGNClUZ86H5dmQCb
         UkMmg02SXTxyWybVmPHsTc0t9D/09zvFcepjrnXoJg9SNRiqto8FIpI1zcHBsys1iFHW
         oo70nS4eEiUOF4Qssvf97lOVxnkJ1FxKmS5IPT5JLi6xFFqhjw/DSmzHraxQqLVaW+9C
         sHG5ZreZpNYBLAbjZ092XYOnqvkg80M2YkzfV6fNVtAAJ7iNNWSyzqWn/QNj5qA4Ogt2
         xfBr++NO6oMqgSkdyRoFeAWWUfG7qSAVKI2FpwgxO7DCHcnzYuOp+QoB98JLjUSO8FEL
         8Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERRPuFMN2HOwCuK5VWexEJe+QDtucWJfwhL9QOSpukg=;
        b=U6GIiYUSRmlnctFgkDd5HwW1ydHdMW3TpCYbURFaPRqX4fepTpN0gGCKovl/UEsrhx
         loJ2/ydzVwUrYuzP2WXpw9YYQv9idtyABHEpmki31BIStrQ0Z51oJGjXQJOi5XqDyEg5
         fr4gpma6ISICjpKtiWKMcAwVQRzngjYDc5JPkBhiKH1IBr29k9kPEmlbW6L6PkLMxq00
         K1kHJvab872L75/UCHcSSHkfzEES3on4wkolmBPmvvGQIacrQlGVbSp3abl9R9xKLoIs
         14JkexLQX7xRI3BMSQVOcOg9FBg6FT3F3g+6e9nM7Vl/9J/pmLDA32l32mA9z1rW7CkR
         htuw==
X-Gm-Message-State: AGi0PuaBTKPZyfP6eBliam1upCWqXf5pdTLD9NYDOfQ3+YlkGAuaq0T8
        27bLYP6f6RHHKi2ZFqsbbtzQVrvfGyWkgAiylUXVRY5w
X-Google-Smtp-Source: APiQypJ3JmKqNIoGmCcd3DTsSdSWvHXTq6dKWAoTdQxvccLpcOsmS0K5CabG8u+AD/Y9Gx5P0Q5CcYbP/ueMdE/PQJ4=
X-Received: by 2002:aca:c646:: with SMTP id w67mr25418180oif.70.1589315515788;
 Tue, 12 May 2020 13:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-1-will@kernel.org> <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com> <20200512190755.GL2957@hirez.programming.kicks-ass.net>
In-Reply-To: <20200512190755.GL2957@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 May 2020 22:31:44 +0200
Message-ID: <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 at 21:08, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, May 12, 2020 at 07:53:00PM +0200, Marco Elver wrote:
> > I just ran a bunch of KCSAN tests. While this series alone would have
> > passed the tests, there appears to be a problem with
> > __READ_ONCE/__WRITE_ONCE. I think they should already be using
> > 'data_race()', as otherwise we will get lots of false positives in
> > future.
> >
> > I noticed this when testing -tip/locking/kcsan, which breaks
> > unfortunately, because I see a bunch of spurious data races with
> > arch_atomic_{read,set} because "locking/atomics: Flip fallbacks and
> > instrumentation" changed them to use __READ_ONCE()/__WRITE_ONCE().
> > From what I see, the intent was to not double-instrument,
> > unfortunately they are still double-instrumented because
> > __READ_ONCE/__WRITE_ONCE doesn't hide the access from KCSAN (nor KASAN
> > actually). I don't think we can use __no_sanitize_or_inline for the
> > arch_ functions, because we really want them to be __always_inline
> > (also to avoid calls to these functions in uaccess regions, which
> > objtool would notice).
> >
> > I think the easiest way to resolve this is to wrap the accesses in
> > __*_ONCE with data_race().
>
> But we can't... because I need arch_atomic_*() and __READ_ONCE() to not
> call out to _ANYTHING_.
>
> Sadly, because the compilers are 'broken' that whole __no_sanitize thing
> didn't work, but I'll be moving a whole bunch of code into .c files with
> all the sanitizers killed dead. And we'll be validating it'll not be
> calling out to anything.
>
> data_race() will include active calls to kcsan_{dis,en}able_current(),
> and this must not happen.

Only if instrumentation is enabled for the compilation unit. If you
have KCSAN_SANITIZE_foo.c := n, no calls are emitted not even to
kcsan_{dis,en}able_current(). Does that help?

By default, right now __READ_ONCE() will still generate a call due to
instrumentation (call to __tsan_readX).

Thanks,
-- Marco
