Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B96C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C792078E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597713483;
	bh=UN/Irk0WMGhahDxHhCFhnMBwEpK3nk1NBmdMtCISZhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lQqnhCynhACp0a2fACuT4IjIg2KKZi8IioKuk60JNwXtAoH2y30dntA3OeUXmYmqp
	 WOnponwT5WKxq8YRi+gNcRLZvSos5XAsqANf3CYyHxHz5+qisVtUO+FiCUgD6j9qq2
	 rpIiVw3PjUspyMpj8hWATaFir/GdQUa9IdD3WWfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHRBR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgHRBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:17:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E6EC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:17:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so19524233ljo.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jO6k+zx2QyYG7TMnQ5c6/6yeQvSBLn9YZjhaXafaPvk=;
        b=eHsDhhag9rrcZCLW4PVvHzOSXn+lP4FTzkwXO8QbMaXFsoRdcItDm4EaUIv9k9Eayj
         DrMKFoyqJ82ML0/jpilgEzHE0oovbm1sqBsCjmoGO2+tOR9O7zFUyZoSgpXghA0LrnSJ
         pzyGN+EBFFdYxkC7yV+8bD6gAtHXA0066kioo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jO6k+zx2QyYG7TMnQ5c6/6yeQvSBLn9YZjhaXafaPvk=;
        b=TgUoGEpz0ggoB+pOmt1nEM6p7ocyO6ks2n1pmZnm+Swrf6+r5UI7LixOGXaShZVnTB
         fAXnHKvjS9Zs9D3RqwCkVbJDx6Jdu2wGnQZc9GvQ+8GNyHOwkAKHmZIJK1Q2EDkfodSa
         jsJ7Yacr+wMBC2ujudZvxRhpt2gWW4GyN3VhCc0RfrmpJCrSzHnjuUeKgtnaUjFSEhoc
         06HwyYWzyPpavkdtddOFDKWX/suE3phnvWr/Atd0GvFB6rKRPuH5GNIKdWxhoKiUZvsk
         QBWo5/NZ1t9NT6It2E/7MF/6PvKIgyVYs9n1fJZU+puZrLWS+bg2pZ49zrhMViPBxZPs
         /srA==
X-Gm-Message-State: AOAM531MNY+QsWCPhsmsYhEObRyvsayKnOZR7GoUcLpCF1GasN/2O9h9
        gG5HDiwsbY095vl+ft1nf93Hc/OvwQuzuw==
X-Google-Smtp-Source: ABdhPJw1FDFQkCimOxqpciR/a4sNyLuYull4UK5HCnY3vnNOAp47ZU4h9pBTx63Q49T69qs9lQk+Qg==
X-Received: by 2002:a2e:9852:: with SMTP id e18mr8552630ljj.415.1597713475244;
        Mon, 17 Aug 2020 18:17:55 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u5sm5902411lfi.91.2020.08.17.18.17.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 18:17:53 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id v9so19573198ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:17:52 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr9127085ljp.312.1597713472024;
 Mon, 17 Aug 2020 18:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-9-ebiederm@xmission.com>
 <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com> <875z9g7oln.fsf@x220.int.ebiederm.org>
In-Reply-To: <875z9g7oln.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 18:17:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
Message-ID: <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, bpf <bpf@vger.kernel.org>,
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

On Mon, Aug 17, 2020 at 6:06 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I struggle with the fcheck name as I have not seen or at least not
> registed on the the user that just checks to see if the result is NULL.
> So the name fcheck never made a bit of sense to me.

Yeah, that name is not great. I just don't want to make things even worse.

> I will see if I can come up with some good descriptive comments around
> these functions.  Along with describing what these things are doing I am
> thinking maybe I should put "_rcu" in their names and have a debug check
> that verifies "_rcu" is held.

Yeah, something along the lines of "rcu_lookup_fd_task(tsk,fd)" would
be a *lot* more descriptive than fcheck_task().

And I think "fnext_task()" could be "rcu_lookup_next_fd_task(tsk,fd)".

Yes, those are much longer names, but it's not like you end up typing
them all that often, and I think being descriptive would be worth it.

And "fcheck()" and "fcheck_files()" would be good to rename too along
the same lines.

Something like "rcu_lookup_fd()" and "rcu_lookup_fd_files()" respectively?

I'm obviously trying to go for a "rcu_lookup_fd*()" kind of pattern,
and I'm not married to _that_ particular pattern but I think it would
be better than what we have now.

                       Linus
