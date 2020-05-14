Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4169C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE81205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUMdlYCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgENO7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgENO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:59:07 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28985C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:59:07 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id z3so183994vka.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ohk0V2iv8WXluqT4a/dc+052339R1E3HbtbkJsHkJdE=;
        b=oUMdlYCiiJrqr66AwOBu6R4rnCgvffli4veTqNb8Kt9I25XuzpNZjNLGWAfywRe853
         85rFie4TaGITV1M3xdxmRJyDrUExFHvD3dTN4R1bq04jJu9U5XElGi7C+Sv2sOjGDY3G
         CQJbnwymk2cFpDrtnUFHEd2bD7HL+wd/FfzxvgHsMMXHYjPGJkv7bkt8P5oVfPaA6urf
         vSBsH/28ZpIxetkY5CgzVo+dbnqJgw5GcINsCY1+v3akDSOyazACJdJk8i9BDL7BQqry
         NtQLkBe3N870ck3+B2I54ydkp9bf43rTtwT4HBGlc2svJW+PNyZmHusCQ5IrGWMUJZ++
         shGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ohk0V2iv8WXluqT4a/dc+052339R1E3HbtbkJsHkJdE=;
        b=eQQLJHoMeMn10UZD7+9vi2qM4waUPI+mcwCXe/5deXnxjDBq43sHTNC5AXJwAK8Icy
         1mXaE52EjDBfbmWd+uCFY5JypQLvSXxTW9Fqeap2FjHecq0v34+Ku2/6zw7s7awdTUJ4
         cvXubt9rNbtcKTfyXMfbN2MFeJZI0uMydpxlPvFUY0k42J/lLZ2QEhCw2dOb1cSs1+Ai
         Q21o1lnGzamUB2KsDbN3mMrgPfeBtNr/NyFYlJs4fHjJW3OxmuqEqiyilNKsd7epo+Kr
         AzcHVQs7fKzPdLbpOPBc++uYL3cySIGb8KiUpnVulO1WabV/ZN72cKM0VxT5Z9oG0X2A
         uCNA==
X-Gm-Message-State: AOAM530bebkdENvaD9RW4kxPyVCpDsPbn3VyJRnIzTckVzvpvcHBsfHF
        8c06gT4Ah46ExJLjhvUvNOKpzHSii5gTsau/SgPCAhmXbSI=
X-Google-Smtp-Source: ABdhPJwIq8TzwnoDCHVb0jakGsWAHn0tB5/baTOL+wJfrPwsPYsDaQRGlojFSV1LcYDjlVf/Ldc+My22PEzxg3+615Y=
X-Received: by 2002:a1f:24ce:: with SMTP id k197mr3849506vkk.13.1589468346233;
 Thu, 14 May 2020 07:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200513220204.1366296-1-lkundrak@v3.sk>
In-Reply-To: <20200513220204.1366296-1-lkundrak@v3.sk>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Thu, 14 May 2020 16:58:54 +0200
Message-ID: <CAH9NwWe1thOazGoGidKS_F_CajmKTS9qb7wfH+ST-1YBgAeHow@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: Fix the pm_domain lookup
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir


Am Do., 14. Mai 2020 um 00:02 Uhr schrieb Lubomir Rintel <lkundrak@v3.sk>:
>
> On a GC860 (both 3D and 2D capable) GPU, kmscube crashes:
>
>   # strace -f ~lkundrak/src/kmscube/build/kmscube
>   ...
>   ioctl(6, DRM_IOCTL_ETNAVIV_PM_QUERY_DOM, 0xbe92b720) = 0
>   ioctl(6, DRM_IOCTL_ETNAVIV_PM_QUERY_SIG <unfinished ...>) = ?
>   +++ killed by SIGSEGV +++
>   Segmentation fault (core dumped)
>
> And triggers an oops:
>
>   8<--- cut here ---
>   Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   pgd = 40e2c0f7
>   [00000000] *pgd=0df6d831, *pte=00000000, *ppte=00000000
>   Internal error: Oops: 17 [#1] PREEMPT SMP ARM
>   Modules linked in:
>   CPU: 0 PID: 346 Comm: kmscube Not tainted 5.7.0-rc4+ #792
>   Hardware name: Marvell MMP2 (Device Tree Support)
>   PC is at strncpy+0x14/0x30
>   LR is at etnaviv_pm_query_sig+0xd0/0x104
>   pc : [<c04f35f4>]    lr : [<c05dd878>]    psr: 20010013
>   sp : c85f5e00  ip : c85f5eb5  fp : beb58748
>   r10: 0000004c  r9 : ca6f9100  r8 : c85f5e6c
>   r7 : 00000050  r6 : c85f5e6c  r5 : 00000001  r4 : c0b69ae8
>   r3 : c85f5e75  r2 : 0000003f  r1 : 00000000  r0 : c85f5e76
>   Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>   Control: 10c5387d  Table: 0df70019  DAC: 00000051
>   Process kmscube (pid: 346, stack limit = 0x816fba31)
>   Stack: (0xc85f5e00 to 0xc85f6000)
>   5e00: 00000000 d90e6000 00000020 c05d5b2c c85f5e6c c059ce90 00000000 c1003f88
>   5e20: c04c644b 0000004c c0b69610 c04c644b c85f5e6c 0000004b ca6f9100 c059d0bc
>   5e40: 00000001 c0d53ee8 c85f5f18 00000001 c85f5f50 c85f5e6c 0000004c c8454240
>   5e60: c05d5b2c 00000051 00000000 00000000 00000001 00000000 00000000 00000000
>   5e80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>   5ea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000274 c011c3fc
>   5ec0: 00000100 c0290434 5ebc5632 30e03501 5ebc5632 c8526600 00000274 00100cca
>   5ee0: 00000831 b64c5000 cdf72d90 c1003f88 00000000 c04c644b c8454240 beb58748
>   5f00: c8454240 00000006 c85f4000 d90ecad8 001c01a0 c02d49ac b64c52cc 80000007
>   5f20: da9d6dc0 d9aa4000 d9aa4040 00000000 00000274 c011818c 00000005 0e200080
>   5f40: 00000000 000003e5 00000000 00000100 00000000 00000000 00000000 cc78ac40
>   5f60: 00000006 00000007 c1009a98 b64c52cc c85f5fb0 c0118080 00000080 c1003f88
>   5f80: 00000000 00000001 beb58748 c04c644b 00000036 c0100288 c85f4000 00000036
>   5fa0: 001c01a0 c0100060 00000001 beb58748 00000006 c04c644b beb58748 0000004c
>   5fc0: 00000001 beb58748 c04c644b 00000036 beb58748 001bd688 beb58700 001c01a0
>   5fe0: b6f41f08 beb586d4 b6f2784c b6e16cec 80010010 00000006 00000000 00000000
>   [<c04f35f4>] (strncpy) from [<c05dd878>] (etnaviv_pm_query_sig+0xd0/0x104)
>   [<c05dd878>] (etnaviv_pm_query_sig) from [<c059ce90>] (drm_ioctl_kernel+0xb4/0xf8)
>   [<c059ce90>] (drm_ioctl_kernel) from [<c059d0bc>] (drm_ioctl+0x1e8/0x3b8)
>   [<c059d0bc>] (drm_ioctl) from [<c02d49ac>] (ksys_ioctl+0xe0/0xaf0)
>   [<c02d49ac>] (ksys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
>   Exception stack(0xc85f5fa8 to 0xc85f5ff0)
>   5fa0:                   00000001 beb58748 00000006 c04c644b beb58748 0000004c
>   5fc0: 00000001 beb58748 c04c644b 00000036 beb58748 001bd688 beb58700 001c01a0
>   5fe0: b6f41f08 beb586d4 b6f2784c b6e16cec
>   Code: 012fff1e e2422001 e2403001 e080c002 (e5d12000)
>   ---[ end trace 387aad33cd9c15ea ]---
>
> Turns out that it's because pm_domain() returns a pointer outside any
> any of the etnaviv_pm_domains. Unless I'm mistaken, the algorithm in
> pm_domain() is entirely botched when GPU's features match more than one
> domain. This tries to remedy it.
>
> Tested with kmscube with mesa 20 on ome machine with GC860 and another
> with GC2000 + GC300 pair.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

There is already an older/other fix for this problem:
https://patchwork.freedesktop.org/patch/365181/

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
