Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCEBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A45F2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598550954;
	bh=6fu/00yovsv+WyNJlrR+vlvmUMNWyprHqNtSN/fD2h4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t+VUUx+VmsGRv/JhydlUsvBJ5HK2HoKDllgS/A4lXrMOTqDN92nvarOTF3ErrtvBo
	 QeoDIzIqOO5u4PinuC1vuMvWussddbAXzQnte1bAa8ksXA4XyKAYuQFLg4Eue1CvXH
	 TkA6WwqZoOhCopPmIodhF4z3xe74F/0WfMsiq9pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgH0Rzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgH0Rzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:55:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C55C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:55:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so7401831ljn.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBxw2hdQPG9HwPnbg4ROvvprorSoqDpTe8GqtXP5pJ0=;
        b=gEx+R3IPWaIJ1rgeNNwr+K1FkcP5eJOLC7ZA9dQ9Cv0uo0pZjd3WeqmWckEgGWoYrU
         ZAG7LNkdYBfRW3VrlUxFVNYbKu1wyi/QwU3U8A/KnnoM89gRInpWvJhvjjqCkfZnBCSn
         5eQEyXLyrqPdWNsvej8MpXfKFNrgFKsRiKyn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBxw2hdQPG9HwPnbg4ROvvprorSoqDpTe8GqtXP5pJ0=;
        b=ODdXlcLmKiC5t3H74Y3KurhaRlygojfoO4fl0ZtB6sMKxDNpJMjVFxAGmCxZLKSxVT
         bQWk9/AI9oh6KgEdcEzkHq8gGaTRzGdgjzw0tpAwram3Odw72KjHtu6pQR4mKBfocrGr
         0goTBjy1+GK4B++A/cxgP0WCnoZUZO7euyMxX1L38TDZwrbnbVSi8HbEgebMcFDNL9CX
         e88s7TanW+oTUyByMiEUL8KE753dJOUo/7HsiKxPiZmWVGXFUmIR79+4z6BVN0c1R2qr
         HDdGgszDrqI4sJP11LteTCF5390sKDq7J6d/qRpAx2OL0dHjPm5N7HuyLnpDbqJcTQ2n
         9hsA==
X-Gm-Message-State: AOAM530TIk4k/2h3IS2N0md1Yg0citePcJj8J549Cvk9R8v1kXgR1YRj
        +Y5JKEwZlaVHMFDUqW5i3lOx2rZBvLWlVA==
X-Google-Smtp-Source: ABdhPJyFfJv2oqdYFRyslx9a2eJVBscq5o5LKSSZnQPTnwzt2HJWcIQBP9sXpRaOTJsCkdsrCzigHA==
X-Received: by 2002:a2e:b81a:: with SMTP id u26mr11056334ljo.241.1598550950646;
        Thu, 27 Aug 2020 10:55:50 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j7sm622516ljg.5.2020.08.27.10.55.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:55:49 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 185so7414638ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:55:48 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr9098156ljk.421.1598550948550;
 Thu, 27 Aug 2020 10:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <202008271145.xE8qIAjp%lkp@intel.com> <20200827080558.GA3024@gondor.apana.org.au>
 <CAMj1kXHJrLtnJWYBKBYRtNHVS6rv51+crMsjLEnSqkud0BBaWw@mail.gmail.com>
 <20200827082447.GA3185@gondor.apana.org.au> <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
In-Reply-To: <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 10:55:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXW=YLxGN0QVpp-1w5GDd2pf1W-FqY15poKzoVfik2qA@mail.gmail.com>
Message-ID: <CAHk-=wgXW=YLxGN0QVpp-1w5GDd2pf1W-FqY15poKzoVfik2qA@mail.gmail.com>
Subject: Re: lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes
 is larger than 1024 bytes
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:34 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> How are you guys testing? I have UBSAN and GCOV on, and don't see
> crazy frames on either i386 or x86-64.

Oh, never mind. I also have COMPILE_TEST on, so it ends up disabling
GCOV_PROFILE_ALL and UBSAN_SANITIZE_ALL.

And yeah, this seems to be a gcc bug. It generates a ton of stack
slots for temporaries. It's -fsanitize=object-size that seems to do
it.

And "-fstack-reuse=all" doesn't seem to make any difference.

So I think

 (a) our stack size check is good to catch this

 (b) gcc and -fsanitize=object-size is basically an unusable combination

and it's not a bug in the kernel.

                Linus
