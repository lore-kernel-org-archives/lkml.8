Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088CAC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CF12073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274418;
	bh=6AjmMzYF+eMzl37oU31FPOWorBxWs3h+zD/ZIZFUkfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mPd85i3sWMuSz8BEWdfgf0Q5RFWg92jig9aq+TGkxXxzWP/Gn6SlIWpUHX+43p+2H
	 QxBmczpWNVbR9e7UlyOZ/1yPaCCBHp7qK6Zx/Jqer7ChU/K8Zaqoee6ICgFE4tNJr3
	 hGEtrpecRUsDyxVTqKLJx34OAWFvmEXjs5EcV0EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgBUIkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:40:16 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36458 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbgBUIkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:40:13 -0500
Received: by mail-oi1-f193.google.com with SMTP id c16so868057oic.3;
        Fri, 21 Feb 2020 00:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AjmMzYF+eMzl37oU31FPOWorBxWs3h+zD/ZIZFUkfk=;
        b=gZKMFffhCh29pEwrjxGdJvgPCkUuEsa11B6IKf5pgjjyQw12bFDvGNgpaqnytLsIYC
         wvleJR5Q+FPfRwpfJZBEnp+D056wX4uSsFgdkoCh/YipGJD2ant/wSRJipjxvToQnlL4
         XsFZuN5dvji3NJxkJqHMxE2utWKS4lIv56a89C9vkq6ouCfbhJ3EhKODIYOYsnRLrKvI
         n9vBxsTMNG0i0ZrBVv5ll5rb9iINBj944Qvnkdp3KDXkGG4MTGgU+nkU9Z/PTc7bQXVh
         ST1LVePBAMeBw8fLWEOA2t4m8uJ9x2/TGIc1VzvIi/8ROOy6LnXLs/PuuwE0D4h27zc6
         xaGA==
X-Gm-Message-State: APjAAAXcjcvsR3+t9JtwHNM4kDSF4VhzwrAddiLWLED1C2o5YukfZ/Xr
        /xhldh23etApYFOgvv07xOP8amOgWdTDexPYuhVSlwVd
X-Google-Smtp-Source: APXvYqzaB4IKV5VMJPddEDdGQGYxjkGa+IVWycfGG5LFdpQ0JB4FvlnEng0YFPqqFdX70HuRWhR3His9GM2Jd+O7J38=
X-Received: by 2002:a05:6808:8e1:: with SMTP id d1mr1058922oic.68.1582274412532;
 Fri, 21 Feb 2020 00:40:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0he=WQ6159fyaYYffdi66y596rVo7z1yLyGFcH45PXNUg@mail.gmail.com>
 <202002201158.2911CE2388@keescook> <CAJZ5v0hkKUi7FUOneEy2nO-=RM8ZbcoG1uHRYNWzrjONEhKYxQ@mail.gmail.com>
 <202002201448.62894C394@keescook>
In-Reply-To: <202002201448.62894C394@keescook>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Feb 2020 09:40:01 +0100
Message-ID: <CAJZ5v0gu_2wkncukKK7u340KLzSCVL_7F9cJTz3wVhxfogR8NQ@mail.gmail.com>
Subject: Re: [Regression] Docs build broken by commit 51e46c7a4007
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Feb 20, 2020 at 10:44:35PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 20, 2020 at 9:05 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Feb 20, 2020 at 07:50:47PM +0100, Rafael J. Wysocki wrote:
> > > > On two of my systems the docs build has been broken by commit
> > > > 51e46c7a4007 ("docs, parallelism: Rearrange how jobserver reservations
> > > > are made").
> > > >
> > > > The symptom is that the build system complains about the "output"
> > > > directory not being there and returns with an error.
> > > >
> > > > Reverting the problematic commit makes the problem go away.
> > >
> > > How strange! This must be some race in the parallel build.
> >
> > I don't think so, I didn't use -j with htmldocs builds.
>
> What version of Sphinx do you have?

1.6.5 (I realize that it is older than recommended, but it had been
working fine before 5.5-rc1 :-)).

> > And you know what, adding "-j 2" to the command line actually makes it work. :-)
>
> Without a -j argument, the Documentation build has been using -jauto on
> Sphinx itself.

Well, maybe this particular version of Sphinx has problems with that.

> > > AFAICT, "output" is made in the first sub-target (Documentation/media). This
> > > doesn't look entirely stable (there's no ordering implied by the "all"
> > > target in there)...
> > >
> > > Does this work for you?
> >
> > No, it doesn't.
>
> Well now I'm really baffled. What make target are you specifying? I was
> assuming you were doing "make htmldocs"?

I've tried that too, but most often I do something like "make
O=../build/somewhere/ htmldocs".

But I can do "make O=../build/somewhere/ -j 2 htmldocs" too just fine. :-)

Cheers!
