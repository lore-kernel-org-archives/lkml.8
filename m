Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF61DC11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DE3208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582238639;
	bh=+Jk8ZLGepwfSKBz/r/AeAIirnEIPybIoNRaHLfpkM8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HFfJcx5/j/TUI91rDCgTKzmk03ofEVTwFZURQaMmftUecLEq2U12wL2k9WIyA5+a6
	 JL5GkG9Ig8gJwcVU/9Uk42AGJ7d8/OK+UfVw/tdJ/zWq8r8vZtXewYHdaCxlOk+YFS
	 7Hm1DK47DeFOTanfXv0V99BVrBsMCEYIGlZUmTb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgBTWn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:43:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42986 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgBTWn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:43:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so151162ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsBAqEZQag0ypHqg0PyTqrCBxrLtLK/vf3m5Pbo+Q1I=;
        b=HocGqZaPvPbj2Rc3tHfIsXtvsU9ZExNqDhyGTd1FkLfg2CixXSIhWg+lhtFLFy7LH5
         Ll9ajjeSCLGyVGJFCP3pr8MzRIUlhdaSf4zT2trYK3NmUY7kfmF8q56qyO7AFc70i6vi
         mx1gRvncgXwtZTQp0OujHwfoGsQovufSXPaY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsBAqEZQag0ypHqg0PyTqrCBxrLtLK/vf3m5Pbo+Q1I=;
        b=UXe5CknQKPTBC6nhtgXAz/7m3fjbuhZLvMk21gmr1SkMm6SSNf+/9Wr3S9yC0t0csv
         QoLBjVmnC7HXQJ6P4thDw/oLBfacV34nohbigBGlRndY7Ei2qLPjAAjcFQyKC3aw63Us
         k4vut22P46OCDMKiZRp0qFp9ANdLC/L9g60+6UkUr8+VDMGctRbEQXJ/0cVNsfanRSNy
         YpZBx7br2yitY5Y4Tjd5Mnw8HWc1cfzMB9O36OqjG2JYKk54aMBGh41TjetRX3Z+8ULw
         F57XtgwkROLkAG2KyfgO34nO7mo3Yz4nY8tSR0FlajXwLj9Hy5qRSjROuFYABaZbnUN3
         cDMQ==
X-Gm-Message-State: APjAAAUUnKmVC8Sm5Q7Lj/qyRAaXC0UhlKUhAsZT+Td8L1PsOGedcOZR
        Iqy/3z/aNqbYMGa+Unn3FwJiLxQpqB8=
X-Google-Smtp-Source: APXvYqys5/hzp2WKKbf6o0qwIwBCTk1LThe6yYs4XhV7Qq2I1H7pIwYV2xP/Hnvd3dLI10cFvl6gyg==
X-Received: by 2002:a2e:8797:: with SMTP id n23mr18879589lji.176.1582238635297;
        Thu, 20 Feb 2020 14:43:55 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id c203sm489358lfg.28.2020.02.20.14.43.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:43:54 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id q23so174265ljm.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:43:54 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr20465844ljk.201.1582238633679;
 Thu, 20 Feb 2020 14:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 14:43:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmwfv6zGwTRR8zTyTdfxgYoc7SE3Z0nKHu_srG_8NPWw@mail.gmail.com>
Message-ID: <CAHk-=whmwfv6zGwTRR8zTyTdfxgYoc7SE3Z0nKHu_srG_8NPWw@mail.gmail.com>
Subject: Re: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:51 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> To use d_invalidate replace d_prune_aliases with d_find_alias
> followed by d_invalidate and dput.  This is safe and complete
> because no inode in proc has any hardlinks or aliases.

Are you sure you can't create them some way?  This makes em go "what
if we had multiple dentries associated with that inode?" Then the code
would just invalidate the first one.

I guess we don't have export_operations or anything like that, but
this makes me worry...

            Linus
