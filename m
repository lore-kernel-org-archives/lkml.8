Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0DBC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3878521924
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKVoTgD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414892AbgDOPoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1414848AbgDOPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:44:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A01C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:44:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id a23so149549plm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W+ikqrmBIBEKvVkXBn0UllA+OtUbb2X28KHF+kd9Sus=;
        b=AKVoTgD+v3LRySKFXD0u43wjuBan3xtaU0vntmRP548nKCKRJn0SCAgfW2hl+sug79
         xeeqyfuxOZgKSwZexJXDW24RXk+8RRO3rl1fPT5DUYrHkg6LRxn2QntT1+3CxgcBplIQ
         PlGTKYDsfv4jrzvd5bekUSg8KqL742ven3KBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W+ikqrmBIBEKvVkXBn0UllA+OtUbb2X28KHF+kd9Sus=;
        b=ouiW6oWJX0rIfzHgNMjt54tDdKEvrDzbB85Y7mSkC0HwoLnaFj8QzNlybundbBtiX0
         VbRBTJ/L61bzE6EJSfw4vmH2PiXbw1QNYT7hdFNvwPPDcMceIOH0XFWvgKK+wLetyuQA
         krqg1PtUXUGMAG23H3qwOmodGpQnjY6JVjgwBiqZEyAYidhGBkoZUxrX6wjwAhE7At7Z
         mRkk5sDJ33jvZ6pfVKOUsNIeqgWy5WxwW36xHt9O1CCj5bjUmLlESxGacxvuvDqJUWvF
         q8/zZAGmnvkD0Gu/M9hTWwTITC358vLKAOtxYqGcUr7mUNzOcnGEbSglo0QT9tOYMXg5
         012A==
X-Gm-Message-State: AGi0PuYbcEVHAOwXNbBZnmPJ/PzD7rqJBM8IVCELiQByRH+Kjf68w160
        Cf/h8F4Bl7xYM4bMN4ed+JHj/A==
X-Google-Smtp-Source: APiQypIpRyHaEbePO5FqjfTHo4ISu3LJ/Zlc8dY0TXjNWuA2eQxr4cd+H9NX2VZ+/N1gu6NTS64z9g==
X-Received: by 2002:a17:902:9b8f:: with SMTP id y15mr5654954plp.169.1586965468363;
        Wed, 15 Apr 2020 08:44:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f30sm15052172pje.29.2020.04.15.08.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:44:27 -0700 (PDT)
Date:   Wed, 15 Apr 2020 08:44:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Stephen Hines <srhines@google.com>,
        Luis Lozano <llozano@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jian Cai <caij2003@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jian Cai <jiancai@google.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Message-ID: <202004150833.E2E9A89E0@keescook>
References: <20200409232728.231527-1-caij2003@gmail.com>
 <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk>
 <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
 <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com>
 <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
 <CAKwvOdm5aawsa2-=atB8z6W8zo8YVgdDEVbU3i4evDcpo1_AxQ@mail.gmail.com>
 <202004141258.6D9CB92507@keescook>
 <CAMj1kXG6_CO6pzeJCSeWiCDyLfWw+ZMuvkv_DLxe-si00fLd1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG6_CO6pzeJCSeWiCDyLfWw+ZMuvkv_DLxe-si00fLd1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:32:17PM +0200, Ard Biesheuvel wrote:
> To reiterate my point: I strongly prefer minor asm surgery over
> elaborate Kconfig plumbing if it means we can retain the functionality
> even when using LLVM tools. In particular, the use of macros to
> implement missing ISA support should be considered before any other
> solution, as these are already being used widely across architectures
> to fill in such gaps.

Yeah, this seems like the right place to start from. It sounded like
there were cases where the people with knowledge needed to accomplish
the macro creation were not always immediately available. But, yes,
let's get iwmmxt fixed up.

> This code has been around since 2004. It has never been possible to
> assemble it with Clang's assembler. So the only thing this patch gives
> you is the ability to switch from a .config where IWMMXT was disabled
> by hand to one where it gets disabled automatically by Kconfig.

Right -- I meant "let's fix iwmmxt with macro magic" not "let's disable
it". I did want to point out the Kconfig disabling may be needed in
other cases.

> So what hard-won ground are we losing here? Did IWMMXT recently get
> enabled in a defconfig that you care about?

It's a CI's ability to do randconfig builds to catch new stuff. (i.e.
where "disabled by hand" isn't part of the process.) Since there are
multiple CIs doing multi-architecture builds we need to get these things
fixed upstream, not a CI's local patch stacks or Kconfig whitelists,
etc. And when the expertise isn't available to fix arch-specific stuff,
Kconfig negative depends seems like a reasonable middle ground. I, too,
prefer fixes that allow Clang to do its work without wrecking things
for GNU as.

> I am not disagreeing with you here, and I have worked with Nick,
> Nathan and Stefan on numerous occasions to get Clang related build
> issues solved.

Yup! Totally; this thread just looked very familiar to me from doing
treewide stuff and I didn't want what I thought looked like the core
points to get lost in the details. :)

-- 
Kees Cook
