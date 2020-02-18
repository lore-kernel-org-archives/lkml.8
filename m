Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB5CC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50AF24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL2OqpCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBRSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:30:17 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41417 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgBRSaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:30:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so21073275oie.8;
        Tue, 18 Feb 2020 10:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+wiw5lrCSQij+T7Z3oal8MXvOgfhByiSsTRsFyzWrro=;
        b=AL2OqpCvhL88spvXodEIYCX2UE5sle8Xf4g0XdrZ/ldsokqbmwcoZn3eBX7anyuWy8
         vlrlN/A6J+XJwXYFZmV/DAHEnW7d7FK01iuCj9nf+YS5pEBD68wWtTWzRVHfWKw4ipEo
         LmYli6LkiVJtD2pJTpZzGqJKB/ylu0Z6JisMgEqUXYyDW2F4hdPQJpI6x9+jctd3UJ3p
         WIabauyIg1yCjPr1JYhXdNpbJPZX4claJRgDQJ3YYfdywrUxJMKOY1UaS+G66RmsBSLs
         m4jqANpQ0fr86C9+hjGJyYnWLdT8I1YDs0uRlg/iHgH/wW2NLVyUgJXTWuycmZjWbJtI
         0Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+wiw5lrCSQij+T7Z3oal8MXvOgfhByiSsTRsFyzWrro=;
        b=GuIVI3kwndmszIcolPpNgk0RKxbmQdZe40yuTGhHqNku2amEn2/1TZw8MO07XG/UeJ
         7YcOuAocyULFJ0cWWZ+nzuDzVGyl6DCgK4ln/ubwesqQ7cnFAU4URtNyETdreI0RUCCr
         RjgJgAZjgRFbzdDTWHNxem00w/XtpocbNPZ8W6fDwhghSI8/JaUVkkvbUDlp0pmLWZm8
         RE/Mi7G6g3htJ4QzMe+xRwNpQb2fDMFGW6sxrbdVGqomws3YbfFKauAe7Bkcwty0GYUM
         bqF6AzKrpE2S1USeVR9RaNMO/QuSFp/BFwDHxLaxoOOEfcTEMb4MEk7asOtROBffH6Rd
         106Q==
X-Gm-Message-State: APjAAAW6d31ObTKIVt0ktnvOLMnHtMxsIXL8HQxJxiX/vAbNBluMzZSd
        Z8AlqLF30JeIyGj+zHaoEOQ=
X-Google-Smtp-Source: APXvYqx9VaDZWhHzRlewamxKXnv7qlX1vetohx2dH9usR8s6uZil0EOAwAHij+iXu+/MAXWLp76QAQ==
X-Received: by 2002:aca:2b04:: with SMTP id i4mr2129858oik.21.1582050612821;
        Tue, 18 Feb 2020 10:30:12 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id l207sm1435015oih.25.2020.02.18.10.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 10:30:12 -0800 (PST)
Date:   Tue, 18 Feb 2020 11:30:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] MIPS: vdso: Wrap -mexplicit-relocs in cc-option
Message-ID: <20200218183011.GA7516@ubuntu-m2-xlarge-x86>
References: <20200217211149.44132-1-natechancellor@gmail.com>
 <CAKwvOdnRbMrXNSMAA20UnoAUKBu5X7JO+DvNTb9pebuzQbRVcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnRbMrXNSMAA20UnoAUKBu5X7JO+DvNTb9pebuzQbRVcw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 10:28:15AM -0800, Nick Desaulniers wrote:
> On Mon, Feb 17, 2020 at 1:11 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang does not support this option and errors out:
> >
> > clang-11: error: unknown argument: '-mexplicit-relocs'
> >
> > Clang does not appear to need this flag like GCC does because the jalr
> > check that was added in commit 976c23af3ee5 ("mips: vdso: add build
> > time check that no 'jalr t9' calls left") passes just fine with
> >
> > $ make ARCH=mips CC=clang CROSS_COMPILE=mipsel-linux-gnu- malta_defconfig arch/mips/vdso/
> >
> > even before commit d3f703c4359f ("mips: vdso: fix 'jalr t9' crash in
> > vdso code").
> >
> > -mrelax-pic-calls has been supported since clang 9, which is the
> > earliest version that could build a working MIPS kernel, and it is the
> > default for clang so just leave it be.
> >
> > Fixes: d3f703c4359f ("mips: vdso: fix 'jalr t9' crash in vdso code")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/890
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Thanks for the patch, and detailed context.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> With this patch applied:
> $ make ARCH=mips CC=clang CROSS_COMPILE=mipsel-linux-gnu-
> malta_defconfig arch/mips/vdso/
> $ lvm-objdump --disassemble arch/mips/vdso/vdso.so.dbg.raw | egrep -h "jarl.*t9"
> $ llvm-objdump --disassemble arch/mips/vdso/vdso.so.dbg.raw | grep jarl
> So jarl instructions aren't emitted.
> 
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thank you for double checking and the review!

Cheers,
Nathan
