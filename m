Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D703AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CE5204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lbRHhw/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgFQKUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:20:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40177 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgFQKUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:20:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49n1Kt37Xcz9sSn;
        Wed, 17 Jun 2020 20:20:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592389234;
        bh=oW+aFhY14nVcErSZ1Yr17+EOjunMNqELZDGyY/r4C/Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lbRHhw/nhzDMFxl8iYyc5SrpaxVTXQMRUwQKKZSfAxRKKg93xAROFcATq8H3RsSlC
         d75MOAO59PYtsjMkRYUuwMccPf/naGXDi7Reovhr+UDv9sNU7cnuv/AkILZM5wAEsl
         DE6LfbKp25olwBXMRK+AIfoc5thMBq8rTbbYDu9koN53rpuo8TeUgpiK+41RGya2TX
         tjxqKJMypuZ4jrp64FsddFqF9ZBwFLH3whXX4fmBOlq42X0kM4SMf/rhbPHTi6cVbE
         E2nYkuH8p0QpOTzjUx4pnJW1FPJozgD8d4kyh6HuZrnwGscvnvdx0OO6Zckpz+V/St
         B4rcbwJyPaNOQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal Simek <michal.simek@xilinx.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, arnd@arndb.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5 01/13] powerpc: Remove Xilinx PPC405/PPC440 support
In-Reply-To: <87bllidmk4.fsf@mpe.ellerman.id.au>
References: <cover.1590079968.git.christophe.leroy@csgroup.eu> <8c593895e2cb57d232d85ce4d8c3a1aa7f0869cc.1590079968.git.christophe.leroy@csgroup.eu> <20200616002720.GA1307277@ubuntu-n2-xlarge-x86> <68503e5e-7456-b81c-e43d-27cb331a4b72@xilinx.com> <20200616181630.GA3403678@ubuntu-n2-xlarge-x86> <50fb2dd6-4e8f-a550-6eda-073beb86f2ff@xilinx.com> <87bllidmk4.fsf@mpe.ellerman.id.au>
Date:   Wed, 17 Jun 2020 20:21:04 +1000
Message-ID: <878sgmdmcv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Michal Simek <michal.simek@xilinx.com> writes:
<snip>

>> Or if bamboo requires uImage to be built by default you can do it via
>> Kconfig.
>>
>> diff --git a/arch/powerpc/platforms/44x/Kconfig
>> b/arch/powerpc/platforms/44x/Kconfig
>> index 39e93d23fb38..300864d7b8c9 100644
>> --- a/arch/powerpc/platforms/44x/Kconfig
>> +++ b/arch/powerpc/platforms/44x/Kconfig
>> @@ -13,6 +13,7 @@ config BAMBOO
>>         select PPC44x_SIMPLE
>>         select 440EP
>>         select FORCE_PCI
>> +       select DEFAULT_UIMAGE
>>         help
>>           This option enables support for the IBM PPC440EP evaluation board.
>
> Who knows what the actual bamboo board used. But I'd be happy to take a
> SOB'ed patch to do the above, because these days the qemu emulation is
> much more likely to be used than the actual board.

I just went to see why my CI boot of 44x didn't catch this, and it's
because I don't use the uImage, I just boot the vmlinux directly:

  $ qemu-system-ppc -M bamboo -m 128m -display none -kernel build~/vmlinux -append "console=ttyS0" -display none -nodefaults -serial mon:stdio
  Linux version 5.8.0-rc1-00118-g69119673bd50 (michael@alpine1-p1) (gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #4 Wed Jun 17 20:19:22 AEST 2020
  Using PowerPC 44x Platform machine description
  ioremap() called early from find_legacy_serial_ports+0x690/0x770. Use early_ioremap() instead
  printk: bootconsole [udbg0] enabled


So that's probably the simplest solution?

cheers
