Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D9FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9B122522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Am17qSnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgA1HZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:25:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37670 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgA1HZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:25:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so6517293pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DeZTFb2+mSAxTYz3CEQPbL5r8uD0hmjwfhYDKzn7KHU=;
        b=Am17qSnkbB2/QkD+PNBV7d2GDKqzvC8FjU0arBxwbxh6n1C9H4RtyzBoDbzrYvqXLH
         +mhF7zYtUyt+CW4XxicKA8MI87/uIMV897oTuJAN9/n/V2T/5nd99niuOqNyiT2Emu8B
         DWBPY4Q4E3iOFEyQTYErISv/9pXWgmxjvla19RqkopUc6iU2OCn9IGImG85mby9yRBez
         YLVuoT42u+NG8QaXY1twMbu7GleyNk6BaJs30PxRUsIyxG0IAr8UVVXN4oNu7yHXTJMu
         vd8iOexlIqAxASPEtwWN3hlfYXKoWjxCqQNDSX1lnvYwhAznFGAqLx2vF3VYz2n+CVP8
         7EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DeZTFb2+mSAxTYz3CEQPbL5r8uD0hmjwfhYDKzn7KHU=;
        b=OOUjVNtLWdTYI6jFM31wxkKWJW23D08H3Mysi7SfY+01LSRN+JkRLea9fl7IkkmRgD
         hDhiuRbSto+eP8tuHMhf8CX7+f2lueWCsOgaaGLjmovz2t1MdoJYJBH6OwvXkFyqAehF
         eiX8hU1MZRzfX/JfH4/rtaBF0X2/0O3GsqjY/aNE+Xuu8YNDXHcinCjOzt9EjrhJgqM3
         rr9PXzRTxPvs06HjrE4IIs/Ko9Rm0kdxiELkekwpUSh2WFfkqB5s5kZ5lUWtnZq/PR1V
         0oFrE4Tyjsc3TVyOV8sbIAKcfvAuY86wKdOeZl77pS1v0NYDz752SmNRGTDfWG2ml2Pk
         kwrg==
X-Gm-Message-State: APjAAAWiy9FFAuRD9HXmbN+2WyYrGagWt63uYrpI7/F8tkISM5ga0Zz0
        2Xwf+bOAnFP3Xtx1S+V9+tBgT+t7IAu1rfSvbpu7SA==
X-Google-Smtp-Source: APXvYqzhDwtJNT/bYA0xB9hi/YED4F0baWbm6jieCSJoubq75bTBsJaQIbFNfHf6Vchc56tVkfTifNdIEiNND7TQyBk=
X-Received: by 2002:a63:480f:: with SMTP id v15mr23047248pga.201.1580196314249;
 Mon, 27 Jan 2020 23:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20200127193549.187419-1-brendanhiggins@google.com>
 <20200127193549.187419-2-brendanhiggins@google.com> <CAK7LNASR13WjasKPmq-8gURhNUpOsrsCN2ODUh56fpM9DKWq7A@mail.gmail.com>
In-Reply-To: <CAK7LNASR13WjasKPmq-8gURhNUpOsrsCN2ODUh56fpM9DKWq7A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 27 Jan 2020 23:25:03 -0800
Message-ID: <CAFd5g47EOrbMdPFa2QO-5dEWZBq_N_MK5g4G2p3E8kEMmAECVw@mail.gmail.com>
Subject: Re: [RFC v1 1/2] kbuild: add arch specific dependency for BTF support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 7:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi.
>
> On Tue, Jan 28, 2020 at 4:36 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Some archs (like UM) do not build with CONFIG_DEBUG_INFO_BTF=y, so add
> > an options for archs to select to opt-in or out of BTF typeinfo support.
>
>
> Could you use a different subject prefix (e.g. "btf:") ?
>
> This is unrelated to kbuild.

Sure. My apologies, I just used the kbuild subject prefix because
that's what the previous commit that touched BTF used. Will fix in
next revision.

Thanks!

> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  lib/Kconfig.debug | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index e4676b992eae9..f5bcb391f1b7d 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -238,9 +238,12 @@ config DEBUG_INFO_DWARF4
> >           But it significantly improves the success of resolving
> >           variables in gdb on optimized code.
> >
> > +config ARCH_NO_BTF_TYPEINFO
> > +       bool
> > +
> >  config DEBUG_INFO_BTF
> >         bool "Generate BTF typeinfo"
> > -       depends on DEBUG_INFO
> > +       depends on DEBUG_INFO && !ARCH_NO_BTF_TYPEINFO
> >         help
> >           Generate deduplicated BTF type information from DWARF debug info.
> >           Turning this on expects presence of pahole tool, which will convert
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
>
>
> --
> Best Regards
> Masahiro Yamada
