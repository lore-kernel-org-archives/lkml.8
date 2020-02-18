Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD640C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6E52464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582054744;
	bh=rPalsf9ZeS+tRDrXzRVQK0Dn0SDTdPYKYvDItHJ5xGQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OnptlY1dvQ81Y4cNGw3+pPxVe0Yl9HOvqeNKbJjX8/LiQQBc5OVDtdGqRydLY5bQ1
	 UMdybSfCwOd2hssxXcMjYkitXB0GvO8OE+1W3KoftYj8D04MHOvlIBPU902V1Cd5mY
	 4ruAuDR9jAHxwMwzG5aF3uA1+bl5+CNcLTb2f5Xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgBRTjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:39:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42963 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:39:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so24371767ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CZVPOdBOz9oqPt50DFcOS2FFpkbcLimq03cuRtqGXPA=;
        b=Xi2BST5TLRjQNTfbbkSbh6qaVoOZxo9wA4E6heEAZZLJ8lCI0RYUW0O3V3Ddaqw4Oe
         o+B9hvNSpADznWAJR0EE8cpmhP3bLlzMcSp84VDzu+PjQO3HlAfDZGDpTLi2JDkD5jFK
         AXBsp3XZOAgj/bXQWSuhRhswXAHyU+64Xo3kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CZVPOdBOz9oqPt50DFcOS2FFpkbcLimq03cuRtqGXPA=;
        b=hTT3lNC4kcMnkaJpDfbXmySx1adNoLYVDyMkwXyVd5s4bb2sPxRMhC7NWpZXfp6bYF
         +NKfVgGoEhHCHWXB1WI4OAFD8GCnGS2A3guqOcRHunyAiH84i8C1iTrlJJixWQYWgmFF
         Bl4EEKep/jbsxDiOS33aQmqetwDf1JdKh794BnbMvF1YSlybCJLl/BkG2xr8U7jamLDy
         Zb7NUkgl0mcIFBDcp+RLWtw9rG4si8R0tUqavuKXQmrMYoi5ciZ9eocqdACYq94a4ZO9
         Z4nUrBdx3KyNJlxWsJ/17o9THir0orCHmplVs/oqTwBBbRlsnrghfb2DShqR9YNtDpDP
         U+9w==
X-Gm-Message-State: APjAAAWmRxSZ37Wy3Azc+RsmscajCjQLVbtE3zb2Npf1Jwmzw4h88PRO
        1hYANWnLvw+leWj5DxEgi8L1U8P/B7M=
X-Google-Smtp-Source: APXvYqx2TSu6SOa01i7vmG4QsdmPz8TXh/8Vgc+2y6Wc9K+6k7WO8vEZWA/vK2Uui+tAg8OPfZZ6dA==
X-Received: by 2002:a2e:e12:: with SMTP id 18mr14184950ljo.123.1582054739904;
        Tue, 18 Feb 2020 11:38:59 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y7sm3047714ljy.92.2020.02.18.11.38.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 11:38:59 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id c23so15402319lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:38:58 -0800 (PST)
X-Received: by 2002:a05:6512:78:: with SMTP id i24mr11588487lfo.10.1582054738541;
 Tue, 18 Feb 2020 11:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20200217222803.6723-1-idryomov@gmail.com> <202002171546.A291F23F12@keescook>
 <CAOi1vP-2uAD83Vi=Eebu_GPzq5DUt+z9zogA7BNGF1B1jUgAVw@mail.gmail.com>
 <CAHk-=whj0vMcdVPC0=9aAsN2-tsCyFKF4beb2gohFeFK_Z-Y9g@mail.gmail.com> <20200218193136.GA22499@angband.pl>
In-Reply-To: <20200218193136.GA22499@angband.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 11:38:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
Message-ID: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: don't obfuscate NULL and error pointers
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 11:31 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> Either "0" or "NULL" (or "=E2=88=85" if you allow cp437-subset Unicode ) =
wouldn't
> cause such confusion.

An all-uppercase "NULL" probably matches the error code printout
syntax better too, and is more clearly a pointer.

And with %pe you can't assume columnar output anyway (unless you
explicitly ask for some width), so the length of the output cannot
matter.

So yeah, I agree. To extend on Ilya's example:

                              ptr        error-ptr             NULL
  %p:            0000000001f8cc5b fffffffffffffff2 0000000000000000
  %pK, kptr =3D 0: 0000000001f8cc5b fffffffffffffff2 0000000000000000
  %px:           ffff888048c04020 fffffffffffffff2 0000000000000000
  %pK, kptr =3D 1: ffff888048c04020 fffffffffffffff2 0000000000000000
  %pK, kptr =3D 2: 0000000000000000 0000000000000000 0000000000000000
  %p:            0000000001f8cc5b -EFAULT NULL

would seem to be a sane output format. Hmm?

             Linus
