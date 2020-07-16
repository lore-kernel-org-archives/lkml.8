Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6616DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403E82076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lv8wc5MB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgGPTak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbgGPTaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:30:39 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5A9C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:30:39 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o184so3648619vsc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JHL6dtY9/obxl6PVDueE6KgqOWo1hP8aToaLoJogXM=;
        b=Lv8wc5MBk1xMDoVDniZJYSNIRYaVwYd563pj/BmHDv29qhlkxXzVxJn/UycDj5BI55
         0o7EKZrbVLG1OH9iMGZCjUaydi2H0vTAwdpEKzb4PDFVmlhuT2w5pIQV1wJSSWKsjDnk
         fvfiqoflke0iz/+NpbwihrTIcQZdfdIcAV8aHK0JN2ysHxmhrqZbA3VmcRSa9jqUfjsB
         fMQlsVKQdqcwLjEJX7bJ4Qed9+Rn6rYUC4en/fQ9rUNxGrl03j2+7zPJiON+pYZQfpbO
         EzxaJQcjLJ5PPVoVTuuALA5gujvbGUxCdHyehPNe2VtYJaHy1nYydB7CQfP374ARk7Zu
         rU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JHL6dtY9/obxl6PVDueE6KgqOWo1hP8aToaLoJogXM=;
        b=dOymsTjTZpGobFXELlBxphB5Q+YyYVs+SSZ3e1shT9PmCPE+eS/tsh+5e9fdofnXMO
         wnnjI7hSAtD97pI8UmDdm1Kc6ylOjxCkAn8fF80rJjRT+SYCgZ6oilWnXLmnWbYSHjfi
         amXuzEYYdFkSSB1cn05gOUzpjSlZ3Q/4cs9MlxUUWXsurrHLpGUpfEFmJgOLv87e25Os
         +IEUGWW9sPV0maPBXtn4H0f5eHts0NM2b1d0X+EpvEzLrISsDS0CtXMu3abNk83yH+eT
         OMHoTCPArqdr9uZylXLtnNLmcO5k/YNAldQAe4PoYTgh9jTr02/aUVYBQQzLjUUIhM0X
         nAwQ==
X-Gm-Message-State: AOAM530Fal+fuwbjRIgirdvflqIXIQlN0D2wVStPxQUS/avY4+Elv3SF
        IS261SKTxRASzwdjru7jQhCeSliIjVzg2+V/hJPOuA==
X-Google-Smtp-Source: ABdhPJwWkXtOPLOqrVcmtyJlG0aP+T8u+bPUV6PKoDH5U90Xrq5hIuM+nD03u5LdjnNO/fWF+VkxFtBnpluxWXZxTok=
X-Received: by 2002:a67:69c1:: with SMTP id e184mr4865729vsc.119.1594927838113;
 Thu, 16 Jul 2020 12:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200716024527.4009170-1-surenb@google.com> <20200716033048.GG1167@sol.localdomain>
In-Reply-To: <20200716033048.GG1167@sol.localdomain>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 16 Jul 2020 12:30:27 -0700
Message-ID: <CAJuCfpGwgmAD0v+F3CxieZmXHnjnbzrZ4Cpugi+8=-fDPgCU7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] staging: android: ashmem: Fix lockdep warning for
 write operation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 8:30 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jul 15, 2020 at 07:45:27PM -0700, Suren Baghdasaryan wrote:
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
>
> Please add proper tags:
>
> Reported-by: syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com
> Fixes: ...
> Cc: stable@vger.kernel.org
>
>
> The Reported-by tag to use was given in the original syzbot report.

Will add in v2. Thanks!

>
> - Eric
