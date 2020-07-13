Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE95C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDABF2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mskIuOFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgGMP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:59:26 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE230C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:59:25 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x9so11615558ila.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2BldiAm+TT/Jt2NQrO6UjTqCxOKkSedXNeqSLddvbVs=;
        b=mskIuOFQiXJ7xPEiqej8CrqbEP1opYhRQbqzUCfzVFsN8DqoFkv79hhlZuV9OvG7DA
         ls+mCSVBpgRJnuwUO/YmNVAUpPvV3lCm0Nk9ERxpLbgyCtsxAqbyD7Pc7yS+T2JPqBVb
         +XRoDNJTYG2hXzUIYEx6VD4clWFETmIYmyJpyaHlNuYeOu0N7jOpd8baSdiqAyZqDxvj
         k6FS4/Let8XXlWmILe8Ij2HliAG/3uXF/XpDMmNVzgQUSV5OQG/LjidWNgYqqhMvF3V8
         FGIiEmMoNNTQZCDINb7eYAw/CODSjp5JsjNCMxQcLfimklcsjpCCxShPoCtN+vRN541b
         l+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2BldiAm+TT/Jt2NQrO6UjTqCxOKkSedXNeqSLddvbVs=;
        b=GekCFckkr7VX764354yb6leB+itcjeWohFv4G3iXYYVE6rvUWItEB2/JRSQRR9iG7s
         Zol/vYUUzz2l8GFTPyu/Mpt+h14qmXg9IU0j1O2Xzhr/KhbUMoFBEIrXZFpSs3o9DDuj
         okKkdO0gNVpS2wPDQdX0yYUuUAphhvjHmha30sww3pzIe1C1uqG/VILEjCnNG4hbwQ5L
         WQ6afL1TlOoU2gYO96jxuFlAJKWY2oxDRWgjzouzeCZ19y1XJu9RD+xjj/2uQiZJPTN1
         kxHQzsjPA+ITzgrxd6sowmA65ELGzVOWQRNsF9nC35g6cgGFGaRKYlZI/sfva2hYEJt6
         bESw==
X-Gm-Message-State: AOAM5304io2CfHbRvscdBKWQKYh7BISScY274VwFsZ2Mk9m9pJ1rdhI4
        0RFHHS6ApmL61RCnEXQh33yOLKNledVdAlQx7Go=
X-Google-Smtp-Source: ABdhPJwnP2GD4g9CUNIaMxid51OSekEGSh9qQODDI//PL9Hz8tlIVtdrjeyWduAsr5POdG+twL9b/wKn/sp+g3msgoI=
X-Received: by 2002:a92:dc09:: with SMTP id t9mr382735iln.226.1594655965186;
 Mon, 13 Jul 2020 08:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200712231050.5147-1-sedat.dilek@gmail.com> <20200713111330.kpppbjbjwwij2rgq@liuwe-devbox-debian-v2>
In-Reply-To: <20200713111330.kpppbjbjwwij2rgq@liuwe-devbox-debian-v2>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 Jul 2020 17:59:13 +0200
Message-ID: <CA+icZUUAyqgJR-qQFMvFAK-SJmUaxdH9EL9VXR0Me+hwJW5qaQ@mail.gmail.com>
Subject: Re: [PATCH] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Jian Cai <caij2003@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 1:13 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Mon, Jul 13, 2020 at 01:10:50AM +0200, Sedat Dilek wrote:
> > When using Clang's Integrated Assembler (LLVM_IAS=1) we fell over
> > ClangBuiltLinux (CBL) issue #1043 where Jian Cai provided a fix.
> >
> > With Jian's fix applied another issue raised up when CONFIG_HYPERV=m.
> >
> > It turned out that the conversion of vectors to IDTENTRY_SYSVEC in
> > case of CONFIG_HYPERV was incomplete and fails with a build error:
> >
> > <instantiation>:9:6: error: expected absolute expression
> >  .if HYPERVISOR_REENLIGHTENMENT_VECTOR == 3
> >      ^
> > <instantiation>:1:1: note: while in macro instantiation
> > idtentry HYPERVISOR_REENLIGHTENMENT_VECTOR asm_sysvec_hyperv_reenlightenment sysvec_hyperv_reenlightenment has_error_code=0
> > ^
> > ./arch/x86/include/asm/idtentry.h:627:1: note: while in macro instantiation
> > idtentry_sysvec HYPERVISOR_REENLIGHTENMENT_VECTOR sysvec_hyperv_reenlightenment;
> > ^
> > <instantiation>:9:6: error: expected absolute expression
> >  .if HYPERVISOR_STIMER0_VECTOR == 3
> >      ^
> > <instantiation>:1:1: note: while in macro instantiation
> > idtentry HYPERVISOR_STIMER0_VECTOR asm_sysvec_hyperv_stimer0 sysvec_hyperv_stimer0 has_error_code=0
> > ^
> > ./arch/x86/include/asm/idtentry.h:628:1: note: while in macro instantiation
> > idtentry_sysvec HYPERVISOR_STIMER0_VECTOR sysvec_hyperv_stimer0;
>
> Hmm... Interesting. GCC never complained. Guests are perhaps broken in a
> rather subtle way.
>
> >
> > I and Nathan double-checked the hyperv(isor) vectors:
> >
> > $ rg --no-heading "HYPERVISOR_REENLIGHTENMENT_VECTOR|HYPERVISOR_STIMER0_VECTOR"
> > $ rg --no-heading "HYPERV_REENLIGHTENMENT_VECTOR|HYPERV_STIMER0_VECTOR"
> >
> > Fix these typos in arch/x86/include/asm/idtentry.h:
> >
> > HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
> > HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR
> >
> > For more details see CBL issue #1088.
> >
> > With both fixes applied I was able to build/assemble with a snapshot
> > version of LLVM/Clang from Debian/experimental.
>
> I think the issue found here is independent of the other. This patch
> shouldn't need to wait for the other to land.
>

Yes, this one is - and can land - independently.
Without Jian's fix and CONFIG_HYPERV=m we have not seen the issue.

> >
> > Cc: Jian Cai <caij2003@gmail.com>
> > Cc: clang-built-linux@googlegroups.com
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > Fixes: a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1043
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1088
> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> > ---
> >  arch/x86/include/asm/idtentry.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> > index 513eb2ccbdbf..a811f6c6cf15 100644
> > --- a/arch/x86/include/asm/idtentry.h
> > +++ b/arch/x86/include/asm/idtentry.h
> > @@ -624,8 +624,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,        sysvec_kvm_posted_intr_nested
> >
> >  #if IS_ENABLED(CONFIG_HYPERV)
> >  DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,  sysvec_hyperv_callback);
> > -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,   sysvec_hyperv_reenlightenment);
> > -DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,   sysvec_hyperv_stimer0);
> > +DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,       sysvec_hyperv_reenlightenment);
> > +DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,       sysvec_hyperv_stimer0);
>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
>

Thanks for your review.

- Sedat -

> Thomas, can you pick this up for 5.8? Thanks.
>
> Wei.
