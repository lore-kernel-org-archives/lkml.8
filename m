Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460D0C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEB02063A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 20:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594586065;
	bh=7s/bXFPta5iGfrJYcoJlW5oI24AlmaeRgmhyxoTk4hk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dQhenet9IABq7/z+DVnvWE2o8wwgCHDz2HLDktMSSKcsSHHykjQkM/XE08TeBqe2b
	 iHX05bnNugt+F9uRorT3RjP+kGFhgaOwDu+JA4ITKEkjweq6PEA2ZiLtl6ajgzxmuy
	 dmNmUJvmKyNJY3jcKssA6lFZJxQF01mf6QPkme7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgGLUeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbgGLUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 16:34:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27689C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 13:34:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s9so13144480ljm.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5WjRrnyhLOSbHqzwifF7Te2n7vimCY08qC27XUzpXI=;
        b=YMyGELxAtRmy9FjeeEk7uVwcYjYoq2mBvgisQy8JZOxvY4g3Bz0EEBukkIZB9h2WDt
         o5f4gSFHlse0x52UYJ8dJF9LafvSlVPybKv1y9cmVH8Fejf1LwYD3ntamxSNJxh16R/b
         +YwTWpc1gg7WyUVJiEH6tMOkH+xXjyU4nCVtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5WjRrnyhLOSbHqzwifF7Te2n7vimCY08qC27XUzpXI=;
        b=Bh64yNP15qtcTtph0ASi73UN2wCZNEFrOmZhZ7bhcXpxjQmD+qLJnzq8+4tQKVmMXk
         8kQu3v84YcnqUT5WGd4TXsAOtqeTsp4f7RbQcWKmd9/bOZMtxSd/QvjqacK3y3/BfIQ7
         K5nZBJYnYyD//hXLPqKmCO2UOXJeBHXeFzJEeAapx9LKhONTHh7/38ZoIx+3UKZDfjap
         r+LaSA4Hk+OnL0y6kXtmKbYcG/KBLgJL5KuZSL6+kGjQZ9tKw5F+W3BjDz38rfp1dFec
         tygBsOcYlcCYSvTbBoFQYmxa7DuVTwD+FZcFRtxsslR9rFCB0u148ZmOpKlvVBF8ElMl
         SMUw==
X-Gm-Message-State: AOAM530kCabDiVUyNx+VwyGXScmoZQf9nnvpHN/HtG3r6ZSwoVyAATK0
        Ml7DaJZ4qZ2FFDcsN0t2p/sIHxnQues=
X-Google-Smtp-Source: ABdhPJzpbys1ImyYl0UOXSBzzbD5bxGeeAjTUNxeE3I+bzoPJqLvoJfojPkLA+B0dlFgjbxxWqPrSw==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr43238190ljg.201.1594586055245;
        Sun, 12 Jul 2020 13:34:15 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id u26sm5865143lfq.72.2020.07.12.13.34.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 13:34:13 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h22so13157237lji.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 13:34:13 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr40262320lji.70.1594586052886;
 Sun, 12 Jul 2020 13:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200712123151.GB25970@localhost> <20200712193944.GA81641@localhost>
In-Reply-To: <20200712193944.GA81641@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Jul 2020 13:33:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=xTmhnL4go0v5BaYRz_81kranLvniA5X8_zq_uCkaOA@mail.gmail.com>
Message-ID: <CAHk-=wi=xTmhnL4go0v5BaYRz_81kranLvniA5X8_zq_uCkaOA@mail.gmail.com>
Subject: Re: Linux kernel in-tree Rust support
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Adrian Bunk <bunk@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alex.gaynor@gmail.com, geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 12:39 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> Rust has hard stability guarantees when upgrading from one stable
> version to the next.

I think the worry is more about actual compiler bugs, not the set of
exposed features.

That's always been the biggest pain point. Compiler bugs are very
rare, but they are so incredibly hard to debug when they happen that
they end up being extra special.

Random "we need this compiler for this feature" is actually fairly
rare. Yes, the most recent case of me just saying "let's use 4.9
rather than 4.8" was due to that, but honestly, that's the exception
rather than the rule, and is to occasionally simplify the code (and
the test coverage).

The most common case of compiler version checks are due to "compiler
XYZ is known to mis-compile ABC on target IDK".

                    Linus
