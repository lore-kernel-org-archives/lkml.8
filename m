Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5062C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7822078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594399960;
	bh=/cUKDLPl2jvjdReg3ifbQY1VJUI2VkF7Wamm7bRWSbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RmbKmqJkMxnIt3RbK+hz6NRZmUZO92ZxAKplOO7Zlj13NzDGtfPvJHuqwdUpT6Ly5
	 4AvuaqrfezJhqEeeC8WrXHkqUCz32RLpoRNC8H9VqUsMs+Wugp9pZZHTT6/ApPuAol
	 IqrDI6EzSXFAlYYLSD6x/bCD/srml9DjtdCJ9BPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgGJQwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbgGJQwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:52:33 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DFC620857
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399952;
        bh=/cUKDLPl2jvjdReg3ifbQY1VJUI2VkF7Wamm7bRWSbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C7QnMDweAh3zXfozgOU23mQU1lsF4mwDug4sJ3VIycdsn2HkU1nJEOxfPy/Q96k5M
         XJbehqF3mSKAekECjJPHKVY/lOhSWjOWqX4rmYVrUNbJNoWNog3vzmTXKfbbVJExl0
         ow7s2am7NzB8FF7EL2f6eL76g96VA/VR8ENPLC+Q=
Received: by mail-wm1-f54.google.com with SMTP id o8so6836935wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:52:32 -0700 (PDT)
X-Gm-Message-State: AOAM5327VHTTDYJHiq/Fcfk4/aehUVHv+57zTMzMZxXwO0mjgufGaJxh
        QcCloHhLk6QMoM/eBiVJu0njIw3gxphc6XV0JvwCtQ==
X-Google-Smtp-Source: ABdhPJwJ5vNk5o5bj03nmpE/WvKrwZ2QjZ/A6anCEV1vb9R8ED2N6Rh7yxfqDFe7tH8YXxOI9rWHfQEt0/FrxN1A5eg=
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr6024612wmb.21.1594399950758;
 Fri, 10 Jul 2020 09:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <202007041703.51F4059CA@keescook> <CAPcyv4jy6cKLNBhi9HCUP=f6GC4bM_iw_-U8o0uMrO8OX1SWTw@mail.gmail.com>
In-Reply-To: <CAPcyv4jy6cKLNBhi9HCUP=f6GC4bM_iw_-U8o0uMrO8OX1SWTw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 10 Jul 2020 09:52:18 -0700
X-Gmail-Original-Message-ID: <CALCETrUvfB6rLWMx=KOsFxbCowz3H2atSCbq-ecHQ5mNFe=e3g@mail.gmail.com>
Message-ID: <CALCETrUvfB6rLWMx=KOsFxbCowz3H2atSCbq-ecHQ5mNFe=e3g@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 9:30 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sat, Jul 4, 2020 at 5:41 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:
> > > Recent events have prompted a Linux position statement on inclusive
> > > terminology. Given that Linux maintains a coding-style and its own
> > > idiomatic set of terminology here is a proposal to answer the call to
> > > replace non-inclusive terminology.
> > >
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Chris Mason <clm@fb.clm>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > (nit: isn't this a Co-developed-by chain, not a SoB chain?)
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > Comments below...
> >
> > > ---
> > >  Documentation/process/coding-style.rst          |   12 ++++
> > >  Documentation/process/inclusive-terminology.rst |   64 +++++++++++++++++++++++
> > >  Documentation/process/index.rst                 |    1
> > >  3 files changed, 77 insertions(+)
> > >  create mode 100644 Documentation/process/inclusive-terminology.rst
> > >
> > > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > > index 2657a55c6f12..4b15ab671089 100644
> > > --- a/Documentation/process/coding-style.rst
> > > +++ b/Documentation/process/coding-style.rst
> > > @@ -319,6 +319,18 @@ If you are afraid to mix up your local variable names, you have another
> > >  problem, which is called the function-growth-hormone-imbalance syndrome.
> > >  See chapter 6 (Functions).
> > >
> > > +For symbol names, avoid introducing new usage of the words 'slave' and
> > > +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
> > > +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
> > > +'performer'.  Recommended replacements for blacklist are: 'blocklist' or
> > > +'denylist'.
> >
> > Keeping "master" in a "master/slave" pairing (i.e. replacing only
> > "slave") seems incomplete to me. If "master" is paired with "slave", it
> > should be replaced too. Potential examples: 'primary', 'leader', 'principle',
> > 'controller', 'sender', 'initial'.
>
> Yes, this matches Andy's feedback, will add.
>
> > Similarly, for "whitelist/blacklist", "whitelist" needs to replaced when
> > "blacklist" has been. For example, seccomp documentation[1] uses
> > "allow-list" and "deny-list".
> >
> > [1] https://man7.org/linux/man-pages/man2/seccomp.2.html
>
> Oh, good to know will make that change.

Looks like that change already happened.  And the new language is IMO
not vastly better than the old language.  I'll send a patch.
