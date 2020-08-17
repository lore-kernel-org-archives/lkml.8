Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9933AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA1E2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597708501;
	bh=9VC0DN6yLohlJLA/9URQDBzzhnNRD23247orsc7xUEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tjPO5BSipYrY/spkZCkto6RUZmAfTeXMN6e9vw72/mKljpk1WSEu6oVA2Pvysgdix
	 uXzYhjuftO2yo3Zrafi8MdBg2PJpn8bHwoy3qDKhl3Jn/6dYss4GFKMc6OeRy711rL
	 4l44r+HTTc9JEl4Mcg2040jnQr0jXLd81WaBucZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHQXy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgHQXyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:54:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84AC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:54:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so19411893ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRD9fxr2dmL3cWS6/haxe+/7+RVNAwBfQJLvwFE/2BM=;
        b=GttK3xwVXIEnQDmtYMvF2IJlJWEatfccGGsHzVm20TPi9ekAoaV3TrMSE8QIJupeaU
         o5VYt+7CPeShna6icVTEVqf0cqW5xz6D3gxuRcD4PasdgxEfOrygjNQEgJGTOM8C+RQ7
         unaPe2LNmBbFRNpH7o6v91jPT9h97hM2C5bOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRD9fxr2dmL3cWS6/haxe+/7+RVNAwBfQJLvwFE/2BM=;
        b=YQbcyfDQhpF89UEJUjqfet0gRIx/Eshtc7Gx+LN4nkOUnKL7cKH0btl8Bw3TRCa/C+
         1YNLzpRKkGUpbdHnpEionBgKY+xsv7jkG9nGpdKT2mwktQLuRM0wjvYZE66Ubz+jO5kS
         b7sQVhkGBx6vpGDJac/v1Wa/Z4Jl0t6VyPc3QljcC83UgBpCzLWovmEIFPUkEQaQ4PKR
         g2cIo7fqCsMXp/gDpHddqHJ4+T1OuNtdH6qlD2cbq3Yl/q7/vEBxtejrfy1hEDhtRHpZ
         tqHe5WUpLzaJXVh1zS9Di0BkihyUrOBxOXVjQCl3r27de6ACsDRFb+pXuM3yKVzYkCgo
         dGvw==
X-Gm-Message-State: AOAM533CRjWdCDoB1GANJjS+syoOVmhJgIj78Pyp8L+V1/N7CM/3Qs7c
        Tee/+n3DhaQpjNVVzVBx4b2y7T+0q3Hxww==
X-Google-Smtp-Source: ABdhPJwFY1CeGGTx8mVfODPqZUDh+zMn4MCGo/kdYqjfS9os7fa2snVQG5nMzZMKBq8PTkqqyALsnw==
X-Received: by 2002:a2e:3802:: with SMTP id f2mr7760993lja.212.1597708493053;
        Mon, 17 Aug 2020 16:54:53 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u9sm5310005ljh.20.2020.08.17.16.54.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 16:54:51 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id f26so19389924ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:54:50 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr7971652lji.314.1597708490610;
 Mon, 17 Aug 2020 16:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-9-ebiederm@xmission.com>
In-Reply-To: <20200817220425.9389-9-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 16:54:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
Message-ID: <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I like the series, but I have to say that the extension of the
horrible "fcheck*()" interfaces raises my hackles..

That interface is very very questionable to begin with, and it's easy
to get wrong.

I don't see you getting it wrong - you do seem to hold the RCU read
lock in the places I checked, but it worries me.

I think my worry could be at least partially mitigated with more
comments and docs:

On Mon, Aug 17, 2020 at 3:10 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> +struct file *fnext_task(struct task_struct *task, unsigned int *ret_fd)

Please please *please* make it clear that because this does *not*
increment any reference counts, you have to be very very careful using
the "struct file" pointer this returns.

I really dislike the naming. The old "fcheck()" naming came from the
fact that at least one original user just mainly checked if the result
was NULL or not. And then others had to be careful to either hold the
file_lock spinlock, or at least the RCU read lock so that the result
didn't go away.

Here, you have "fnext_task()", and it doesn't even have that "check"
warning mark, or any comment about how dangerous it can be to use..

So the rule is that the "struct file" pointer this returns can only be
read under RCU, but the 'fd' it returns has a longer lifetime.

I think your uses are ok, and I think this is an improvement in
general, I just want a bigger "WARNING! Here be dragons!" sign (and
naming could be nicer).

            Linus
