Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49856CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E27206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGqh2RXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgELTXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:23:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1BCC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:23:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so5810046plt.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3Opb6arzJwXelkGLAeI5ijV0q+qANDWY75OUMFqdTw=;
        b=uGqh2RXUdJGWl4vM5ngSkKyM33oCzN0D7rcTg3PahkCN5jK46nLHvb81Q6+NXnvJk6
         LjUqly3uQEVD7t/d9EUt+Z7iaEkHN+WWMlSTXWjuF7T5NO3Vib4I2JIS89lpqrhIOx1v
         sZ6h90wKOXIzfl49sNYheDJhejgkqD8GVao4Tj6ExSkA2DfXUIG14pvJ6cAjN5BRDiio
         ZTAS0jFvVdqjYdf2KJ47sIn7LpAQjmJZPfqEEVRzg8PoSIetgsVuPk7fcaaMtmB6wh8e
         HkN3ZzjHFrxeqBOVBc6mAB+pYXi9ZRBkJOaVDiWPHcKMwsPmAd6w8WRR/XXnvj+r2zqs
         HRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3Opb6arzJwXelkGLAeI5ijV0q+qANDWY75OUMFqdTw=;
        b=f8zbL1+uEzCq/tuBRDe2lHEURc8csifs1BPGK06f7AtfiVtKDimdEsHPAJB+9GYDIU
         S2DJH5x7/8sLvaBBB9z2NF0QyfKWEr8mCDly4cwtOP+gYI5QwgvjQb4h1vDSwPGGLYwM
         Z1QxMEuAimDk8ULLSOZY8XWQSY14mdBYGeERzXwjbdMDzB5YhIKthqJiNzPJGNtHbQk5
         LGbNkhWM8oEIqBEZX4Ri7rQFAw+vefpKNUrOyX3s6m6XGQXD0hDeASVSSb+qHn1yyMMC
         emuoxuAIF/LUrWyR/oiB30yg5adOrfoc99KCM2s+au8fJBErQMYvB3KV7Dbx6m8NKHfZ
         0Eyw==
X-Gm-Message-State: AOAM5333JehGYT+fWeVsFNHYyjPcjTJX5G4xBpcv3QLu5gwTsFbalV78
        8nEKEABD0TNVMeRw5br2LErTaDGEuehcjw1gf6vkJA==
X-Google-Smtp-Source: ABdhPJxJM3DP8tQlMfcGivh9vfkZm4K3CVXJuLlEPwZAMHaub6Fim/plw5kyQ/IFPpdLRyyZau9KKX5M9Z0ugKluwR4=
X-Received: by 2002:a17:90a:2a4a:: with SMTP id d10mr4799210pjg.32.1589311426080;
 Tue, 12 May 2020 12:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200504031340.7103-1-nick.desaulniers@gmail.com>
 <CA+icZUUOaqeKeh6n4BJq2k6XQWAfNghUj57j42ZX5qyd3iOmLw@mail.gmail.com>
 <20200505004738.ew2lcp27c2n4jqia@google.com> <CAK7LNAR7-VMEWBcJ_Wd+61ZDHEa0gD8FaSs63YPu7m_FgH8Htg@mail.gmail.com>
In-Reply-To: <CAK7LNAR7-VMEWBcJ_Wd+61ZDHEa0gD8FaSs63YPu7m_FgH8Htg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 May 2020 12:23:34 -0700
Message-ID: <CAKwvOdmEP9Auuc+M+MqPoQmx+70DgdsPYZQ6pg=8oGnfCviqRA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: support compressed debug info
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <nick.desaulniers@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:54 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > >On Mon, May 4, 2020 at 5:13 AM Nick Desaulniers
> > ><nick.desaulniers@gmail.com> wrote:
> > >>
> > >> As debug information gets larger and larger, it helps significantly save
> > >> the size of vmlinux images to compress the information in the debug
> > >> information sections. Note: this debug info is typically split off from
> > >> the final compressed kernel image, which is why vmlinux is what's used
> > >> in conjunction with GDB. Minimizing the debug info size should have no
> > >> impact on boot times, or final compressed kernel image size.
> > >>
> Nick,
>
> I am OK with this patch.
>
> Fangrui provided the minimal requirement for
> --compress-debug-sections=zlib
>
>
> Is it worth recording in the help text?
> Do you want to send v2?

Yes I'd like to record that information.  I can also record Sedat's
Tested-by tag.  Thank you for testing Sedat.

I don't know what "linux-image-dbg file" are, or why they would be
bigger.  The size of the debug info is the primary concern with this
config.  It sounds like however that file is created might be
problematic.

Fangrui, I wasn't able to easily find what version of binutils first
added support.  Can you please teach me how to fish?

Another question I had for Fangrui is, if the linker can compress
these sections, shouldn't we just have the linker do it, not the the
compiler and assembler?  IIUC the debug info can contain relocations,
so the linker would have to decompress these, perform relocations,
then recompress these?  I guess having the compiler and assembler
compress the debug info as well would minimize the size of the .o
files on disk.

Otherwise I should add this flag to the assembler invocation, too, in
v2.  Thoughts?

I have a patch series that enables dwarf5 support in the kernel that
I'm working up to.  I wanted to send this first.  Both roughly reduce
the debug info size by 20% each, though I haven't measured them
together, yet.  Requires ToT binutils because there have been many
fixes from reports of mine recently.
-- 
Thanks,
~Nick Desaulniers
