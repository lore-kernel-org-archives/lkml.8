Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2243FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF3E20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deM17WMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgERXqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:46:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B98C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:46:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id x5so12661664ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qear2Z9MWJSv6xobtZ0lLKyEiYjp+BthQ29ye9795uY=;
        b=deM17WMiXP0CoYPaNk0pYJs43JINW49Urrf5LNJBRlsZG5RJ3SB1+aMaCZr/AklygQ
         /fNjFg1qadh2FFaLRArKILcpDTxiZsORp+rFx7sIKnRJD0mb8PBC5iCwsE3ImQUy2k0X
         eofTxRLUyx2q4tr8o8lOkrCDyf50C9jzGDLYg+erfsrL404SAWSV5TKXhf4mGUFqKp3O
         0iEufgPGfKjPhCgR8Sxs6ssFHm7M81g/f+V5A/oolaC6FJRLcggtVK3JYrdI1k/p2fsv
         BesAtgMEXGppBUMAcNxRYgZhQhQ+iIicdIxoiRm+vZ1FUSUeFltFFqQfcEDH0q1VH4K1
         flYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qear2Z9MWJSv6xobtZ0lLKyEiYjp+BthQ29ye9795uY=;
        b=tsZmqhygISplr6/paoIJCTkuuTUw3+MOQLF90UDWPpsqJE3c6/sLCmymzUOkGRhM+6
         Uf/3ibkhYMw+Ed/E3n6entfIi/CjI8VXFZM2uDGyBTsOi3i4HZwj/aGYXGEPiUnbLOCu
         eI3bJl/iXsdIuaYL9s/SsNMaKjixUc7mFArynVMQGbGqPVxceVFiTQqKFjTHwJMk52Gr
         2oq58GYS1mNogWJVSgy7uPjVfy/88PVJYrrJBufih94pZ5MJZxuWxO6msKUV+iKIBYi6
         ooB/PfhWQt1/jDjg4B+iIAgE5xgwJKg1cX1iB2pRUMdG2aRF7TQrdXdOgMt95HbJDYiJ
         zDAw==
X-Gm-Message-State: AOAM533UQNof0kU6wqT00zsPb11YsmNGDEy2NmjLEM2I8w9mXaq+qUw/
        8r9Nnfmgnf/qinuHIVclwm40B6Hp8AjbxBdjCQ==
X-Google-Smtp-Source: ABdhPJw8J+Z2zEbU8SZPU/0GZktYf64Jy9OR4OTfTsFAPLX9xwIPzkAFytSBNqkJR1oQOU3Q8G/e005mVwkkRp5A/OY=
X-Received: by 2002:a02:c6c5:: with SMTP id r5mr17898566jan.133.1589845565837;
 Mon, 18 May 2020 16:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-6-brgerst@gmail.com>
 <CAKwvOdn7yC1GVA+6gtNewBSq2BK09y9iNWhv1dPFF5i4kT1+6A@mail.gmail.com>
In-Reply-To: <CAKwvOdn7yC1GVA+6gtNewBSq2BK09y9iNWhv1dPFF5i4kT1+6A@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 18 May 2020 19:45:53 -0400
Message-ID: <CAMzpN2j6gp-+zwa+meWbGC_TCEJF0GSC-xQ3mdMU07DxDR+pmA@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86/percpu: Clean up percpu_add_return_op()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 6:46 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 17, 2020 at 8:29 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > The core percpu macros already have a switch on the data size, so the switch
> > in the x86 code is redundant and produces more dead code.
> >
> > Also use appropriate types for the width of the instructions.  This avoids
> > errors when compiling with Clang.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  arch/x86/include/asm/percpu.h | 51 +++++++++++------------------------
> >  1 file changed, 16 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> > index 21c5013a681a..ac8c391a190e 100644
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -199,34 +199,15 @@ do {                                                                      \
> >  /*
> >   * Add return operation
> >   */
> > -#define percpu_add_return_op(qual, var, val)                           \
> > +#define percpu_add_return_op(size, qual, _var, _val)                   \
> >  ({                                                                     \
> > -       typeof(var) paro_ret__ = val;                                   \
> > -       switch (sizeof(var)) {                                          \
> > -       case 1:                                                         \
> > -               asm qual ("xaddb %0, "__percpu_arg(1)                   \
> > -                           : "+q" (paro_ret__), "+m" (var)             \
> > -                           : : "memory");                              \
> > -               break;                                                  \
> > -       case 2:                                                         \
> > -               asm qual ("xaddw %0, "__percpu_arg(1)                   \
> > -                           : "+r" (paro_ret__), "+m" (var)             \
> > -                           : : "memory");                              \
> > -               break;                                                  \
> > -       case 4:                                                         \
> > -               asm qual ("xaddl %0, "__percpu_arg(1)                   \
> > -                           : "+r" (paro_ret__), "+m" (var)             \
> > -                           : : "memory");                              \
> > -               break;                                                  \
> > -       case 8:                                                         \
> > -               asm qual ("xaddq %0, "__percpu_arg(1)                   \
> > -                           : "+re" (paro_ret__), "+m" (var)            \
>
> ^ before we use the "+re" constraint for 8B input.
>
> > -                           : : "memory");                              \
> > -               break;                                                  \
> > -       default: __bad_percpu_size();                                   \
>
> Comment on the series as a whole.  After applying the series, the
> final reference to __bad_percpu_size and switch statement in
> arch/x86/include/asm/percpu.h in the definition of the
> percpu_stable_op() macro.  If you clean that up, too, then the rest of
> this file feels more consistent with your series, even if it's not a
> blocker for Clang i386 support. Then you can get rid of
> __bad_percpu_size, too!

I haven't yet figured out what to do with percpu_stable_op().  It's
x86-specific, so there isn't another switch in the core code.  I think
it is supposed to be similar to READ_ONCE() but for percpu variables,
but I'm not 100% sure.

> > -       }                                                               \
> > -       paro_ret__ += val;                                              \
> > -       paro_ret__;                                                     \
> > +       __pcpu_type_##size paro_tmp__ = __pcpu_cast_##size(_val);       \
> > +       asm qual (__pcpu_op2_##size("xadd", "%[tmp]",                   \
> > +                                    __percpu_arg([var]))               \
> > +                 : [tmp] __pcpu_reg_##size("+", paro_tmp__),           \
>
> ^ after, for `size == 8`, we use "+r". [0] says for "e":
>
> 32-bit signed integer constant, or a symbolic reference known to fit
> that range (for immediate operands in sign-extending x86-64
> instructions).
>
> I'm guessing we're restricting the input to not allow for 64b signed
> integer constants?  Looking at the documentation for `xadd` (ie.
> "exchange and add") [1], it looks like immediates are not allowed as
> operands, only registers or memory addresses.  So it seems that "e"
> was never necessary.  It might be helpful to note that in the commit
> message, should you end up sending a v2 of the series.  Maybe some
> folks with more x86 inline asm experience can triple check/verify?

That is correct.  The "e" constraint shouldn't have been there, since
XADD doesn't allow immediates.  I'll make that clearer in V2.

--
Brian Gerst
