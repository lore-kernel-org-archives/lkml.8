Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA05C35240
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 06:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB34206E6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 06:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580623756;
	bh=6BjKQ50LeXMQ1Km3JEUy+9+8c4oHjfSyl8ZzF8b7oKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nRaKZYmx+QbRMTrfkVmDd0ogzyIjM3t9GUugbgE9LQUMisewULOWLLMiL0uETzwNA
	 F8sDheAA8YXK1T5YjdU3uwcN9d2D0kkXg41qnCWRA3/orx1Y963mV/4revUR+ii0wn
	 Cmpvwp9pcPQlDDwWmrZ7KHL540SOeCazVY1S3/GA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgBBGIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 01:08:02 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:37824 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgBBGIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 01:08:02 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 01267vSo020752
        for <linux-kernel@vger.kernel.org>; Sun, 2 Feb 2020 15:07:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 01267vSo020752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580623678;
        bh=J3WU4e+zn67eERAVkmqy0bxRWEiSF9lbC2mFseAfKrA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mcvQxZLSO/2cVw1iKSo2MZ5t0bGBPAFSVrepEq+wRCtfs6O5UW9UuQAqochSaFInd
         JJpqFqlJj8dLOiAk8bPswF07sK/67M1fEsJlF3coaD6GqOcUXLCEK+xOqPnJvkXYSM
         jJhVXuLxeODOKBOWb+6/Tgnny8vBxyl7ogE2oA5ZylL5LhTwcdtBmNuUxga0QJLKma
         zA0419nYeX4PPI+mu7TBtS/Djx0wHc3XsxDqIrXsaIxZFVCD4DJYsXOWUJQUzYxDZ/
         cmqXUAPOjdUknesn2SYryYHeXS7KsD4lFx2TIm1Y4kS+/aDxXD5Dis4XaUZ0XdNicH
         TPr1o7EyhfhIg==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id p6so6941578vsj.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 22:07:58 -0800 (PST)
X-Gm-Message-State: APjAAAVCZp2U0RA0JAUjIcOriLPEPOqLJpy/3P0MAxUzAqCjedZktZIR
        FAHQqjvh0weR8i1se2k+54MRC57694eb75Jnsag=
X-Google-Smtp-Source: APXvYqxf0wxZTYPmk3EX9SthhY/Umnv48FrTys6+4NqcBy3NVavWV81H+xHza1pDXBzgBL2VsTzUoyCB0ObMa8T50Ic=
X-Received: by 2002:a05:6102:1174:: with SMTP id k20mr8960579vsg.155.1580623676956;
 Sat, 01 Feb 2020 22:07:56 -0800 (PST)
MIME-Version: 1.0
References: <1580161806-8037-1-git-send-email-gvrose8192@gmail.com>
 <CAK7LNAQyh9CFgKd1DtAPFW8DuHNp1gn8YABuP8-LsF=hHK2DFw@mail.gmail.com>
 <f6ffa0d0-8214-8fc0-4fe9-4b70a1581d3e@gmail.com> <677aff5a-a52e-08ae-f341-547af08f7566@gmail.com>
In-Reply-To: <677aff5a-a52e-08ae-f341-547af08f7566@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 2 Feb 2020 15:07:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARsBQm8jTs6PZDHAVFX4GZ_=Ls-5MOutNJFOHBN29Gd5w@mail.gmail.com>
Message-ID: <CAK7LNARsBQm8jTs6PZDHAVFX4GZ_=Ls-5MOutNJFOHBN29Gd5w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Include external modules compile flags
To:     Gregory Rose <gvrose8192@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dev@openvswitch.org, dsahern@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 3:09 AM Gregory Rose <gvrose8192@gmail.com> wrote:
>
>
> On 1/28/2020 7:37 AM, Gregory Rose wrote:
> > On 1/27/2020 7:35 PM, Masahiro Yamada wrote:
> >> On Tue, Jan 28, 2020 at 6:50 AM Greg Rose <gvrose8192@gmail.com> wrote:
> >>> Since this commit:
> >>> 'commit 9b9a3f20cbe0 ("kbuild: split final module linking out into
> >>> Makefile.modfinal")'
> >>> at least one out-of-tree external kernel module build fails
> >>> during the modfinal make phase because Makefile.modfinal does
> >>> not include the ccflags-y variable from the exernal module's Kbuild.
> >> ccflags-y is passed only for compiling C files in that directory.
> >>
> >> It is not used for compiling *.mod.c
> >> This is true for both in-kernel and external modules.
> >>
> >> So, ccflags-y is not a good choice
> >> for passing such flags that should be globally effective.
> >>
> >>
> >> Maybe, KCFLAGS should work.
> >>
> >>
> >> module:
> >>         $(MAKE) KCFLAGS=...  M=$(PWD) -C /lib/modules/$(uname
> >> -r)/build modules
> >>
>
> Hi Masahiro,
>
> I'm unable to get that to work.  KCFLAGS does not seem to be used in
> Makefile.modfinal.


I quickly tested it, and confirmed
KCFLAGS works for external modules, too.


Makefile.modfinal includes scripts/Makefile.lib


So,  c_flags contains $(KCFLAGS)

 c_flags -> KBUILD_CFLAGS -> KCFLAGS






> [snip]
> >>> --- a/scripts/Makefile.modfinal
> >>> +++ b/scripts/Makefile.modfinal
> >>> @@ -21,6 +21,10 @@ __modfinal: $(modules)
> >>>   modname = $(notdir $(@:.mod.o=))
> >>>   part-of-module = y
> >>>
> >>> +# Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
> >>> +include $(if $(wildcard $(KBUILD_EXTMOD)/Kbuild), \
> >>> +             $(KBUILD_EXTMOD)/Kbuild)
> >>> +
>
> I continue to wonder why this it is so bad to include the external
> module's Kbuild.


Because it is not correct behavior.


> It used to be included in Makefile.modpost and did no harm, and in fact
> was what
> made our external build work at all in the past.  Without the ability to
> define our
> local kernel module build environment during the modfinal make I see no
> way forward.


As I said, ccflags-y is not intended to be
passed to *.mod.c
Upstream modules never rely on it.

External module should not rely on it either.


>
> That said, I'm no expert on the Linux kernel Makefile
> interdependencies.  If you
> have some other idea we could try I'm game.

-- 
Best Regards
Masahiro Yamada
