Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC76C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD0E2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599749911;
	bh=FYttYrZtuK5BwOL7MlOFary7ccNNYwSvTguucnlrJ+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BoGekT63CnpM0tIdSdYaJzerzCrLw1N8dLObxr5jvhgvPsKo9yuxe5gzOzCMUnRv2
	 EvDrZn+CnFHcIbKy/iu5doxx/rvEyU7q0K4rpKzfwcxF3Z5Islxya2vmGxoatXk7Fy
	 V4ydsLdz2ySrqsIafwlIAfxkj2Y0vtJK2ma8eGw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbgIJO6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:58:23 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43931 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbgIJO5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:57:15 -0400
Received: by mail-ej1-f65.google.com with SMTP id o8so9150813ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SP185hc4qqDaCocuE1o9/q6QIwRYkBlPfsR5unwg+tw=;
        b=r0k7ErdCjNm8aC+5fpE+k+OlNn6yxK9eUdB1n2q2rM+VsWlKr5L+PNJ0c/7Fd1oV4G
         FrqeZPLmQDDeB7Der4Q2mOoFkkQAD4dbKDXcbNLr7DrkOrV2VsgQXeHLrmiCfWyXCiYF
         Jh8MCcCATk1/zvyqHCUWLxuD2Lls1EePCSLIb+IW9lyn6y4m6PJ98OV5SlqO4YcKLkMr
         3Wa4QH7Byd4vtyHfLRO/n58vvq4XCV0iCaJw++WPKOmd5fhGO/7UikO74pKT69rAg0DA
         Qywf8CEzDbq2IMKi+1lryta0eBjAJT3hUBTHOS/wNt7mMZferklkzycNKiljmo3+LiST
         b0Kw==
X-Gm-Message-State: AOAM533mBcTwZF8kPYy3yXpC3b2ENONCFUSXhETfjfMPbUZJhvG8ufmJ
        eEzKskNgun/0XRpdAeCWoeWr3zPX7t7MsWMiboVMUDAyH8A=
X-Google-Smtp-Source: ABdhPJxxh+toO9w+3Xk3Z8n0cYqYrf9qTBRvR8yTvjyobzGOq0dcjT8+GZp2gyhK4BYyVpUdX8kM0Z8tNlCc7xLEmgU=
X-Received: by 2002:adf:8b48:: with SMTP id v8mr9157976wra.21.1599745693134;
 Thu, 10 Sep 2020 06:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200910104153.1672460-1-jolsa@kernel.org>
In-Reply-To: <20200910104153.1672460-1-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Sep 2020 22:48:02 +0900
Message-ID: <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix race in perf_mmap_close function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Wade Mealing <wmealing@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 7:42 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> There's a possible race in perf_mmap_close when checking ring buffer's
> mmap_count refcount value. The problem is that the mmap_count check is
> not atomic because we call atomic_dec and atomic_read separately.
>
>   perf_mmap_close:
>   ...
>    atomic_dec(&rb->mmap_count);
>    ...
>    if (atomic_read(&rb->mmap_count))
>       goto out_put;
>
>    <ring buffer detach>
>    free_uid
>
> out_put:
>   ring_buffer_put(rb); /* could be last */
>
> The race can happen when we have two (or more) events sharing same ring
> buffer and they go through atomic_dec and then they both see 0 as refcount
> value later in atomic_read. Then both will go on and execute code which
> is meant to be run just once.
>
> The code that detaches ring buffer is probably fine to be executed more
> than once, but the problem is in calling free_uid, which will later on
> demonstrate in related crashes and refcount warnings, like:
>
>   refcount_t: addition on 0; use-after-free.
>   ...
>   RIP: 0010:refcount_warn_saturate+0x6d/0xf
>   ...
>   Call Trace:
>   prepare_creds+0x190/0x1e0
>   copy_creds+0x35/0x172
>   copy_process+0x471/0x1a80
>   _do_fork+0x83/0x3a0
>   __do_sys_wait4+0x83/0x90
>   __do_sys_clone+0x85/0xa0
>   do_syscall_64+0x5b/0x1e0
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Using atomic decrease and check instead of separated calls.
> This fixes CVE-2020-14351.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7ed5248f0445..29313cc54d9e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5903,8 +5903,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>                 mutex_unlock(&event->mmap_mutex);
>         }
>
> -       atomic_dec(&rb->mmap_count);
> -
>         if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
>                 goto out_put;

But when it takes the goto, rb->mmap_count won't decrement anymore..

Thanks
Namhyung

>
> @@ -5912,7 +5910,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>         mutex_unlock(&event->mmap_mutex);
>
>         /* If there's still other mmap()s of this buffer, we're done. */
> -       if (atomic_read(&rb->mmap_count))
> +       if (!atomic_dec_and_test(&rb->mmap_count))
>                 goto out_put;
>
>         /*
> --
> 2.26.2
>
