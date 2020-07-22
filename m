Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB53C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12F820792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="fCuEEXu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGVFqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgGVFqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:46:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B162C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:46:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s189so592414pgc.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=c3WKCCywdgvLGCz57S7am54sr0h7w7V/JrEMUHUMU/o=;
        b=fCuEEXu++BATZZEgu63jyhgE+Y1XNFfh/hfRTuYGDp7tRoc6LbkGOtZmRlJEX0Q4mc
         58Wx5DrHLgqWGA15ODfmp4BD+A6kqkaXmwBVAcQy7tZT4nC6LrgGJ3lzv06Ej9jur88k
         XGQBpKOytzyljGp9JTo/2ytrZBP2jJniHbB1MwjDRZhque2NwdZ0aWGsgryRqU+3DE9U
         m+vgwzNJSvheMii7MxNhJxPUYaZbP4XIj428wVkVonkWkFnWlNi3Hd/UlX/sByadTgHP
         sXR0VV6uQ74NOk6fTFxzR7f22jvf+xzhKswTeZHjL411qPbZeON+M2WgzsdrCjh868sb
         i6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=c3WKCCywdgvLGCz57S7am54sr0h7w7V/JrEMUHUMU/o=;
        b=jRkuC/v/F5Tj0AZz+3naoWfl++jrWNsGvbu56QzOb+BehDedyFpMkH11GpXA74ko5j
         0K5PBnJzjMzf9ANkD0OYcgE82fLHxLlf1yFdfDv2DPcSLvVdCsdfAu8x3MgUGYNdIkjB
         XtvkTHjSYubMfkFOgTxbqQuWsEfEMDxgDpcn8YQQL0JqQvuTehslgLUl8nwd/F7TWRbY
         h6eKn/iAmI2pGnBTHrhWrBLSweKdezz2022fy+3g11K68kBMYvgz2AfDhk3yGGk6FmiG
         /JdYBOkJhV+LtlmMpLNLLmSXBzw737DRZyxyqv6+ZS0YvOBxY0xbVeqyyXG14zaI5zAk
         idKQ==
X-Gm-Message-State: AOAM533k2Qv+yWgayPj2IDJiJam/9ihKSyDcrD2QW2EzJyzeV/43SrgC
        yA2UzOZPs8UGpjwGM0MfsLNBqg==
X-Google-Smtp-Source: ABdhPJwR06FNegYVsAU8o74hwv373Yq9KlDunC4jItd8mIVMPn3zgJSHBlM3MLtzBDjvCEtSQnV5Fg==
X-Received: by 2002:a62:7505:: with SMTP id q5mr25490271pfc.262.1595396799507;
        Tue, 21 Jul 2020 22:46:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r16sm22153983pfh.64.2020.07.21.22.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 22:46:38 -0700 (PDT)
Date:   Tue, 21 Jul 2020 22:46:38 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Jul 2020 22:46:37 PDT (-0700)
Subject:     Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
In-Reply-To: <87sgdkqhjx.fsf@mpe.ellerman.id.au>
CC:     benh@kernel.crashing.org, alex@ghiti.fr, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mpe@ellerman.id.au
Message-ID: <mhng-378c6e4e-9eba-4bfd-89d6-b4d2549ff3a1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 21:50:42 PDT (-0700), mpe@ellerman.id.au wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> On Tue, 2020-07-21 at 16:48 -0700, Palmer Dabbelt wrote:
>>> > Why ? Branch distance limits ? You can't use trampolines ?
>>>
>>> Nothing fundamental, it's just that we don't have a large code model in the C
>>> compiler.  As a result all the global symbols are resolved as 32-bit
>>> PC-relative accesses.  We could fix this with a fast large code model, but then
>>> the kernel would need to relax global symbol references in modules and we don't
>>> even do that for the simple code models we have now.  FWIW, some of the
>>> proposed large code models are essentially just split-PLT/GOT and therefor
>>> don't require relaxation, but at that point we're essentially PIC until we
>>> have more that 2GiB of kernel text -- and even then, we keep all the
>>> performance issues.
>>
>> My memory might be out of date but I *think* we do it on powerpc
>> without going to a large code model, but just having the in-kernel
>> linker insert trampolines.
>
> We build modules with the large code model, and always have AFAIK:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?commit=4fa640dc52302b5e62b01b05c755b055549633ae#n129
>
>   # -mcmodel=medium breaks modules because it uses 32bit offsets from
>   # the TOC pointer to create pointers where possible. Pointers into the
>   # percpu data area are created by this method.
>   #
>   # The kernel module loader relocates the percpu data section from the
>   # original location (starting with 0xd...) to somewhere in the base
>   # kernel percpu data space (starting with 0xc...). We need a full
>   # 64bit relocation for this to work, hence -mcmodel=large.
>   KBUILD_CFLAGS_MODULE += -mcmodel=large

Well, a fast large code model would solve a lot of problems :).  Unfortunately
we just don't have enough people working on this stuff to do that.  It's a
somewhat tricky thing to do on RISC-V as there aren't any quick sequences for
long addresses, but I don't think we're that much worse off than everyone else.
At some point I had a bunch of designs written up, but they probably went along
with my SiFive computer.  I think we ended up decided that the best bet would
be to distribute constant tables throughout the text such that they're
accessible via the 32-bit PC-relative loads at any point -- essentially the
multi-GOT stuff that MIPS used for big objects.  Doing that well is a lot of
work and doing it poorly is just as slow as PIC, so we never got around to it.

> We also insert trampolines for branches, but IIUC that's a separate
> issue.

"PowerPC branch trampolines" points me here
https://sourceware.org/binutils/docs-2.20/ld/PowerPC-ELF32.html .  That sounds
like what we're doing already in the medium code models: we have short and
medium control transfer sequences, linker relaxation optimizes them when
possible.  Since we rely on linker relaxation pretty heavily we just don't
bother with the smaller code model: it'd be a 12-bit address space for data and
a 21-bit address space for text (with 13-bit maximum function size).  Instead
of building out such a small code model we just spent time improving the linker.
