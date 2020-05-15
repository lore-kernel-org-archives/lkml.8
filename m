Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D873C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BC420709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HuhqVP38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEOUmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOUmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:42:53 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122BFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:42:53 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s21so3347657ejd.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dz+fWfDJYsM+tFXNBKAA9wqSLEoWW+Ek7ibRNvsSK4A=;
        b=HuhqVP38EnG9v4J11YxP/SXESV/y9N9Mu6eqUgsjR3b5rpD8n4+8IAl9zZCsrjaWmD
         bdt5vMFXqOH9VSAXo2uCH7i/Ba3MPOVWUkfld1CKVR5VAHxoKMI27hnZ8B0isc+6plTd
         3i257scz/DFqUsV55sLUnz31Qoj2gddWUVCcN/YbtfWdubh/Bp+ZHdrWrkIHvntpjws4
         ec5mBj941nZXLGJEuYPzkaPI7Mj7PZqiO4ArfmnD1sh0cjzfSc7MqPcHm2FhD0UCsdnF
         sOKaWk03AmsyDohBerKzNpwjZJQzFJPHDRCfs70bXTfPdYsTCAAUrVQHG1mloMy+PbuF
         YcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dz+fWfDJYsM+tFXNBKAA9wqSLEoWW+Ek7ibRNvsSK4A=;
        b=l3dQL6Uy5Z6zYwnVWRyKX2zWyxYZhhEtenpwGE3dG0NOSejnQWOQ/O0e5qYo9EF+WV
         RpSc1SrerJxlah3DEUIroknMTF8PDoz+6wTwyyVb/bYVnZBEWApjyHu0jynowpgCdvbu
         yZVAwz0+2C+ezQnfRJ59VJnNrtUloUlW6poo5J9whgzm4sHsWONd5i9GIt3DjBqz360f
         a1RPfwHDvMRy0H38DaffsUgWBT2lYoC7nKZI9irMhuSNJmGpmxLubNs0gukfKLe/NVTj
         1Ogryhs+rnt6YkRbm8mEQ+SX7Ve/4mb8CONNuIiKEXDeGRm8U1JeNYe9fDzVf4MmdXQh
         lE7g==
X-Gm-Message-State: AOAM532mns0cWT77f6Cxl2sRqSTMmU6vBco27FDs9lZmhkudUvMA2hRE
        SrxiooSm86O/yiRGGIrAI6HkNlRfA7gn50aBke6QWA==
X-Google-Smtp-Source: ABdhPJxqgAkYgYezisODwIMgNYIOCNmXUdqnBOG6D2B2uk0jS3Oca1lw0nYuQyVFttqz+Kniz2zo7IYbtafB+LdjELA=
X-Received: by 2002:a17:906:55c3:: with SMTP id z3mr4688303ejp.180.1589575371237;
 Fri, 15 May 2020 13:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200515172756.27185-1-will@kernel.org>
In-Reply-To: <20200515172756.27185-1-will@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 15 May 2020 13:42:40 -0700
Message-ID: <CABCJKucXmMD82mQ0rSMjfByXD42htTjkde3TsKTVP-jvuqkZwQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Clean up Shadow Call Stack patches for 5.8
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 10:28 AM Will Deacon <will@kernel.org> wrote:
>
> Hi all,
>
> Here's a series of cleanups I hacked together on top of a modified v13
> of the Shadow Call Stack patches from Sami:
>
>   https://lore.kernel.org/r/20200515172355.GD23334@willie-the-truck
>
> The main changes are:
>
>   * Move code out of arch/arm64 and into the core implementation
>   * Store the full SCS stack pointer instead of the offset
>   * Code simplification and general style things
>
> I'd like to queue this on top early next week so that it can spend some
> quality time in linux-next.
>
> Cheers,
>
> Will
>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@am.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <kernel-team@android.com>
>
> --->8
>
> Will Deacon (6):
>   arm64: scs: Store absolute SCS stack pointer value in thread_info
>   scs: Move accounting into alloc/free functions
>   arm64: scs: Use 'scs_sp' register alias for x18
>   scs: Move scs_overflow_check() out of architecture code
>   scs: Remove references to asm/scs.h from core code
>   scs: Move DEFINE_SCS macro into core code
>
>  arch/Kconfig                         |  4 +--
>  arch/arm64/include/asm/scs.h         | 29 ++++------------
>  arch/arm64/include/asm/thread_info.h |  4 +--
>  arch/arm64/kernel/asm-offsets.c      |  2 +-
>  arch/arm64/kernel/entry.S            | 10 +++---
>  arch/arm64/kernel/head.S             |  2 +-
>  arch/arm64/kernel/process.c          |  2 --
>  arch/arm64/kernel/scs.c              |  6 +---
>  include/linux/scs.h                  | 16 +++++----
>  kernel/sched/core.c                  |  3 ++
>  kernel/scs.c                         | 52 +++++++++++++---------------
>  11 files changed, 55 insertions(+), 75 deletions(-)
>
> --
> 2.26.2.761.g0e0b3e54be-goog

Thanks, Will. I tested these on my SCS tree and didn't run into any
issues. Looks good to me.

Sami
