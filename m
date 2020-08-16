Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB74EC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86820206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 09:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHZrxLVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgHPJhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 05:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgHPJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 05:37:49 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3FFC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 02:37:49 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l204so12233179oib.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 02:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vdeFolz54S0qQkKk6HM9/kh8B5+wcpI8HQoAZlCYNWk=;
        b=AHZrxLVV24TyadXoffwqmI0BdAYIP7udTzaHqoU59+6ye8Uwfx6Z4iB/RR3srIsg8q
         UNsvKIBoSAZrObDUfxG0V7Lrt6+ObL6KhqM8+kNwxl/xJO3sGIj3lCzzFleQiKFX8RdT
         mMtU+IJ/yGm/QY5ihtJhwx2fFzPzQv7fW8FKR8WfHf2mAREGXrfe9X31w1kxxlmRFUDx
         wbxKlwSqJJNByLmxH/e6Mm+D6ZdUVAeZugeiJ5R7wbeU4oIiGVRPQnQCxQkiRQAweHWf
         CymZvtxRG84L8y1v+UHHtYMzYjKB0fEjbsotpXEN8RuQqg63VKop7b9xOUMLJgQmLm2f
         jXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vdeFolz54S0qQkKk6HM9/kh8B5+wcpI8HQoAZlCYNWk=;
        b=UK4v3tYSJDgX+EXA5ehZBKcwyatMOvndiU6KpLEOKQCF3tGPeaahjIiispaBRAbXG9
         ym2jc5oeFU+RUagSTVqsJFwNgyKKFgHuULGC5f0C5DXxNO9O906NFVRn1ulpO8EDROhV
         IouBNPT80S/++qv4Cn7kvyuybU2niIIvSGo7j3FGnHSbxCEs4+a9en42duS90z9nZZV1
         AtxRazHy6zgYg4PU6uPOrFs8TuWKYVU9YmhgWeRE++sGM4GfUzirSOiX0k6jzXtkv6lU
         kkMP5kI0n3itMRicxBCayldbUBTBXN/Q2qYdQioj5+qf/elDm22QqKLF5w9iZj8l/u4I
         DydA==
X-Gm-Message-State: AOAM531QGybRxdq1vIXQFg5uO1ZBqu/fjuVUvwzaSYuY05xS76BdVu6E
        tqLV1j7jmUpgb7xGlkPG5SZikjN22c4YQnT251k=
X-Google-Smtp-Source: ABdhPJypkmXVafvWQ4nHtbXg12blS7k3B5AX7+pZOgWkTN5uxT90H/u2ZEJwaru8S73eTNyn790MQt5JXna3FYTrw7I=
X-Received: by 2002:aca:724f:: with SMTP id p76mr6348374oic.35.1597570669063;
 Sun, 16 Aug 2020 02:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de> <CAKwvOdmA29WzTd7APsQCsG_a=NVWuR53Z2h8NTLza5sisnV2PA@mail.gmail.com>
 <CA+icZUUjtu3fCNTngY52h3uRL+eUaimNJb0UNwj5v-QwKggs5A@mail.gmail.com>
 <CA+icZUWH5f4B_6eYy2_OOi45VjUkE_kN9akqvcOxxmmmM3TSrg@mail.gmail.com>
 <CAKwvOdnj6ObdpsdVYkDxWp-dVTTg=xMkBm84y419SNtLuAqfMg@mail.gmail.com>
 <CAKwvOdnahyqQQMdWhzpaYkJNi21Ux=8qyBmRnPidiT_RAn0YFw@mail.gmail.com>
 <CA+icZUVKBsp4cJV5V=ZtywEi=Ary5w-fNSijkNknU+U9xiKRRg@mail.gmail.com>
 <CA+icZUV5m+kPWpk0ovoWD+DK0Tn8=c0MdWnr2XTxStwXf_VF0g@mail.gmail.com>
 <CA+icZUW6vb2JgKCnWMx-yRU24benZNLizwk30HLPGwYrNDR-3A@mail.gmail.com> <CA+icZUWpExhm951r9C2XCrMXiZ4KXMioc_YzhxWW3i+tHNDqLw@mail.gmail.com>
In-Reply-To: <CA+icZUWpExhm951r9C2XCrMXiZ4KXMioc_YzhxWW3i+tHNDqLw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 16 Aug 2020 11:37:37 +0200
Message-ID: <CA+icZUUV-vXQFkhDrLTCtnCpuKR5BpZ_SG+9376aK2g+BcE-hA@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC toolchain simply ignores if kaslr_64.o has __force_order means the
build ends up successfully whereas LLVM toolchain and IAS breaks and
the build stops and needs explicitly commit
df6d4f9db79c1a5d6f48b59db35ccd1e9ff9adfc ("x86/boot/compressed: Don't
declare __force_order in kaslr_64.c") reverted to fix this.
With the revert GCC toolchain is also fine.

Maybe it is good to revert that commit?

This is with [1]:

diff --git a/arch/x86/include/asm/special_insns.h
b/arch/x86/include/asm/special_insns.h
index 59a3e13204c3..e1c19c5ecd5e 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -17,7 +17,7 @@
  * all loads stores around it, which can hurt performance. Solution is to
  * use a variable and mimic reads and writes to it to enforce serialization
  */
-extern unsigned long __force_order;
+extern unsigned long __force_order __weak;

 void native_write_cr0(unsigned long val);

...and the patchset of "x86/boot: Remove run-time relocations from
compressed kernel" applied [3].

More details in [4].

- Sedat -

References:
[1] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674182703
[2] https://git.kernel.org/linus/df6d4f9db79c1a5d6f48b59db35ccd1e9ff9adfc
[3] https://lore.kernel.org/patchwork/project/lkml/list/?series=456251
[4] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-674502114
