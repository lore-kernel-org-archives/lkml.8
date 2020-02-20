Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67D8C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9231207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582239409;
	bh=pZudnsciafrb+vXn4etwqNO8T95u5KrvEe3MBiiI0Kc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=esZtqvHMvkTY+D+YXTAXAMABF+hV6VAAZFXraaM5aTNzGfSVhIvRDeNSEec/P3Dgj
	 p0/+v6/stp7P+knrDBmdkIeHxIljutBzWipOX07KNIpFxBhfnjE38QkH0nTIX8RRzT
	 REM3FqPBbScQwBAvQZAw+q3d4aKJSrNQQThnBcfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgBTW4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:56:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43251 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgBTW4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:56:47 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so172128ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPKDe6yRRFJGUnIwSU2OwVdWr6D/nSY2qyTGzzCBHYQ=;
        b=g52x6jfoclKMmzoDFsItZqupm/1XbxO96MhH+R0k3RS07HgaUyCwcGY2OQkLyiZEGS
         HeYbZrTNT4ygcHbgFok2GwM1MWDRWE1rWgHw90nB1fVTrKRtnxVYM68htw6dBXxWj+3F
         UhZPwMEXtTOtA6b4b76Pnl2fv6iWYWogA+Ul4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPKDe6yRRFJGUnIwSU2OwVdWr6D/nSY2qyTGzzCBHYQ=;
        b=Dud5ivsM6Zs8gmlbqZpDwEVZkpUXZuTcJT8JKdirSaA86JOg7D1i+ZucuVG9MU1Ii/
         mVmUOtyplrX5X2yHPpiJe6S2thimVfw4rD54Q0tbArCjM5bOWDIZuy0Rlzymv9GqPjZJ
         Y7s9VCM+FdMXsKHfA+G6GNW+bJ0/6rsrew1OSFOHMmfL2TtLQq0PwC+jPJEBHCpawPu/
         fvsHpTLTMBBAF/fXsFDLmEzA2eRDnaRNUQJYzFk4E+JHvCPjR5C1IByyMi4kSouVryVl
         WuN6bQKv28YKC+MTZ74jrCpZEc4XlmIElH7MSyI0BD8wQqPlm/SOjfF3RgYLscAOc0m1
         QQ4A==
X-Gm-Message-State: APjAAAX5lAHadWVuuWF+8YIcmMbAhD40NiJGJaIFs6l0sAS5qyQp1FO6
        QfBiBcZnCbCY+PSQcHsx8dxf5fS+G6I=
X-Google-Smtp-Source: APXvYqzi2XME7EAm3RJQ6RUdWW2k9+PeE2WIRx76tVDvNT872rFzIZgD5uk4bHED7mS9TEPg++s8gg==
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr19658221ljg.168.1582239405508;
        Thu, 20 Feb 2020 14:56:45 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d20sm425253ljg.95.2020.02.20.14.56.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:56:44 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id f24so43752lfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:56:44 -0800 (PST)
X-Received: by 2002:ac2:490e:: with SMTP id n14mr3027836lfi.142.1582239404138;
 Thu, 20 Feb 2020 14:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20200217183340.GI23230@ZenIV.linux.org.uk> <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
 <20200220224707.GQ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200220224707.GQ23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 14:56:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
Message-ID: <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
Subject: Re: [RFC] regset ->get() API
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 2:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Feb 19, 2020 at 12:01:54PM -0800, Linus Torvalds wrote:
>
> > I don't mind it, but some of those buffers are big, and the generic
> > code generally doesn't know how big.
>
> That's what regset_size() returns...

Yes, but the code ends up being disgusting. You first have to call
that indirect function just to get the size, then do a kmalloc, and
then call another indirect function to actually fill it.

Don't do that. Not since we know how retpoline is a bad thing.

And since the size isn't always some trivial constant (ie for x86 PFU
it depends on the register state!), I think the only sane model is to
change the interface even more, and just have the "get()" function not
only get the data, but allocate the backing store too.

So you'd never pass in the result pointer - you'd get a result area
that you can then free.

Hmm?

The alternative is to pick a constant size that is "big enough", and
just assume that one page (or whatever) is sufficient:

> > Maybe even more. I'm not sure how big the FPU regset can get on x86...
>
> amd64:
>         REGSET_GENERAL  =>      sizeof(struct user_regs_struct) (216)
>         REGSET_FP       =>      sizeof(struct user_i387_struct) (512)
>         REGSET_XSTATE   =>      sizeof(struct swregs_state) or
>                                 sizeof(struct fxregs_state) or
>                                 sizeof(struct fregs_state) or
>                                 XSAVE insn buffer size (max about 2.5Kb, AFAICS)
>         REGSET_IOPERM64 =>      IO_BITMAP_BYTES (8Kb, that is)

Yeah, so apparently one page isn't sufficient.


> FWIW, what I have in mind is to start with making copy_regset_to_user() do
>         buf = kmalloc(size, GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
>         err = regset->get(target, regset, offset, size, buf, NULL);

See above. This doesn't work. You don't know the size. And we don't
have a known maximum size either.

>         if (!err && copy_to_user(data, buf, size))
>                 err = -EFAULT;
>         kfree(buf);
>         return err;

But if you change "->get()" to just return a kmalloc'ed buffer, I'd be
ok with that.

IOW, something like

        buf = regset->get(target, regset, &size);
        if (IS_ERR(buf))
                return PTR_ERR(bug);
        err = copy_to_user(data, buf, size);
        kfree(buf);
        return err;

or something like that. Just get rid of the "ubuf" entirely.

Wouldn't that be nicer?

            Linus
