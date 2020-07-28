Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4867206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="rOaMkTxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgG1Nuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbgG1Nun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:50:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDF7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:50:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s16so5981210ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kirB/gqqBAJLG2HuIH/MRYs/QM8IzhLjrn4QtyOzkA=;
        b=rOaMkTxvxz7MU41mGM5X9WGJVCNgPj2eqdTPrl1MZOfNig0RktAmv+bs4zVG/65Iq+
         1YmQX3Xbewo8DBvAY7j6aVthCb8EVXvzxA7o+FX/q2e9E7icNGXJyXinkD0zE9ohWTTO
         R7LBv2k1TGhWEYbSsMF0mHBdWXq8Tx8kGgeVlx1tmngzf31+3pT34V1YsfoOGqXOKLqj
         4RWc/TCEax0zTO/x4KpKzAjOEqSLOyfvqq89aWtebyfV56oQlP6/7sCYserCpqPF7W0h
         m4UZdFwqNr/fctLo/5YbJ3LipQa64SsN4BF1vq8rpqDL0nydlb5O4TDUUAtNftLU5bNv
         wiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kirB/gqqBAJLG2HuIH/MRYs/QM8IzhLjrn4QtyOzkA=;
        b=l/PVdluQ861vhX2hXq4llowAJKfjrphpC4apAr8wcEUNEyS9yc6WGnkbH0Enys8eWf
         XDD1seUtjBV8CVzB15r8chQxnlmxrMns0HOtD2RVQ1fKan+LCL8tUPocO0O21uXlNpY3
         23O+1YojdjdJVcWM2DylZOMK8bcp9MITXOFiwDZJsevwirEawEYhqNdZocOhftIZOq7D
         7ol2mfBVeEAbHmx5G5STY3VbRZFS9xTU89aDt11IjesDGIuL4QJ9jpcsyRA3nz7o+GDC
         kyO6jfrOgN7xosYBu328/yCNIC3Fzxj9ul4SUadY2d1gmb2EQTH1OAeTIsFuVps41PcA
         elbQ==
X-Gm-Message-State: AOAM533fvkttWdl2Bto/MIfWEtlC/rKyvP5IQ26A+1BcinCw6hNFr4/S
        3wrPmnph9Hm2nAjC8X2BtzNuGlURpax418tieSSYlw==
X-Google-Smtp-Source: ABdhPJwrFjXlEfBJpCKWZNs/cvbKzMTZ8lKV+f0jPRgfBJozfChhw0t2qpuL3xTuhCNPxTza18YEqTecz6lLEY2gnVk=
X-Received: by 2002:a2e:6c14:: with SMTP id h20mr11380570ljc.176.1595944241508;
 Tue, 28 Jul 2020 06:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200727120424.1627555-1-jannh@google.com>
In-Reply-To: <20200727120424.1627555-1-jannh@google.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 28 Jul 2020 15:50:30 +0200
Message-ID: <CAB0TPYHx-SkaWR6i0LwLYRJv13_0V3Ak63H0=parZNvS5XdqgA@mail.gmail.com>
Subject: Re: [PATCH v2] binder: Prevent context manager from incrementing ref 0
To:     Jann Horn <jannh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Mattias Nissler <mnissler@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jann, the change LGTM, one question on the repro scenario that
wasn't immediately obvious to me:

On Mon, Jul 27, 2020 at 2:04 PM Jann Horn <jannh@google.com> wrote:
>  - task B opens /dev/binder once, creating binder_proc instance P3
>  - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
>    transaction)
>  - P2 receives the handle and uses it to call P3 (two-way transaction)
>  - P3 calls P2 (via magic handle 0) (two-way transaction)
>  - P2 calls P2 (via handle 1) (two-way transaction)

Why do you need P3 involved at all? Could P2 just straight away make a
call on handle 1?

>
> And then, if P2 does *NOT* accept the incoming transaction work, but
> instead closes the binder fd, we get a crash.
>
> Solve it by preventing the context manager from using ACQUIRE on ref 0.
> There shouldn't be any legitimate reason for the context manager to do
> that.
>
> Additionally, print a warning if someone manages to find another way to
> trigger a transaction-to-self bug in the future.
>
> Cc: stable@vger.kernel.org
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Acked-by: Todd Kjos <tkjos@google.com>
Reviewed-by: Martijn Coenen <maco@android.com>

> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> fixed that broken binder_user_error() from the first version...
> I sent v1 while I had a dirty tree containing the missing fix. whoops.
>
>  drivers/android/binder.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f50c5f182bb5..5b310eea9e52 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2982,6 +2982,12 @@ static void binder_transaction(struct binder_proc *proc,
>                         goto err_dead_binder;
>                 }
>                 e->to_node = target_node->debug_id;
> +               if (WARN_ON(proc == target_proc)) {
> +                       return_error = BR_FAILED_REPLY;
> +                       return_error_param = -EINVAL;
> +                       return_error_line = __LINE__;
> +                       goto err_invalid_target_handle;
> +               }
>                 if (security_binder_transaction(proc->tsk,
>                                                 target_proc->tsk) < 0) {
>                         return_error = BR_FAILED_REPLY;
> @@ -3635,10 +3641,17 @@ static int binder_thread_write(struct binder_proc *proc,
>                                 struct binder_node *ctx_mgr_node;
>                                 mutex_lock(&context->context_mgr_node_lock);
>                                 ctx_mgr_node = context->binder_context_mgr_node;
> -                               if (ctx_mgr_node)
> +                               if (ctx_mgr_node) {
> +                                       if (ctx_mgr_node->proc == proc) {
> +                                               binder_user_error("%d:%d context manager tried to acquire desc 0\n",
> +                                                                 proc->pid, thread->pid);
> +                                               mutex_unlock(&context->context_mgr_node_lock);
> +                                               return -EINVAL;
> +                                       }
>                                         ret = binder_inc_ref_for_node(
>                                                         proc, ctx_mgr_node,
>                                                         strong, NULL, &rdata);
> +                               }
>                                 mutex_unlock(&context->context_mgr_node_lock);
>                         }
>                         if (ret)
>
> base-commit: 2a89b99f580371b86ae9bafd6cbeccd3bfab524a
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>
