Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60AC82075A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtJtUAQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgFZUZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFZUZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:25:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396DC03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:25:40 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l6so2345629pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lj8Vexb+6K2EkvRLDIIMa04+QiE5YATPbQS9XSZnShM=;
        b=BtJtUAQP1Xeozg2+9z9AlinIWiJ+0lAh++hWmxBVJxh8hwQh9WjK/7JIYmr5qANx8+
         rObqJyzwtVq3+g4FtTBx2OrKqyZPtMpOpfZuGDD8hFjrhT+zs9i3EoZuKsMlc5WpXcLo
         RyNOyqqeE9dKOo/lSlpY6LbgmNvhelDsGFg14Pg/Wz+urEHSpf/69j6TPIHWL8eN24BX
         9pZOzOQGySgZfoYCljqlnssJhYlYZoxFcQsIANIlFuIgerryKcEt0H9LKLdqXsxUtfkU
         q+KeTMaCLhaRiVSysD2ZM5rCRxFidoDg/lOsbGd5wquzb+2yAZcuj0i6JUGBVB9EtP+Z
         evHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lj8Vexb+6K2EkvRLDIIMa04+QiE5YATPbQS9XSZnShM=;
        b=LeUbdQTs7P785oGNSOfjFC6uaGPvEqzFjZf86jgsU2t2uYccS5SPIUoGbgsuPNIT1J
         wqGr03vjvDWyerj96cm0MS+b85dm+4M0vIVcdksanrx387HpFr92629vy/mM+4vku8TC
         fhI3icDOSwK1KoJX0FBO+J2Ztb8Rr8sq3gSH7QVZ4xMmdaUPzGIn+bVrAw81cWvwXxmW
         yo7z1MVuRrSZJoyLRnajqtUNCBSlFHWQ9Y2VaMNAXpYcscKP4rH5YEPjoCHB4CQw95Ne
         dn0Ot2qfME1OQicl2fRT4dNqmdUFvCuHpvjMxLs6O3OJAqchpzXRN7KvNkluTayzh80W
         lSdA==
X-Gm-Message-State: AOAM531kXd7sPxeZN7qMFMU8nGTDiu3Z7Qqeh91Tmi8eAPsQQ+c5RF+2
        DEIMPUcFsEYBxtCuOG/sOx/WBCWPG8o3nfsthvqgyA==
X-Google-Smtp-Source: ABdhPJzi2CjOFoRaJFc6nIMQidEczrCchKjb4mW48OJK5lS21+wU2sDMo1f9Dcd7/SOBVPm9EP1XSN0nK3bjmIdsPg4=
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr5337521pjb.32.1593203139352;
 Fri, 26 Jun 2020 13:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200626185913.92890-1-masahiroy@kernel.org> <CAKwvOd=V_M43CP7G87K3TqSsxua2NcXPz6BnDt-z6167O2WAzQ@mail.gmail.com>
 <202006261319.F130204@keescook>
In-Reply-To: <202006261319.F130204@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Jun 2020 13:25:27 -0700
Message-ID: <CAKwvOdmFpgSGow3X4AhEC1B-xWNORTgAFBXgYPQHLGyhgefddw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 1:21 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 01:13:20PM -0700, Nick Desaulniers wrote:
> > On Fri, Jun 26, 2020 at 12:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > +++ b/Makefile
> > > @@ -762,7 +762,7 @@ ifneq ($(CONFIG_FRAME_WARN),0)
> > >  KBUILD_CFLAGS += -Wframe-larger-than=$(CONFIG_FRAME_WARN)
> > >  endif
> > >
> > > -stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> > > +stackp-flags-y                                    := -fno-stack-protector
> > >  stackp-flags-$(CONFIG_STACKPROTECTOR)             := -fstack-protector
> > >  stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
> >
> > So it looks like the previous behavior always added
> > `-fno-stack-protector` (since CONFIG_CC_HAS_STACKPROTECTOR_NONE was
> > always true), but then we append either `-fstack-protector` or
> > `-fstack-protector-strong` based on configs.  While that's ok, and you
> > patch doesn't change that behavior, and it's good to be explicit to
> > set the stack protector or not...it seems weird to have
> > `-fno-stack-protector -fstack-protector` in the command line flags.  I
> > would prefer if we checked for not having CONFIG_STACKPROTECTOR or
> > CONFIG_STACKPROTECTOR_STRONG before adding `-fno-stack-protector`.
> > That doesn't have to be done in this patch, per se.
>
> No, it would add only what was latest and most selected. (They're all
> ":=" assignments.) If CONFIG_STACKPROTECTOR_STRONG, only
> -fstack-protector-strong is set. If only CONFIG_STACKPROTECTOR, only
> -fstack-protector is set. Otherwise -fno-stack-protector.

Ah, right. Thanks for pointing that out.  I'm still curious if the
CFLAGS_<file>.o rules get appended or overwrite all flags for that
translation unit?
-- 
Thanks,
~Nick Desaulniers
