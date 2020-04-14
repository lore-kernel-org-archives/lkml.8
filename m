Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D05C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20D92074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CSqlXQVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633428AbgDNUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730661AbgDNUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:53:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68A0C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:53:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so5827255pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K0jdNDYsyVBKVJ8vrSclC2i6UhecRADdZccibZZW3Fk=;
        b=CSqlXQVETewXhgi7NEbLvyqtymrdv4KHSnaV7YJrij7Z94Wt9M/LRF+hI64VHazJtJ
         1OEaNJd60jfAh5LIyE1CGhu25SP010BksVkq1wrNNHfLFFEZ61/P7rUnVcuhRDEqhcNY
         df4JRfjYorbuTTNhpo8Q3kiPlE4PL/0KJw86w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K0jdNDYsyVBKVJ8vrSclC2i6UhecRADdZccibZZW3Fk=;
        b=S0bzTE8dwsY41MXdR2+1ZxBNpI05qftanSqgVHuRrXVgJkFw5wi0wD2Y0p9TsOBWxK
         drrz28sRlAw12KnuszVle5ncnIF5Cuc6xwQ0r0l23b1lB8vTDD2KF35SVE/IyL+HLajv
         9Z4w47XPutt7kd57ej/h2492ufZflNgSTApeaL66apoqNxvxxwFxlnw49+T3SpHsSYFN
         q7Yz/45PUfJeYclbgnm3gnKafsHwbbYRU8rXPeIRb1O6FRNWbyQ2/hNY+xKayjCft3Cv
         13qjoblq+T8erMq6ZTAXg7Zgc8CORHxT5H+GESJgy5EVIKMpf04SD0S73+79e/081JcD
         fepg==
X-Gm-Message-State: AGi0PuZvApeSoP7e/3CpL51Kkf87If/QDJn9laHvQn0H6Bq7Clbz+tRc
        wb09gA6PHlhvm1tgLcSV9CI/UQ==
X-Google-Smtp-Source: APiQypLdGMmw7NvSuzoHy8mBNVlipdBTPHcElNsahD9loveLyoxd/GXH2+3BqDp98wZz9NH2Z0oODA==
X-Received: by 2002:a17:90a:e2c1:: with SMTP id fr1mr2244175pjb.124.1586897623282;
        Tue, 14 Apr 2020 13:53:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1sm11810795pfl.188.2020.04.14.13.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:53:42 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:53:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Kristof Beyls <Kristof.Beyls@arm.com>,
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
Message-ID: <202004141258.6D9CB92507@keescook>
References: <20200409232728.231527-1-caij2003@gmail.com>
 <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk>
 <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
 <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com>
 <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
 <CAKwvOdm5aawsa2-=atB8z6W8zo8YVgdDEVbU3i4evDcpo1_AxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm5aawsa2-=atB8z6W8zo8YVgdDEVbU3i4evDcpo1_AxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this will help, but I feel like folks might be talking
past each other a little here. I see two primary issues that are
colliding, and I just want to call them out specifically...

On Tue, Apr 14, 2020 at 1:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Mon, 13 Apr 2020 at 22:45, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > 1. continuous integration and randconfigs.  We need CI to help us spot
> > where things are still broken, and help us from regressing the ground
> > we've fought for.  We can't expect kernel developers to test with
> > LLVM.  Currently, we have LLVM builds in numerous kernel continuous

First, is this one. To paraphrase, "we don't want to lose hard-won
ground."

> To be honest with you, I don't actually think iwmmxt is that
> important. But I have already demonstrated how we can use a couple of
> macros to emit the same instructions without resorting to bare
> opcodes, so there is really no need to disable pieces left and right
> because the Clang assembler does not support them outright - it just
> needs someone to care enough about this, rather than rush through the
> list with a tick the box attitude, and rip out the pieces that look a
> bit too complicated.

The second is this one. To paraphrase, "we can just fix things instead
of disabling them."

This feels a lot to me like the pain I (and plenty of others) have felt
when doing treewide changes (adding full compiler support is kind of a
treewide change). The above two points were really strongly felt when we
were trying to remove VLAs. In our case, we didn't even have the option
to disable stuff, so the pain was even worse: VLAs were being added to
the kernel faster than we could remove them.

What's a good middle ground here? For VLAs, I ended up getting akpm's
help by having him add -Wvla to his local builds and send nag emails
to people when they added VLAs. That's not really a thing here, but it
seems like there should be a way to avoid losing ground (in this case,
it's the erosion of attention: repeated known-issue warnings means the
CI gets ignored for the warnings on newly added issues). It does seem
to me like adding the negative depends is a reasonable first step: it
marks what hard things need fixing later without losing coverage for
things that can be more easily fixed now with available resources.

For the specific iwmmxt.S case, perhaps the solution is the suggested
changes? I imagine it should be possible to do a binary diff to see zero
changes before/after.

For others, is a negative depends acceptable? Given how responsive
Nick, Nathan, and others are, I don't think there is any real risk of a
"slippery slope" of things just getting swept under the rug forever.
Everyone here wants to see the kernel be awesome. :)

-Kees

-- 
Kees Cook
