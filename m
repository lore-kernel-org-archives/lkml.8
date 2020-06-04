Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD53C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BD0206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faSHCfVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgFDMGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgFDMG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:06:29 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7993BC03E96E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 05:06:29 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e20so2763808qvu.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8XXw9bWqog1qXznkBFIaFfGNYcanEbfH23hTVGzPIQ=;
        b=faSHCfVZTU002i9rOq3081b6hzhIIqH7n5dv5hGRJd8jMEK/WM+98oeWfE+xnoRjTI
         xwyoBTmd5jkTkC2T2FtyxJh6cTLJurmhk5Kp48DH8KwAg3CCsjlyqPhtYX+t8vlCC9Kc
         1l0/nu61+qDRbgfmSUXRvlSPGBNhPbZeMTPJBClNBBv85NJMoIeVwAOBeJN3uzZiNTdI
         0tM1CsKAEz9faQe/svQg9wwSlgpONxqegigWVLrYtNSr8/GJnaRUx7mztf4LMqBfpPu5
         TXw0mpqlRLDAHb0UL2838SF2FOH0YJ3/K2eGG8/NGgguFUx8fanSmhr6OSVaa41cZ/5z
         VRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8XXw9bWqog1qXznkBFIaFfGNYcanEbfH23hTVGzPIQ=;
        b=UJ4DBtSRpGj8tdr5ARnXPa38pVZmKqreX55JlQt2TTSNZeVqkbKKbu2Lf3raSSOHP2
         RxbkfekrHYF75HJTICE/VS5xsxE3G6Lj7w3+qpTi8Wr2VR80mNgmOaCaIcjdNThX7Qtg
         DUMkEzBQ4muphPcLpJC4yjYthtfJPJKTd/AKgKuXXFolZsNmb0lLm9pZkTmHPSJSAvpa
         CStJoJDn8L+Glct1P9qCao/+SkgBJ5UjA7QZYdWaKzYoSB9q6htG/Q5RZzRl6VIGW0tL
         GDE3GiY4Ul8S0F2aLpkDmAvtFkSwh+lLFG5eNDXdeHHCoUck91oQNuWC2+pA4wYdbvoJ
         uG4A==
X-Gm-Message-State: AOAM532B/Jn0OnMvy+XT0V00VSqwHIWLFHHaZm9rTTGYmiOoN5YztW4r
        GoNLfTI0gCxSvsJoLMabn2MMMoZsOevq2N8kTy8YDg==
X-Google-Smtp-Source: ABdhPJxZCPPf49APC5CxzIFLlJ2ZS0uykwlb6NLcKgK/nhI4HSwy5rWlG4Afb78EiExniD1IYqBpul8PsQDoOd/7vq0=
X-Received: by 2002:a0c:c70f:: with SMTP id w15mr4544479qvi.34.1591272388478;
 Thu, 04 Jun 2020 05:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com> <9d9134359725a965627b7e8f2652069f86f1d1fa.1585233617.git.andreyknvl@google.com>
In-Reply-To: <9d9134359725a965627b7e8f2652069f86f1d1fa.1585233617.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Jun 2020 14:06:17 +0200
Message-ID: <CACT4Y+YMd1f_trERXGgcQgXa35cq33kfQd-Fv8_5G6V+XLbqTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] kcov: fix potential use-after-free in kcov_remote_start
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
> If vmalloc() fails in kcov_remote_start() we'll access remote->kcov
> without holding kcov_remote_lock, so remote might potentially be freed
> at that point. Cache kcov pointer in a local variable.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcov.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index f6bd119c9419..cc5900ac2467 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -748,6 +748,7 @@ static const struct file_operations kcov_fops = {
>  void kcov_remote_start(u64 handle)
>  {
>         struct kcov_remote *remote;
> +       struct kcov *kcov;
>         void *area;
>         struct task_struct *t;
>         unsigned int size;
> @@ -774,16 +775,17 @@ void kcov_remote_start(u64 handle)
>                 spin_unlock(&kcov_remote_lock);
>                 return;
>         }
> +       kcov = remote->kcov;
>         /* Put in kcov_remote_stop(). */
> -       kcov_get(remote->kcov);
> -       t->kcov = remote->kcov;
> +       kcov_get(kcov);
> +       t->kcov = kcov;
>         /*
>          * Read kcov fields before unlock to prevent races with
>          * KCOV_DISABLE / kcov_remote_reset().
>          */
> -       size = remote->kcov->remote_size;
> -       mode = remote->kcov->mode;
> -       sequence = remote->kcov->sequence;
> +       size = kcov->remote_size;
> +       mode = kcov->mode;
> +       sequence = kcov->sequence;
>         area = kcov_remote_area_get(size);
>         spin_unlock(&kcov_remote_lock);
>
> @@ -791,7 +793,7 @@ void kcov_remote_start(u64 handle)
>                 area = vmalloc(size * sizeof(unsigned long));
>                 if (!area) {
>                         t->kcov = NULL;
> -                       kcov_put(remote->kcov);
> +                       kcov_put(kcov);
>                         return;
>                 }
>         }
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
