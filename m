Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9EAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5D52072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJDG2r5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgCKS0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:26:13 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40929 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbgCKS0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:26:12 -0400
Received: by mail-vk1-f196.google.com with SMTP id k63so816474vka.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSTO/qgdxH6bi8PzikSAQgbIeZmagWyxAFGQFRnsxM0=;
        b=RJDG2r5hZ7Fa4gKvOb6pCPMrNGIdb/yHB7y2MSErjlsY7DUNkWh3ZEca8aPPbLj0VE
         ul6gkiQlxlyJ/oy4EVgannnB3f34MaqcrdBRY3NjNzJw+MC8doRaRH7czlERR29oZ7++
         XYgZ+a+e0GmSpGSW3PT5McijvKzbFCJfGGATRrEVCXhrhJvZ8sjZbJFhTfZWIu5pT+/0
         CE8s2xJ/zkUwJ75LtNCMyNOk99ot3gpGEzwc2DGOzuAcgDj8+bf6Wg8pUBdhHYtj4zqj
         1kzbY7mdKIMO1CScVFA8I+qyVi62JAK/5fBe+cSzveK3TknfkrVuCQQyXf/GO4cqHQOe
         BEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSTO/qgdxH6bi8PzikSAQgbIeZmagWyxAFGQFRnsxM0=;
        b=fwYnqa1mRbhbcCbD7DXpiqk3ky24HYnBvp2jlrYCzwJsINqVD43nDHazV0pAuGCVO6
         wp/fvKFYxyysSNmgEPLEaOi4rvz+xClru0wGugMJv/I/iTDNvODc3dqYi3iYKd/bJsK9
         DZWBlWpHCfzHuytasToHw/FVaJOgGwW2Exp0e2JUP/tMbmr2c4ot0niHFX4Czb5fJRXc
         J2vRMzLUgIx9w9P+JazWR6KYLrVryXRhSvauSatYm32a2ivYq5vsDgvA8u2t9bPvHYvB
         YuEMlRXEdypyxtOvun81CnPo6QNA0iCivm0rZdW2YSEdXjxC6CySV/4RlHon+kkGp+vl
         /hEA==
X-Gm-Message-State: ANhLgQ3pqBi1I1lfG92BDwzNdDQurGJg3G1rAVo0Vbay60gqGzIC5H/C
        S+/GmHQBLNwR9rb/N5B52nZ1vYeI2l+7Xz8D3VSEtA==
X-Google-Smtp-Source: ADFU+vuIP9IDVuL0y634tAQhisn3M2xsRFEZFWHFyFy7XLhjtLGyNWdbdNXlCC9/Qu0OTuevDsb+8mNaGPDTKJZbW+M=
X-Received: by 2002:a1f:cbc1:: with SMTP id b184mr2790877vkg.73.1583951170072;
 Wed, 11 Mar 2020 11:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYusdfg7PMfC9Xce-xLT7NiyKSbgojpK35GOm=Pf9jXXrA@mail.gmail.com>
 <20200311105309.1742827-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 11 Mar 2020 11:25:58 -0700
Message-ID: <CAHRSSEwF_UX7=6PLsmd62PfJwzdwScjqi=JxjtWkAmGorn+Xkw@mail.gmail.com>
Subject: Re: [PATCH] binderfs: use refcount for binder control devices too
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     naresh.kamboju@linaro.org, ard.biesheuvel@linaro.org,
        ardb@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, lkft-triage@lists.linaro.org,
        shuah@kernel.org, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 3:53 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Binderfs binder-control devices are cleaned up via binderfs_evict_inode
> too() which will use refcount_dec_and_test(). However, we missed to set
> the refcount for binderfs binder-control devices and so we underflowed
> when the binderfs instance got unmounted. Pretty obvious oversight and
> should have been part of the more general UAF fix. The good news is that
> having test cases (suprisingly) helps.
>
> Technically, we could detect that we're about to cleanup the
> binder-control dentry in binderfs_evict_inode() and then simply clean it
> up. But that makes the assumption that the binder driver itself will
> never make use of a binderfs binder-control device after the binderfs
> instance it belongs to has been unmounted and the superblock for it been
> destroyed. While it is unlikely to ever come to this let's be on the
> safe side. Performance-wise this also really doesn't matter since the
> binder-control device is only every really when creating the binderfs
> filesystem or creating additional binder devices. Both operations are
> pretty rare.
>
> Fixes: f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> Link: https://lore.kernel.org/r/CA+G9fYusdfg7PMfC9Xce-xLT7NiyKSbgojpK35GOm=Pf9jXXrA@mail.gmail.com
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: stable@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binderfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 110e41f920c2..f303106b3362 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -448,6 +448,7 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
>         inode->i_uid = info->root_uid;
>         inode->i_gid = info->root_gid;
>
> +       refcount_set(&device->ref, 1);
>         device->binderfs_inode = inode;
>         device->miscdev.minor = minor;
>
>
> base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
> --
> 2.25.1
>
