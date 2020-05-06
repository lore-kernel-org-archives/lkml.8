Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4006BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5F02080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588787084;
	bh=RafwzRMxEiqewRDjYX9jx28hV2yqim7/WefdTKS8dBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IL0jcaVtPcShZ8V3dG33ffblkkL3NK7jk5arTOM6KccuxbXFrlLe9MFQQt13CMeJq
	 nPU6HP8s1/f897PwvdkzDxSlgtOZ/OBKUq6wjxoXYMooa/1jJIQxh7ayy6qNFqfeNF
	 50TXShv1uKw3/OHZX8gIMH+jkxs1LfrlU7iPsm3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgEFRom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbgEFRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:44:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B6C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:44:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b2so3323357ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNt2KHwB8PiMSyUUcvWbb3LmQf/yl99wmVRwAMCe6Sw=;
        b=QfIhp8bnkHziXy45j6AZQvnQuPZVCBRmkYNh4Qk1yBWY/AbDih3c468GHPPi0NxUWC
         +RsQItHsCm4TW5y+JMWQZhOFGKrkw/OMHO8k0Ff3ChO35z8KVI8vHTXhfxO6dpDN2zOT
         R/3GLd58rAk/zgyKNOtvPikt/JEPwM8VJVw+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNt2KHwB8PiMSyUUcvWbb3LmQf/yl99wmVRwAMCe6Sw=;
        b=gS9+xsoM1qiVPTwJyj0waZy7rqShkQN70rO0wXx4kjGSGNdq5pXYwXUb27NdNzFYhW
         TiCMB/YblULz/nRQ9Ahd8NIElMrYsdN0n6Fkl0g/XLB3XwuntJtN4rs6KJCm2AgZkz75
         U+V0gYssU00c5+4sG+AOrNt0Sawxe9cyv930YDScfWdFbXzsoZamCFRes2VrpmWenTfy
         kUJO4SofvLhbMCPJ1GakzEk81+hOOZkt5QA9BaSelFqFBPj8tZXO+HNcha4yrGr2Zv31
         rd+m5A2JwIr8sjNavoG3tHXVXnVazOZVBrcoeUtJXyO6OGA7Iry9U458lfj5TmqND16Y
         9Utg==
X-Gm-Message-State: AGi0PuaVTcwogSUcprEDo6m4z5MKdSwo7edd8XgnD21ew336Bwbf/f/Q
        lqNziwZUk3yD80CF6epfcNq53pvf3bI=
X-Google-Smtp-Source: APiQypIiRf4AEzeSgaDNyTxs6XbtZEi6k+t3Z0S6HLlq9Hw4ANfljbuAJK42xRtsJGiSElWJBnQ4Bw==
X-Received: by 2002:a2e:9117:: with SMTP id m23mr5551208ljg.43.1588787072860;
        Wed, 06 May 2020 10:44:32 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 16sm1741008ljr.55.2020.05.06.10.44.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 10:44:32 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j14so2074293lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:44:31 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr5836440lfk.192.1588787071388;
 Wed, 06 May 2020 10:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200506062223.30032-1-hch@lst.de> <20200506062223.30032-9-hch@lst.de>
In-Reply-To: <20200506062223.30032-9-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 May 2020 10:44:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3T6u_kj8r9f3aGXCjuyN210_gJC=AXPFm9=wL-dGALA@mail.gmail.com>
Message-ID: <CAHk-=wj3T6u_kj8r9f3aGXCjuyN210_gJC=AXPFm9=wL-dGALA@mail.gmail.com>
Subject: Re: [PATCH 08/15] maccess: rename strnlen_unsafe_user to strnlen_user_unsafe
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 11:22 PM Christoph Hellwig <hch@lst.de> wrote:
>
> This matches the convention of always having _unsafe as a suffix, as
> well as match the naming of strncpy_from_user_unsafe.

Hmm. While renaming them, can we perhaps clarify what the rules are?

We now have two different kinds of "unsafe". We have the
"unsafe_get_user()" kind of unsafe: the user pointer itself is unsafe
because it isn't checked, and you need to use a "user_access_begin()"
to verify.

It's the new form of "__get_user()".

And then we have the strncpy_from_user_unsafe(), which is really more
like the "probe_kernel_read()" kind of funtion, in that it's about the
context, and not faulting.

Honestly, I don't like the "unsafe" in the second case, because
there's nothing "unsafe" about the function. It's used in odd
contexts. I guess to some degree those are "unsafe" contexts, but I
think it might be better to clarify.

So while I think using a consistent convention is good, and it's true
that there is a difference in the convention between the two cases
("unsafe" at the beginning vs end), one of them is actually about the
safety and security of the operation (and we have automated logic
these days to verify it on x86), the other has nothing to do with
"safety", really.

Would it be better to standardize around a "probe_xyz()" naming?

Or perhaps a "xyz_nofault()" naming?

I'm not a huge fan of the "probe" naming, but it sure is descriptive,
which is a really good thing.

Another option would be to make it explicitly about _what_ is
"unsafe", ie that it's about not having a process context that can be
faulted in. But "xyz_unsafe_context()" is much too verbose.
"xyz_noctx()" might work.

I realize this is nit-picky, and I think the patch series as-is is
already an improvement, but I do think our naming in this area is
really quite bad.

The fact that we have "probe_kernel_read()" but then
"strncpy_from_user_unsafe()" for the _same_ conceptual difference
really tells me how inconsistent the naming for these kinds of "we
can't take page faults" is. No?

                   Linus
