Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703EAC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D7420801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMdoPkJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSS1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:27:46 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33409 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:27:45 -0500
Received: by mail-vk1-f195.google.com with SMTP id i78so427507vke.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8bheu//eOsUC2rG1tcM8D2woU+rRRO7+NHd/SAby40=;
        b=DMdoPkJfjI8vEiQ931OXimak2rqeezogGTA8Jz0YUFlSK+iP3iGUiJm8P0zxfSazbl
         sTLes5Pdhak910J52lP/cGVjDxzDihqkqyUztiFUlwZg0VhXzKO1IB9YGArPtZqB6CV3
         5i85IFWDdO9zpfwEZ9XXCunsWgqWEwKKlhfY1B2U5wv6+QD3YcbhFr+s44GC4sg72+rA
         n2ie3yBEKdehbzyFS5WDKMUNUnSdwc2SvQkZ5DylB/so9f2QssueydxU/mKohLfzAbZz
         K3OtN1dWSEkKMUwc/C1SbRHw0naFdurKZuH+kXBfdy4MpfLQng5Kl2vAtDn1OZwbvUbU
         +EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8bheu//eOsUC2rG1tcM8D2woU+rRRO7+NHd/SAby40=;
        b=Usbu8iqTAxBGN+HT66U77xD18pfmBbrXVY6RTmcMsu7A7/UxHXCObRYtkl+6vrWjQE
         iPiDNKjuScA/23heTAPB9+aonqxosTIeCfW0BFx+NevpRmc2mnr1hBARnI4PEShkPkv8
         wB6aLBbecTGVtE5ART8l1WZKuNQUtRaR/Lexfh4KITrPKHN7bWgyXnUgnDXTIyqgJ0az
         gjen4cJexq6aH4LNlNyAvcXKzQIelO+GImUCcLbjth1kuy9kxb2Fe63mpMJoX5K8nZ/g
         MI5yUfvVW7IjHw7F4wliLlDVRoGQghen8SeQjFVmaUfoNRdxv0U1et7S3Js+r3IfYNpI
         CYqA==
X-Gm-Message-State: APjAAAV5SI1WgBVNIpK7nRkw/Kcjv3HSo9yIS2kFShMR/Az7AU1uTpvz
        7VOtms1IzuUKv2z3AIxaNVoit9d/zRyDyNTrFdgI4A==
X-Google-Smtp-Source: APXvYqz43ZWMlwcCQPP90XUO0jIibofgqeEtAm/3NdUy/lBowdl1d7auUgQbzj7b/uQk3jHx8Zbly6t36F7bSB8gUac=
X-Received: by 2002:a1f:e784:: with SMTP id e126mr12203230vkh.102.1582136864292;
 Wed, 19 Feb 2020 10:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200219000817.195049-1-samitolvanen@google.com> <20200219000817.195049-13-samitolvanen@google.com>
 <CAKv+Gu9HpKBO-r+Ker47sPxvHBWLa6NAHe4P71x=K4Wiy2ybwQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9HpKBO-r+Ker47sPxvHBWLa6NAHe4P71x=K4Wiy2ybwQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 19 Feb 2020 10:27:33 -0800
Message-ID: <CABCJKuckw-_WMDF7=Vndwm5vfZXpeZachUSMMCsN0Sx_P8DXBg@mail.gmail.com>
Subject: Re: [PATCH v8 12/12] efi/libstub: disable SCS
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 11:41 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 19 Feb 2020 at 01:09, Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > +#  remove SCS flags from all objects in this directory
> > +KBUILD_CFLAGS := $(filter-out -ffixed-x18 $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
> > +
>
> I don't see why you'd need to remove -ffixed-x18 again here. Not using
> x18 anywhere in the kernel is a much more maintainable approach.

Sure, I will drop -ffixed-x18 from here in v9. Thanks,

Sami
