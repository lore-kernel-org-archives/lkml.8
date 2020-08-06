Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E81C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA9823119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dXe6RGc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgHFQ7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgHFQ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:58:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE290C0A3BD0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:58:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l4so51022940ejd.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XBlSxPFXmmwC9ml0NMR2WdlXom4n6CpwebB65mVnUs=;
        b=dXe6RGc6/xXA7dnes7IB/pkAiTFvxhcpMvvtqW5JIhIYAIOZZskja/irTxfuzn7ZLl
         BBhgrAchBiS9dj4kiDmcC0lEGAn06HCfFv6nA5dXmdYahycy0MfXQ2ZMAd65HnYzIU0G
         OvEJar8x1W8NIm/obNQnQmKoMi94gth0dQhd0cO/R5GP/Ep+6wW2lP44E7m8Pd8S2Z06
         PaKtvZp+Y7P3sMXXRTWk1rDK3tszZaurMvD748iPm+CVVqeCD3YJFeKNkRQvWm3wJGOY
         VJd9cVLog2o4YEJ6H4NSw2R88nYq7Bg1mQOzd2aOlgIjNcz2oSZP6yf04FCk4EHCIoAH
         /l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XBlSxPFXmmwC9ml0NMR2WdlXom4n6CpwebB65mVnUs=;
        b=LYGX00miFV1fJlU5tJlkde/NDCOtwscz82eYp3jcC7kLxYDfNtJgzHfALyPJuHqLBH
         efnrg/vLcE/1GbWjphqvnG9KsDFEesBziAEwRBVQBCgBxTlnN4ejWXUHYvzKT6HTmJUp
         0T396ELot0THM9YXy7iU33briKfSICemXk2pgrQt6Th8KuHu2FmlYln1ByaNjyaa/GW7
         yeOxW8wGqzX96PEkm08jN568rAoSKhhsCatgxrXGIBXh8HYMfD2p93NqlddLp+rK0h+2
         SK1gOFT4OdsgZLBMhyhoTbiZlPLbv2TLGyJ+kCWWVVZ9o2nBL8cvOVck1jB5TJV5++53
         BwCA==
X-Gm-Message-State: AOAM533G4Z4C+2q0nS9U4bZme2MgSr5j/ZprFgaQUmHs2aYZBG+Knxpq
        ZFe4+qcDaImhet2KaRyB8dpD2xuMsUnszTSv1jRSOg==
X-Google-Smtp-Source: ABdhPJwRwr7iyIOMmsIdXrbJrtDmOHJSdVosW8f7X72dl0j3AzF5hsJa5Lkjawzt3dSCmXDg7a+kSdYK+wDCeczJkfM=
X-Received: by 2002:a17:907:208e:: with SMTP id pv14mr5596998ejb.438.1596733116143;
 Thu, 06 Aug 2020 09:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200806165359.2381483-1-jannh@google.com>
In-Reply-To: <20200806165359.2381483-1-jannh@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 6 Aug 2020 09:58:23 -0700
Message-ID: <CAHRSSEwgfaQhqgHhfKWKpd78WAT20aj49exUgbJqhVXp7NBY_w@mail.gmail.com>
Subject: Re: [PATCH] binder: Remove bogus warning on failed same-process transaction
To:     Jann Horn <jannh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 9:54 AM Jann Horn <jannh@google.com> wrote:
>
> While binder transactions with the same binder_proc as sender and recipient
> are forbidden, transactions with the same task_struct as sender and
> recipient are possible (even though currently there is a weird check in
> binder_transaction() that rejects them in the target==0 case).
> Therefore, task_struct identities can't be used to distinguish whether
> the caller is running in the context of the sender or the recipient.
>
> Since I see no easy way to make this WARN_ON() useful and correct, let's
> just remove it.
>
> Fixes: 44d8047f1d87 ("binder: use standard functions to allocate fds")
> Reported-by: syzbot+e113a0b970b7b3f394ba@syzkaller.appspotmail.com
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f936530a19b0..5b0376344dbe 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2344,8 +2344,6 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
>                          * file is done when the transaction is torn
>                          * down.
>                          */
> -                       WARN_ON(failed_at &&
> -                               proc->tsk == current->group_leader);
>                 } break;
>                 case BINDER_TYPE_PTR:
>                         /*
>
> base-commit: 47ec5303d73ea344e84f46660fff693c57641386
> --
> 2.28.0.163.g6104cc2f0b6-goog
>
