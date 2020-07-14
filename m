Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90318C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D98A2256C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rw2Ooa/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgGNRyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgGNRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:54:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70106C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:54:14 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m16so6132387pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45xI8rEeWi7QXFwrqKcRbpSWjjoJSS/Qt/Ikgj5NGNk=;
        b=Rw2Ooa/4ydY2kuipZY7t3EHXuDLvDsaolNVYTbOw/NHk5Jj0yTma+nZMIhm0RimdW1
         4JfbmJtFIImxCLNF7Likd5JJ75qLUq1nUBH2EITFJdGdoeazyFh1iNO8AUdKQSjKGvkb
         vWPL6G0Ys/dM88zsh00Mm3C64zTOwNylvBlKCSCyQZmVrKUl2gs/OaYNb00wcMR4DAe7
         HqLTQu9936MuMSL6GVU2YNVrqJKkGAGTgtOqKFRzuK+QyPeCSCgh+hD/dBEIkV1NTSF1
         di8HEi1g5AXgcdN3uU8s7dqxHfQFyrPIIaOX6UfyK+tDEjX6rN6ML4r7djGwSQ0peH3h
         HIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45xI8rEeWi7QXFwrqKcRbpSWjjoJSS/Qt/Ikgj5NGNk=;
        b=OsgRxMrTHRzI/LCpfxv34E3R4jFWXoqYyVjUZIR2pEORyOVCJIrgOYISHhglP66/GO
         ZCgxGW9Xhcombn83xviV9R/E+u0EDkQ5uJM972kV12fEU9PDZAD0u4Hz2JRw15rIOE0/
         kbP/H80np2zOiPQOfU9zMH0FurErq2kZrVtOoBXqC0/9dyRvdDT2FMHgKBGzQs6hcFEM
         h3DczQq96gw+779+Zm9eWhjnFMWM26wMtG5HxjCGQ6GQK/nvgVj5WEgl/MKV7L2VhkW6
         dYh6tqkrF6cCG7cpy/ocJwN9X9tbZPGJOibEq6q52U0x9bfSKpbnBkGMoFWLM1zozKye
         0KJw==
X-Gm-Message-State: AOAM531XBjYtRRkQa4vN6CGj9vec/nRzQVrPpSySBgINZE14M7vUHVjS
        MaDXL9EYvHVIhTDAhyrgmen8u6uYGFqS1zgpWrw4jg==
X-Google-Smtp-Source: ABdhPJwcIBhuWQSJnb22Hu6ykmJZrRn50yho0jiA1jzvQkDPRjZ5DnsFPHJW6iYaLbzuW2WylixGSW07GgQyW7nvEuA=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr6056117pjc.101.1594749253773;
 Tue, 14 Jul 2020 10:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de> <CA+icZUXPB_C1bjA13zi3OLFCpiZh+GsgHT0y6kumzVRavs4LkQ@mail.gmail.com>
 <20200712184041.GA1838@Ryzen-9-3900X.localdomain> <CA+icZUWyqb8jdzTAophvBKuX3e2NvG7vQPnMW+SRW5v0PmU7TA@mail.gmail.com>
In-Reply-To: <CA+icZUWyqb8jdzTAophvBKuX3e2NvG7vQPnMW+SRW5v0PmU7TA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Jul 2020 10:54:02 -0700
Message-ID: <CAKwvOdnFxihNnGYTsowzEbtMvb-pwv9pHNo-tihD2h74LX+H+g@mail.gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 2:44 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Jul 12, 2020 at 8:40 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Lastly, for the future, I would recommend grabbing b4 to easily apply
> > patches (specifically full series) from lore.kernel.org.
> >
> > https://git.kernel.org/pub/scm/utils/b4/b4.git/
> > https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/README.rst
> >
> > You could grab this series and apply it easily by either downloading the
> > mbox file and following the instructions it gives for applying the mbox
> > file:
> >
> > $ b4 am 20200624203200.78870-1-samitolvanen@google.com
> >
> > or I prefer piping so that I don't have to clean up later:
> >
> > $ b4 am -o - 20200624203200.78870-1-samitolvanen@google.com | git am
> >
>
> It is always a pleasure to read your replies and enrich my know-how
> beyond Linux-kernel hacking :-).
>
> Thanks for the tip with "b4" tool.
> Might add this to our ClangBuiltLinux wiki "Command line tips and tricks"?
>
> - Sedat -
>
> [1] https://github.com/ClangBuiltLinux/linux/wiki/Command-line-tips-and-tricks

Good idea, done.

-- 
Thanks,
~Nick Desaulniers
