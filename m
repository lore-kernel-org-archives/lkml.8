Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE545C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89098207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpjQZRBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGIUBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgGIUBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:01:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53AFC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:01:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id o4so1890240lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTuFFx+LM7FvItVugeQGGweyAvmIIEb57TLVDjlPY0c=;
        b=gpjQZRBfgknPgToKf4jJopWuArBbfyzEqorYF86kvD65J4xt9C2k1qEZRGU/p+ZG5B
         Ixm+TqJgPxYDtzo7Tork0MgD4E+oSyD9y45vQMzxY2Gl01j5Rw1fKEkdy8Kx7xKkNa7P
         deM6rEIaRNzGbiTs8yY/ICU7aV11OnW8+vyLE94Wq5coWQTixDsVyBy5A49X19sDUr5B
         KnRW/U8xrlHgtu63PEPZyeniB8GhjxqRZ5zQnM4HZb6/4pRwOzrLu7qYyysUqedtnhPp
         vA9UVik+kgCkAKY+6meGwOLcvS5a9RZAKbd69JOjp9GVXoB4hdAI1odoNyp5sqtac8am
         ZBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTuFFx+LM7FvItVugeQGGweyAvmIIEb57TLVDjlPY0c=;
        b=Dwbfdflv3kzEkIp1YoWl5DDTaf+V42sN9uet5g7nAUpbo6Mfu8Yd67rlUdz2l1dHBh
         QvwWywxHUaxAZjPT9wufq/joLzcO8UQ9Htv2Brt5vX9wAampFagUKTs60RsB+6PYhc9B
         KcBWQ3a0MukYixJG+1uQprv3L2CSmyFE6ER7iVq1ofHee7Jz8A5rtqAEvdae63/zpnPm
         fFW2VSI0clw8XXuTefXRXFz8pNQ6o6iiwgLYgyQxj66OrWgRx0w4BFp6giAFiY2IY5rp
         WvrMl+RcAZKjMqztrVGuI5y9/0lczYb7Lb1fMNNbbBHuilaCbflNJdR4sZ9Jp4AXBRPD
         tEMQ==
X-Gm-Message-State: AOAM5307V+UUeCiXWT9tmLzK9ZGVWTOSyTaK8AO2oQcvvo3D921ryoeq
        ekE2fOo9LjOEATSyFd5LFd8KZ4fZApdQpdJAPC+Vpw==
X-Google-Smtp-Source: ABdhPJzMEObKGztP4FkJdtpJ/jsigQq5atbT70AaZs8psKw5IErg+CIW340AK74bJ/ktHqLM57A7CacQhNPzzfvbILs=
X-Received: by 2002:a05:6512:3107:: with SMTP id n7mr42006913lfb.63.1594324868930;
 Thu, 09 Jul 2020 13:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200709182642.1773477-1-keescook@chromium.org> <20200709182642.1773477-3-keescook@chromium.org>
In-Reply-To: <20200709182642.1773477-3-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Jul 2020 22:00:42 +0200
Message-ID: <CAG48ez1gz3mtAO5QdvGEMt5KnRBq7hhWJMGS6piGDrcGNEdSrQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] pidfd: Add missing sock updates for pidfd_getfd()
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 8:26 PM Kees Cook <keescook@chromium.org> wrote:
> The sock counting (sock_update_netprioidx() and sock_update_classid())
> was missing from pidfd's implementation of received fd installation. Add
> a call to the new __receive_sock() helper.
[...]
> diff --git a/kernel/pid.c b/kernel/pid.c
[...]
> @@ -642,10 +643,12 @@ static int pidfd_getfd(struct pid *pid, int fd)
>         }
>
>         ret = get_unused_fd_flags(O_CLOEXEC);
> -       if (ret < 0)
> +       if (ret < 0) {
>                 fput(file);
> -       else
> +       } else {
>                 fd_install(ret, file);
> +               __receive_sock(file);
> +       }

__receive_sock() has to be before fd_install(), otherwise `file` can
be a dangling pointer.
