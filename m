Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557FCC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4702076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585084940;
	bh=X6ebq0WcchKrdaWOlTlc8AvYM4jWLIYlXO6WwrHjwSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y6XZMzRMH+9su8zRL/09zPYFprPb6B0wUVQtCNkPmt1p8NERFQLYE71DvCLVW2i0O
	 7yJW3tyrbFiMTwRimFudWmnzvPeE8mtt6q/rcyKI5RlQpJeuFgIq4DUf+mVo78ptY5
	 pomKKkoEAauJyhQhwHcPwiLjNBY9R+6M1zU28Q4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgCXVWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:22:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46342 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgCXVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:22:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id v16so213180ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0AQOrscsNAyPOgnjIz1wdZ8BwbWscK7BvSW7dZFNMU=;
        b=TU+v6vgTqqL8DSRyHNIS3zPA2Au3s8bOdz4RjYVrI59y/xJG37DuCzUkFedo8prEM1
         kEhbDC8RUbuZ44J4woqibSX2DnsCF77IrNvFFBgUdsgFnP87BEfOj65kKyLU5UPa/XiH
         yLDUovevdVM9pFj6antE7mF1/9gnUPays5DSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0AQOrscsNAyPOgnjIz1wdZ8BwbWscK7BvSW7dZFNMU=;
        b=Mau47tj/vxmXRguB0cinbmpu0kY/ERXDf4tRTW8biTDmyD9m6Ice6zbmuMdcjcL/bx
         0vdY1xzqSnBvyT3uwrxJvz43TWWUGbBvsbkPBhnq+fiwirmDhnjLunAkBkNAdo4mPAtQ
         Wu79+oku7BbnNgPAPqay2R9W5/qJeH/DPG0L+foRAm196XyQTazUyaYKZ6CipDogVV3K
         U2P20GXKaOB+uSAzjL8t8mMgpupOpNoCPmkGdCaFsIEh5L2gZ2vkLa4MhDEHlKuo/i6N
         G6wiY+oHt0DaenCGKwmnZDAEn5KIVmoLxJf3Y9WcqBPLE6L0qIMxkTemn6Tz6zOgPV7h
         XWKg==
X-Gm-Message-State: ANhLgQ0f812tmcz7coJ8S46F0a1zCpu5Ni8X/AV2qj2SVh9Ka+g1sr5s
        GkQMnLHPMvvVnaUtI1KoRg4Xpr1ZQgk=
X-Google-Smtp-Source: ADFU+vv1guZMSt2tjhx3HD9nfghEKRjSMy0ZQlf7MIKaUGGlXOc5kKzqVWQOEgZC2Ok1zUrAt+PB4Q==
X-Received: by 2002:a2e:3206:: with SMTP id y6mr6666471ljy.231.1585084936008;
        Tue, 24 Mar 2020 14:22:16 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id d23sm937823lji.62.2020.03.24.14.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 14:22:15 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j11so46903lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 14:22:15 -0700 (PDT)
X-Received: by 2002:a19:f015:: with SMTP id p21mr60990lfc.10.1585084934903;
 Tue, 24 Mar 2020 14:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200324204449.7263-1-gladkov.alexey@gmail.com> <20200324204449.7263-4-gladkov.alexey@gmail.com>
In-Reply-To: <20200324204449.7263-4-gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 14:21:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
Message-ID: <CAHk-=whXbgW7-FYL4Rkaoh8qX+CkS5saVGP2hsJPV0c+EZ6K7A@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 3/8] proc: move hide_pid, pid_gid from
 pid_namespace to proc_fs_info
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 1:46 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> +/* definitions for hide_pid field */
> +enum {
> +       HIDEPID_OFF       = 0,
> +       HIDEPID_NO_ACCESS = 1,
> +       HIDEPID_INVISIBLE = 2,
> +};

Should this enum be named...

>  struct proc_fs_info {
>         struct pid_namespace *pid_ns;
>         struct dentry *proc_self;        /* For /proc/self */
>         struct dentry *proc_thread_self; /* For /proc/thread-self */
> +       kgid_t pid_gid;
> +       int hide_pid;
>  };

.. and then used here instead of "int"?

Same goes for 'struct proc_fs_context' too, for that matter?

And maybe in the function declarations and definitions too? In things
like 'has_pid_permissions()' (the series adds some other cases later,
like hidepid2str() etc)

Yeah, enums and ints are kind of interchangeable in C, but even if it
wouldn't give us any more typechecking (except perhaps with sparse if
you mark it so), it would be documenting the use.

Or am I missing something?

Anyway, I continue to think the series looks fine, bnut would love to
see it in -next and perhaps comments from Al and Alexey Dobriyan..

            Linus
