Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3049DC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A4721D56
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxtncIiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgAPPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:16:49 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51142 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgAPPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:16:49 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so1659760pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGV1h/iK7hiXSSeoWtrJ8GgUJFrerydZrHGUyBFsufA=;
        b=rxtncIiZqM3ICugqtMazv94B5O/KjQTtkhi/er7Z9fVtOxdTy5zmcicx+tagprHsBG
         NWOUcN8jjejkSAdlPu1L/FQYnDn8+jG91nuwCRKATs3QnMZlOOSMm1TMAGkLzRbfvThE
         fOU9lEw/alOEC2tFAYkVsMQ+k8d6inoHR/tXhhMP0E61uyE9NvgISizH96Ncl1RXXePI
         Apsc/qubW1txHLXZabRWTLXYbYv7NOuT/pHnpMT3e66+SPZsH8irx/Owmq2kJPFuRSS+
         b1Ld5SaPiw1a2D9UxFqqYiuM4SkCyujzB0nij5hXFKZjtY0TL4vgdA0KZvPSuqe1Cp//
         EgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGV1h/iK7hiXSSeoWtrJ8GgUJFrerydZrHGUyBFsufA=;
        b=hZOFl61UEjyghKtIJBbjGOQx01CDaLkP8SWLVcGCOB2osPHg1rGS0f3yBY+0hrhavy
         pYxGKDCUL8gMi/9dt7OpLZegUWkXhpYjFu2KajERpF67wWU2DAo+yVY99rYcv5gRWupn
         sUa4BdthozGGLa3b1nTr0kujJ089qahBzZXI8pdDtZ3AzOhN/9latMciJeO8N9XIXLlz
         Mu3N9ISQmNvVR/GML2pNGzrds8p+nyhGJjYcco3ua8ROoDKPTP+8aTIdjKRtBRwZPknz
         zPCI7q+Qi3dQpchkhagEoTgsWLjhzOIEb6AmIz7GWezwQCrl/pM8CnCzEppoldi7blUm
         tCtw==
X-Gm-Message-State: APjAAAVawYWN9DuTR3z3hpCXAemXG7piGz3PV/C+0K+KJaQoobYRI1Iq
        soO5+KXOiUZ6DYCzB8kk6Cq/Wz3xONLvVgEBV9wXMw==
X-Google-Smtp-Source: APXvYqwtSLDuetDkCV0E+KsMaNEoduKtwW+EweZylWBoc3U9hFDIJaaN0ETH41v7I3HcB0hVm6MiugmmUrHotWc+WeM=
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr7400543pjn.117.1579187808434;
 Thu, 16 Jan 2020 07:16:48 -0800 (PST)
MIME-Version: 1.0
References: <201912301716.xBUHGKTi016375@pmwg-server-01.pmwglab>
 <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com> <202001151727.C07DA17@keescook>
In-Reply-To: <202001151727.C07DA17@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 16 Jan 2020 07:16:36 -0800
Message-ID: <CAFd5g45rOLWoC6KQ+YXJpKMirNSfUFj3SrXefBVpmQ2-oi+Siw@mail.gmail.com>
Subject: Re: kunit stack usage, was: pmwg-ci report v5.5-rc4-147-gc62d43442481
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, PMWG CI <pmwg-ci@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Private Kernel Alias <private-kwg@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 5:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jan 07, 2020 at 01:37:07PM +0100, Arnd Bergmann wrote:
> > On Mon, Dec 30, 2019 at 6:16 PM PMWG CI <pmwg-ci@linaro.org> wrote:
> > >
> > >
> > > The error/warning: 1 drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 3128 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> > > ... was introduced by commit:
> > >
> > > commit c032ace71c29d513bf9df64ace1885fe5ff24981
> > > Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Date:   Wed Dec 4 10:53:15 2019 -0800
> > >
> > >     software node: add basic tests for property entries
> >
> > This problem is a result of the KUNIT_ASSERTION() definition that puts
> > a local struct on the stack interacting badly with the structleak_plugin
> > when CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is set in
> > allmodconfig:
>
> Geh, BYREF_ALL strikes again. I'm at LCA currently, but I'd like to try
> to revisit actually fixing the basic-block splitting in the plugin. This
> was looked at before, but I need to dig up the thread.

Sounds ideal.

I almost got the idea I suggested with the union/single copy
implemented, but it turns out that it is much more complicated than I
originally thought. It turns out that I need more than one copy per
struct kunit instance, I need one per active thread associated with a
struct kunit instance. It still seems possible to do this with percpu,
but it also makes the macro factory more complicated as well.

I am now questioning whether the approach I suggested is really any
better than Arnd's approach.

So yeah, I would definitely prefer fixing the struct leak code.

> If a fast fix is needed, I'm fine with disabling BYREF_ALL with KUNIT.
> It's not optimal, but I feel it's on the BYREF_ALL code to solve this. :)

Sounds good to me.
