Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B39820C09
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Q9Ew4Z8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgIGJ7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgIGJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:59:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA6C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 02:59:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so13584281wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5DC9nZOly/sIshwJMs/T2M9xGwEixaZIQAAMhdaTd8=;
        b=Q9Ew4Z8qiML0wcPyFpDAyE5dpHUOzyp540W51+cevWVCR86uUG0WM3UoGPOMrCzrdY
         i/B7wUL9G6iwwXzGVL/bq31OOpMm5DJ4n7oJjbejnbb6QKktJfkHIfpjtO2AEy3gYx4K
         pha94kU99hLIeq4c++tfUtg939fZT2efkzPxuPOHILGi7ci1b8AKeLHuGUwARbudSFpQ
         m4FC4mUwYNIa5u3RD0ksuO6SvW7DrJDrm0MjqM++v+OWPvqQ1TLmyVLX79NCB4kfuMzL
         iUeShqpbB51uBhrAXG2J2zDHW2aECCHGqzgHOaj5hGsnp8D79wCGgDOyp0mQs4NXBuqG
         Qk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5DC9nZOly/sIshwJMs/T2M9xGwEixaZIQAAMhdaTd8=;
        b=sG5cJpVduAy03ps3SYFR8KttAR97hpAYr041MMbl97Opfwhr1VlTPFSBOHRYkG6Oqb
         oDFRJJQQioh2C4//gMDU90jINxDpLMn/igVTrL5iIGy5puSKY8xmzbt6oJpQFW+HVO00
         G2xAJrYRSml0TScI/La8maHA2LnVRSeiHhTQIk0IHUYPZemKE2fs73Bd7JoJrKu9UmT9
         EsNgECTe75aDsvQNZaf/oxMgX/9Xr5SdSWBiAwtMOJ3sarAee89K0+TXaDF3XS6JJxjU
         q9Kx0zrjigv6TLf5I7/ePEtKrK+tKXWOPtpuGGg5MNkSzxTOMmguqYKmXDiOA5g7J+Q9
         WPJA==
X-Gm-Message-State: AOAM530YeOtxwssRvAV4LodXC9RpwVGVH24333ZmJKQMEP6hsUEFpyVE
        xbJ+5gRcpcA7Eu6jLcL3GPdLPfYYnDHFeXC05WLQkg==
X-Google-Smtp-Source: ABdhPJwhbVezkRsz42O01tI11rDfQ+ohnilrUWZNMj/Kyt92DMYI2Orkgg8RVLqJ6axE6DSFZmH263z4x/rqWD9gKAw=
X-Received: by 2002:a1c:234d:: with SMTP id j74mr19248120wmj.157.1599472756116;
 Mon, 07 Sep 2020 02:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200904165709.GA32667@lst.de> <mhng-5249e999-3e82-417d-8d39-dcb4a159bd83@palmerdabbelt-glaptop1>
 <CAAhSdy0HW8Rjyoiu+Ldx31C9zCBdxJZxhDBcXC4sgitfXnPNDg@mail.gmail.com>
 <CAAhSdy3ESD6L_T1rFprDF2jduN8buTz173F6_mYCbTL3s4RG2A@mail.gmail.com> <20200907061853.GA19038@lst.de>
In-Reply-To: <20200907061853.GA19038@lst.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 7 Sep 2020 15:29:04 +0530
Message-ID: <CAAhSdy2QkjZXzDBfLpu_Wtn8wWJ+pJSnUiyS+e0e4vtrJ2MWoQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Allow drivers to provide custom read_cycles64 for
 M-mode kernel
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 11:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Sep 05, 2020 at 11:05:48AM +0530, Anup Patel wrote:
> > Your patch will also break if the SOC specific timer has a 32bit
> > free-running counter
> > unlike the 64bit free-running counter found on CLINT.
> >
> > I guess it's better to let the SOC timer driver provide the
> > method/function to read the
> > free-running counter.
>
> Seriously, build the interfaces once you know the consumers.  Don't
> build pie in the sky interfaces just because you can, because that
> is what creates all the problems.
>
> And of coruse at least for IPIs which absolutely are performance
> criticical we need a standard interface (one that doesn't suck as much
> as the SBI detour with the four extra context switches).  But I guess
> I have already given up on RISC-V because the incompetency about things
> like the irq design are just so horrible that it isn't worth bothering
> any more.

Most of us are aware of these issues. The SBI IPI call will eventually
become fallback option once we have standard mechanism for IPI in
RISC-V privilege spec. Until then we try our best to support all existing
RISC-V systems out there. This also means we end-up supporting
existing SOC specific timers and IPI injection mechanisms.

Regards,
Anup
