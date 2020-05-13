Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE47C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A32C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589411023;
	bh=vewls980HRuxR06tg5H4BH+YA45h9SryXksyHmYSP8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a03kI2OChVaJynhtu1BqO+meV6ksRwSES4gSOTjRz/FzeC7iKqsErZBeAYR3zGC0q
	 Tt6zaWOq9Z+PkkHdpYN1dRgALhvey2MPLbdfSAHlqEi08RzpR0numzgFkRwGfQ9YMJ
	 MT2oprF19SBYh29zhmWLiwpz/NxakpEt0IVqzdKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbgEMXDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732236AbgEMXDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:03:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56BC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:03:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 188so925141lfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdZg4gkYTds/C4KUVy9erLK1Ch+WqNN+RvFMTseVuAg=;
        b=C1TcjV6OtJpa2YRiWAUnGcZZ/u09cBy851Mx94wSMSQa9VrdsWV1jVHW4P1sNrL8Bh
         F6WpmJ1tQWre2J0ca6Wb2LX04yqV6LxMJpd1Tpa6EPb8PrEYBkkbwpuLaAdO/BjmCZ2G
         9egVYPaqRVmuIV8Yift2HwrZ/fz1dHM99i9n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdZg4gkYTds/C4KUVy9erLK1Ch+WqNN+RvFMTseVuAg=;
        b=XOYGxrsRsQPdXXeRh+psp9ZT6VcmwnnECj3npfeWZYunS3wonUROAXsEU3B8W7CnLH
         bL4xsQYjhYXGtjrByhzzCiKiAW3zvS6rjx+L+73EzXNYas8+jMvoAvnOCmEYAr2xgeit
         4O3Z9vsGkBqAB9nt8j2cHPWI8/G7Rns0Z/bH5T00cbDFxcQWyegmx0z5TQ2J4TCEexrI
         qVnML6cbBBy8l/0/ZUdlveYwg5CYNF5s0bOeoVFJWGk8JlwAZsEhraYe8a/oyxz4y4Z0
         uhbDfj/9apY/0jjh0Wf0BrgO2lQvKGEP7BJTHSnGuB5pmLi+tV6bgAfiw3MtDTivqCCy
         ggiA==
X-Gm-Message-State: AOAM533bqbT1+W5D+EM5PFsflfLUusk2N89OVkT0RUclh0lBcZO+u8Wr
        Y/iOseDsAabafCTYSyZYpO29zThowH4=
X-Google-Smtp-Source: ABdhPJxTtRL5ITTgQ0cJMjxghWCdBpdsl78DTeOSBeBASiVLHvuHSf45z9Rj1Z2y/HonFo/f5JVTuQ==
X-Received: by 2002:ac2:48b2:: with SMTP id u18mr1104694lfg.122.1589411018016;
        Wed, 13 May 2020 16:03:38 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d16sm431144ljj.84.2020.05.13.16.03.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:03:36 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id v5so906561lfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:03:36 -0700 (PDT)
X-Received: by 2002:ac2:58c8:: with SMTP id u8mr1177915lfo.142.1589411015919;
 Wed, 13 May 2020 16:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-12-hch@lst.de>
 <CAHk-=wj=u+nttmd1huNES2U=9nePtmk7WgR8cMLCYS8wc=rhdA@mail.gmail.com>
 <20200513192804.GA30751@lst.de> <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
In-Reply-To: <0c1a7066-b269-9695-b94a-bb5f4f20ebd8@iogearbox.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 16:03:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiivWJ70PotzCK-j7K4Y612NJBA2d+iN6Rz-bfMxCpwjQ@mail.gmail.com>
Message-ID: <CAHk-=wiivWJ70PotzCK-j7K4Y612NJBA2d+iN6Rz-bfMxCpwjQ@mail.gmail.com>
Subject: Re: [PATCH 11/18] maccess: remove strncpy_from_unsafe
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Wed, May 13, 2020 at 3:36 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> It's used for both.

Daniel, BPF real;ly needs to make up its mind about that.

You *cannot* use ti for both.

Yes, it happens to work on x86 and some other architectures.

But on other architectures, the exact same pointer value can be a
kernel pointer or a user pointer.

> Given this is enabled on pretty much all program types, my
> assumption would be that usage is still more often on kernel memory than user one.

You need to pick one.

If you know it is a user pointer, use strncpy_from_user() (possibly
with disable_pagefault() aka strncpy_from_user_nofault()).

And if you know it is a kernel pointer, use strncpy_from_unsafe() (aka
strncpy_from_kernel_nofault()).

You really can't pick the "randomly one or the other guess what I mean " option.

                  Linus
