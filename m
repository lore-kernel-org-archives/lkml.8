Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C9CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6822A20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+GilTzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbgDMTVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727849AbgDMTVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:21:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131A9C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:21:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r20so3285686pfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3v3lMYX71OYS7ExZ5JtALb3DwWrKTziHCm5gwOcJBM=;
        b=U+GilTzgZn485m/gVVQKl0E/vydgYV4Oo0+zwr4XwvKuxpKqL+QwXG2ln/L4Mn74YF
         h/HlvMXQhjsvO7mPI0nEp602ii5l2JuMg7rMSQDxXIlJT7OQ0frEfnM7qr23+3INNBlu
         vpXRHGk4Mzlw9bNmhJa85wmgows5iO/doPGu6Zh2Le+wKvxVZTwvM6ZnqPpphhE1mGQl
         2kn7v5XayBdAr+5YOJJdYgKr1hX+PpNd/opcHTYr1mhYApKBa/Qvn6nPTUIESjHR53+q
         z5t+/rP/XvHjSVbYR7CBlvnzv/vk9ywknCKwWQfoyRSAYHql/TrK1VMXYj+N/D7tWsqj
         3TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3v3lMYX71OYS7ExZ5JtALb3DwWrKTziHCm5gwOcJBM=;
        b=uT6b0oHKtygYDmYOtQOzpDgRgBUhQBPriO7qj6NvG/QodvSjDIxcfRUfzB4p6aw+zp
         I5d6HJv5pnHtXE/yaKjmN4ntO6HXTMrwO8aML3vp3xx9SD2cqfcmPvnEKsuppp0PIp98
         tcjOFnhttU27BxeQwCtM2KHkEgP4CtFdX/bwMpLGJauAda0G9SBp0G/MSlomDwc0Nt/j
         35L7w35yCptcBpE7RmQBvCI0nEGtqTIJinX03tw+FK5urlUE6VZbDZefMdVkvj1VkWBw
         OAnxdQ4qeYb5GzXE9wsxEx5qAqthvmrLypBq8VOWU05XRlIO9ObVDP4+6ISofPUFT+sm
         Fuzg==
X-Gm-Message-State: AGi0PuZGjqytGoeP9LIPEOh43IsTwSJkE8LWHUnNqVFFgRUF9q/eJ5aX
        pqFK+Ujf3qGBiakORmth37AxrJgh7qTXt1tpIG3j8g==
X-Google-Smtp-Source: APiQypLc2bGWndwrv130fbQvw2IFcVCXMnlN7wZcX+BhWB/S4mwUuLNY4H7yB7zdGhQFDGWjmd3oMw6khE9rZUz1Pws=
X-Received: by 2002:aa7:919a:: with SMTP id x26mr19063745pfa.39.1586805669240;
 Mon, 13 Apr 2020 12:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 12:20:57 -0700
Message-ID: <CAKwvOdnpW0VSRdD6958xyWh-tDbuVTti265aqOpvfhvh6iQEXQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jian Cai <caij2003@gmail.com>, Manoj Gupta <manojgupta@google.com>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Jian Cai <jiancai@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 2:56 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Apr 10, 2020 at 1:28 AM Jian Cai <caij2003@gmail.com> wrote:
> >
> > iwmmxt.S contains XScale instructions LLVM ARM backend does not support.
> > Skip this file if LLVM integrated assemmbler or LLD is used to build ARM
> > kernel.
> >
> > Signed-off-by: Jian Cai <caij2003@gmail.com>
>
> It clearly makes sense to limit the Kconfig option to compilers that
> can actually build it.
> A few questions though:
>
> - Given that Armada XP with its PJ4B was still marketed until fairly
> recently[1],
>   wouldn't it make sense to still add support for it? Is it a lot of work?

Sorry, can you help me verify from that link that PJ4B uses XSCALE?  I
didn't see references to either in the link provided.  Also, given the
history of XSCALE as noted by Russell, I'm surprised to see Marvell in
the mix.

>
> - Why does the linker have to understand it, rather than just the assembler?

It doesn't, just the assembler is the problem.

>
> [1] http://web.archive.org/web/20191015165247/https://www.marvell.com/embedded-processors/armada/index.jsp



-- 
Thanks,
~Nick Desaulniers
