Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F13C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10312065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJRl6ID2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgEQUZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:25:30 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF5C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:25:30 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v4so6510396qte.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pdFkZ3z8hbCWgEtAKY5gJCVXhkdUK7J2l2u0edhAVKY=;
        b=RJRl6ID28Pxd5kKOkc8IERBuhMxeaW7jyOUlSo0Uebc0bJ1c+HrkvunsvGSuLA1hXo
         pLak9nwWP/Rl+RASlBSPFq/jB3fdchGI0F4cRHdUz/xHUrJxWvlKEHvc0rOjBHKhFJAI
         kZBbMPLJDQ4rU6JBEOWuld4WGiC1BkwppKxUVLy4Wo7N2eS0Zuq4CnpCZSgM5Lj3l7gj
         iZVZ1zYNiTgywlXJRyRKzBf/Dgbmr9ZZg9PUbGEZCkntszzqw6ogsg4Noygqx2zZzuAE
         Fv3O0HLHeQ61e3AwdLHLsvYv6ndCht2FgIfaXnaRiJp3iYAKHAV1X2Q7s5xsJM0MSnUo
         53qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pdFkZ3z8hbCWgEtAKY5gJCVXhkdUK7J2l2u0edhAVKY=;
        b=iVQSOSpDOK3RJyrRZt8zt4m5efzRrnKmHWEf1B4rRZXw389zVGePYDRYeLIsRLoWSj
         nySpraufYCFddrUtKKk1hl6JRYYM4ZBLb6+GuDTynXUOPGZcWPESIhflXh1bSOxgKh2k
         zslKrO37l3TdIzknVVxfG6oNcP6zZBgmPIdzqxrPiFm7rrPNfmON9/DADNKfjDiyKMEz
         i2SMKaQsEl9Z9JXTaM+xbFpeelQtY0adEjSCNngROIRTA7Dj99tvpejlyP0PtVcA1FQd
         sFK2be1wDQvpTjXk5RM5FxmzVigNRC0PLLUEl/TSCEmvjkMIzmKfgyQHcH2/Rnk8H+OL
         YHLw==
X-Gm-Message-State: AOAM530KA722h0/WMopmHz5Z8vV3FiFBep9rmSfhDQD1BZUOuDYe5+94
        6UqJEVg/68dWOaQl8dXFNaU=
X-Google-Smtp-Source: ABdhPJxdqHyc6sPiMgC/zVuZuRsKXgyD5zpeQho+cZLRSckEO5l1wuxlFlwWFKu+W4EYg4uZmV9UVw==
X-Received: by 2002:ac8:5517:: with SMTP id j23mr3008528qtq.215.1589747129446;
        Sun, 17 May 2020 13:25:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y185sm6662678qkd.29.2020.05.17.13.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 13:25:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 17 May 2020 16:25:27 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Dmitry Golovin <dima@golovin.in>, Borislav Petkov <bp@alien8.de>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: allow a relocatable kernel to be linked with
 lld
Message-ID: <20200517202527.GA2563549@rani.riverdale.lan>
References: <20200501084215.242-1-dima@golovin.in>
 <20200515185051.GC19017@zn.tnic>
 <602331589572661@mail.yandex.ru>
 <20200517194429.scwhfr4l4bv4h3ux@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200517194429.scwhfr4l4bv4h3ux@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 12:44:29PM -0700, Fangrui Song wrote:
> On 2020-05-16, Dmitry Golovin wrote:
> >15.05.2020, 21:50, "Borislav Petkov" <bp@alien8.de>:
> >>
> >> I need more info here about which segment is read-only?
> >>
> >> Is this something LLD does by default or what's happening?
> >>
> >
> >Probably should have quoted the original error message:
> >
> >    ld.lld: error: can't create dynamic relocation R_386_32 against
> >    symbol: _bss in readonly segment; recompile object files with -fPIC
> >    or pass '-Wl,-z,notext' to allow text relocations in the output
> 
> Do we know where do these R_386_32 come from?
> 
> When linking in -shared mode, the linker assumes the image is a shared
> object and has undetermined image base at runtime. An absolute
> relocation needs a text relocation (a relocation against a readonly
> segment).
> 
> When neither -z notext nor -z text is specified, GNU ld is in an
> indefinite state where it will enable text relocations (DT_TEXTREL
> DF_TEXTREL) on demand. It is not considered a good practice for
> userspace applications to do this.
> 
> Of course the kernel is different....... I know little about the kernel,
> but if there is a way to make the sections containing R_386_32
> relocations writable (SHF_WRITE), that will be a better solution to me.
> In LLD, -z notext is like making every section SHF_WRITE.

The assembly files head_32.S and head_64.S in arch/x86/boot/compressed
create bogus relocations in .head.text and .text.

This is the source of the common warning when using the bfd linker, for
eg on 64-bit:
  LD      arch/x86/boot/compressed/vmlinux
  ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-only section `.head.text'
  ld: warning: creating a DT_TEXTREL in object

These relocations are "bogus", i.e. they're unwanted and the kernel
won't actually boot if anything were to perform those relocations before
running it. They're also the cause of the 64-bit kernel requiring linker
support for the -z noreloc-overflow option to link it as PIE.

From arch/x86/boot/compressed/Makefile:

# To build 64-bit compressed kernel as PIE, we disable relocation
# overflow check to avoid relocation overflow error with a new linker
# command-line option, -z noreloc-overflow.
KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z
noreloc-overflow" \
        && echo "-z noreloc-overflow -pie --no-dynamic-linker")

The relocations come from code like
	leal    gdt(%ebp), %eax
which should really be
	leal	(gdt-startup_32)(%ebp), %eax
to be technically correct.

I've played around with fixing the head code to avoid creating the
relocations in the first place, but never got around to submitting
anything: if there is interest in this, I can polish it up and send it
around.

Thanks.
