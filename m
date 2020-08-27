Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC15C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24222087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598554123;
	bh=1YLMWPfV1KJRjr1pNvuV7hmWk5jpP5UXWOHKa2kkVvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YAz7qvt02wKMcWI2sGimYy0SsG8I7uHCA3yZgPJXZ4Jk2yQqysU2HR9n7dA40mf6k
	 b0C15hbSm01avVFS/YzJQBL/kS1CZebBO6dv4ySN9BL8Kcs0Df5DiM47hNiW3rpPOi
	 0u5lnGFTyV1rC4MDBguZQwwICRJeHX28lqyFGV4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgH0Ssm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Ssl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:48:41 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22587C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:48:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so7588760ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8uKIyxKJZGMFK27FSpfT4pEOrXmgQmftLPNQiF5Ags=;
        b=GdtWp5MQD4adXPn1+MPDOh47Q/qmNR+kXHqkReEttYlyV5nvZd9s00btYUxQs4l1dH
         dNWVrwcT/Cs0w0f3pLvad2nkncjmN/0n3FrUvEHk4y0he+XT2yd0ZF8H+ptMq3YYYyYH
         cQbOeLwBFBc74quV8xJe90M8SbzIOaQfYHm9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8uKIyxKJZGMFK27FSpfT4pEOrXmgQmftLPNQiF5Ags=;
        b=qgSE+JsgpiHloWUPoHOM5m9NOWSbUHpbk4NxJPDKDSbSso5IEW8DQD/GMaBoHOKgLr
         UaQ0KlUHJPuqLu7hEP7CXsrbYD5B8WXlc33XMTefm4AAr9Ufv+CNgZEqvxelESfFaher
         u9EPcZ01ZxGhFFWmOp6dAFcVOTpCQd50C9RmqC705F8vQl9dyd3bfovGrIECMeQHTXbr
         ZUGyCDVRRcLr4C/fCclceSfwpjW9veMYfRUk4E1qhllgqGBF08yASVXF7z011IpHLaFk
         5kXQzATP4cRmH7Uqb4Nqlg4SqM+LQozsNS749T34OP+Of6NfXlI7hKivpEW29ga9vcOE
         5Orw==
X-Gm-Message-State: AOAM532/EuhGqOifbPqVXBFex/ghiPRiP+vdWdV0ODrhmHvf1IwzuACy
        YvScgdrkSK/jEArOaVvLN4rT3+8lBh/w5w==
X-Google-Smtp-Source: ABdhPJzfu0KPx+4tJzU5h6sejSG3kfnfQvozE4S5qD8GF2vtGRaOVlrydZVNjkdkgGq5tbebFSUE5g==
X-Received: by 2002:a05:651c:1125:: with SMTP id e5mr10654827ljo.238.1598554116875;
        Thu, 27 Aug 2020 11:48:36 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a192sm619845lfd.51.2020.08.27.11.48.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:48:36 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id d2so3481302lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:48:35 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr10463708lfc.152.1598554115455;
 Thu, 27 Aug 2020 11:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200827013636.149307-1-allen.lkml@gmail.com> <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
 <1598553133.4237.8.camel@HansenPartnership.com> <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 11:48:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wingJWToQfoc+m2am7Q=7r8XD+6p0FXasCRAzOdcRyngw@mail.gmail.com>
Message-ID: <CAHk-=wingJWToQfoc+m2am7Q=7r8XD+6p0FXasCRAzOdcRyngw@mail.gmail.com>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Allen Pais <allen.lkml@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:40 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Aug 27, 2020 at 11:32 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> >
> > The tasklet rework people don't want to use container_of, which was our
> > first suggestion, because it produces lines which are "too long".
>
> WTF?

Side note: I'm entirely serious. If somebody has problems with "too
long lines", they are doing things wrong. Just ignore them.

Changing standard kernel interfaces is the wrong solution. What's
next? Using 2-character indentation like some broken projects do just
to make lines shorter and encourage people to do deep nesting?

No. The solution is to not write crap code with overly complex expressions.

"container_of()" has been a _very_ successful model, and the only
reason to ever wrap it is if you already *know* the type, and you wrap
it with an inline function that actually checks it.

For a lot of (usually) good examples of this, just do a

     git grep return.container_of

and find things like

    static inline struct kvm_pit *pit_state_to_pit(struct kvm_kpit_state *ps)
    {
        return container_of(ps, struct kvm_pit, pit_state);
    }

which now results in a type-checked *true* simplification of container-of.

It basically creates a specialized version which documents what it
does in the name, and does proper type checking, and doesn't try to be
another name for the existing generic container_of().

Seriously. It sounds to me like the tasklet rework people are people
we want to avoid. They're doing completely the wrong thing.

So just throw that garbage out.

                      Linus
