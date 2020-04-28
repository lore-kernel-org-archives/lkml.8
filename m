Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6DBC83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C7C206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588038273;
	bh=Lkl6K/3AX+U13aetHC0TrO4ikRJFL3MaON0p7QUiEWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B/8VFqdS3Hiv0VAc9xiWYi3GfX+RQibPjCP3XCJUN1s6lsaa3V8lnqVxG7FZEYG5j
	 OgmWMcilEB9jC/UBKtyiZUK+b4TcIAdcK44oDcdaiLxVuSfsByosl6c6iX5daUI9k8
	 QzW2ILGtbYW3qrIjS2dgSk+Y8SeB5chEDC7jTIeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD1Boc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgD1Bob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:44:31 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C5FC03C1A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 18:44:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id r7so15193385edo.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dLKuml1l37VsUNUL7W3+8Plw3oZZU13zk85vygbzVU=;
        b=Bd+HoaOQxYuuh8Zf1OdODQuVSh84RUl4JQmlzGerUyQmf8yQo21wChRkbSt91VRbi7
         rW7nVLys2SsQX2Zyf0eFgqihojc0YmFDp8m/iu9CZyEhvrn1ELZTebPjm+Ei/dLS9xRA
         fQg/tEt3Rd0+Q259PEVjDGKRpewOS/+lcY8FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dLKuml1l37VsUNUL7W3+8Plw3oZZU13zk85vygbzVU=;
        b=OFEa9D0TR44hd2nxsFuPrP2BC6pvFEAzJMitRQ68VEpT8VU0yoNxRtmdn4ZGfHgK1U
         y3ymkmp9qclKpeIcfBKAxhLgyqKyqd5ntl5GIyi7RAb1xZE7Ym6zSmmbxGQW8fQ2sI37
         d96oNJ/FQ5Io69470SvCHxgclsbXp9h6eNRYaeaqbKKQ2IKq2cp9PB7i4PD2LyEYuPkZ
         FxkRvZ54pRvvUYUtmPn/wO0EDWa3DumRBHibQ/N1/UxVYsmzWkgwpHUK1o2N+f83AC+C
         g1jVRuzgDPUr5I484Sv3n77RGc7Z0WBhYY11OrIp6LSV7vs6hrzHwJBsK8//eCHAjKRs
         76SA==
X-Gm-Message-State: AGi0PuZ0vhGhhjQ+0BD7teCE/r9JdIWHJSQEqKeNw2LVml4vMv2adkWe
        gjvi0DP/9zYzaqw0STHkGd2U9HTCkJk=
X-Google-Smtp-Source: APiQypImgvMU7CXHZH0GN68HjQ+4686vzh9ZabejfYlMM6csZNqh+vZZAj/tT/cDTcbDNiNEEu8xqA==
X-Received: by 2002:a50:9b53:: with SMTP id a19mr21482394edj.104.1588038269964;
        Mon, 27 Apr 2020 18:44:29 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a15sm134933eds.50.2020.04.27.18.44.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 18:44:29 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id a8so15219881edv.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 18:44:29 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr17156490lfo.152.1588037812064;
 Mon, 27 Apr 2020 18:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200426130100.306246-1-hagen@jauu.net> <20200426163430.22743-1-hagen@jauu.net>
 <20200427170826.mdklazcrn4xaeafm@wittgenstein> <CAG48ez0hskhN7OkxwHX-Bo5HGboJaVEk8udFukkTgiC=43ixcw@mail.gmail.com>
 <87zhawdc6w.fsf@x220.int.ebiederm.org> <20200427185929.GA1768@laniakea>
 <CAK8P3a2Ux1pDZEBjgRSPMJXvwUAvbPastX2ynVVC2iPTTDK_ow@mail.gmail.com>
 <20200427201303.tbiipopeapxofn6h@wittgenstein> <20200428004546.mlpwixgms2ekpfdm@yavin.dot.cyphar.com>
In-Reply-To: <20200428004546.mlpwixgms2ekpfdm@yavin.dot.cyphar.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 18:36:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
Message-ID: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 5:46 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> I agree. It would be a shame to add a new ptrace syscall and not take
> the opportunity to fix the multitude of problems with the existing API.
> But that's a Pandora's box which we shouldn't open unless we want to
> wait a long time to get an API everyone is okay with -- a pretty high
> price to just get pidfds support in ptrace.

We should really be very very careful with some "smarter ptrace".
We've had _so_ many security issues with ptrace that it's not even
funny.

And that's ignoring all the practical issues we've had.

I would definitely not want to have anything that looks like ptrace AT
ALL using pidfd. If we have a file descriptor to specify the target
process, then we should probably take advantage of that file
descriptor to actually make it more of a asynchronous interface that
doesn't cause the kinds of deadlocks that we've had with ptrace.

The synchronous nature of ptrace() means that not only do we have
those nasty deadlocks, it's also very very expensive to use. It also
has some other fundamental problems, like the whole "take over parent"
and the SIGCHLD behavior.

It also is hard to ptrace a ptracer. Which is annoying when you're
debugging gdb or strace or whatever.

So I think the thing to do is ask the gdb (and strace) people if they
have any _very_ particular painpoints that we could perhaps help with.

And then very carefully think things through and not repeat all the
mistakes ptrace did.

I'm not very optimistic.

              Linus
