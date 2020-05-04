Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644F1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BED920735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBkBWfDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgEDLJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDLJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:09:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5B3C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 04:09:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so9186250ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdLTHxO9IddcIoMI/8THqMR0N6LIXAbkMhmdlHl48Hc=;
        b=EBkBWfDsbVxU7ShnPu9MmCzKnY96MUEv8NG3QCP9FdBISR6BN2GZq9UQ3Cdmg/flkp
         +OVkM1mF0URDaXGbY+OD9SsFs+ceKjLZinXQU+NCB8VLXKVxXZfOmBNODg6s1f2vWgN0
         6+rjuqtE2q09uIcQDXvWXWuS+4MBSvAov8MAMrr+whe/6rNQgDPi7lxMMgo4cllYt658
         jZG7FaTHkSrUDBifEO7ZZomaXD5NM1ez/9Kmv7A99+Vw9wIPnP0o3hTrbAnpSsL8+gHn
         y3zPSNwlkmrx8VTaMHd+KfDN5FJYOHTHFUgzihcLJi01WIe2AsRJjU4JP+mmM38ZBY5d
         Pi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdLTHxO9IddcIoMI/8THqMR0N6LIXAbkMhmdlHl48Hc=;
        b=ebPBd0j4ggJd7AhN9Z43mLWH37CZWb4Y5dDE1jATg3ryh9+nlMEQ9ZreKS5ulTm/Mp
         7VmKqsW5V1uNH4HfORrtObIFKBCYNpFb3iQd2NDJ9HKGmpEiEU6VYhDfSoD1P2sB+EBl
         M5pl05oQMPNqsXe/lb4k1DlhYNjG2Y/rZC3YcDW47xHqtd4uGlkZmk4BvtoEBK3ovqeM
         Se/8WFga75g3mh370eSSc8I2sxe2yI8mGHq3qu0Xrdr7LMnBj6v4JWSeHuTsWOm7CDMg
         kJK3iF8t68u8whNthPJzlYcJQ9e87YhUzwwTwppobUmPpsKH5avYRRRwdqf2AiVJItDU
         ckxw==
X-Gm-Message-State: AGi0PuaH4ZfpGzX+aHNdI9DEouvc9qLRH/DiVLwmK9HLFG2xh7xcU4b2
        VPrwm/sgqc96c5uCiDpzNr/uVxat0XNsF57H4WGeoYa6
X-Google-Smtp-Source: APiQypJz8mA1HuzgTjGk9FEd8v3Q8Dc+SfvfQTO03PV4DBCDSRRorW8Kz5Zbda7dc18IvxS6cjlGP5xFaHCFenBSFL4=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr9226190ljg.99.1588590568751;
 Mon, 04 May 2020 04:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588421219.git.asml.silence@gmail.com> <56e9c3c84e5dbf0be8272b520a7f26b039724175.1588421219.git.asml.silence@gmail.com>
In-Reply-To: <56e9c3c84e5dbf0be8272b520a7f26b039724175.1588421219.git.asml.silence@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 4 May 2020 13:09:02 +0200
Message-ID: <CAG48ez0h6950sPrwfirF2rJ7S0GZhHcBM=+Pm+T2ky=-iFyOKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] splice: export do_tee()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Clay Harris <bugs@claycon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 2:10 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
> export do_tee() for use in io_uring
[...]
> diff --git a/fs/splice.c b/fs/splice.c
[...]
>   * The 'flags' used are the SPLICE_F_* variants, currently the only
>   * applicable one is SPLICE_F_NONBLOCK.
>   */
> -static long do_tee(struct file *in, struct file *out, size_t len,
> -                  unsigned int flags)
> +long do_tee(struct file *in, struct file *out, size_t len, unsigned int flags)
>  {
>         struct pipe_inode_info *ipipe = get_pipe_info(in);
>         struct pipe_inode_info *opipe = get_pipe_info(out);

AFAICS do_tee() in its current form is not something you should be
making available to anything else, because the file mode checks are
performed in sys_tee() instead of in do_tee(). (And I don't see any
check for file modes in your uring patch, but maybe I missed it?) If
you want to make do_tee() available elsewhere, please refactor the
file mode checks over into do_tee().

The same thing seems to be true for the splice support, which luckily
hasn't landed in a kernel release yet... while do_splice() does a
random assortment of checks, the checks that actually consistently
enforce the rules happen in sys_splice(). From a quick look,
do_splice() doesn't seem to check:

 - when splicing from a pipe to a non-pipe: whether read access to the
input pipe exists
 - when splicing from a non-pipe to a pipe: whether write access to
the output pipe exists

... which AFAICS means that io_uring probably lets you get full R/W
access to any pipe to which you're supposed to have either read or
write access. (Although admittedly it is rare in practice that you get
one end of a pipe and can't access the other one.)

When you expose previously internal helpers to io_uring, please have a
look at their callers and see whether they perform any checks that
look relevant.
