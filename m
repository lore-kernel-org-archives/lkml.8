Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7D6C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D622073B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOEoiFED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgEaSgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaSgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:36:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7780C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 11:36:23 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so6086981qtb.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uFiZ3vtvfGZJXTiSVbH/Y+78uY5VsPnJrnelVPcyHfw=;
        b=dOEoiFED9OGciRtrneAKaixHl3Fd3L8r26kFmzq0F9+VZ/waaN2/fgbjq3vgdj/Kv6
         9AtKUFMbTMJ6IBTIVAuolmMbihx3tcitrXFASu1XfGu8wzsM2ICBHeW/9iRj4Si1iF7h
         ohc5qAZ4i1ZZrSb8cPjuoezlD/lOo5p5lgOnEVaT09mqWTq8XTgQG8mkkO7X4V/Z5j6O
         OSDTDtPUPFrrziHJ0Vm8h2VeMUDtunH+KyRyaJTxqtssYNw+95DEDvHWGF4oXZZwXZBF
         K4DcbGPYY4zJRhGRSwFjeFP9XKNMp0V3qe2PuwnWBEgav6IDl7k9L8lgQNcTTX+1CqQN
         tyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=uFiZ3vtvfGZJXTiSVbH/Y+78uY5VsPnJrnelVPcyHfw=;
        b=kRxlstW6Dqxu2C5InORzsym1XuuLVXsopE6Jgs45hN+osDo1dVWJwChZs5pnb2uMfB
         JEAxSL4CZZCCeOxyvDsmd4SL+Jlvhx68602nNlL7L8y8O6FbXoWyNRXbbZIG3s1EZ204
         S8QJ2du72w91B6HOno9l4MBfBY6qWFp+NxB+GAzhe4nj4DBfI8fVVVw/kDbmzOwmQmau
         vLcZUs6gvuwJMjLUg6ciiPy5dbfcDrEWPUtaIehyQL8UJhG7c1XRmkR+fHdjpUrjSudK
         Av8RbE0HTVKGm+8Xe4OE9CjVEDUAFmKcUAXKt7oQlzQ8p/q/91EkPPtsSAARBULuM/Vy
         odCQ==
X-Gm-Message-State: AOAM530Q1XOEecKMYBTjEsFzT81QUwwfE0EwP1DceLz/2e7w9h3kS2t9
        v+cmNF00y8jxcrisHjNUdUQ=
X-Google-Smtp-Source: ABdhPJx5AImyHGsIBqFapJez5iwuWtAurk44RdAkD/S8cnUZvhf5fZ6F4qUGaVj9lJkAn16D4mZTTg==
X-Received: by 2002:ac8:312e:: with SMTP id g43mr18335367qtb.308.1590950183016;
        Sun, 31 May 2020 11:36:23 -0700 (PDT)
Received: from [192.168.1.62] (89-178-168-199.broadband.corbina.ru. [89.178.168.199])
        by smtp.gmail.com with ESMTPSA id x66sm12824922qkb.33.2020.05.31.11.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 11:36:22 -0700 (PDT)
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory
 areas
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <85367hkl06.fsf@collabora.com>
 <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
 <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com>
 <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
From:   Paul Gofman <gofmanp@gmail.com>
Autocrypt: addr=gofmanp@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a14be8b0-a9a2-cf96-939e-cedf7e0e669a@gmail.com>
Date:   Sun, 31 May 2020 21:36:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/20 21:10, Andy Lutomirski wrote:
>
> That's not what I meant.  I meant that you would set the kernel up to
> redirect *all* syscalls from the thread with the sole exception of one
> syscall instruction in the thunk.  This would catch Windows syscalls
> and Linux syscalls.  The thunk would determine whether the original
> syscall was Linux or Windows and handle it accordingly.
>
> This may interact poorly with the DRM scheme.  The redzone might need
> to be respected, or stack switching might be needed.

Oh yeah, I see now, thanks. Sure, we could trap every syscall and have a
Seccomp-allowed trampoline for executing native ones with the existing
Seccomp implementation. But this is going to have prohibitive
performance impact. Our present use case specifics is that vast majority
of syscalls do not need to be emulated, they are native. And just a few
go from the Windows application which we need to trap and route to our
handler to let the program continue, while we do not care too much about
the overhead for those few. So the hope was that the kernel can route
that majority of Linux native syscalls inside with the minor overhead.
I've read the suggestion to use SECCOMP_RET_USER_NOTIF instead of
SECCOMP_RET_TRAP, is handling the trap this way supposed to be much
quicker than handling the sigsys from SECCOMP_RET_TRAP? More
specifically, would not SECCOMP_RET_USER_NOTIF effectively serialize all
the syscalls waiting in a single queue for processing, while
SECCOMP_RET_TRAP can be processed without exclusive locking?


