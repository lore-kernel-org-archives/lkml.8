Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F038EC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFA920730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSzoVn31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgAPLjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:39:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38602 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAPLjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:39:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so9764076pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 03:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQ2WYK66tyT9hqx5BTHGPz07wmp8qftkyUQb3t1BOpU=;
        b=dSzoVn31mzKWef/nnHG1uXr6Zxopc4S8CzEfz2r4chbCqgoMBr1WNPGI3UOm05BjXO
         9/X4lpg8BxT5BKjIc3NOY4KVOOXKJfWmnwQJH1PXcHMuih7x5I/D7TreTm1h5gqqgdLd
         OnOQdwnNPQS/8579FMfo96clV/2yMUcT29zZW11W1OoDEcg7esEbyvieb7qeuPzSp+8R
         WsPrn0XlQDD2p0fQPwevC+to99jaV5yAWNARP0JM1z76Lv0/B0pGtXqIEfUeeJUY5KV2
         WqdSTFTgnqQ+D55RWTOwZwgwqsex2a5XXtNtarvAr3cTwgwMbGSMYofXI+eB6WsJlhv5
         AOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQ2WYK66tyT9hqx5BTHGPz07wmp8qftkyUQb3t1BOpU=;
        b=j6lUS6v5myP9K9nyhdukVR2PszTu0JOcPYrJ3xWNZ8CZs0eglyW24b8sMs4/wRc6Rh
         KeuJwfxNG/UK7qEVvlK1X70bFpuJpByyNgwvf0QyHUXzJREG9mtnWFaNlwDNmB/YjEYQ
         j72vn+1rN3xr6GFvArUGKWG4DUerW3KtmoLNQRX1gcbnLtjqKXFH8APTHQmNS6RYepKv
         sL4kovJ2eIl6AgOy7C/WXMEz5KcbLXY+0RocJv7G2f5qWmBXGROO/ALJCiTKSvxAVs4w
         OcZEsA/dTrOIP1k8bmdHIISGoa4BTt6lY6R+gPzKImscp71l8IH+WxAULJ8JeO+ooIu2
         gklw==
X-Gm-Message-State: APjAAAWOYkkIiLOjKh+A5VQUmc//RPb4lpRG8QfDK09hZNOHBgdmB0jj
        AqXU7UDFhXTFJ9/qQfdj7zp85wA3mSqf3ueNf14P3w==
X-Google-Smtp-Source: APXvYqwPiIfdOngwSbMd2ZgYuwpEaNsn3HmGYL37NV427Q34ckb5EtuW9e8KjyLgjS2c6xRf/5IIr2AKLYFnERKAMTk=
X-Received: by 2002:a63:358a:: with SMTP id c132mr39524917pga.286.1579174755819;
 Thu, 16 Jan 2020 03:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20200116111449.217744-1-dvyukov@gmail.com>
In-Reply-To: <20200116111449.217744-1-dvyukov@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 16 Jan 2020 12:39:04 +0100
Message-ID: <CAAeHK+x1o+7qvZx0tkqqaSHJfovajywFh5PhACcjDu2PsNNpVw@mail.gmail.com>
Subject: Re: [PATCH] kcov: ignore fault-inject and stacktrace
To:     Dmitry Vyukov <dvyukov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:14 PM Dmitry Vyukov <dvyukov@gmail.com> wrote:
>
> From: Dmitry Vyukov <dvyukov@google.com>
>
> Don't instrument 3 more files that contain debugging facilities and
> produce large amounts of uninteresting coverage for every syscall.
> The following snippets are sprinkled all over the place in kcov
> traces in a debugging kernel. We already try to disable instrumentation
> of stack unwinding code and of most debug facilities. I guess we
> did not use fault-inject.c at the time, and stacktrace.c was somehow
> missed (or something has changed in kernel/configs).
> This change both speeds up kcov (kernel doesn't need to store these
> PCs, user-space doesn't need to process them) and frees trace buffer
> capacity for more useful coverage.
>
> should_fail
> lib/fault-inject.c:149
> fail_dump
> lib/fault-inject.c:45
>
> stack_trace_save
> kernel/stacktrace.c:124
> stack_trace_consume_entry
> kernel/stacktrace.c:86
> stack_trace_consume_entry
> kernel/stacktrace.c:89
> ... a hundred frames skipped ...
> stack_trace_consume_entry
> kernel/stacktrace.c:93
> stack_trace_consume_entry
> kernel/stacktrace.c:86
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/Makefile | 1 +
>  lib/Makefile    | 1 +
>  mm/Makefile     | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index e5ffd8c002541..5d935b63f812a 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -30,6 +30,7 @@ KCSAN_SANITIZE_softirq.o = n
>  # and produce insane amounts of uninteresting coverage.
>  KCOV_INSTRUMENT_module.o := n
>  KCOV_INSTRUMENT_extable.o := n
> +KCOV_INSTRUMENT_stacktrace.o := n
>  # Don't self-instrument.
>  KCOV_INSTRUMENT_kcov.o := n
>  KASAN_SANITIZE_kcov.o := n
> diff --git a/lib/Makefile b/lib/Makefile
> index 004a4642938af..6cd19bb3085c5 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -16,6 +16,7 @@ KCOV_INSTRUMENT_rbtree.o := n
>  KCOV_INSTRUMENT_list_debug.o := n
>  KCOV_INSTRUMENT_debugobjects.o := n
>  KCOV_INSTRUMENT_dynamic_debug.o := n
> +KCOV_INSTRUMENT_fault-inject.o := n
>
>  # Early boot use of cmdline, don't instrument it
>  ifdef CONFIG_AMD_MEM_ENCRYPT
> diff --git a/mm/Makefile b/mm/Makefile
> index 3c53198835479..c9696f3ec8408 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -28,6 +28,7 @@ KCOV_INSTRUMENT_kmemleak.o := n
>  KCOV_INSTRUMENT_memcontrol.o := n
>  KCOV_INSTRUMENT_mmzone.o := n
>  KCOV_INSTRUMENT_vmstat.o := n
> +KCOV_INSTRUMENT_failslab.o := n
>
>  CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
>  CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
> --
> 2.25.0.rc1.283.g88dfdc4193-goog
>
