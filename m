Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A46C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CD1208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Cy9AQ+Vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFQPa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgFQPa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:30:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3342C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:30:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t18so2799684wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T1golDGZEJrES9AECIsgNd7Q6JCPqXWMnBLVGHcf590=;
        b=Cy9AQ+VyuP+0qd3hAJXxGuFHnwH6wTe6yGx3stzIDULpYoHeETmSe6ztIZ0QFNuhzh
         YP0Y5w4Nr7NQWaYetHLA3x5TpRKrZUOPHhXDrr4Ml9Hk79RfDHNTQmReKnoJwvLCNlbH
         aE7uJEsPUCN7xeKaG3NwZhQnLisqpQkJPTjeC5lYiW6C/3QDt5WERlGD+L86OyJh81w3
         VmQIJAx6UCxqkPOGnUAVo3CLCCzporsc+x7XqpMHVLxuo3pfgRAKK1P9FmtkIhrulvbK
         n77VSZKxF82bf4d8wwvkbMAmzSqd55/XaMVBtqcXtq/EWwc1FPIIPLmQMYFsmqtZMU/+
         kQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T1golDGZEJrES9AECIsgNd7Q6JCPqXWMnBLVGHcf590=;
        b=TDvBambQJcat6OT3ptK0y6USjPqe7zgmxJtMWv/pKVsUf2grkRgO4kqrKtbjoEOui9
         vn348DOFuQdc0rVE7QBti9TbGyW8IUxGCPjjUb8y2uOoPcwK81iI1KbLzfXzW2s0b6fR
         b/ig/asrV+FPNdbxuolCOsSXQmzYEhzHcQzT9PXG+ArKU12dC000yMMY4vXkx9z4TBZb
         iEBaiZ0YqpAfmckNtXB4Z+iKtQGC14Sj0nM6oaW3UvjFKLpOsZI8RF715ooFNTFqavbF
         HZ2Del7LC1JwBVn9aVe4d3Y7kkHLQYtvLQDs3Gh+Yt+pEnGgedDpRNZO9CZuZsXENRtj
         uLew==
X-Gm-Message-State: AOAM531GHDnfNF/bng5ON9qFgqZnb4UzPNV3nv8dRLVpLC1HOg3Dro71
        roYTEYqfT8gD848gasUY0ijqJBvMIbSpEj8qEwnUh5P5
X-Google-Smtp-Source: ABdhPJx1leEQgVWctKmCa/D6EkrZVGOfU6KqG3T04Q4mFyuD4yVz4mr3sUf75jtyyVPFIBxK3K5x1JlNNJc7+cWRW90=
X-Received: by 2002:adf:e908:: with SMTP id f8mr8987215wrm.184.1592407853534;
 Wed, 17 Jun 2020 08:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200616180123.GL13515@zn.tnic> <1D569B6B-B8C3-497E-8A74-2E1A3D46299E@amacapital.net>
 <20200617083314.GC10118@zn.tnic>
In-Reply-To: <20200617083314.GC10118@zn.tnic>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 17 Jun 2020 08:30:42 -0700
Message-ID: <CALCETrXQB2ZuDno1E70spamt30ix3kf8gShdNCM7Ua3xqWbZdQ@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 1:33 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jun 16, 2020 at 02:17:16PM -0700, Andy Lutomirski wrote:
> > We definitely need to sanitize MXCSR for kernel fpu if kernel fpu
> > means SSE2. If kernel fpu means x87, we need to fix the fpu control
> > word.
>
> Bah, there's no need to beat around the bush - let's just do:
>
>         if (boot_cpu_has(X86_FEATURE_XMM))
>                 ldmxcsr(MXCSR_DEFAULT);
>
>         if (boot_cpu_has(X86_FEATURE_FPU))
>                 asm volatile ("fninit");
>
> and be sure that kernel users get a squeaky-clean FPU.
>
> > On x86_64, I suspect the UEFI ABI technically requires a clean x87
> > control word too. If we=E2=80=99re willing to declare that the kernel p=
roper
> > won=E2=80=99t use x87, then we could shove that into the UEFI code.
>
> Nah, we don't trust the firmware.

What I mean is: if we trust ourselves to have no x87 instructions in
the kernel, we could put the FNINIT in the UEFI stubs to save some
cycles.  I don't know how slow FNINIT is.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



--=20
Andy Lutomirski
AMA Capital Management, LLC
