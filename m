Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D90AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF3020671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589481351;
	bh=DBsRMjvUPnOqCsVmwYL6jya0KCwKQ1zQUIs0BXYW/7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LkTtwvRTy+pAbKi9F63Au5Lvw/cEImTVeDvqMCBm53vHj92vOixIS/yEw2vyOrXAc
	 Q6yvF4wvAdR6DNHnmRUuSub/tZfJjGbIULayppn85sibOHZqbYuIneAr5JucquXpcE
	 7+xeI1gXQH0jc7socymriQtVYqpDYnIo9bDvwgbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgENSfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbgENSft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:35:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73071C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:35:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so4624572lje.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8s6vDtxuT5olw4UM6subAP86ZwrBjNzAYmJbIDfuCY=;
        b=fgXSyf0fckO2ltX2VwxVKikMBMpglkxCARZIOKyOtCiQEL1TZcg5HkOTZ7ySmrB5lf
         vxtWHU+nchNF+ANnp3/v2fvqljvpOUtBHt8c1vuR/sUKXTr4DIiUH0HGahhYay5c/baU
         zDvjpcHNIg9W0KMF+jl0GQxZzhQhzGtTu+sp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8s6vDtxuT5olw4UM6subAP86ZwrBjNzAYmJbIDfuCY=;
        b=Cc+z4LCQ7+jmidjMA33ebdxvl1M1cPSezik96zouB7d+cFTsH86YIesNFCxH5NjJnN
         ChJFI1cfzG9Py7c1m/1gcmk9rXyfRx5UQS5mlEM1gpaieCQzZpjqKjpIcD/Sc7ubFeWn
         RfNJk82UKYQ8Vx5qEvCN5br5UE/MgcKvjJGOxLGpXR6pZzuHqC48uiIii/DFtRUk7q7W
         op2rdOUMGnSzcGyUEeC/O218BiMdUQItNB166MakRBCNP0H0HS9bUcGyienOVZOfEP6X
         GZ9SeFcf/8VH5YxFPVwnEHfTerPVu/gMljGbesg+uUWK/vdss+2Jpk35Kji4gGYotASP
         6PBQ==
X-Gm-Message-State: AOAM531Y+5dhON9NcsD6g2oSLyxuTXf7j756xhbGKnDBLXEXIquJKG0p
        iqjGvcSFZhyt0HR5Jv7dLfr+090fzqE=
X-Google-Smtp-Source: ABdhPJzUN7P/v+ThA8iOb+xMr3oIzqkEuXZI8+sbSpMlJgSR4+kQjZ5L668wyf0mJk3h2m/ePjW93w==
X-Received: by 2002:a2e:a40d:: with SMTP id p13mr3569238ljn.183.1589481347437;
        Thu, 14 May 2020 11:35:47 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m3sm2082056lfb.30.2020.05.14.11.35.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 11:35:46 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id h26so3507317lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:35:46 -0700 (PDT)
X-Received: by 2002:ac2:47fb:: with SMTP id b27mr4273082lfp.10.1589481345738;
 Thu, 14 May 2020 11:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
 <CAHk-=wjpb-h9Z6O6o_7GkqCV1N-qQhagVJxpYZurYQR+eLkuEg@mail.gmail.com> <1C5DBE84-3E8F-4478-8188-8A09A527B195@ubuntu.com>
In-Reply-To: <1C5DBE84-3E8F-4478-8188-8A09A527B195@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 May 2020 11:35:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjET6Hu50QbnPA+khx8b7hPsZ2bWXmpgA7Ljc6kg8iO-Q@mail.gmail.com>
Message-ID: <CAHk-=wjET6Hu50QbnPA+khx8b7hPsZ2bWXmpgA7Ljc6kg8iO-Q@mail.gmail.com>
Subject: Re: [GIT PULL] thread fixes v5.7-rc5
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 11:22 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Seemed weird to me to change something that's been exposed to userspace for that long.

Well, the internal declarations aren't actually "exposed" to user
space - it's not like it's the declaration of the system call, that's
separate.

And we have done that before: we have had a lot of history of using
"unsigned long" to basically mean "register", and then ended up
cleaning up types afterwards.

In fact, if you look at the macros that do SYSCALL_DEFINE() (hint -
don't actually do it, you'll go mad) you'll see that magical
__SC_LONG() thing, which actually declares _all_ arguments as either
"unsigned long" or "unsigned long long".

That's the "native" representation of the low-level system call (it's
also marked "asmlinkage" etc).

We then end up casting them to the internal representation with that
__SC_CAST() macro.

So the actual types that we get are intentionally "cleaned up"
versions of the raw registers that were passed in.

But you really don't want to understand the __SYSCALL_DEFINEx() macro.
It's clever, but it really is the Cthulhu of macros. Just looking at
it might drive you mad.

                Linus
