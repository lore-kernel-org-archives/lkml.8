Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37FBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9115920791
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598549711;
	bh=SJFyBgJjnJWvokiUuxx31nRuuPCwZwc1QPvpFnDbkBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hPY2SZY3pw+tH1PFyKjN+WMT8umXyzn8YPJspt4RMqIwBibH15L5lhZv1nWk7wrlz
	 Drz9YJko/dh5TPipBCtHUMNdbSc1RoX/7f1WTJU85a/5hCLgeXxDlLsRBCwWcA6AX4
	 HchoHxoHispdar4/rQIX5hHO8iMl/yxUwZtrUM7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgH0RfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgH0RfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:35:09 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA74C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:35:09 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y26so3373904lfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BC/JcdsJrh7D1baGdsMISOmKuvWwQO6PTtPOyfbkKo=;
        b=eCSI0FOCZRGoIZSFsgWImch53XxylRdRW9nBxdCujM9/5e9Icmd99didgqiTQNpgqR
         sKrz0tsPtlMub2w7SYON4tyaIZXXNlhBhfBuwtSxuJO7vV+6HrKtKFS4DbuKiBlL7msf
         NRDW5/K/GBZxy0t/NmYf5fzKOw12bYm48anO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BC/JcdsJrh7D1baGdsMISOmKuvWwQO6PTtPOyfbkKo=;
        b=AR4/hMvINPojaYBgVWqMMwqvJzEcPXq5RP9tID92/IIcehFprHIKgrh11Z4feIi7ls
         f26RjqAJVKqNJpsz1X5Y7wdhOH+CMJHO3xEw+2w6R7/tGPKsPnvWx4AzCwyosQgNyZfL
         57OMnEKyL5JEkSSFOhcBqmPvHd09ZMM3ga0Ay7ktuKQP/hWbylcCysx8jJZXjSoIMTnJ
         tNoeEO5xVsBNltJ4UBq+NmpVpSfBqDl8q4xv5nweqjaiywK3T3uIvmgmso+TnpfgLsi2
         ltiF6Hd6rDA71XH/k06fv5cErLrKzBkFd62vCVciOhZkguHTopK9IkO8KH/beXMHWUaA
         1ySA==
X-Gm-Message-State: AOAM531I7+h6Ohkp3nFuJcxm9K3XOzy4sHSTFpUxcW0OCZIzqgxVU80f
        W3/1bcBJdjuybd++fnBfC2uJBqD8ZRquxA==
X-Google-Smtp-Source: ABdhPJz2/sYqNllxdyJ6TUK37FoS+mqo5821eHlb7FE95FdowzJEBTCMwmg6t4z4K8tNtTDIJLhCAw==
X-Received: by 2002:ac2:5683:: with SMTP id 3mr10316797lfr.69.1598549706602;
        Thu, 27 Aug 2020 10:35:06 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id f12sm354229lfj.50.2020.08.27.10.35.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:35:05 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id x77so2348449lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:35:05 -0700 (PDT)
X-Received: by 2002:ac2:58db:: with SMTP id u27mr5435779lfo.142.1598549704843;
 Thu, 27 Aug 2020 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <202008271145.xE8qIAjp%lkp@intel.com> <20200827080558.GA3024@gondor.apana.org.au>
 <CAMj1kXHJrLtnJWYBKBYRtNHVS6rv51+crMsjLEnSqkud0BBaWw@mail.gmail.com> <20200827082447.GA3185@gondor.apana.org.au>
In-Reply-To: <20200827082447.GA3185@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 10:34:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
Message-ID: <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
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

On Thu, Aug 27, 2020 at 1:25 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Interestingly this particular file fails with those options on
> gcc 8, 9 and 10.

How are you guys testing? I have UBSAN and GCOV on, and don't see
crazy frames on either i386 or x86-64.

I see 72 bytes and 64 bytes respectively for chacha_permute() (plus
the register pushes, which is about the same size)

                  Linus
