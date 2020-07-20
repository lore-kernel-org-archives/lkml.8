Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97EEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3D622CF7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ui/WFmlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgGTSX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:23:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A95C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:23:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so19065696eje.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYtPOu3+6Et/kxltzHexe0n0N7DSpTjVRyHcPXRKmCw=;
        b=ui/WFmlokRzdDA5JN1GR5fdBq/UdFuxXFmj7ASkGwvwdeQH5Cd+w3vTSFoF5gUlaiV
         CD10FNPrnEwqMrxIDzhDOwx/IwCPewbSoTDhySKiU6dVEW2iERwIbgt90LUUMOV5ygij
         Stq7qqJdjVdfpcdGrmY9qJGlH/NiV4hXKLOUEZhdc9Xo7tdC9mvggPOoyBx4+QPpNNCW
         hs7Dq+C+Ex5KscAQsqdKfPyjrq/1i1twgoKM+hNMYCu+1bsZ2HOcSCxVkkgt+giJ1g70
         K5BcJkaB/SamNI6vcJEMYUq1b56zYYMsEbMi89iq6qcBnrdqMS4TUrVFwdR154adJR6q
         OShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYtPOu3+6Et/kxltzHexe0n0N7DSpTjVRyHcPXRKmCw=;
        b=Dxoy30FStc1bJnPY0dqQlxMA4Kl3YAZQ9v3yF1ZEbFpIi71MAXPnS0iPEagHBNkVPu
         bZ9jH8/Zgau37EYTcQd0N8EP785JMxHt7S9D2zoHpPbsJWvuxx2Qwn39HFPSLB/VpSwA
         HLVtozv0fzYbVVtGP+7NAIMv7K/wV9+6/mn1iL64gOCENoBQIpJ/7p3xQqaQq144gnRq
         jOeQzBsY2ChjpuYfaCrr4omiXY4Mx9Ck6bxDT9CryzIfhIVqNXByQBb6QZW6d/ClTPxM
         Lk/RZC+PDCXp8L6gOjtfzIZGrnIPwMRrloMDOYClh98sjyOF2wPpvNEDiX7iVn/YdDLu
         9Hog==
X-Gm-Message-State: AOAM532aMKgtjVvgLUr73cyM9inAa6Dr6TVaWbiGyddjdaYY2aLn+XA8
        D7jna8rtsXKl7LLAGX7GPXdlRJbXGhaZE9MJb9CXiA==
X-Google-Smtp-Source: ABdhPJw6kbpkvhqkdMCphSGiRLzzPUV18DZOTQU5dB0cdi0CwxIGyDs6TiAqw4ENGTmfmH4/sgAjvJ6lBMmDeYEKedQ=
X-Received: by 2002:a17:906:c007:: with SMTP id e7mr21842223ejz.481.1595269434577;
 Mon, 20 Jul 2020 11:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200507085544.GB1097552@kroah.com> <1591791827-23871-1-git-send-email-Frankie.Chang@mediatek.com>
 <1591791827-23871-3-git-send-email-Frankie.Chang@mediatek.com>
In-Reply-To: <1591791827-23871-3-git-send-email-Frankie.Chang@mediatek.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 20 Jul 2020 11:23:43 -0700
Message-ID: <CAHRSSEydixN=4JQW3PGsTVaYZG+1aVZA6JOE9c9GufiWrkDycQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] binder: add trace at free transaction.
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

On Wed, Jun 10, 2020 at 5:24 AM Frankie Chang
<Frankie.Chang@mediatek.com> wrote:
>
> From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
>
> Since the original trace_binder_transaction_received cannot
> precisely present the real finished time of transaction, adding a
> trace_binder_txn_latency_free at the point of free transaction
> may be more close to it.
>
> Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>
> ---
>  drivers/android/binder.c       |    2 ++
>  drivers/android/binder_trace.h |   27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 1592396..5ec9af8 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1523,6 +1523,7 @@ static void binder_free_transaction(struct binder_transaction *t)
>          * If the transaction has no target_proc, then
>          * t->buffer->transaction has already been cleared.
>          */
> +       trace_binder_txn_latency_free(t);
>         binder_free_txn_fixups(t);
>         kfree(t);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION);
> @@ -3094,6 +3095,7 @@ static void binder_transaction(struct binder_proc *proc,
>         kfree(tcomplete);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
>  err_alloc_tcomplete_failed:
> +       trace_binder_txn_latency_free(t);
>         kfree(t);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION);
>  err_alloc_t_failed:
> diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
> index 6731c3c..8ac87d1 100644
> --- a/drivers/android/binder_trace.h
> +++ b/drivers/android/binder_trace.h
> @@ -95,6 +95,33 @@
>                   __entry->thread_todo)
>  );
>
> +TRACE_EVENT(binder_txn_latency_free,
> +       TP_PROTO(struct binder_transaction *t),
> +       TP_ARGS(t),
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
> +               __entry->from_proc = t->from ? t->from->proc->pid : 0;
> +               __entry->from_thread = t->from ? t->from->pid : 0;
> +               __entry->to_proc = t->to_proc ? t->to_proc->pid : 0;
> +               __entry->to_thread = t->to_thread ? t->to_thread->pid : 0;

t->to_proc and t->to_thread are not safe to dereference without
holding t->lock. If the target process dies, these fields can be set
to NULL

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
