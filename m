Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A85C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C733C206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8MKx8Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgFDMJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgFDMJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:09:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE76C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 05:09:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w90so4922439qtd.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jNY0OxQKLd1WvX6JnPs3onyVCUthdyvu9aUn5huzkI=;
        b=L8MKx8WkT410qkYvFSaTqRUr4fVYNHkSx0TMJzFvPuA2qozcz5nNF31doad1qmcZKG
         P+/u60vsnCSow0+vcJywo5Va0rIDFMJI7XeaoXkowyTEd1A4yhgXqJZFl5lMpn1Vr9MN
         gsB2kNOJ1Dbye6GCsOfSyAieGfa9zN8RmLiaawnsVZugTqUP3yMbERpToeMHPoNX+wQO
         J+1uylPX/SIoay8Hu+MJW1JpozVVWfPbXAcE+VjSHVQpSbbt4WR8nzbWsdZeFFl+Wfp7
         EmjmiF7TSLVX7Qm4hr7oiO1r7VTVCt0CkzDw4eb0qlSjivO5ACgwGxQ7h7e+ZS3g6fax
         c2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jNY0OxQKLd1WvX6JnPs3onyVCUthdyvu9aUn5huzkI=;
        b=iTvW0BaTm5dIbgDwx5ZFLLLXlU4lsFlUBVa4XdQXUNjK9aox2zGeEmuWuGCZfXXIb5
         4XANLMp5qU39x718SvE52LFsxSx6WYu8IQijsOzL4jiBdy9FgvnZFvU4X0PzLfUzvnEw
         3AmKtarqPeC3ScBWG5dCUeE9VaRwk/FAIkfSLHATzJSimVPUXmCXVD0kbUJuhehjq00y
         ZR62IbpSns1djijGL9gsiDTfkQopBxqfRita+0MhNLNCdsh9r2UvZub3ub9wkN7kukAV
         ssMlnuGShxs61dbYRFblh7ry9XQh2ePURyAt4hXMuxgKg6db5HvgbgAR4m+Gd6aDZSlQ
         DnvA==
X-Gm-Message-State: AOAM531k+OWcikvlNWXDJjr7v3ebp1Cga05aL31/ZIXETNkSJuzRiltW
        GDu9y+qmhGo1Psp2RPN0bGQeR3usayVt3KylfDi7zA==
X-Google-Smtp-Source: ABdhPJyC/ODun0saZltRdN6aUWpqSrTbDPEU82krsoQnxXg3qXfZSSCrXgNUXCpEpixt5SDFFEFb5jC0FeGyhciChxA=
X-Received: by 2002:ac8:32dc:: with SMTP id a28mr4156710qtb.158.1591272571334;
 Thu, 04 Jun 2020 05:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com> <6644839d3567df61ade3c4b246a46cacbe4f9e11.1585233617.git.andreyknvl@google.com>
In-Reply-To: <6644839d3567df61ade3c4b246a46cacbe4f9e11.1585233617.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Jun 2020 14:09:20 +0200
Message-ID: <CACT4Y+aH-ScaO4wwciZQbOB-tLXYun3vFwGNf8MOpCQ+JMbptg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] kcov: move t->kcov assignments into kcov_start/stop
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
> Every time kcov_start/stop() is called, t->kcov is also assigned, so
> move the assignment into the functions.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcov.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index cc5900ac2467..888d0a236b04 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -309,10 +309,12 @@ void notrace __sanitizer_cov_trace_switch(u64 val, u64 *cases)
>  EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
>  #endif /* ifdef CONFIG_KCOV_ENABLE_COMPARISONS */
>
> -static void kcov_start(struct task_struct *t, unsigned int size,
> -                       void *area, enum kcov_mode mode, int sequence)
> +static void kcov_start(struct task_struct *t, struct kcov *kcov,
> +                       unsigned int size, void *area, enum kcov_mode mode,
> +                       int sequence)
>  {
>         kcov_debug("t = %px, size = %u, area = %px\n", t, size, area);
> +       t->kcov = kcov;
>         /* Cache in task struct for performance. */
>         t->kcov_size = size;
>         t->kcov_area = area;
> @@ -326,6 +328,7 @@ static void kcov_stop(struct task_struct *t)
>  {
>         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
>         barrier();
> +       t->kcov = NULL;
>         t->kcov_size = 0;
>         t->kcov_area = NULL;
>  }
> @@ -333,7 +336,6 @@ static void kcov_stop(struct task_struct *t)
>  static void kcov_task_reset(struct task_struct *t)
>  {
>         kcov_stop(t);
> -       t->kcov = NULL;
>         t->kcov_sequence = 0;
>         t->kcov_handle = 0;
>  }
> @@ -584,9 +586,8 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                         return mode;
>                 kcov_fault_in_area(kcov);
>                 kcov->mode = mode;
> -               kcov_start(t, kcov->size, kcov->area, kcov->mode,
> +               kcov_start(t, kcov, kcov->size, kcov->area, kcov->mode,
>                                 kcov->sequence);
> -               t->kcov = kcov;
>                 kcov->t = t;
>                 /* Put either in kcov_task_exit() or in KCOV_DISABLE. */
>                 kcov_get(kcov);
> @@ -778,7 +779,6 @@ void kcov_remote_start(u64 handle)
>         kcov = remote->kcov;
>         /* Put in kcov_remote_stop(). */
>         kcov_get(kcov);
> -       t->kcov = kcov;
>         /*
>          * Read kcov fields before unlock to prevent races with
>          * KCOV_DISABLE / kcov_remote_reset().
> @@ -792,7 +792,6 @@ void kcov_remote_start(u64 handle)
>         if (!area) {
>                 area = vmalloc(size * sizeof(unsigned long));
>                 if (!area) {
> -                       t->kcov = NULL;
>                         kcov_put(kcov);
>                         return;
>                 }
> @@ -800,7 +799,7 @@ void kcov_remote_start(u64 handle)
>         /* Reset coverage size. */
>         *(u64 *)area = 0;
>
> -       kcov_start(t, size, area, mode, sequence);
> +       kcov_start(t, kcov, size, area, mode, sequence);
>
>  }
>  EXPORT_SYMBOL(kcov_remote_start);
> @@ -873,7 +872,6 @@ void kcov_remote_stop(void)
>                 return;
>
>         kcov_stop(t);
> -       t->kcov = NULL;
>
>         spin_lock(&kcov->lock);
>         /*
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
