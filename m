Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB0AC433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E5F206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulyQe9g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgG1U5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgG1U53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:57:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E8CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:57:29 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id t15so13332445iob.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FSwie7gbecv3LuLSKvysGeFpSnlyQ0HY+UfcoC3l9Ls=;
        b=ulyQe9g+Gek/4SCJMk2jaRWt44ckJ2J4m9qhbNva6/NUosWt03AVeXgjwvd6r6rLLz
         OQlFWyUY5QV2n5Dx/5qHN2E0QRVguMDIC0om0Yd4SdZbP8cLsFluymYRy788FUoD7G2M
         Ytu1Pnki/NyqU506n7xZC3VkyL1Ov/d5nkyt4/0pD76p1Ct45op0qvsk4vY9w06NqDx7
         fjR8gkTD6wAgPyszY9DaEqAWyF+1NxrhNHqrrKFC/8IbMlXOFypLVU8ImsGpMqIHiyVX
         dstEkJkTZsBIh5SFo7UM3BM3JFcbyz8Nvlw3TYwa7gt6aO6CPJZ4NP3eMT/NMDB9s0V3
         Fyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FSwie7gbecv3LuLSKvysGeFpSnlyQ0HY+UfcoC3l9Ls=;
        b=jmH6zX//T6La5TIFYGpjEuyiKAeFjUWBE4bbqAxA7LMsvx6RtM4mJxRbDAldUJs3IQ
         QluTRvlbQdl7bZiJq8lbkfaSNoYhacof8UeLHJL5iewz9lSpwXFzQ05DPi9Nd5AlUYJC
         hN5wPkM0gUliJLFuNPcptpd5hbALTyholbgnM6VyWO9dPiJBPHfy8EkP4Gwpu1Pbm3AX
         5lJxABNsjz7x2kGuNgDSKEoOUApWFhvKXqybenq2TASR358vt2RXqTRExbIIc3w7vC60
         R90C5g7KPJsLWk2HMp3m7SG2hGXnAEVY2JhyrcIw5qmbWraUD3x1tuoFlTJX8bvRbSSB
         NNWw==
X-Gm-Message-State: AOAM531wSrJ7fmzEF86TkoRkm2Nkv2d62MrU9mNQBj1DKSeH5Mmk7xqY
        kZHQV5eyOAQPS+6QOqvfnW2JFZc+nbeTBTSmLrpiNw==
X-Google-Smtp-Source: ABdhPJy8W3kXCOhBuTi0UpoKm6nSp8vdamibTtQHu4xCmOnTQmF4SuI0SzX/+hL0XobeY91vFRi2P9vQ8jyq4onYJI8=
X-Received: by 2002:a05:6638:22d0:: with SMTP id j16mr34246940jat.92.1595969848379;
 Tue, 28 Jul 2020 13:57:28 -0700 (PDT)
MIME-Version: 1.0
From:   Giuliano Procida <gprocida@google.com>
Date:   Tue, 28 Jul 2020 21:56:52 +0100
Message-ID: <CAGvU0H=AAPt0wSTh1dyb-aTnG9zeUY6U2uBkmi6K9Bvpuc9YAA@mail.gmail.com>
Subject: BTF_KIND_FWD enums
To:     Yonghong Song <yhs@fb.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Re: https://github.com/torvalds/linux/commit/9d5f9f701b1891466fb3dbb1806ad97716f95cc3

Both GCC and LLVM support forward-declared (a.k.a. incomplete) enums
as a language extension -
https://gcc.gnu.org/onlinedocs/gcc/Incomplete-Enums.html.

(C++11 has a different notion of incomplete enum type - opaque enum
declaration - storage size is known but enumerators are not)

Forward-declared enums feature in various places in kernel code and
allow the usual things to be done (passing around pointers to such).
I'm curious as to if and how they are they are handled by BTF and
whether a further change to btf_type is needed:

1. Use BTF_KIND_FWD, with another spare bit to allow up to 4 kinds of
forward-declaration; or
2. use BTF_KIND_ENUM, kind_flag 0 and vlen 0 (as empty enums are
currently illegal C); or
3. use BTF_KIND_ENUM, kind_flag 1 and vlen 0.

If I had a working pahole -J, I'd test this myself. :-)

$ cat /tmp/en.c
enum H;
enum H * fun(enum H * x) { return x; }
$ clang -Wall -Wextra -ggdb -c /tmp/en.c
$ build/pahole -J /tmp/en.o
Segmentation fault
$ build/pahole -J /dev/null
btf_elf__new: cannot get elf header.
ctf__new: cannot get elf header.
Segmentation fault

My interest here is that I helped add support for incomplete enums to
libabigail which we're using to monitor kernel ABIs.

Regards,
Giuliano.

(resend due to email address typo)
