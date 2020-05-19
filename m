Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36D1C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93514207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589905579;
	bh=NTirTEmGhpSEDm5jG+eNbo8finTZb/dlG9CSBQARp3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H+HegWvNfV9COBuLp5LV/S2yb8yhOlj2KWsKj5e9FvGRkMcVeDU0PFTlmNOswQUg0
	 5MPPsO7k0X/fqnTuQVtwENM1hJ3AokUcFD/TOv24eqq6wOQooAOP0fIJJRYtUsT8/U
	 8V7+Wqu4GGxCOI4z3DhLWufkuOx+jyxyap4TVKFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgESQ0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbgESQ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 12:26:18 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1ABC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:26:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so418459ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhbRZ27gTq3LlamCeWaOIagumkyuEgHdNj01JBr2vyU=;
        b=a8S6FimrljQCYdqdMRjHudj5xuwSAYeW17sDBke8Wp/wO6Vv10u9cXvAcweW0ZSEYT
         O3hXN68ol8TooTR2xUI2YNd5y+PctNRhxhENJnhmYB+aBitMMtqsXQFMvUY86xEYH5PA
         jFICERjG8bgZGMW0GbVN6qDt50ZsFp9Lq9zCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhbRZ27gTq3LlamCeWaOIagumkyuEgHdNj01JBr2vyU=;
        b=sPtcYoXApujBVLiHcKINXhjfI/pdTRxUg/H82nl9SJgyWgzJk/sde58qB4ANFBA7Nz
         4ZdoxcDem/aFenx75H/o6K77dsdK07u8ansDpaC0/oRV5q7C4xisIhR2Ay/l19qFoIRL
         qCehXJqLsh5bMwcjDBOeL9X6ohEQyWPRpG45WTM7bCcj+tPjb2m0+qyRbX5+mFZvIlFw
         gFHjxBy8b/2ZL0U212ALRW5+E76WRE5JnpKFnh+eCvyGXcRP5NSNk+i8Cow9wcT61H17
         jAWenXBBqkgJA8EUlVJmwUCjwOfb+6u2csK1B/sM/3prtsesto7IM7da5C/bIsgF3S3W
         kp9w==
X-Gm-Message-State: AOAM533noDBoiBfze9tyybj8cGiYs8BAChA2E5u9Vs11/D9GJFuTFvQN
        cc6RnsIa3aiErpmVd/+sJs3Qu5m3HHI=
X-Google-Smtp-Source: ABdhPJydBW3EVX4Yhd5/4EX14cHK7VL6CTShFWAR7wGjGcmpKBt/qZxTkyg+LXHVlLs9hjf8mdga9g==
X-Received: by 2002:a2e:a171:: with SMTP id u17mr122687ljl.225.1589905575230;
        Tue, 19 May 2020 09:26:15 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n23sm1495618lfq.76.2020.05.19.09.26.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:26:14 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q2so352261ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 09:26:13 -0700 (PDT)
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr128485ljo.265.1589905573160;
 Tue, 19 May 2020 09:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200519134449.1466624-1-hch@lst.de> <20200519134449.1466624-13-hch@lst.de>
In-Reply-To: <20200519134449.1466624-13-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 May 2020 09:25:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com>
Message-ID: <CAHk-=whE_C2JF0ywF09iMBWtquEfMM3aSxCeLrb5S75EdHr1JA@mail.gmail.com>
Subject: Re: [PATCH 12/20] maccess: remove strncpy_from_unsafe
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

On Tue, May 19, 2020 at 6:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +       if (IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) &&
> +           compat && (unsigned long)unsafe_ptr < TASK_SIZE)
> +               ret = strncpy_from_user_nofault(dst, user_ptr, size);
> +       else
> +               ret = strncpy_from_kernel_nofault(dst, unsafe_ptr, size);

These conditionals are completely illegible.

That's true in the next patch too.

Stop using "IS_ENABLED(config)" to make very complex conditionals.

A clear #ifdef is much better if the alternative is a conditional that
is completely impossible to actually understand and needs multiple
lines to read.

If you made this a simple helper (called "bpf_strncpy_from_unsafe()"
with that "compat" flag, perhaps?), it would be much more legible as

  /*
   * Big comment goes here about the compat behavior and
   * non-overlapping address spaces and ambiguous pointers.
   */
  static long bpf_strncpy_from_legacy(void *dest, const void
*unsafe_ptr, long size, bool legacy)
  {
  #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
        if (legacy && addr < TASK_SIZE)
            return strncpy_from_user_nofault(dst, (const void __user
*) unsafe_ptr, size);
  #endif

        return strncpy_from_kernel_nofault(dst, unsafe_ptr, size);
  }

and then you'd just use

        if (bpf_strncpy_from_unsafe(dst, unsafe_ptr, size, compat) < 0)
                memset(dst, 0, size);

and avoid any complicated conditionals, goto's, and make the code much
easier to understand thanks to having a big comment about the legacy
case.

In fact, separately I'd probably want that "compat" naming to be
scrapped entirely in that file.

"compat" generally means something very specific and completely
different in the kernel: it's the "I'm a 32-bit binary on a 64-bit
kernel" compatibility case.

Here, it's literally "BPF legacy behavior", not that kind of "compat" thing.

But that renaming is separate, although I'd start the ball rolling
with that "bpf_strncpy_from_legacy()" helper.

                Linus
