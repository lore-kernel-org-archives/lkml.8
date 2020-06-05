Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47089C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6B82075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rCaoirU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFEJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFEJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:54:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96206C08C5C4
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 02:54:40 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k8so6974832edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQ16o+qUwgYcoh0hZifP35qFFRDEvSaPDsLpEh1ikCk=;
        b=rCaoirU7A0HN6aBgr2LdE3yr5g17a+UroWILMuXJVVtYCBdmWed1GS8GwUni1Mn4bs
         WiCixcK2FEbDfiqcT5aI8OwT4CDrGCx8TZ3kDHlnVgJ+ErAZ6buF8PeNt5p6EhEJTg76
         RwBhpNX0IUheJeDrz936ea+31jUlqJ1kNQaSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQ16o+qUwgYcoh0hZifP35qFFRDEvSaPDsLpEh1ikCk=;
        b=hnOOxxa5bU8736TXEzBjUaRJuuYd5AKXy9J8h2q7yTdxozxP3jzA9hngKYqkNhsL4g
         dMLNsyMwK5xu3zuevvnhjUOXNdYZoBEFPWVwihNcU+vRlHT9PvQ0kTLWTGhmWmOk1qiu
         KMDBU3+p39TgISCRnb4AhQPcETe+uBBF1788S658qSEbha4w3NCHtWKChxFBcsHj7OJi
         PWyctviMu2oTrvo4GKjWkXWPoZEfLXL1JMQEbpvXs81nVJ5E/qmKlTjZh/mUL01WPihe
         7B45Gr6/cmR7nf22TVPMKQy1T61NLD6wElVOT/Psh9THk9wOzgUZ4TPnCp0NHvPSn7OA
         kG+A==
X-Gm-Message-State: AOAM530B1NrNGYs6QA+kUHvAg67loAvLwJbGAxa4gX+MwyQuN4wB8kGB
        xiYFTRQ445zSBmhi61YmDC7gGeRYiT+ZxXPIkn3ngg==
X-Google-Smtp-Source: ABdhPJxPXhJVSPka5expBk13ruYWdBASBt1uTHiBSxAcue4V3qBGXozjJwtdDHlzLpa3GAZtoYQwqOkGqSuOZOhiOKI=
X-Received: by 2002:aa7:d785:: with SMTP id s5mr8857980edq.17.1591350879015;
 Fri, 05 Jun 2020 02:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200604084245.161480-1-glider@google.com> <202006040844.C50B47699@keescook>
In-Reply-To: <202006040844.C50B47699@keescook>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 5 Jun 2020 11:54:27 +0200
Message-ID: <CAJfpegsNL17k+Yv1-4bmogqjzq-rO9H1xT-+DM2m7qq7oH25MQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: explicitly initialize error in ovl_copy_xattr()
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, royyang@google.com,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 5:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 04, 2020 at 10:42:45AM +0200, glider@google.com wrote:
> > Under certain circumstances (we found this out running Docker on a
> > Clang-built kernel with CONFIG_INIT_STACK_ALL) ovl_copy_xattr() may
> > return uninitialized value of |error| from ovl_copy_xattr().
> > It is then returned by ovl_create() to lookup_open(), which casts it to
> > an invalid dentry pointer, that can be further read or written by the
> > lookup_open() callers.
> >
> > The uninitialized value is returned when all the xattr on the file
> > are ovl_is_private_xattr(), which is actually a successful case,
> > therefore we initialize |error| with 0.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Roy Yang <royyang@google.com>
> > Cc: <stable@vger.kernel.org> # 4.1
>
> Please include a Fixes (more below) and Link tags for details to help
> guide backporting, then you don't need to bother with with "# 4.1",
> the -stable tools will figure it out with a "Fixes" tag.
>
> Thanks for the v2!
>
> Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1050405
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> > The bug seem to date back to at least v4.1 where the annotation has been
> > introduced (i.e. the compilers started noticing error could be used
> > before being initialized). I hovever didn't try to prove that the
> > problem is actually reproducible on such ancient kernels. We've seen it
> > on a real machine running v4.4 as well.
>
> It seems like it came from this, but that's v4.5:
>
> Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")


I believe it's actually:

Fixes: 0956254a2d5b ("ovl: don't copy up opaqueness")

That patch added the ovl_is_private_xattr() check in ovl_copy_xattr(),
without which 'error' was always initilalized.

Thanks,
Miklos
