Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF75C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014AC20786
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eluQCNvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGYEsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 00:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGYEse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 00:48:34 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8589C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 21:48:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id u64so10616484qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M900l+pHGFzlMD+an1AOPOSVrqFC82MZzg5BDb5VOU0=;
        b=eluQCNvZ0DsqX2W/4AKjDbydgSFvfJn/nDNQymfqWRlSiNUz4Tj7w2YpyrcG92//GO
         RBzgz2vwKb3IXOQej496GWrrEK4d/O4Ug2H7s/kNFeyA1oyCbYzLbyQvclKAhDuv5BzK
         Pib7ScrVjpKI/M1sRG+vEJLhNxz1HzxATbKFmobUFe3JD66B/AK9Lot/umW53TID8o+Q
         W36hoNJDpl4hZ7H4Q4qFGH/TffX75SYLfcj87JQ0Tp4lSAIq9fH1ex5fxbh+gTvDY+vK
         cauPpWbtKQGMQiBf5mGFcOHgtsyReNfp5DOrVkO5u7jxKn9FK4dp20etF6MR1fWaeZYu
         7/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M900l+pHGFzlMD+an1AOPOSVrqFC82MZzg5BDb5VOU0=;
        b=Gw6XAnONQs99YfdKqwFORma9QWdT8Xf7nxh8d+gvp/JqiCU4y4SpLayUmW+WmGHPtT
         sokkMUV1zv1FwA50P1PKcR/6d/9JXgvDGAb7jcy4YF73UcHeueRFR1m+ROeuCw/d+chT
         jGnh+zFu0ZMiiPA/ener+petFRoJiB+HD+9sFGGDC5vFf/+W7Cbmc/54VbVdPZi2A0GM
         4pFddKPtMWqX8+gvWaBYkEjQgQUud4UQc+qS15UWrPwp2pXB8XOpmET9viU37PSnID61
         0T7jYYXtWO2jHtS+3o1m65fmTi8EujwQT9ZsCNMuP3o8PFHLE7e6U1BmJPlscn5TR5Rv
         HC7A==
X-Gm-Message-State: AOAM531hTLjRDxeDe9KpfaGrtNYQaLdlLoiG4IfKvbGIPadfXZXt0YOI
        +LqztCEak0dhb8E/ZctIdST6zHMiO2OTl2p67ZoxTQ==
X-Google-Smtp-Source: ABdhPJx9+xpSAg5N1Pu2t9E6yzh6mPxCD36TC/FufaKPAYgMCuAi6SDqIK1bfjaKcvKnTGo0khfkUW0KwwMgMMOzBhI=
X-Received: by 2002:a37:7c05:: with SMTP id x5mr13264146qkc.256.1595652513494;
 Fri, 24 Jul 2020 21:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 25 Jul 2020 06:48:21 +0200
Message-ID: <CACT4Y+YXT9iLij-AbrUwj=yPq-YNFw=Au9g0LQJCKwYonaHCDQ@mail.gmail.com>
Subject: Re: [PATCH] lockdep: Introduce CONFIG_LOCKDEP_LARGE
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>,
        syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>,
        syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 3:30 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since syzkaller continues various test cases until the kernel crashes,
> syzkaller tends to examine more locking dependencies than normal systems.
> As a result, syzbot is reporting that the fuzz testing was terminated
> due to hitting upper limits lockdep can track [1] [2] [3].
>
> Like CONFIG_LOCKDEP_SMALL which halves the upper limits, let's introduce
> CONFIG_LOCKDEP_LARGE which doubles the upper limits.
>
> [1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
> [2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
> [3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
>
> Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/locking/lockdep.c           | 4 ++++
>  kernel/locking/lockdep_internals.h | 5 +++++
>  lib/Kconfig.debug                  | 8 ++++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 29a8de4..85ba7eb 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1349,7 +1349,11 @@ static int add_lock_to_list(struct lock_class *this,
>  /*
>   * For good efficiency of modular, we use power of 2
>   */
> +#ifdef CONFIG_LOCKDEP_LARGE
> +#define MAX_CIRCULAR_QUEUE_SIZE                8192UL
> +#else
>  #define MAX_CIRCULAR_QUEUE_SIZE                4096UL

Maybe this number should be the config value? So that we don't ever
return here to introduce "VERY_LARGE" :)
Also somebody may use it to _reduce_ size of the table for a smaller kernel.

> +#endif
>  #define CQ_MASK                                (MAX_CIRCULAR_QUEUE_SIZE-1)
>
>  /*
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index baca699..00a3ec3 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -93,6 +93,11 @@ enum {
>  #define MAX_LOCKDEP_CHAINS_BITS        15
>  #define MAX_STACK_TRACE_ENTRIES        262144UL
>  #define STACK_TRACE_HASH_SIZE  8192
> +#elif defined(CONFIG_LOCKDEP_LARGE)
> +#define MAX_LOCKDEP_ENTRIES    65536UL
> +#define MAX_LOCKDEP_CHAINS_BITS        17
> +#define MAX_STACK_TRACE_ENTRIES        1048576UL
> +#define STACK_TRACE_HASH_SIZE  32768
>  #else
>  #define MAX_LOCKDEP_ENTRIES    32768UL
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210..69ba624 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1266,6 +1266,14 @@ config LOCKDEP
>  config LOCKDEP_SMALL
>         bool
>
> +config LOCKDEP_LARGE
> +       bool "Use larger buffer for tracking more locking dependencies"
> +       depends on LOCKDEP && !LOCKDEP_SMALL
> +       help
> +         If you say Y here, the upper limits the lock dependency engine uses will
> +         be doubled. Useful for fuzz testing which tends to test many complecated
> +         dependencies than normal systems.
> +
>  config DEBUG_LOCKDEP
>         bool "Lock dependency engine debugging"
>         depends on DEBUG_KERNEL && LOCKDEP
> --
> 1.8.3.1
>
