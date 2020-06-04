Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423C3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E4520772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="norj+OxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgFDNHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgFDNHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:07:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DBAC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:07:46 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z1so5122739qtn.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spr/NPPAffPb40s6qAmeni6NJsTnXmWG1bgJUhXLpiA=;
        b=norj+OxSaUTJR+9g7Idf9dJWECEfCxDtdbIKfefQPmAxyGVw44ghGHtq7QCfhtF2tm
         9UNCq51UrwREXWhc49MuquhNb9DXGSEZ99NBilcw6sZpXpwnmYtKDXV0d/BcnWAi0nBq
         N7L2m3cxHRg1ZPEA5LPJgBo6Xc2ffE+1PUBSpzhOutKIY6pSSWsi1Gwo7MbVFIzkfwHW
         o0slbeVE9Co4pYsw/k0kUK5f1FWTAy3tGm/KNo/kWG91T9wSkjwDyY5MeeBGgOkIefA/
         9SyR5d0Pl6yih6tSkllfzzujaIozZcx45HgrAxBlIkbrGC1Futr/W3RGxuHgIbD1Tj/C
         MNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spr/NPPAffPb40s6qAmeni6NJsTnXmWG1bgJUhXLpiA=;
        b=UjP4E+DhYF3nZL2MoE/cOIUK+nJ+FmmjytKEMTiwWUcd5AkBuTSgOrMmF0zJuXHiKs
         f4C+ZjM92AHonjc0mpTrZ8ML/1xsrDwCP8/dyZnwwQ8oyAggqhOTBj0KxSscBx3yiEdg
         vbIADQXL7CMMiTPLHjESJ4hRefwBuswR2UpLKhqRNqhk2z/7kwxb/KAdwp1dqINFN4Td
         LLAe7jpuX2ZrbTgdHijJXZIVDXALiFfQnNsnTeita/iAcWHRgjnOxn1AQyTM2gZ5lN60
         DrvVdSmCqN6w/BVGCSqSHWKS2kZNOAqNOC93ljEIkxRkR2Jg4fhP7X7iP9xG/ammZVUW
         NthQ==
X-Gm-Message-State: AOAM532md3S0W+Lz3iDOVE4qAlN9XAmcF4vaHBxcoQjxda0xp9lky9YF
        NZE/vz3/kk3Xp0d6MaN29sx9EGoBOOjmywkMtspl/g==
X-Google-Smtp-Source: ABdhPJzzvRzkjlxDhSeDQfQb84Cx99UMX4PqcBGOgNyhBZlIlFtkEM0SI8ZjH5kLg6imGNDp3dJA30f75fgCcuKlj0M=
X-Received: by 2002:ac8:36c2:: with SMTP id b2mr4314281qtc.257.1591276064973;
 Thu, 04 Jun 2020 06:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com> <f70377945d1d8e6e4916cbce871a12303d6186b4.1585233617.git.andreyknvl@google.com>
In-Reply-To: <f70377945d1d8e6e4916cbce871a12303d6186b4.1585233617.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Jun 2020 15:07:33 +0200
Message-ID: <CACT4Y+axz_FHFBg7nfDt8C4p5uuUR21_22A_kwKMYTh2mW9FZw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] kcov: use t->kcov_mode as enabled indicator
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 3:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Currently kcov_remote_start() and kcov_remote_stop() check t->kcov to
> find out whether the coverage is already being collected by the
> current task. Use t->kcov_mode for that instead. This doesn't change
> the overall behavior in any way, but serves as a preparation for the
> following softirq coverage collection support patch.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcov.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index b985b7a72870..e43f06b5b2e4 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -746,26 +746,33 @@ static const struct file_operations kcov_fops = {
>   * In turns kcov_remote_stop() clears those pointers from task_struct to stop
>   * collecting coverage and copies all collected coverage into the kcov area.
>   */
> +
> +static inline bool kcov_mode_enabled(unsigned int mode)
> +{
> +       return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
> +}
> +
>  void kcov_remote_start(u64 handle)
>  {
> +       struct task_struct *t = current;
>         struct kcov_remote *remote;
>         struct kcov *kcov;
> +       unsigned int mode;
>         void *area;
> -       struct task_struct *t;
>         unsigned int size;
> -       enum kcov_mode mode;
>         int sequence;
>
>         if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
>                 return;
>         if (WARN_ON(!in_task()))
>                 return;
> -       t = current;
> +
>         /*
>          * Check that kcov_remote_start is not called twice
>          * nor called by user tasks (with enabled kcov).
>          */
> -       if (WARN_ON(t->kcov))
> +       mode = READ_ONCE(t->kcov_mode);
> +       if (WARN_ON(kcov_mode_enabled(mode)))
>                 return;
>
>         kcov_debug("handle = %llx\n", handle);
> @@ -863,13 +870,20 @@ static void kcov_move_area(enum kcov_mode mode, void *dst_area,
>  void kcov_remote_stop(void)
>  {
>         struct task_struct *t = current;
> -       struct kcov *kcov = t->kcov;
> -       void *area = t->kcov_area;
> -       unsigned int size = t->kcov_size;
> -       int sequence = t->kcov_sequence;
> +       struct kcov *kcov;
> +       unsigned int mode;
> +       void *area;
> +       unsigned int size;
> +       int sequence;
>
> -       if (!kcov)
> +       mode = READ_ONCE(t->kcov_mode);
> +       barrier();
> +       if (!kcov_mode_enabled(mode))
>                 return;
> +       kcov = t->kcov;
> +       area = t->kcov_area;
> +       size = t->kcov_size;
> +       sequence = t->kcov_sequence;
>
>         kcov_stop(t);
>
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
