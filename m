Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D53C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE88205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1HdYDG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgENDBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 23:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725932AbgENDBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 23:01:52 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EC3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 20:01:52 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so1250094otu.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 20:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D0DXJFYXFg8miFahx4IIEl7ks6L+9RP226Ci1x5buMc=;
        b=q1HdYDG9rDLhZ1LBql1NRHhTBLZuTZVVoTAF2U5yE520wQ/ui7tsT6B7htvUXNeu8F
         dLNDtvm9T0wm0d74AJ9HPT+QsNMX9dOgzhBDr3av0q9ZHqaySvUT3BygY6DLSTMhPukd
         iXP6inz43EEvuRvqL63Z2k4R2H8+bw/X1BzrVkoyG/CDw035GzR8T9KNOv+lZvrTU3rV
         auledRMBoekIqWHwlRUe9ZfFYRoS4p4Xx+r9tKR342M1+2T5gq2u801Cp+G0L8MzABOH
         ucBOHtXeYM161M6xjgng5ypCnJ83Q3thNGhbFMcnl3aashthmTISg66V8kVRufzNyCNE
         qhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D0DXJFYXFg8miFahx4IIEl7ks6L+9RP226Ci1x5buMc=;
        b=DRnPGmCOCtnx8OSSoUdUZCG4INLbmv2j7pwCx/9GkhGC62u0JgNF/0LF81SQJ8YjTV
         3dLD+PEZHQa3rmHNOYlD/dofDMrHo7xoCJKOtDi1BHK94vL0d1yXisw4DmZTh2YgeSPp
         r9ei1FJGnlEUB5DjMPNnbpncXOhftl1/+57FKaPnwWzlHYGp7WuEuV6Yx6SAFNG7LJL7
         IP2QxWtWEw1EyRwaC9hMer0NiD4EZvbvvEFeg3HHfMMG0r7QYKaQWKcQw7IFU+5F5ZEK
         vNCq7efFoQ12DWzt28Lbu30N0iDnEheBGvzXo42eKx4RbBgvorAJisy5jWfBpoinSx2H
         79mw==
X-Gm-Message-State: AOAM530Z478DXfk2BWKjJ+rvCl16Xfpy0NqhDculzYX1RyA1yLZwFvht
        fqrhSBooyNY9P5Gs4gNaNvlN9WzZ
X-Google-Smtp-Source: ABdhPJw2mSMtGueh+kYHi3JUfD8AL7Md49ogyCiY9Nn1so5fk1oGZGubh8FyEQZMBz3u61Kdru39tw==
X-Received: by 2002:a05:6830:1e7c:: with SMTP id m28mr2041492otr.151.1589425311131;
        Wed, 13 May 2020 20:01:51 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id i127sm3879874oih.38.2020.05.13.20.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 20:01:50 -0700 (PDT)
Date:   Wed, 13 May 2020 20:01:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: ld.lld: error: undefined symbol: kb_cs
Message-ID: <20200514030149.GA1841966@ubuntu-s3-xlarge-x86>
References: <202005140845.lthaPgxR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005140845.lthaPgxR%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:13:48AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   24085f70a6e1b0cb647ec92623284641d8270637
> commit: 5990cdee689c6885b27c6d969a3d58b09002b0bc lib/mpi: Fix building for powerpc with clang

I am certain that this patch did nothing to cause this... Maybe exposed
it but not the root cause.

> date:   3 weeks ago
> config: powerpc-randconfig-r034-20200514 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 310d32cb80a611e6384a921e85607fea05841f26)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         git checkout 5990cdee689c6885b27c6d969a3d58b09002b0bc
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: kb_cs
> >>> referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> >>> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> >>> referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> >>> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> >>> referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> >>> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> >>> referenced 45 more times
> --
> >> ld.lld: error: undefined symbol: kb_data
> >>> referenced by i8042.c:309 (drivers/input/serio/i8042.c:309)
> >>> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> >>> referenced by i8042-ppcio.h:33 (drivers/input/serio/i8042-ppcio.h:33)
> >>> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> >>> referenced by i8042.c:319 (drivers/input/serio/i8042.c:319)
> >>> input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> >>> referenced 15 more times

kb_cs and kb_data are declared as extern void pointers when
CONFIG_WALNUT is set, which this config does. However, it looks like
the definitions of these variables were removed in
commit  917f0af9e5a9 ("powerpc: Remove arch/ppc and include/asm-ppc"),
way back in 2.6.27-rc1... So presumably, this has been broken for 12
years and nobody noticed? Probably means there is a good amount of dead
code that can be removed, or we could just avoid ever selecting this
driver with CONFIG_WALNUT (if it does not actually work without the
special handling from i8042-ppcio.h) while removing the dead code.

Cheers,
Nathan

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 924c541a9260..59b2f655e39e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -138,7 +138,7 @@ config PPC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_MIGHT_HAVE_PC_SERIO if !WALNUT
 	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/drivers/input/serio/i8042-ppcio.h b/drivers/input/serio/i8042-ppcio.h
deleted file mode 100644
index 391f94d9e47d..000000000000
--- a/drivers/input/serio/i8042-ppcio.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _I8042_PPCIO_H
-#define _I8042_PPCIO_H
-
-
-#if defined(CONFIG_WALNUT)
-
-#define I8042_KBD_IRQ 25
-#define I8042_AUX_IRQ 26
-
-#define I8042_KBD_PHYS_DESC "walnutps2/serio0"
-#define I8042_AUX_PHYS_DESC "walnutps2/serio1"
-#define I8042_MUX_PHYS_DESC "walnutps2/serio%d"
-
-extern void *kb_cs;
-extern void *kb_data;
-
-#define I8042_COMMAND_REG (*(int *)kb_cs)
-#define I8042_DATA_REG (*(int *)kb_data)
-
-static inline int i8042_read_data(void)
-{
-	return readb(kb_data);
-}
-
-static inline int i8042_read_status(void)
-{
-	return readb(kb_cs);
-}
-
-static inline void i8042_write_data(int val)
-{
-	writeb(val, kb_data);
-}
-
-static inline void i8042_write_command(int val)
-{
-	writeb(val, kb_cs);
-}
-
-static inline int i8042_platform_init(void)
-{
-	i8042_reset = I8042_RESET_ALWAYS;
-	return 0;
-}
-
-static inline void i8042_platform_exit(void)
-{
-}
-
-#else
-
-#include "i8042-io.h"
-
-#endif
-
-#endif /* _I8042_PPCIO_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index 38dc27ad3c18..eb376700dfff 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -17,8 +17,6 @@
 #include "i8042-ip22io.h"
 #elif defined(CONFIG_SNI_RM)
 #include "i8042-snirm.h"
-#elif defined(CONFIG_PPC)
-#include "i8042-ppcio.h"
 #elif defined(CONFIG_SPARC)
 #include "i8042-sparcio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
