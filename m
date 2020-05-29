Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B985C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24369204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590719109;
	bh=uuwlPIgW6OpST3dieI/H2vwHfIEkX0tT2ZfAJHWY8yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2PXR8MFZnmXfMgdqOFr33qqdItYaEK4YbfpZNf6Rzsq1WAQHhRsEeQ9QetqTzg4a3
	 V3GhnxejRq1sXLEyaUnm39nn0k+UHIFCWIUNNhnHVJfS+NU0RH/MVFV5DWF+S8I0id
	 LKe5hOSn4WLOJIexRLKz+n9nAT7e+XjPXlz/xTqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405402AbgE2CZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404312AbgE2CZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:25:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5BC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:25:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so682352ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONa6CuPxkOqIgk/WD4umBDCRhNX8IRtUPeSQktiBLgc=;
        b=IUtiUtqF2PtXjjJP12hGeZH2Pklr0srp0Yox7oJ7CbquVwDACOdUv4mHI55w8wqbpU
         nk5Uz+wTotTYBSZxKEWd0U+zLd9M2RSZXKUWzh5tStLdBfkZtLAC2HlOPZ3L5FnW+nmD
         WygaQMcqNkJVXPHcSRNeV8qZZEjut/WB+rfBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONa6CuPxkOqIgk/WD4umBDCRhNX8IRtUPeSQktiBLgc=;
        b=L+Hc5lJT4Dr4G1Xvc6xp/vhJ8n5rTJrOp7HurGjf6zIotblQl1lpwm8V6SuqC9hXFk
         fxmnODT/Vkbxj6USKbrYuQBiz+W2l1md0ZVkwBFZ7dw5RwDtYhyFcs24PyDy29a3MxFM
         LeTa1bmL4Ez6jIP8yh35j96llOqbW01mHna1JwRKFy84i3ezH5jruQ0NzVGLPIPWU2ht
         TFO0LoZ9PCLVUwnjdNi2/pWp3QSpldQVPPHPjpKgrFvjSbgdsmj/uWPZk2EAtitaM33F
         0EOx9UsdFzKanL9NOQPjIo3gCJ2b7xueHKP8cgNcT8RDNSwDSqegsoaUoQF7Eaj1+/vv
         98qA==
X-Gm-Message-State: AOAM531Qyi4/laKdmufEBX+V2PGc+EYEV24rEVRarpD0LCNJa03q5W7J
        Lc+QIm+H+Wi4lRm+KxufFbB/DgpXRmc=
X-Google-Smtp-Source: ABdhPJyEUYtvpudRnJ063QRrZ4PXpG/g3IHvyTRc3/6IIr/pVky6hAuDZHDgPHSUXJsFz++tmjWFWw==
X-Received: by 2002:a05:651c:1028:: with SMTP id w8mr2378082ljm.136.1590719103222;
        Thu, 28 May 2020 19:25:03 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k5sm1749212ljg.13.2020.05.28.19.25.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 19:25:01 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id v16so652875ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:25:01 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr2942818ljc.314.1590719101235;
 Thu, 28 May 2020 19:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei> <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
 <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
 <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
 <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com> <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
In-Reply-To: <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 19:24:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
Message-ID: <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into snprintf()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 7:14 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> You said
>
>   Some kind of "not even root" flag, which might be per-process and not
>   possible to clear once set (so that your _normal_ system binaries
>   could still do the root-only stuff, but then you could start a fuzzing
>   process with that flag set, knowing that the fuzzing process - and
>   it's children - are not able to do things).

Yes, that was in a long ago discussion.

And I still think it's actually possibly the right idea for several of
these flags.

Some flags do end up having to be practically system-wide, because
they end up being used in contexts other than the test environment (ie
anything that ends up doing workqueues or networking or VM or whatever
- it's a "global context").

At the same time, some of the flags might well be "in the test
environment" if they act on behavior that is all synchronous. Then
other testers can use them on production machines for testing, even
when the kernel might be used for other things at the same time.

But the point is, NONE OF THIS IS CONFIG OPTIONS.

And absolutely none of this should be named "twist". If you can't make
a config have a sane name that talks about what it does, then it
shouldn't exist at all.

An option like "disable-sysrq-k" is a fine option. It might make
sense. In fact, it would fit well with boot options that we already
have, like "sysrq_always_enabled".

An option called "twist-disablke-sysrq-k" is just odd and nonsensical.

And making that a build-time option is the worst of all worlds.

                   Linus
