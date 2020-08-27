Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFBEC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BECA22B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="amAWIrNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgH0IW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgH0IWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:22:55 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49486C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:55 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id x24so3747319otp.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGJWcpN1ntTu98dcskn67ut+Ep3J0JtQnookryJIizM=;
        b=amAWIrNt1eTgYWi1kEAYhttdOwvSYssVqMFE49HSWbPuMy643K+dkGD3bna/Us80Zq
         Uk017raHDRDEhceG/BxRvXmSVqLrXXLuZTZcUCDzpHCR6T96a/ubnk/BFHjzqQyTz2ou
         Ca0WTwo+dhAHPqnzH9mTLuwG53ZOg+BNpfT81/1/iyL1y3/XJThWHOSP9Y3L2siWfs/r
         lTXxXnJAaB9ejlUcF+Yll0eDOfDTeXtH2/L4hJgIRxb5l89JnCZDlMMj5hTgs4HiwJ4k
         KSpQf7CjjVAWAdMQ7YMp/kvh4D4iXBqO9441k7a78o7z+X8vyPE90UJE8Xp7faNsgUjh
         nFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGJWcpN1ntTu98dcskn67ut+Ep3J0JtQnookryJIizM=;
        b=DMZDg0u0cYU4Vpb9ONQFaV80IotR3Qnlj7iuPrgrNVPYcdnsEt4vtCECRLexAf2gRg
         FyoFUXHwgsdHeMEHo44w/4DmTBjbWZfuyhO5dNf0QZZ6QhLJQsLZdhC4aNsqWhXY7yH7
         lV6e31wn7YuZ/CqvwTZBGQtUpNqyP/0zQqkUJ6wM5c72sgZ6BU/HF0QrYcJlf1Feuwxz
         uUZr6Pfk9fULocRfIUMWkhm4sMZD699knAIaeYEUncM7qQhL5XV8xl9niJmVU47KhNRL
         COQfxDGYlJZVysrUXZkdYsNAusag3/xHWgFV+b56KbHMp8hCjyCGN4x1r+pLO/NDdfne
         ttRw==
X-Gm-Message-State: AOAM531KmgCBkjml52uvqe3JFXxd2AZak1SRNz23ZI5OWiBJY8TWbT0e
        DyhSzVvGFcLv4GNKoK4+eZgHlmJHgE3rjwrwuikQkg==
X-Google-Smtp-Source: ABdhPJwbvObRJv75xg6Z4J9EmesdTOtkbN7G+0jBQXvEjsAG3ZnZD+wmPOQx+5bZgJg6Xy9KRD+xu13pah/sJ5hEnpM=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr13183617oth.127.1598516574712;
 Thu, 27 Aug 2020 01:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593766028.git.zong.li@sifive.com> <mhng-ec05108e-fd03-44c2-992d-649e967f86f0@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-ec05108e-fd03-44c2-992d-649e967f86f0@palmerdabbelt-glaptop1>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 27 Aug 2020 16:22:43 +0800
Message-ID: <CANXhq0rbKJFHgVCQzXDAmSOi6KjCcwE583tAVF7TNLTpLsiTSQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Get cache information from userland
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 4:45 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 03 Jul 2020 01:57:52 PDT (-0700), zong.li@sifive.com wrote:
> > There are no standard CSR registers to provide cache information, the
> > way for RISC-V is to get this information from DT. Currently, AT_L1I_X,
> > AT_L1D_X and AT_L2_X are present in glibc header, and sysconf syscall
> > could use them to get information of cache through AUX vector. We
> > exploit 'struct cacheinfo' to obtain the information of cache, then we
> > don't need additional variable or data structure to record it.
> >
> > We also need some works in glibc, but we have to support the function in
> > kernel first by rule of glibc, then post the patch to glibc site.
> >
> > The result of 'getconf -a' as follows:
> >
> > LEVEL1_ICACHE_SIZE                 32768
> > LEVEL1_ICACHE_ASSOC                8
> > LEVEL1_ICACHE_LINESIZE             64
> > LEVEL1_DCACHE_SIZE                 32768
> > LEVEL1_DCACHE_ASSOC                8
> > LEVEL1_DCACHE_LINESIZE             64
> > LEVEL2_CACHE_SIZE                  2097152
> > LEVEL2_CACHE_ASSOC                 32
> > LEVEL2_CACHE_LINESIZE              64
> >
> > Zong Li (3):
> >   riscv: Set more data to cacheinfo
> >   riscv: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO
> >   riscv: Add cache information in AUX vector
> >
> >  arch/riscv/include/asm/cacheinfo.h   | 14 +++++
> >  arch/riscv/include/asm/elf.h         | 13 ++++
> >  arch/riscv/include/uapi/asm/auxvec.h | 24 ++++++++
> >  arch/riscv/kernel/cacheinfo.c        | 92 +++++++++++++++++++++++-----
> >  4 files changed, 127 insertions(+), 16 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/cacheinfo.h
>
> Sorry, I lost track of these.  There's a little issue in #1, LMK if you want to
> send another version or if you want me to just fix it.

Sorry for being late here, I have sent the second version patches to
fix it, thanks for your reviewing.
