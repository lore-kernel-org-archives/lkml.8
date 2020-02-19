Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED5C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD4D207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582142538;
	bh=umOU8xNUP/S6VwpcOuP3vXNP9ZrtqaQDktotBa9G2yk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cV1PheByqsJBAeMmJPq0LmUqqvHVAMhn7RSkwk3m5D/9XD3A78ywS28+aIw0m0vgv
	 hERplfftIB9wtTKHsnQAtqsxZD1feA+2hCdD0Vzv0ll6na50g1jlEovXjgRRD/PwVr
	 klWZmTx0QiA2HQYkpRBOAy3scmpzjhb+upNcpc6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgBSUCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:02:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37417 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgBSUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:02:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so1139746lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrkpqGraJLSkkIbOys6AoGrfk0Io+UFshGQRunL40e4=;
        b=Kal0t6FR8sTD9iiGJnfjhlXxFvjpdgJ0AmNkYuS5+GpYB7A6koFsDGC4LjWp3IlWMG
         8OJbfj5jS7kVQYisDBJtgYraPdDsq2qBcThKDbdt4yADBtbKOrss3Db40c521F3kWde7
         kPrPExtNPNh8tK7n9gw1KxMW9LOvAwNvNohQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrkpqGraJLSkkIbOys6AoGrfk0Io+UFshGQRunL40e4=;
        b=Ku5h3a/t4DaMCcooaNsEtgoZqsCu7VAXUM39BQFlXYydUFOcugMaiEerW1t1rj4SmT
         Qti4idVtxBFynsr2vTQ4yJXcy7RXxOS6WgdCSW+Ehrfiipck3EYceK750ISiNHlPq8KI
         oRpsWnrjlClL9rdp4lZbsXJkz+s6sJoWXPshV1UlFG+KVrFJKQfF1YVjMZeLtaCThiJ+
         wX5XWSKh6+JFUvtaoPAWYZ0S62lr5incZaLsYwgLgdfrYksKNJsBm0u/6vc6Rg68DzK8
         +RfztyxGadGFRzDeOXxdaqmDxgeeJ74FMykhjc2hD8hZweZD6Ngom2dwDspWPRkH4WU+
         +LGw==
X-Gm-Message-State: APjAAAXx3HKIQ9NDMEdyW5COcUgXhIpAe9onPlBQ1Tg8ohEcgGK9XHUI
        mry5GgnmP89aFC9F0xZj/Q28xasAZzM=
X-Google-Smtp-Source: APXvYqwbatUPg8vTaMbviO3fJgFJAb7+I1zIr/jnuF0RXs9x0BaI+QVK7HrRtQSy0z68RSTj1OJsFw==
X-Received: by 2002:ac2:5549:: with SMTP id l9mr14345335lfk.53.1582142533068;
        Wed, 19 Feb 2020 12:02:13 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id l7sm332495lfc.80.2020.02.19.12.02.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 12:02:12 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id f24so1141617lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:02:11 -0800 (PST)
X-Received: by 2002:ac2:456f:: with SMTP id k15mr14373098lfm.125.1582142531417;
 Wed, 19 Feb 2020 12:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20200217183340.GI23230@ZenIV.linux.org.uk>
In-Reply-To: <20200217183340.GI23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 12:01:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
Message-ID: <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
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

On Mon, Feb 17, 2020 at 10:33 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Looking at the regset guts, I really wonder if the interface
> is right.

No, it's not right, but it has a history. I think it comes from the
internal gdb model, and Roland - who was used to that model - then
modelled the kernel internals roughly similarly.

But part of it is that the user interfaces have evolved over time too,
with the original one being the "get one register using magical
PTRACE_{PEEK,POKE}USR", and then because that performs horribly badly,
there's now a PTRACE_GETREGSET.

And yes, because of the gdb history, some of the interfaces make no
sense for the kernel. Like

> For another, the calling conventions are too generic - the callers
> of ->get() always pass zero for pos, for example.

I think that comes from the historical PTRACE_{PEEK,POKE}USR case,
where gdb has a unifying interface for getting one register (using
PEEKUSR) vs getting the whole regset (using GETREGSET).

But in the kernel, we never actually got to the point where this was
generalized. Each architecture keeps its own PEEKUSR implementation,
and then there is that generic GETREGSET interface that is completely
separate.

End result: ->get is never actually used for individual registers.

So yes, you always have a zero position, because you always basically
get the whole thing. But the interface was written on the assumption
that some day the PEEKUSR thing would also be generalized.

Except absolutely nobody wants to touch that code, and it's hard to do
because it's so architecture-specific anyway, and you can't switch
over to a generic model for PEEKUSR until _all_ architectures have
done it, so it's never going to happen.

Anyway, that's the explanation for the bad interface.

That is not an excuse for _keeping_ the bad interface, though. It's
just that effectively the interface was done overr a decade ago, and
absolutely nobody has ever shown any interest in touching it since.
"It works, don't touch it".

> What I really wonder is whether it's actually worth bothering - the
> life would be much simpler if we *always* passed a kernel buffer to
> ->get() instances and did all copyout at once.

I don't mind it, but some of those buffers are big, and the generic
code generally doesn't know how big.

You'd probably have to have a whole page to pass in as the buffer -
certainly not some stack space.

Maybe even more. I'm not sure how big the FPU regset can get on x86...

But yes, I'd love to see somebody (you, apparently) carefully simplify
that interface. And I do not think anybody will object - the biggest
issue is that this touches code across all architectures, and some of
them are not having a lot of maintenance.

If you do it in small steps, it probably won't be a problem. Remove
the "offset" parameter in one patch, do the "only copy to kernel
space" in another, and hey, if it ends up breaking subtly on something
we don't have any testers for, well, they can report that a year from
now and it will get fixed up, but nobody will seriously care.

IOW, "go wild".

But at the same time, I wouldn't worry _too_ much about things like
the performance of copying one register at a time. The reason we do
that regset thing is not because it's truly high-performance, it's
just that it sucked dead baby donkeys through a straw to do a full
"ptrace(PEEKUSR)" for each register.

So "high performance" is relative. Doing the STAC/CLAC dance for each
register on x86 is a complete non-issue. It's not that
performance-critical.

So yes, "go wild", but do it for the right reasons: simplifying the interface.

Because if you only worry about current use of
"__get_user()/__put_user()" optimizations, don't. Just convert to
"get_user()/put_user()" and be done with it, it's not important. This
is another area where people used the double-underscore version not
because it mattered, but because it was available.

It's like Sir Edmund Hillary, except instead of climbing Mount
Everest, people write bad code using the wrong interfaces: "because
they're there".

               Linus
