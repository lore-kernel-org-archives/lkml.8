Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC2AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672CC20714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsHW7I1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgC3S6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:58:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40178 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgC3S6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:58:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so7092487plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaymTvWhl+uolecE6yhTgiJXYyga2SjGtw1lmCMSDqs=;
        b=PsHW7I1fS2tGpAp9WvwvJEIEB1UhTC/5ffZ+EV5rw9+EDE7tWWEdgrRp6Zkf4SjVEp
         cwkaxDt9VbxLbNrtTCDAhBtyhD2Hd7kMQQl43Bm5Tdtw1LhZ9hJfHMP6t+JJvItmlmR0
         u8RpCpiEqOS4oEXW6TJJwjsszDbl9ZCCf+g0khHWGpbpEvPGMUti1mNuC9GtgMR7826j
         5DHf+zOjK/EeHeemjI/6utfmQwuuxAhaslZa8Hdd+DhjiiwyqBHnr74+La/82/FPPZOc
         Gdy6e4cyYRmLAxOJFWJ6fE+lhclAJLgLw1S8OZ/jjoiG8/1Vz/58WuDfW+rkaVbwPWeV
         Ya2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaymTvWhl+uolecE6yhTgiJXYyga2SjGtw1lmCMSDqs=;
        b=Pj4RkvGoHD76kenb7N9xvm5/M8abNtJJejb87ZZiDHV7lrG+0fhXwGm7r3TNVfHkep
         3/GJJzuZC1Iqm8zwlI964rYiEF8h1WuZx1gt3CQi+QGZlxnayxVgp5pIORXIJIpZK7Lp
         pCqrKLUcnSiwAxCnw7/VSRsg8KcueqdjxU40VWa/UbdqkZCTG8JRUXHBmnaPV9VFIyaN
         ZRmoooWxGiDkIpiV85+8a1JmqvQgG0/f518WQWMa44bjGaia9dyETFByDVIza0LjK9Oz
         AZGV/ZQIT1G+yU34VVRjGumFJ8tPcPHbSvRDcATwro8sWdjDsEoUAPZwvI0YWLHKhmMA
         KGgA==
X-Gm-Message-State: AGi0PuZkz3bjVITzh9ge+UIMUF77R5P8ylrCkvn45FMHRLnHFWA/F4F/
        iEPf0YfJJ9muE8AISxoK1D4mRU3DDZ3MBMYNOf2FNg==
X-Google-Smtp-Source: APiQypJX8XRZqI6Y72HOVBrO9Kad5wcjOxF9c16uT5iosishYmErkreBO76B6Vuj88tyApqJwzl6pKfebpS72m697O8=
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr531303pjb.186.1585594711248;
 Mon, 30 Mar 2020 11:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200317202404.GA20746@ubuntu-m2-xlarge-x86> <20200317215515.226917-1-ndesaulniers@google.com>
 <20200327224246.GA12350@ubuntu-m2-xlarge-x86> <CAK7LNAShb1gWuZyycLAGWm19EWn17zeNcmdPyqu1o=K9XrfJbg@mail.gmail.com>
 <CAK7LNAQ3=jUu4aa=JQB8wErUGDd-Vr=cX_yZSdP_uAP6kWZ=pw@mail.gmail.com>
In-Reply-To: <CAK7LNAQ3=jUu4aa=JQB8wErUGDd-Vr=cX_yZSdP_uAP6kWZ=pw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Mar 2020 11:58:19 -0700
Message-ID: <CAKwvOd=5AG1ARw6JUXmkuiftuShuYHKLk0ZnueuLhvOdMr5dOA@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile.llvm: simplify LLVM build
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 6:57 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I also had planned to provide a single switch to change
> all the tool defaults to LLVM.
>
> So, supporting 'LLVM' is fine, but I'd rather want this
> look symmetrical, and easy to understand.
>
> CPP        = $(CC) -E
> ifneq ($(LLVM),)

Yes, a simple if statement is much simpler than the overly complex patch I had.

> CC         = $(LLVM_DIR)clang

Do we need $LLVM_DIR? Shouldn't users just have that in their $PATH?

Also, I think we need to support suffixed binaries, as debian
distributes these with version suffixes, as Nathan points out.  Or do
the debian packages install suffixed binaries AND path versioned
non-suffixed binaries?

> LD         = $(LLVM_DIR)ld.lld
> AR         = $(LLVM_DIR)llvm-ar
> NM         = $(LLVM_DIR)llvm-nm
> OBJCOPY    = $(LLVM_DIR)llvm-objcopy
> OBJDUMP    = $(LLVM_DIR)llvm-objdump
> READELF    = $(LLVM_DIR)llvm-readelf
> OBJSIZE    = $(LLVM_DIR)llvm-size
> STRIP      = $(LLVM_DIR)llvm-strip
> else
> CC         = $(CROSS_COMPILE)gcc
> LD         = $(CROSS_COMPILE)ld
> AR         = $(CROSS_COMPILE)ar
> NM         = $(CROSS_COMPILE)nm
> OBJCOPY    = $(CROSS_COMPILE)objcopy
> OBJDUMP    = $(CROSS_COMPILE)objdump
> READELF    = $(CROSS_COMPILE)readelf
> OBJSIZE    = $(CROSS_COMPILE)size
> STRIP      = $(CROSS_COMPILE)strip
> endif
>
>
>
> I attached two patches.
> Comments appreciated.

I'm not sure the second one that recommends changing cc/c++ is the way
to go; I think it might harm hermeticity.

> If you are so addicted to LLVM

Lol, maybe?
-- 
Thanks,
~Nick Desaulniers
