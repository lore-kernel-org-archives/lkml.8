Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217F7C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0003120732
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOmUYzHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgHVCFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 22:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHVCFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 22:05:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDDC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 19:05:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t6so1587763pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 19:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3lxg92/5I8JxtarJ0uEVhZtvtwWfxzDminhJw0ojf4=;
        b=MOmUYzHI24ouwk2s8+jh1IP/9b6q2yx/68TjdM3SybROedsaLrx9kyX5ghrf+xc4n3
         UIsPio5Sh+HL5Lr33P0ekWQo64vZAbQmvmjm6nd8xmGBJtt/fOs87+Gc94VOEkw+bw40
         R137YFVqY71jDQeSpBdcKRR+vvUoEx57WBts5j3iIYArqE7C+asjsi5VhFAiAQnwKKE0
         t231adRUJ3lP780snPyM3sYnHxNtSlbANoiCpawoUHxO53gdxzknE9qqQxK9FWwxxgPs
         nva6LEYRbx5fre4Zpm6sClMVu+xnsUlxrLNTj9eWP4IaU+XRe5LpBBhO+BaQmU770r9D
         mSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3lxg92/5I8JxtarJ0uEVhZtvtwWfxzDminhJw0ojf4=;
        b=CDVCal05caLQ+ZzzQY6TtfUqWgmEGpxntAZ4I/4qHUg7Z9DJTeuepT0yG//zhFxeMz
         m9Ax1NsFcPEyDXk7WIG3wGgn4/VdtCYdXYoBOrmrflKGrKc5yaMJi2eVoVJhDM6Za43n
         JQqPJomy3gTOi8ZJ2oK5Q1A/yui1pv1uacuk2oFxjZsgK/M2wmHKhr/kb3veh7l+UtWL
         KOcWOeIb8CtW2jYfZwH52bZg616DlN3H5l2opbOgqIJBrrA1c8c7qR4WMt63nAPAj5ym
         ZRS9UNBkxiBbcnJrqZxHwwrbsi1MibR8qscuGY1vGsFk+Nu/pbyhRQYAILtSy3xnbIpw
         gHJA==
X-Gm-Message-State: AOAM530xluAkpNYZdR5Zr1AFm6Zjufam4T5RjkTPMm7g87IUoUtFGWIT
        zrHWEoI11F+y0raDw59JEx8Z6MLD+GZpAtwTAcwLig==
X-Google-Smtp-Source: ABdhPJzH5RMNwabRgxGebvfZz6g+gcpWatZOoRUnPziM3BPJOlfhXoG+99x0Tr7bRBm0wzUKiQYB6Vd1l3P8jzkwO8M=
X-Received: by 2002:a17:902:a60e:: with SMTP id u14mr3418680plq.179.1598061922175;
 Fri, 21 Aug 2020 19:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200821190159.1033740-1-masahiroy@kernel.org>
 <20200821190159.1033740-5-masahiroy@kernel.org> <CAKwvOdnCZ7ao55Zdh3qkJQzudOwhkPFPOY802Emx3o7GMDdCwA@mail.gmail.com>
 <CAK7LNAR+ZdwCg7Dcg3BR5YysxzeraEHMAVsHuez5znwjoN+1pQ@mail.gmail.com>
In-Reply-To: <CAK7LNAR+ZdwCg7Dcg3BR5YysxzeraEHMAVsHuez5znwjoN+1pQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Aug 2020 19:05:10 -0700
Message-ID: <CAKwvOdmUBr0dMw-C1VPMF8adAwedNb8n=PyV78AFo9KkvJiS=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] gen_compile_commands: reword the help message of
 -d option
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 6:56 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Aug 22, 2020 at 9:29 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Fri, Aug 21, 2020 at 12:02 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > I think the help message of the -d option is somewhat misleading.
> > >
> > >   Path to the kernel source directory to search (defaults to the working directory)
> > >
> > > The part "kernel source directory" is the source of the confusion.
> > > Some people misunderstand as if this script did not support separate
> > > output directories.
> > >
> > > Actually, this script also works for out-of-tree builds. You can
> > > use the -d option to point to the object output directory, not to
> > > the source directory. It should match to the O= option used in the
> > > previous kernel build, and then appears in the "directory" field of
> > > compile_commands.json.
> > >
> > > Reword the help message.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > > Changes in v2:
> > >   - New patch
> > >
> > >  scripts/gen_compile_commands.py | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> > > index 1b9899892d99..5f6318da01a2 100755
> > > --- a/scripts/gen_compile_commands.py
> > > +++ b/scripts/gen_compile_commands.py
> > > @@ -31,13 +31,13 @@ def parse_arguments():
> > >
> > >      Returns:
> > >          log_level: A logging level to filter log output.
> > > -        directory: The directory to search for .cmd files.
> > > +        directory: The work directory where the objects were built
> >
> > Punctuation (add a period `.`).
>
> Will fix.
>
>
> > >          output: Where to write the compile-commands JSON file.
> > >      """
> > >      usage = 'Creates a compile_commands.json database from kernel .cmd files'
> > >      parser = argparse.ArgumentParser(description=usage)
> > >
> > > -    directory_help = ('Path to the kernel source directory to search '
> > > +    directory_help = ('specify the output directory used for the kernel build '
> >
> > Capitalization (specify -> Specify)
>
>
>
>
> The help message of -h starts with a lower case.
> The others start with a capital letter.
>
> It would be better if "show this help message and exit"
> started with a capital letter. But, it comes from the
> library, so I do not know how to change it.
>
> I changed our code to make it consistent, but
> starting them with a capital letter is a preferred style,
> I can do as you suggest.

Consistency throughout the patch is my priority, not necessarily
whether we're using Capitalization or not.

>
>
> Currently, the help looks like follows:
>
> ---------------->8-----------------------
> masahiro@oscar:~/ref/linux$ ./scripts/gen_compile_commands.py  -h
> usage: gen_compile_commands.py [-h] [-d DIRECTORY] [-o OUTPUT]
>                                [--log_level LOG_LEVEL]
>
> Creates a compile_commands.json database from kernel .cmd files
>
> optional arguments:
>   -h, --help            show this help message and exit
>   -d DIRECTORY, --directory DIRECTORY
>                         Path to the kernel source directory to search
>                         (defaults to the working directory)
>   -o OUTPUT, --output OUTPUT
>                         The location to write compile_commands.json
>                         (defaults to compile_commands.json in the search
>                         directory)
>   --log_level LOG_LEVEL
>                         The level of log messages to produce (one of
>                         DEBUG, INFO, WARNING, ERROR, CRITICAL; defaults to
>                         WARNING)
> ---------------->8-----------------------
>
>
>
> Thanks.
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Thanks,
~Nick Desaulniers
