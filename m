Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5333DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDDE20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNVb2CG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbgAPV6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:58:06 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34361 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbgAPV6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:58:06 -0500
Received: by mail-vs1-f67.google.com with SMTP id g15so13691680vsf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 13:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90kSKrsPpbCluN0U4RDiVNxyzvDrsXuzgr4VAEgKFuc=;
        b=VNVb2CG8c3HkjMqddLo98y3OPZa+WSPTAgoYdSf7FbWI5WNi3wnlLK0p32BzwbDJkl
         DxW3dVwqqXEzvQDJ/t2t8XVh7UcdBnxl57fQBAwB07GY+Kc5s2di8Ti7bcTy/S2/pe8U
         ishyY7KqIu0u9X9VZYcJD0ArT3LnkwpSs93Icdin/XOuAUh49RrudpoY+q52GTTYSx40
         GpnMdqP6bRbODHeQRjbKNwwaXhmlW1mB68/yoKkEelegSKWRaD4DkiQa+ct5BY9CQ8b+
         WhW5jUQJ1e+6OM3m0IRmGb8dXhOkx9FNog8QbWSOqQkVjep7R9pRuyilDTthUXsbS/HD
         LriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90kSKrsPpbCluN0U4RDiVNxyzvDrsXuzgr4VAEgKFuc=;
        b=KEkNnaUhOKkzLdXcA5i1GVSycc9i45LRPAvjr+qjJzrmWSTEF7m9/sSXS9XDKwKqDm
         bDcu1UF/MS6VcAJ7jdLhik9v4KeYQH0wux/mc59T8Ig6VZbF8Wnm0u81z4tSNKnmSzg/
         Z7M2y7p/0K8g59dvL1950+GMvBuKlcSeM7vBVywVi6ikS5UCvZG98MfvbPHI2+gY0IM8
         +hI3z3QMMGdh0zOytrLpuchhTuyZ+p5mxtyIleBQ8AiP8elREM4tE347X9K+5+ihbfn1
         678JX6R6WiyZF4PMYnUaXZbImydQk3KyfPCqmsj5gozednWCDlGboNr6Zo9oCTTuE1DM
         Iw6A==
X-Gm-Message-State: APjAAAUaK2LCpOKRi1iXk31gCJK/6V1kw8qSa9/BkEUeRWRepEfBEi5H
        k6aPW0CG/SckVQH/oAOtXzBNDzYnDRAFBUFt4dQs6w==
X-Google-Smtp-Source: APXvYqzrUqH5/W2UZ+FeXG0hZr7Tack1J9k9eB9pBix6w41rOK+OkTqsOrnRDdc5aMPEGFoHQeXxcn/0tewoHbFlgSg=
X-Received: by 2002:a67:ae43:: with SMTP id u3mr3413809vsh.44.1579211884786;
 Thu, 16 Jan 2020 13:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191206221351.38241-1-samitolvanen@google.com> <20191206221351.38241-15-samitolvanen@google.com>
 <20200116182414.GC22420@willie-the-truck>
In-Reply-To: <20200116182414.GC22420@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 16 Jan 2020 13:57:53 -0800
Message-ID: <CABCJKucnitMPUv+NhZu4bscz9qs1qB9TXR1OP-ychFO0LQ4v_g@mail.gmail.com>
Subject: Re: [PATCH v6 14/15] arm64: implement Shadow Call Stack
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:24 AM Will Deacon <will@kernel.org> wrote:
> >       .macro  irq_stack_entry
> >       mov     x19, sp                 // preserve the original sp
> > +#ifdef CONFIG_SHADOW_CALL_STACK
> > +     mov     x20, x18                // preserve the original shadow stack
> > +#endif
>
> Hmm, not sure about corrupting x20 here. Doesn't it hold the PMR value from
> kernel_entry?

You're right, and it's used in el1_irq after irq_handler if
CONFIG_ARM64_PSEUDO_NMI is enabled. Thanks for pointing this out.
Looks like one of x24-x29 should be safe here, and the comment needs
to be updated to explain why x20-x23 shouldn't be corrupted.

Sami
