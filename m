Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2667C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD12D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pv2RJRtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgHDP0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgHDP0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:26:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9832C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 08:26:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l4so42825587ejd.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3o6MDqUXmxvVSlcdLb2IgJysM+Vk/j+xrJF23Zh02s=;
        b=Pv2RJRtdXsa5JPcelCLgxa/MabWdHgHvtHX75GYe7Y7xpruRC9hh7PLtf/ZOrHAiw8
         VP5SVZy9b8umW6eW4ARyy48QMQ04NXamcrYz/GNkRfZMJGsXWPv/4vzFwLb3jFRpYEil
         pH6XwupwhFlGXDIdQ31xqorNxSrOTLPt93pOsFh4wouUfVLrvSyQy3o1r6I+AsoT/Vz0
         RSdzPrqKE53H3zFd38glLLTTI8nU73sl1fjcJGsbwGX5h7qUZ0KqWC8tWUOmv7csf1uL
         QT7YGckMXfwEbCMNjfsr1ATWDXeF16wNxdgOU8FRKqoElZ1lvj4d+mZyRV4KwZRBLvS2
         6wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3o6MDqUXmxvVSlcdLb2IgJysM+Vk/j+xrJF23Zh02s=;
        b=jq8ZIbXadMcYO2N+Q+J3renDtU5T1LrTKleUpfXKx1zmpA83Qoqh5wFEw1PdMx3Nc7
         KZ82nSpOvIe+3V7FWJVRayi5+hp/3NL3qpzq/kbGAiWkTeZ/sVNd7JCLumqKqZbEUc5b
         ZP+6JwhVtVXHH3THz5WgT4nVW5YkQ+V2JiKNCIGdawI2lid/TfogSr+aB1f60OcORlsr
         K2d12i2b750Va8YxrSL+GKc3/eCOJsnDWVowC6ZA6Nn4/PIwlai2lSy72ly01MazbMvu
         KNzZnf/RdkCnanOkhTcXx5vtkgeLaYPKavPZf4Lta7NNgPtvh5TTQ1fJrRUc0luamn3H
         glUw==
X-Gm-Message-State: AOAM530easuE8kg7Dse6uLCV1Jgu7hZdhMCiHLzTOPsO+0YWd0syb0GO
        THi8kikUrK2S6yorFLev3D2SRijmIIaC1hFxqHQ/7A==
X-Google-Smtp-Source: ABdhPJzaWinHalOkG+8o4dRZjbIYHrsFx1Egu0ptiIqT6GQ27fDqCFx7Adt4ulh0/BdlBtahwcDejEV1GBPU83hOoBw=
X-Received: by 2002:a17:906:c406:: with SMTP id u6mr23070434ejz.47.1596554807097;
 Tue, 04 Aug 2020 08:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <1596509145.5207.21.camel@mtkswgap22> <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
 <1596549552-5466-3-git-send-email-Frankie.Chang@mediatek.com>
In-Reply-To: <1596549552-5466-3-git-send-email-Frankie.Chang@mediatek.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 4 Aug 2020 08:26:34 -0700
Message-ID: <CAHRSSExeOn_MO3F3aFc=N0KXBmP0TsWz3RQ8Z-0G2QwK_3y=sw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] binder: add trace at free transaction.
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 7:09 AM Frankie Chang <Frankie.Chang@mediatek.com> wrote:
>
> From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
>
> Since the original trace_binder_transaction_received cannot
> precisely present the real finished time of transaction, adding a
> trace_binder_txn_latency_free at the point of free transaction
> may be more close to it.
>
> Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c       |   18 ++++++++++++++++++
>  drivers/android/binder_trace.h |   29 +++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 2df146f..1bfadc2 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1508,6 +1508,20 @@ static void binder_free_txn_fixups(struct binder_transaction *t)
>         }
>  }
>
> +static void binder_txn_latency_free(struct binder_transaction *t)
> +{
> +       int from_proc, from_thread, to_proc, to_thread;
> +
> +       spin_lock(&t->lock);
> +       from_proc = t->from ? t->from->proc->pid : 0;
> +       from_thread = t->from ? t->from->pid : 0;
> +       to_proc = t->to_proc ? t->to_proc->pid : 0;
> +       to_thread = t->to_thread ? t->to_thread->pid : 0;
> +       spin_unlock(&t->lock);
> +
> +       trace_binder_txn_latency_free(t, from_proc, from_thread, to_proc, to_thread);
> +}
> +
>  static void binder_free_transaction(struct binder_transaction *t)
>  {
>         struct binder_proc *target_proc = t->to_proc;
> @@ -1518,6 +1532,8 @@ static void binder_free_transaction(struct binder_transaction *t)
>                         t->buffer->transaction = NULL;
>                 binder_inner_proc_unlock(target_proc);
>         }
> +       if (trace_binder_txn_latency_free_enabled())
> +               binder_txn_latency_free(t);
>         /*
>          * If the transaction has no target_proc, then
>          * t->buffer->transaction has already been cleared.
> @@ -3093,6 +3109,8 @@ static void binder_transaction(struct binder_proc *proc,
>         kfree(tcomplete);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
>  err_alloc_tcomplete_failed:
> +       if (trace_binder_txn_latency_free_enabled())
> +               binder_txn_latency_free(t);
>         kfree(t);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION);
>  err_alloc_t_failed:
> diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
> index 6731c3c..eb2c53c 100644
> --- a/drivers/android/binder_trace.h
> +++ b/drivers/android/binder_trace.h
> @@ -95,6 +95,35 @@
>                   __entry->thread_todo)
>  );
>
> +TRACE_EVENT(binder_txn_latency_free,
> +       TP_PROTO(struct binder_transaction *t
> +                int from_proc, int from_thread
> +                int to_proc, int to_thread),
> +       TP_ARGS(t, from_proc, from_thread, to_proc, to_thread),
> +       TP_STRUCT__entry(
> +               __field(int, debug_id)
> +               __field(int, from_proc)
> +               __field(int, from_thread)
> +               __field(int, to_proc)
> +               __field(int, to_thread)
> +               __field(unsigned int, code)
> +               __field(unsigned int, flags)
> +       ),
> +       TP_fast_assign(
> +               __entry->debug_id = t->debug_id;
> +               __entry->from_proc = from_proc;
> +               __entry->from_thread = from_thread;
> +               __entry->to_proc = to_proc;
> +               __entry->to_thread = to_thread;
> +               __entry->code = t->code;
> +               __entry->flags = t->flags;
> +       ),
> +       TP_printk("transaction=%d from %d:%d to %d:%d flags=0x%x code=0x%x",
> +                 __entry->debug_id, __entry->from_proc, __entry->from_thread,
> +                 __entry->to_proc, __entry->to_thread, __entry->code,
> +                 __entry->flags)
> +);
> +
>  TRACE_EVENT(binder_transaction,
>         TP_PROTO(bool reply, struct binder_transaction *t,
>                  struct binder_node *target_node),
> --
> 1.7.9.5
