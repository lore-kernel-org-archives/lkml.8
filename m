Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09739C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D867A206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRtCYfvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgGNSac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgGNSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:30:26 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F464C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:30:26 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s21so15044978ilk.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=dWHcSl+qV/ewcMbxZBTT0+5lIFUMoe4sskE51jeT9lk=;
        b=hRtCYfvrOgpiPBp2kK7bu3rXM3+A1WNg1/pBdBE/siaWiM/19t27VY9kkFGjEq+SJK
         ZYvOB00ShqmSXS7CXhPY8hZ9MCMnJS6Le3tuc7ckIa1uqYQINYDueKcnthpHeIae4vI6
         yepNLFfcmEzLvmlLX6QA6wM3yFaUX3DigXae81DLwVuCO9cyo/Mf+lTXGlauuloY8L9r
         yuTDSstfIPBPncoGehCS60mw7HFl16ZNvxyQU8IqVnkQoWDFP83Vdmtv87kqcuxMgo2r
         NqW8K3Grv6DvAv5jpkr/t6gv3c4PEIR1qWa+33t1KsIcLY5+o6NwaWxxJxiSSk8tj6Mj
         3pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=dWHcSl+qV/ewcMbxZBTT0+5lIFUMoe4sskE51jeT9lk=;
        b=oB+PathOP1svVHHeXJE+cY2WHJobUg1rvb/mKEqkdc32mcfkpy8TdDkUfHeb+/if+n
         2iISsKEay/jFl/ZJYwcSTjwTRWRsVuJ9w9ocfTmv6JQTcMvUHzbH3U3WzByqJwWJEb1u
         jRhQkWcgimqVV9tgeD2TBO2FT+Zp85nxU8NnbiSjumysB9i9swl1jylQ6qL3p/z3NnUg
         x6YmmDxPHChECuvRsaivQb/BzSqYCuPVB5qvNfVIhoOHUL31oCg8wuD3Fp/VxBsE5n24
         9XLmiIC0r1n40eEipASTl/8JB2YoHgREXvB1PYZHLXSXNXQmnz8BTHq0Hbcu3vfsP/vv
         fMRw==
X-Gm-Message-State: AOAM533F0YxSrjA9JUtDukuKP6hzN46aMm6nj1EzaDXOTctCAIfeqkhg
        pSmGmsNZ30siL9iR7w8vbmfwegncpi1amxiBsAQ=
X-Google-Smtp-Source: ABdhPJzx18mqHyQ4etVh1LD4UcOLiKcnXXsoj42hNNmGLq1OnW/+nQ0kwzVRMEqW0axSc18V2VGu02BP/HutZChrMrM=
X-Received: by 2002:a92:d843:: with SMTP id h3mr6290036ilq.255.1594751425849;
 Tue, 14 Jul 2020 11:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu> <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan> <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
In-Reply-To: <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 20:30:14 +0200
Message-ID: <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I did a full new build...
>
> ...and it fails with ld.lld-11 as linker:
>
> ld.lld-11 -m elf_x86_64 -pie  --no-dynamic-linker -r -o
> arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o
> -T arch/x86/boot/compressed/.tmp_misc.ver; mv -f
> arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o;
> rm -f arch/x86/boot/compressed/.tmp_misc.ver; fi
> *** ld.lld-11: error: -r and -pie may not be used together ***
> make[5]: *** [scripts/Makefile.build:281:
> arch/x86/boot/compressed/misc.o] Error 1
>
> It's annoying to fail on the last minutes of a build.
> Sorry for being very honest.
>

I applied this diff...

$ git diff arch/x86/boot/compressed/Makefile
diff --git a/arch/x86/boot/compressed/Makefile
b/arch/x86/boot/compressed/Makefile
index 789d5d14d8b0..9ba52a656838 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -51,7 +51,10 @@ UBSAN_SANITIZE :=n
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
+# LLD linker does not allow -r and -pie options to be used together.
+ifndef CONFIG_LD_IS_LLD
 KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
+endif
 LDFLAGS_vmlinux := -T

 hostprogs      := mkpiggy

...and was able to build, assemble, link arch/x86/boot/compressed/*.

- Sedat -
