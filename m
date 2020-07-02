Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860A4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F09A207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKe8M2r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgGBM1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBM13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:27:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2D3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 05:27:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so9295398pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLQ15+CdQChxty3+DBgvS6O0S3FqhW0gE4V2//Qfq5U=;
        b=nKe8M2r8+TJaEfv7cWfuuX1yOhzrfH0Idks3Y9CkI7hw18iCeAnFNNdzryVXHjUKjs
         QYh71vA0xA8eqhk8LDqBBOwxHFUl/OUHcAFnZ9T8K3SGmAzLX+LsNwoSPeQDky/dKYfW
         Wb1GzfCVZ8lyDjwa5VWrWctcn4F3km98jMuBgbYmSegwlMC/cKqheBbu2b6jwsp9Iegq
         lRUiJXrxWK5uILUcKmfuUbPvgn23cRw3slt2YsLEKC/9ecI3+ZLH+j0HNJo7X314dOPR
         0ZSHyvXauuGdM6wcqYRonbZ0xbUQKT7Z1c8L6jFrWimUunQtD8YgNPXtorZigmWGqLVM
         zaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLQ15+CdQChxty3+DBgvS6O0S3FqhW0gE4V2//Qfq5U=;
        b=lSmEA+OG0eR0yRQAOAorbCQrPCaNDIKbZ1VjzFlMEq8BcY6BeDGqvdjrVHOADr1fA1
         4BlBc1ITuRTPM0Ltuq96u0soeIwixLPl57FkpozswTtIABl9Hh6X3AAIYePJegT99ckS
         q5/e8goCKPeIqtLocsRtTZtgGRWEeiZSJnLbo4IsTPc7LxhnlsmMdadb7elSF45Q5GBQ
         fH5/5YVuZvofY4QLi2O1HCMjO4lmZhBrXiw4PSEF7Rj/8VOFhqkfgDm6zjuKElCIeXAu
         2MhzNfmaUs05DY3KH8RsywYjPAVwIa4ykmY0cF2N/Fo6Hc8UqFVeN6hqEhBj2kpFvRgb
         IpTw==
X-Gm-Message-State: AOAM532g9o6MapALwA3h3bVzA/j4z3OAUJDimSMsCsAqh5/opqZKSyU0
        RdNBPR9ZhOiSMtC7I9hBya14cSWgTU0crCg0nf0Wxw==
X-Google-Smtp-Source: ABdhPJxozXLVHpHifgBzEIYtaFN45fA0gQJGYR64Z0GdhxUS2A3vRphk7qBAhuRwyJIdIlCkZR+/tdAg10xNi0+uWBE=
X-Received: by 2002:a17:902:6ac1:: with SMTP id i1mr27410698plt.147.1593692848549;
 Thu, 02 Jul 2020 05:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200702115501.73077-1-weiyongjun1@huawei.com>
In-Reply-To: <20200702115501.73077-1-weiyongjun1@huawei.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 2 Jul 2020 14:27:17 +0200
Message-ID: <CAAeHK+yNs2O52wYZgrbVw2JhKJmC36V_DibvxGdNh=2v3GaAEQ@mail.gmail.com>
Subject: Re: [PATCH -next] kcov: make some symbols static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 1:44 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fix sparse build warnings:
>
> kernel/kcov.c:99:1: warning:
>  symbol '__pcpu_scope_kcov_percpu_data' was not declared. Should it be static?
> kernel/kcov.c:778:6: warning:
>  symbol 'kcov_remote_softirq_start' was not declared. Should it be static?
> kernel/kcov.c:795:6: warning:
>  symbol 'kcov_remote_softirq_stop' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  kernel/kcov.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 6afae0bcbac4..6b8368be89c8 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -96,7 +96,7 @@ struct kcov_percpu_data {
>         int                     saved_sequence;
>  };
>
> -DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
> +static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
>
>  /* Must be called with kcov_remote_lock locked. */
>  static struct kcov_remote *kcov_remote_find(u64 handle)
> @@ -775,7 +775,7 @@ static inline bool kcov_mode_enabled(unsigned int mode)
>         return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
>  }
>
> -void kcov_remote_softirq_start(struct task_struct *t)
> +static void kcov_remote_softirq_start(struct task_struct *t)
>  {
>         struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
>         unsigned int mode;
> @@ -792,7 +792,7 @@ void kcov_remote_softirq_start(struct task_struct *t)
>         }
>  }
>
> -void kcov_remote_softirq_stop(struct task_struct *t)
> +static void kcov_remote_softirq_stop(struct task_struct *t)
>  {
>         struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
>
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!
