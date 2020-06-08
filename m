Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A21C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D9220656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NaHAImHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgFHIGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgFHIGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:06:03 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F743C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 01:06:03 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dp10so7892798qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RnGTVOb3Nv5WNDCecfKqTEw95jHmOkYyQ+RTpehLbU=;
        b=NaHAImHdNtabQd/Qvuo5QWbyCOQaSX99q/se5lAqVYF1L/IQrBrIsy4r96m340g0m3
         f3LRrEKq8AhFSgHO7HI+7Tw5vig1YThiVK/46nBP6dq2vWA2kVKGzsyTUnGZwmLRbU93
         9CwYnC17IIWOTXfrErZNo57EirJ9WOUMVojW6ChQtdszAv2f0sRWehdW1etUu4ShBuL6
         q6B0rFAcQSKlg6h6Qm49XlGAT7sXlgwEliId4BROQRrtEwo69Nbr9+Bvf3J7Au9kvniV
         QjuVa7DnIL2IunKl7+DTXqEzUuTywOz9CJGiFDostVXPsqTupKZR+3AfbgkE5Pr5Iigx
         0lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RnGTVOb3Nv5WNDCecfKqTEw95jHmOkYyQ+RTpehLbU=;
        b=RdCngCpzpxQmvmazQoA4qPHn6CMOgQUSWTgiS1KpakjOLcx1Mlq/8/WMGYixtHSvQR
         YIWhmSg2T98lf/CSj2b3yqiSw89AyhNZ0UM+isxnC6ud854JfJUZF9x9Q0AyZzCbT8Lo
         QRRpoEIO3HwmWmO8D42h7eKKRpt68Yca2Lhtk+5dS1G4hr5xaRi01v6rUubG8bNVhwxw
         D7xSMtOddjCKr4EY9qMkOmiKwC0ABWCqht11jcEgFAdHOSNmJ6LG7+hXDzRp+R0pUrfV
         OGacV6vC09QKxq7zADNXLqqVvxmDDiDFW0eDj79MpU0Kr8O+vWKrcFT/J3A5jhe3Ie0c
         SPkQ==
X-Gm-Message-State: AOAM533l0XTmDzDQWKXtu13Q1ONdBfr5tINJHUJx4PRElSgpRhFCUGnk
        uiLEZrZ85mNQ2YEn/DADUXicGotpU10YvF9QugRt8Q==
X-Google-Smtp-Source: ABdhPJxrWoXgyJwjBSwHr1fg7cg0NgpXasMqFwVhili2G5JI6X5WxIAOtYt8k8yKUP5aFc8S70CFmGNqbCnsgiUNM3g=
X-Received: by 2002:a0c:910c:: with SMTP id q12mr20293465qvq.22.1591603561321;
 Mon, 08 Jun 2020 01:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <fcd1cd16eac1d2c01a66befd8ea4afc6f8d09833.1591576806.git.andreyknvl@google.com>
In-Reply-To: <fcd1cd16eac1d2c01a66befd8ea4afc6f8d09833.1591576806.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Jun 2020 10:05:50 +0200
Message-ID: <CACT4Y+ZWaSWWhxv3fw_bN0y_MKSG8L+Q_eFvWDwLgyWcTC0aSQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: check kcov_softirq in kcov_remote_stop()
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 2:42 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> kcov_remote_stop() should check that the corresponding kcov_remote_start()
> actually found the specified remote handle and started collecting
> coverage. This is done by checking the per thread kcov_softirq flag.
>
> A particular failure scenario where this was observed involved a softirq
> with a remote coverage collection section coming between check_kcov_mode()
> and the access to t->kcov_area in __sanitizer_cov_trace_pc(). In that
> softirq kcov_remote_start() bailed out after kcov_remote_find() check, but
> the matching kcov_remote_stop() didn't check if kcov_remote_start()
> succeeded, and overwrote per thread kcov parameters with invalid (zero)
> values.
>
> Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcov.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 55c5d883a93e..6afae0bcbac4 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -427,7 +427,8 @@ void kcov_task_exit(struct task_struct *t)
>          *        WARN_ON(!kcov->remote && kcov->t != t);
>          *
>          * For KCOV_REMOTE_ENABLE devices, the exiting task is either:
> -        * 2. A remote task between kcov_remote_start() and kcov_remote_stop().
> +        *
> +        * 1. A remote task between kcov_remote_start() and kcov_remote_stop().
>          *    In this case we should print a warning right away, since a task
>          *    shouldn't be exiting when it's in a kcov coverage collection
>          *    section. Here t points to the task that is collecting remote
> @@ -437,7 +438,7 @@ void kcov_task_exit(struct task_struct *t)
>          *        WARN_ON(kcov->remote && kcov->t != t);
>          *
>          * 2. The task that created kcov exiting without calling KCOV_DISABLE,
> -        *    and then again we can make sure that t->kcov->t == t:
> +        *    and then again we make sure that t->kcov->t == t:
>          *        WARN_ON(kcov->remote && kcov->t != t);
>          *
>          * By combining all three checks into one we get:
> @@ -764,7 +765,7 @@ static const struct file_operations kcov_fops = {
>   * Internally, kcov_remote_start() looks up the kcov device associated with the
>   * provided handle, allocates an area for coverage collection, and saves the
>   * pointers to kcov and area into the current task_struct to allow coverage to
> - * be collected via __sanitizer_cov_trace_pc()
> + * be collected via __sanitizer_cov_trace_pc().
>   * In turns kcov_remote_stop() clears those pointers from task_struct to stop
>   * collecting coverage and copies all collected coverage into the kcov area.
>   */
> @@ -972,16 +973,25 @@ void kcov_remote_stop(void)
>                 local_irq_restore(flags);
>                 return;
>         }
> -       kcov = t->kcov;
> -       area = t->kcov_area;
> -       size = t->kcov_size;
> -       sequence = t->kcov_sequence;
> -
> +       /*
> +        * When in softirq, check if the corresponding kcov_remote_start()
> +        * actually found the remote handle and started collecting coverage.
> +        */
> +       if (in_serving_softirq() && !t->kcov_softirq) {
> +               local_irq_restore(flags);
> +               return;
> +       }
> +       /* Make sure that kcov_softirq is only set when in softirq. */
>         if (WARN_ON(!in_serving_softirq() && t->kcov_softirq)) {
>                 local_irq_restore(flags);
>                 return;
>         }
>
> +       kcov = t->kcov;
> +       area = t->kcov_area;
> +       size = t->kcov_size;
> +       sequence = t->kcov_sequence;
> +
>         kcov_stop(t);
>         if (in_serving_softirq()) {
>                 t->kcov_softirq = 0;
> --
> 2.27.0.278.ge193c7cf3a9-goog
>
