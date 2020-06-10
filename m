Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C06C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0477D20853
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591808057;
	bh=fAdBqinCGHfmgrDM2PwAAQJVvSRyeEDaH7oFdg5LMuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XlRblqQn0UY666eBeTQpWTIL6MmNX8j98w8l8Ut0fJm3ybNX+/NwKu3AXLsBJSEi/
	 DvJC08dGVKOVErcbey3avF0Die3aDGy8lks8ZJNew7WR1oNmAccQrXOwUpLAb395pR
	 8jzwAnr8NxTV3XTI+tbvjd5GNKwULmDjnuvfod70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgFJQyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgFJQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:54:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F35C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:54:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y11so3359411ljm.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGXejVSpqx4L2PlHIfd5JVBtSOWL/TuutZfvvE958Z8=;
        b=ZFce94Usj6EkI4Lk9l8ZbLgBKcrOaOEIKI+lsoHoWwucoH5PaFSFEUF5nSpDfmtX/m
         zpiTKIsyT2HuVYK0uUKJl0hfSDP//4+ueTqu4gfQUH9jmW1Fx7086RKZCkNC01IFk27w
         7I94+DibpxplQFqh0putGbec4FKBVLxsfzedA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGXejVSpqx4L2PlHIfd5JVBtSOWL/TuutZfvvE958Z8=;
        b=PyjBQm+LQ9+ROrBegOOTOFOY71ABVKBIdY0uY4+zixCvyLT4SQRYnn4gE3Tb54uFOI
         iFmji6v02irYo1Cj00cP1/16NylpzVQ/AXKIH/n3ix+knZassVn6o1PbxNgX1FDax8q5
         WIKlVc78hx95GALv2HqyXLzbBblLObuXMwQm80rueOww4xjQ/mNuCqjX3n4w/5JYvGeK
         tNQDDrXZUwmlKsUyT4LOAq/6ZwqthPXLU4aC4cYcxFCeykrzAosiI3GrloBtI2TeL0WA
         JiUWuPrLStTOo9UaM5SUyLlxhltUP/4w7ly55xQCnRGa7+WaB6KoLQ8veyZbMgSYrWEG
         jyvA==
X-Gm-Message-State: AOAM533/La8Bx6L4CwRVXr/MLEoKR1JgI1Q6UwuG0X2ryg+lj44KUXmV
        vTcH4iSnqlyc+998lqETKneQ187ode8=
X-Google-Smtp-Source: ABdhPJw9uaFuJyJ2HeD88YyQG20CQOrTEm9ySbJcSUlmocrUxOyTS98XKySfoxOoUawOjskXopo6eg==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr2164895ljg.99.1591808047759;
        Wed, 10 Jun 2020 09:54:07 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id j17sm71181lja.30.2020.06.10.09.54.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 09:54:06 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 9so3373764ljv.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:54:05 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr1979736lji.421.1591808045437;
 Wed, 10 Jun 2020 09:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200610174811.44b94525@thinkpad>
In-Reply-To: <20200610174811.44b94525@thinkpad>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jun 2020 09:53:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgm0_0PjXaSVbrpDfgtn6UbDyWjSRnXvfdebweUYSZ+eA@mail.gmail.com>
Message-ID: <CAHk-=wgm0_0PjXaSVbrpDfgtn6UbDyWjSRnXvfdebweUYSZ+eA@mail.gmail.com>
Subject: Re: Possible duplicate page fault accounting on some archs after
 commit 4064b9827063
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     Peter Xu <peterx@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        Nick Hu <nickhu@andestech.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Guan Xuetao <gxt@pku.edu.cn>, linux-xtensa@linux-xtensa.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 8:48 AM Gerald Schaefer
<gerald.schaefer@de.ibm.com> wrote:
>
> This was found by coincidence in s390 code, and a quick check showed that
> there are quite a lot of other architectures that seem to be affected in a
> similar way. I'm preparing a fix for s390, by moving the accounting behind
> the retry loop, similar to x86. It is not completely straight-forward, so
> I leave the fix for other archs to the respective maintainers.

Hmm. I wonder if we could move the handling into  handle_mm_fault() itself.

It's _fairly_ trivial to do on the arch side, just as long as you
remember to make the VM_FAULT_MAJOR bit sticky like x86 does with that

        major |= fault & VM_FAULT_MAJOR;

right after handle_mm_fault(). But it certainly doesn't seem like it
would be hard to move into common code in handle_mm_fault() either, by
just not doing the accounting if it's about to return VM_FAULT_RETRY
or VM_FAULT_ERROR.

That said, we want that perf_sw_event() accounting too, so we'd have
to pass in a 'struct regs *' as well. And it's not clear which way
accounting should go for other callers of handle_mm_fault() (ie gup
etc).

So I guess just having architectures fix it up individually and make
sure they don't do it for retry conditions is the right thing to do..

             Linus
