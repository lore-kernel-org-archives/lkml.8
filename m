Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA53FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92DD2076B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UT4URF6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbgGaSvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGaSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:51:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B30C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:51:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id di22so15857772edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1yxWveFbgcxmN3Okh0JmdDmTWWm3AmW1DCmR+UkLwo=;
        b=UT4URF6JuAnuqhvuR1gZqQzyWvjRB35xaMTPR5ptKWuVhPr2VM17Z5Z9y1p9gbgvRL
         tzD9iAvHKBTmrkB7ywOk2RT6OdGIRdy0zlfySBYlgl/FaHYOtM2w24QZ5X4choHHVPoF
         UYSjc9w5LWrqi/APIzwueY9q3/+XZBoPQqn/9EIyvfg6kett4gni4HrgUYYrp2P0zfsO
         KbVs8XykCCLwIEpMS4PHMcEmgdjCH8Bvpih4FG3owg+NKMPvbgytKK37qGg2i0f9cyzc
         heWKZZ2gbYy3b+ihcmy9JzMyGARQ2g5LGrcPdgntIq5ITSxp1MgzJ3TQyljcMPWBMQQ3
         LxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1yxWveFbgcxmN3Okh0JmdDmTWWm3AmW1DCmR+UkLwo=;
        b=Cnsc+pss18nYn3kosI4k0Iv/j3CLOBvLCP7fk0BHcfh08f1I4fCimDFVc1BmSrhWSu
         4yjrS2O0CcuRDILhCRs5726ebPsNJFLnxxuEpyzNz0kYSY7gmN5Qx/zUCOg0/SH88gWq
         eBGnkBFa7bukN+o71p0bLnTqXUlbc94UXKOcjhjRgFtPag0dbPh/ovPcbsIj51D/OT+X
         SlmcfBu16Ho9RlJyic/bHl9v5lp4kwBwLKnMy5kGY0eEx++xQttiiM5agz+1TQf9s/se
         LkiFKD5SkI1UnXXRYzTjUSRFCfcry++OuGRH/BHLlJwWCm5prtuvCKnQahTN8p5hN2s4
         WcFw==
X-Gm-Message-State: AOAM532280toxMbbMVIDdEGCoM/duu9Kea9aLolUkTuLt0uZfwb6dwJ+
        6or/urHmL5lJh0MAi3Q8uqEo9q0cFKvj3UicYOsQLg8w
X-Google-Smtp-Source: ABdhPJzExpqA+zLrjByDy59iupLrzFa0bZZT8Zx8QXaMYMClOk6aeoTQgXKBDYnuU6xtw/kcvxzaui3xHDZLmNZFixA=
X-Received: by 2002:aa7:d455:: with SMTP id q21mr5075852edr.164.1596221464460;
 Fri, 31 Jul 2020 11:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <1595252430.5899.6.camel@mtkswgap22> <1595906401-11985-1-git-send-email-Frankie.Chang@mediatek.com>
 <1595906401-11985-3-git-send-email-Frankie.Chang@mediatek.com>
In-Reply-To: <1595906401-11985-3-git-send-email-Frankie.Chang@mediatek.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 31 Jul 2020 11:50:52 -0700
Message-ID: <CAHRSSEwqbbTZgaE-KLC0-AMHzRVU3O2AwUzW9i5u54tVmkFAQA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] binder: add trace at free transaction.
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

On Mon, Jul 27, 2020 at 8:28 PM Frankie Chang
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
>  drivers/android/binder.c       |    6 ++++++
>  drivers/android/binder_trace.h |   27 +++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 2df146f..1e6fc40 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1522,6 +1522,9 @@ static void binder_free_transaction(struct binder_transaction *t)
>          * If the transaction has no target_proc, then
>          * t->buffer->transaction has already been cleared.
>          */
> +       spin_lock(&t->lock);
> +       trace_binder_txn_latency_free(t);
> +       spin_unlock(&t->lock);

Hmm. I don't prefer taking the lock just to call a trace. It doesn't
make clear why the lock has to be taken. I'd prefer something like:

if (trace_binder_txn_latency_free_enabled()) {
  int to_proc, to_thread;

  spin_lock(&t->lock);
  to_proc = t->to_proc ? t->to_proc->pid : 0;
  to_thread = t->to_thread ? t->to_thread->pid : 0;
  spin_unlock(&t->lock);
  trace_binder_txn_latency_free(t, to_proc, to_pid);
}

And then the trace would use the passed-in values instead of accessing
via t->to_proc/to_thread.

>         binder_free_txn_fixups(t);
>         kfree(t);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION);
> @@ -3093,6 +3096,9 @@ static void binder_transaction(struct binder_proc *proc,
>         kfree(tcomplete);
>         binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
>  err_alloc_tcomplete_failed:
> +       spin_lock(&t->lock);
> +       trace_binder_txn_latency_free(t);
> +       spin_unlock(&t->lock);
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
