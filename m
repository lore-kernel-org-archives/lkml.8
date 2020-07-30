Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC58AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD152074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mo+shIuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgG3TP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbgG3TP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:15:57 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDDAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:15:56 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id j7so351949vkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4NiYN/fL3K8jec2SXRSUpaYIgmwzb4CRMYaIZHw2Wc=;
        b=Mo+shIuYgxTD570H7jADBYlG25BTBtzrCa/DMP1/ZnB6du6o7y6Iu5HbWzAN4ikxdt
         uh0vY0TUwlLo/4mK3aDD1e2p9cYTU8AyeBViPTFM257sEPZ1poyvbt5TYlepaj0qNtEt
         T6A5+SmbejL5NQla83ikEicCbOq8JCHEIK5sTYxlIwibfj4+c4mw1IuGemr3C8pipv3c
         CUieCxgTJtNauBFRebXeOJmUf8NY2ibViaw3h42+IoleuNICpPq1BwhTUxp773yqsknX
         53x9EuiMUs4Xa7aTN7i0TnOJM4c476XqN/ron4MOlLkMmKydzur14NSGoQeUJekKCsc+
         NoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4NiYN/fL3K8jec2SXRSUpaYIgmwzb4CRMYaIZHw2Wc=;
        b=OtI1vQyCOeinvR+qJ8sKWWX21mBs10sTe0nsTWrcAy0008edJjFaonHCoGhkEI9TZU
         5hY6QgB6mq95lZHtEtJL2vjCB4rOaYe6XrcuQjD00vglyd9R66zMn0RY/7NUdt7kdkGx
         RlOIJhdtB75yNn7BWf1gzOWb4up3MajcuHGT06AZJ3HXScmOQduU53dzvh+JpOV6g0HY
         27UjC++mrfEZC/uipn/gDzOK6GPC3lMlhkytUrnrM2YqBrzH/2vmnURMbiWeouYhDOik
         Hc0Aqc3IvSQtpPeT+1eCcKUXQkv1jt27tA7gf7EJAqzLSyxsHue+9iMUW6Ix1WWMdKIb
         ASuA==
X-Gm-Message-State: AOAM531T1pqKZlZ+/mBzwk9FX7A08969yZw2z6UW10rroBufEcYckqlk
        8DC4ZNFBtSJQPPa6o6jtQTnExG8NR+y2gMBV6od0ng==
X-Google-Smtp-Source: ABdhPJygcFQl2Dx9t0fnHvdutxsbUiu3tCDlK/opODfvCZT9YJsnyIQJdPdlNHeffyQM0HQhM6iIbwxUr1yjzgBWlLA=
X-Received: by 2002:a1f:96c7:: with SMTP id y190mr310774vkd.5.1596136555382;
 Thu, 30 Jul 2020 12:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200716024527.4009170-1-surenb@google.com> <CAEXW_YTps99nspdCtvMi6hO7kbpz8PgOH--g4d2-8gticrs4OQ@mail.gmail.com>
In-Reply-To: <CAEXW_YTps99nspdCtvMi6hO7kbpz8PgOH--g4d2-8gticrs4OQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 30 Jul 2020 12:15:44 -0700
Message-ID: <CAJuCfpF7+8zex72b=sPkFjHu+emPBwzVYLdA69FqBRd2ieVVmw@mail.gmail.com>
Subject: Re: [PATCH 1/1] staging: android: ashmem: Fix lockdep warning for
 write operation
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 8:24 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Jul 15, 2020 at 10:45 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > syzbot report [1] describes a deadlock when write operation against an
> > ashmem fd executed at the time when ashmem is shrinking its cache results
> > in the following lock sequence:
> >
> > Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(fs_reclaim);
> >                                 lock(&sb->s_type->i_mutex_key#13);
> >                                 lock(fs_reclaim);
> >    lock(&sb->s_type->i_mutex_key#13);
> >
> > kswapd takes fs_reclaim and then inode_lock while generic_perform_write
> > takes inode_lock and then fs_reclaim. However ashmem does not support
> > writing into backing shmem with a write syscall. The only way to change
> > its content is to mmap it and operate on mapped memory. Therefore the race
> > that lockdep is warning about is not valid. Resolve this by introducing a
> > separate lockdep class for the backing shmem inodes.
> >
> > [1]: https://lkml.kernel.org/lkml/0000000000000b5f9d059aa2037f@google.com/
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
>
> Once Eric's nits are resolved:
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks Joel!
I'm fixing the nits and will report the patch shortly. One note about
adding the "Fixes: " tag - this is a fix for a false positive lockdep
warning and it's unclear which patch should be quoted here (I could
not find a clear cause that started this warning). In similar
situations, for example here: https://lkml.org/lkml/2020/6/15/958
developers seem to skip that tag. So I'll do the same.

>
> Thanks.
