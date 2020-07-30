Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDBBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF2E22BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OZ8J5iKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgG3DYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 23:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgG3DYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:24:07 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC65EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:24:06 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z17so6196008ill.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHh4RsCBRXoWwPbSjRWWq5HuFYgEivNXO/c+GhS+MZs=;
        b=OZ8J5iKdzrD7ZOS3oiWeOqMjZ8YQGcyZAgnZ2AY4LAqnKj9fMWuIO/lEMxQi5cbI6C
         BgEhayHQ7LbJhGHnWA5EG2/vvBN12zXQfH/3WbvSTl6Bt5XVozjvwIuAGHcIXR4hT8m9
         GOGcZjLTYdHk5GVsgUDQJ85EvWp1Q4NYe56Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHh4RsCBRXoWwPbSjRWWq5HuFYgEivNXO/c+GhS+MZs=;
        b=Dod4hGnKAHRTqp/sfncPmlbxcj16avq9zc3dNlp92UQ20a+3wGK5nDUr/r2vNLyqAx
         3mlduaSPWUkpKr1/srol13bCKNgiVGG20nI+LNr79kJeeiMBpIICMnSilCW8ikDGNwC7
         F4oBu0CZQB4h/0iDDbE/2nPIUAPgGrSWu1xf+sChorY5Yze6CUthOX3d+XWTEMXaa/3O
         GGrnsUXCk+fehmWEhXwq22xP83TSureIWjNI+sRgF4A+A/RPLma5R0B6P02n2g1qd5w0
         IqZ/CopW7lCEfIbBImD/dhvVXyAroGetFqzIpfCby4IFJ/rFRnfXtauYNDD7AL0/JpiH
         sc0w==
X-Gm-Message-State: AOAM532Ob721a4GzRQVP2wWQeNVS252dWwPYNRq4uhlgFOzEsUEYlj3b
        BwT+8h0zSH7FBzs+yHQqOdq8qq8FroIYYUxqfSzaVA==
X-Google-Smtp-Source: ABdhPJxVGmadWUvVb3YuYWhyFyI8XAr8VNALnFQQRC9snfK8nFNAi1PjGa347aw5KbtbI19VmFRkyAXaVSpXkLWvd60=
X-Received: by 2002:a92:b705:: with SMTP id k5mr35501322ili.176.1596079446340;
 Wed, 29 Jul 2020 20:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200716024527.4009170-1-surenb@google.com>
In-Reply-To: <20200716024527.4009170-1-surenb@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 29 Jul 2020 23:23:55 -0400
Message-ID: <CAEXW_YTps99nspdCtvMi6hO7kbpz8PgOH--g4d2-8gticrs4OQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] staging: android: ashmem: Fix lockdep warning for
 write operation
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Michal Hocko <mhocko@kernel.org>, hdanton@sina.com,
        ebiggers@kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> syzbot report [1] describes a deadlock when write operation against an
> ashmem fd executed at the time when ashmem is shrinking its cache results
> in the following lock sequence:
>
> Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(fs_reclaim);
>                                 lock(&sb->s_type->i_mutex_key#13);
>                                 lock(fs_reclaim);
>    lock(&sb->s_type->i_mutex_key#13);
>
> kswapd takes fs_reclaim and then inode_lock while generic_perform_write
> takes inode_lock and then fs_reclaim. However ashmem does not support
> writing into backing shmem with a write syscall. The only way to change
> its content is to mmap it and operate on mapped memory. Therefore the race
> that lockdep is warning about is not valid. Resolve this by introducing a
> separate lockdep class for the backing shmem inodes.
>
> [1]: https://lkml.kernel.org/lkml/0000000000000b5f9d059aa2037f@google.com/
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---

Once Eric's nits are resolved:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks.
