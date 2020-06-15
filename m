Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BF8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38378207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592259835;
	bh=mWOQVJPGYYQg8n/lCcNEsMyLRpJg8N9N6HSGt6zx+u0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p2UpNmzPt2PVADxpEH0L3vcomTzQYeCs1gG9HN4Cd+eXGsS67FFP5v/eJEW8Maaqp
	 W6SJe5ScNoByTjfFlTm7FIrGmf5eYXks7KITjj27WPgG//kIxYVWyQSj6NDaj79NzF
	 mo+S5A/vM2S7dp5jsJ0LRvc4dbu9Z07v8wZ9t/Yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgFOWXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgFOWXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15560C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:23:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so21110013ljv.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fmb9LbkW00jXn2iCA2oMUh0qcJ6N12lt1xDN5WwkwPk=;
        b=X5oA5ZkI6BmYRo4G5tjAU7J1NaMnr5CZsGfkdzLhi7WbZ11gomiHh/T2MuSk2Lhkg9
         v9D27QyUcwnm/E5k9nB+xI80JwHC2OAGJSEPxGTzo+TOedfzm82cbpySAeDY8Vf+Sfj7
         lksbb23BPujdX2vOVAmYxKtIvmyJZfE2ie1VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fmb9LbkW00jXn2iCA2oMUh0qcJ6N12lt1xDN5WwkwPk=;
        b=Dpumt4OMvA1xhMKu2w33TL3mTHbK9xT/dNWwIbSZ6bRRD+xaB7SEkTBay8b2JNz7lp
         Nn9unh8QyoUIzk4KiP6dLLWJRxQv6ux9YThn0amff+nuoS2g8XY+twEkKGsD1TTcIePn
         AAxl/fVOU27olK/AYVpaFN7JkAe+Ya4ZCn7FlcZzmBprHUQNeLfZGBD1/Md5bhYkk6Af
         +F9hmwwIA00jnCuuuZOuSjKnrCymhGTwWdZtGNrygY3hlzk5qN1+GE2nDpvKf1uxm/ZL
         Ls4f8nmLSL9XibfR4xl0vWyhtG4UV62kOpLpnGWHq8eWbIQPRNPdyN0IRxFIZIwWs3rt
         qhCQ==
X-Gm-Message-State: AOAM531LEmL2lRhBgEewXfYKHuTBKjQaFf8/62Wj7f9vyIvX1rNd45Xb
        NTAQIq5GtS4k6nt2CU6NCajxbwZeKlk=
X-Google-Smtp-Source: ABdhPJw2Mzw5R8/dLUpIqssn7Wij9J1Q6CZ/lOK38apgNw2NZib4UVW7jXX1E0NpEbXJd/+sUQWq+w==
X-Received: by 2002:a2e:98c2:: with SMTP id s2mr13981070ljj.288.1592259821607;
        Mon, 15 Jun 2020 15:23:41 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a1sm5718244lfi.36.2020.06.15.15.23.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 15:23:40 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id n24so21081344lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:23:40 -0700 (PDT)
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr13634729ljj.371.1592259820216;
 Mon, 15 Jun 2020 15:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
 <CAHk-=wjmZzz6b_9iBGp+3Nysb0A6_3VatmUdr_ArgyqHq0KMcA@mail.gmail.com>
 <f5102546-786d-eb63-10c5-97a92c0be311@linuxfoundation.org>
 <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com> <c35745bb-5700-f6c8-ae5b-e931502cb270@linuxfoundation.org>
In-Reply-To: <c35745bb-5700-f6c8-ae5b-e931502cb270@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 15:23:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_d7dqoC40M9AvU3g8v0AtexV-rMLDkvkiQQCU1TnHGw@mail.gmail.com>
Message-ID: <CAHk-=wh_d7dqoC40M9AvU3g8v0AtexV-rMLDkvkiQQCU1TnHGw@mail.gmail.com>
Subject: Re: Linux 5.8-rc1 BUG unable to handle page fault (snd_pcm)
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 2:18 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Yeah. I should have thought about adding module path. With module path
> added, I get better results:
>
> [   15.341267] ? snd_pcm_hw_params (./include/linux/string.h:391
> /home/shuah/lkml/linux_5.8/sound/core/pcm_native.c:759) snd_pcm
> [   15.341272] snd_pcm_common_ioctl (sound/core/pcm_native.c:792
> /home/shuah/lkml/linux_5.8/sound/core/pcm_native.c:3210) snd_pcm

Yeah, now it gives the complete path and you see exactly which
memset() it ends up being, ie it's that

        /* clear the buffer for avoiding possible kernel info leaks */
        if (runtime->dma_area && !substream->ops->copy_user)
                memset(runtime->dma_area, 0, runtime->dma_bytes);

Quite often  with all the inlining the compiler does it can be really
hard to figure out where things come from when you just see the symbol
and offset.

Ok, in this case there aren't that many calls to memset() in that
file, and it might have been obvious which one it was in this case.
But sometimes they just come from various inline helper functions too,
and when automation can give us the answer easily, it's the thing to
do.

> > Maybe even just a warning about lacking a module path when there are
> > module symbols present?
> >
>
> It does tell you the usage.

Yes, it's more that it's very easy to overlook it, and then get a
partial decode.

Once you know how to use that script, it's very convenient, but the
problem tends to be that too few people are aware of it in the first
place.

                 Linus
