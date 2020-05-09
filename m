Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED3C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA9E1208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589066834;
	bh=h7jcx4RX12UAauOjjaF3CWWs8JN9JlTJ0E1MJWu2ZPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZmDW55Z0p+MdHIEly9wzmLJSC7+Pj/BhTrH+/MmFzO9qJ8D/RAGmF9IF7ERA+UegR
	 XilDatzS3GOthBZP6PrdGlv2WfTZCcQ2C2NUV4Yf0ncgAYvV4FdllKEDRv7StOMEsm
	 7Np3O5KnfIBOfv9WC5JouTViny2W5bqLlhmzd/Yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEIX1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725927AbgEIX1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:27:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9DEC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:27:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h4so5532624ljg.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/526PjPnbjCwilKm7RsHfW0Ne/bEDskYmPkox9dhVf0=;
        b=J6GSYDTxcjkpJ68uD/bLGdCa08JXEON68qGsC5jjDyX0dXL7P1sV4tN24W7cJuDQLu
         dwkQCm4gYLNybNoSpRZa/NEVgkvOibr6OUuJ757fJfSIhdWS/WQJ1IByySQn/0+kf1VM
         3/WoQH/EKw/gyZH0IBGeQF1jLOK27vvFeL5Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/526PjPnbjCwilKm7RsHfW0Ne/bEDskYmPkox9dhVf0=;
        b=WF4QN7utl/bclOfEOf8M3c4AYqFoKiIV9Jz3AlWxfIQzpph/bDlqkGL92Ai/FZaCjB
         Cpya2u4FrBKXgYs0v6KYUu15ucpjC5dBhH47XPtRVJj4djnVcmEGW4fuvKWAP61e3uwv
         t9aAQYGRfRO1eOt9gS1PuIWdGaNOIt9Rgduc/zFZBih8ztJ4O2sbq508lGUJvItcH9GM
         xKxHVIH++s1wZo52vmvqP67+U7G57xh6U5xms4EBlP+sv3By7qAvonlqKt+dmRzqOoup
         NKcizZmXdeTaDd2uLZzESIkZIg7JoCVCyMpYe7zVj34y4tFYgAcNqCZjR7WuOjktOQFj
         N1Lg==
X-Gm-Message-State: AOAM533nvQ0+yLkGSEMqCDLbw8quL2qSXJ8/IuFUxy6ET7MGod0R49s7
        /GqLw9OP4ezh23wIMHdqsoD7PL5mrtg=
X-Google-Smtp-Source: ABdhPJwefZjj0ZyF56diMTEgHkD5orv9X7Epx3LUdGMvV0e9aUi7Z6Ev+QfBO6iK2tVmMaX7B1GZsw==
X-Received: by 2002:a2e:8108:: with SMTP id d8mr5577330ljg.184.1589066830881;
        Sat, 09 May 2020 16:27:10 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p2sm5032261lji.40.2020.05.09.16.27.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 16:27:10 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id s9so4387407lfp.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:27:09 -0700 (PDT)
X-Received: by 2002:ac2:418b:: with SMTP id z11mr6301034lfh.30.1589066829592;
 Sat, 09 May 2020 16:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-81c83c19-6f5d-4ed1-a0bb-26accf4b7d3a@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-81c83c19-6f5d-4ed1-a0bb-26accf4b7d3a@palmerdabbelt-glaptop1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 16:26:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=win0EVU_GuO=GuJu3Ck0WG1B3+ub-CjncM3B1G9x5d9cw@mail.gmail.com>
Message-ID: <CAHk-=win0EVU_GuO=GuJu3Ck0WG1B3+ub-CjncM3B1G9x5d9cw@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.7-rc5
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andreas Schwab <schwab@suse.de>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 11:47 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> * Adding a note to the VDSO so glibc can check the kernel's version without a
>   uname().

Eww.

I realize other architectures do this, but why add it to new architectures?

glibc depending on kernel version is WRONG. It's bogus. You can't do
feature detection based on kernel version, it's fundamentally broken.

So I really would prefer to see glibc fixed not to do that stupid
thing, instead of adding pointless vdso notes to the kernel.

Andreas? Why does glibc care about that ELF note?

              Linus
