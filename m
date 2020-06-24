Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E12C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E401320738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJvh37nN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbgFXXkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbgFXXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:40:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6794C061795
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:40:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so1411421pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OXwCzf5B5Vnc4rPGARP7edsvVNysUhYzQGqjGFLfJUg=;
        b=eJvh37nNRJoXUBuIREWky64c/2Zy+QfsGiyybHo4/AY79kM2WK5DCWQ2SFWNIlhRqR
         uvyBfk+MP4VctCsNpVpZcmoQSq5Bq2w+lQM6xBkh25apGFZZlExegOU/Xa4ZzLv1+QGo
         2SZwCYjmMFcvWre4jkB8JFSvGQLtaMZLbShuOQoeq/pW5jRL7ENSqIcZKBium29PAxHa
         SUKoF/TCC6EPkmXpV56a4eqzpU85/8BnY0vmWySOQ6P4JhiJF+3GTW6JN67+OxEwI6FO
         083DgLg4vlRvZAYijlbkUJhYrikRhcAUh0cGmqJe8b/JYcwRofo02mXuHf66C14NJXzV
         SJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OXwCzf5B5Vnc4rPGARP7edsvVNysUhYzQGqjGFLfJUg=;
        b=RvOx7cbBPE3lDjR3p99eQ51PXPXm9gWUEtXNrjFs9dvssSrWOkQ910i6HbhdNcQSSg
         o54DuQ50ajbbRfSA69tkCCvHq3pxtVxPBMDJFAlwUTFxZEzZim9O2e9d9BAMl9efAedA
         VGK3nOo+REOp/c8ls+QrGy14IsKqkMKnwX3lSQCUywCj3pBFfKztwoikva+1nD/6Vtum
         vSEOyaueW5iChpjUfs8/3WmnQonNJci64lzPgSMbxGHBTAEIuHuJf7ok8qxGpm5XungK
         V6WJk+aPnb5Tc4ymBG7pJ3RJA6FW2qfn3vNyB+kvLdX8hNPm46emaBRMCsMTz2nEfW4L
         Akbg==
X-Gm-Message-State: AOAM531FFICZySLYmzR5o1h5oQdStZH318wBALXYm6o7XCw2FC/5hmIz
        rq+mw95K1gTTsaqkM6TbOOI6WA==
X-Google-Smtp-Source: ABdhPJzXlVXz0ute8/7RtpY4QOpyoQzqmeZeuFCeuHxJTgdZ5uUxN+EFgHwfWmPsVtpJN+LSHdwUaA==
X-Received: by 2002:aa7:9289:: with SMTP id j9mr33592532pfa.124.1593042004835;
        Wed, 24 Jun 2020 16:40:04 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id mu17sm6845223pjb.53.2020.06.24.16.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 16:40:04 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:39:59 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
Message-ID: <20200624233959.GB94769@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-18-samitolvanen@google.com>
 <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
 <20200624215231.GC120457@google.com>
 <CAKwvOdnWfhU7n0VfoydC7epJPrj+ASZzyNRpBCNuvT_5E+=FcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnWfhU7n0VfoydC7epJPrj+ASZzyNRpBCNuvT_5E+=FcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 04:05:48PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 24, 2020 at 2:52 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 01:58:57PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > > >
> > > > Filter out CC_FLAGS_LTO for the vDSO.
> > >
> > > Just curious about this patch (and the following one for x86's vdso),
> > > do you happen to recall specifically what the issues with the vdso's
> > > are?
> >
> > I recall the compiler optimizing away functions at some point, but as
> > LTO is not really needed in the vDSO, it's just easiest to disable it
> > there.
> 
> Sounds fishy; with extern linkage then I would think it's not safe to
> eliminate functions.  Probably unnecessary for the initial
> implementation, and something we can follow up on, but always good to
> have an answer to the inevitable question "why?" in the commit
> message.

Sure. I can test this again with the current toolchain to see if there
are still problems.

Sami
