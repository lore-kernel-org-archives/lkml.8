Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F276C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572932082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gMJvLtSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgFQSQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgFQSQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:16:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AFBC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:16:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r18so1666556pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iHpdxTSsJV8Zk3XZ13SNgoX2KXs00CS5Ze28gN8oq4=;
        b=gMJvLtSibvq67YGso8XYpxFnSmLZoRjXPPUqyKDRwnWdCpcHeBmiNXdCbfKIchRtS/
         hSrhpIY5G7Y545ckpnYuA0wk9iqFRhMBkVDUmF6WUUfqekbbOSIevevUjfvYN4Ajzg10
         JOlCYV4rfTaZeQjmKY2lxB1ix82WlXrDuFdOrFqYvVFVv3+83qGR6eAk+PqJSucsnE25
         Hb99nFfaWuFRgy0aSWVLAUOlzrVOWXFzx8nqFIvPjvOLp+sIB6Wbbbt3E2kymty5XyHK
         uuj9vWZadGn6o20m/C7bRAb/vv7JfEx3QnVGPygvY0Qm7ipcvW5t+9VJoz8Au7Mkpd0O
         nRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iHpdxTSsJV8Zk3XZ13SNgoX2KXs00CS5Ze28gN8oq4=;
        b=UkW8Tj/+KSKzeuGiBk8OutyIF/uJfTceWncBBsdbrEJz0kt11dfZYCTRbM4dViMb8F
         lqnwgAFushrx8FvxA37PHXYmn3yMWNTe+UX4a7GKs06hpy8omq8Wo8Dv2I0jm99hcCuH
         OGGzWnGhlPMJRMQSsibFwUmK6izHijeDvd8DU40zJCcx+pm9sXeU5xHlvoddNQOOd5wz
         hVUAtbMmV3HInB9lM7doTGeuwZsGia4LPqGwJ8Z+7MPwMh9laa+i5rfb72x5iD5BB73e
         bkEOd19eqtJy3F2lktA7r2u9cNOu/aaFRZ/ZdFg4n45xos7ZdxXCTIDUvA1OWPEr6fzq
         BiAA==
X-Gm-Message-State: AOAM532Oz8JffJ4/TZQrEcUkKoKmGXWJPIiN8miaTW9jLq6fTXGoYM7c
        74Ig2cShvkY5v4opWsL4EwaH14rtmlWrcw9I9xDKdw==
X-Google-Smtp-Source: ABdhPJzfTBWS0aJ5XI2zVM6jazuKCFG/ugBxDHwAZofS2hb3/+lnVHVZ9XQKA3bIEz+6O/pqZK+UEL1W9pWZ+PUEU/4=
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr247pfu.169.1592417814250;
 Wed, 17 Jun 2020 11:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590079968.git.christophe.leroy@csgroup.eu>
 <8c593895e2cb57d232d85ce4d8c3a1aa7f0869cc.1590079968.git.christophe.leroy@csgroup.eu>
 <20200616002720.GA1307277@ubuntu-n2-xlarge-x86> <68503e5e-7456-b81c-e43d-27cb331a4b72@xilinx.com>
 <20200616181630.GA3403678@ubuntu-n2-xlarge-x86> <50fb2dd6-4e8f-a550-6eda-073beb86f2ff@xilinx.com>
 <87bllidmk4.fsf@mpe.ellerman.id.au> <878sgmdmcv.fsf@mpe.ellerman.id.au>
In-Reply-To: <878sgmdmcv.fsf@mpe.ellerman.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 Jun 2020 11:16:42 -0700
Message-ID: <CAKwvOdnkcjLGay0jdQ77kHTmKhE56F9jvzh01XWwEE8rjbhLAA@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] powerpc: Remove Xilinx PPC405/PPC440 support
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 3:20 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Michal Simek <michal.simek@xilinx.com> writes:
> <snip>
>
> >> Or if bamboo requires uImage to be built by default you can do it via
> >> Kconfig.
> >>
> >> diff --git a/arch/powerpc/platforms/44x/Kconfig
> >> b/arch/powerpc/platforms/44x/Kconfig
> >> index 39e93d23fb38..300864d7b8c9 100644
> >> --- a/arch/powerpc/platforms/44x/Kconfig
> >> +++ b/arch/powerpc/platforms/44x/Kconfig
> >> @@ -13,6 +13,7 @@ config BAMBOO
> >>         select PPC44x_SIMPLE
> >>         select 440EP
> >>         select FORCE_PCI
> >> +       select DEFAULT_UIMAGE
> >>         help
> >>           This option enables support for the IBM PPC440EP evaluation board.
> >
> > Who knows what the actual bamboo board used. But I'd be happy to take a
> > SOB'ed patch to do the above, because these days the qemu emulation is
> > much more likely to be used than the actual board.
>
> I just went to see why my CI boot of 44x didn't catch this, and it's
> because I don't use the uImage, I just boot the vmlinux directly:
>
>   $ qemu-system-ppc -M bamboo -m 128m -display none -kernel build~/vmlinux -append "console=ttyS0" -display none -nodefaults -serial mon:stdio
>   Linux version 5.8.0-rc1-00118-g69119673bd50 (michael@alpine1-p1) (gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #4 Wed Jun 17 20:19:22 AEST 2020
>   Using PowerPC 44x Platform machine description
>   ioremap() called early from find_legacy_serial_ports+0x690/0x770. Use early_ioremap() instead
>   printk: bootconsole [udbg0] enabled
>
>
> So that's probably the simplest solution?

If the uImage or zImage self decompresses, I would prefer to test that as well.

> That means previously arch/powerpc/boot/zImage was just a hardlink to
> the uImage:

It sounds like we can just boot the zImage, or is that no longer
created with the uImage?
-- 
Thanks,
~Nick Desaulniers
