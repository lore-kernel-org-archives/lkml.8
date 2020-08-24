Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A9FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728D02071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zQK29oix";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2UjFVzZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHXJ7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgHXJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:58:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20061C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 02:58:35 -0700 (PDT)
Date:   Mon, 24 Aug 2020 11:58:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598263113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBtkaB/urMRjE3KDZiHlShNfLKbL53xdqqZJYFhzB6U=;
        b=zQK29oix1xwa06jMXLKYr+zKUzHU699aC1Y7GbINccUZlofpr3TVjS229SPdTOywDmRmKR
        NNq9UoeBjWaX/R0F6hxFHm8jAhzoNfGfnpSw2mp7P9jQG9M97ORA3QzC/jsF8D6S6Y5e1B
        ne7B3kt63HE45NchLkJPB+UXmLbYw80+j6TftpzTPGbjGe04I5GnFsUgkLuNb64Lb3jfiQ
        HbgRSoBno6ntZfeDAc7O0Zsfs6uKaQJorFtdJjLx+iRcyW76iysPwWEn9vTdvdGWpIgLLU
        HBO8tdEm3he973k81nulL2wfvZ9fWZPsghPqTMMzRVj4qbJCkzBzl3OBROYdhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598263113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBtkaB/urMRjE3KDZiHlShNfLKbL53xdqqZJYFhzB6U=;
        b=2UjFVzZIp1GezRNJ7apJWJOzysrfRYWMPEkSSV724oBmU7zCnuPfW2s/wjn2aPmKMOQayW
        BxglsF10dTFJCpAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: {standard input}:5973: Error: operand out of range (512 is not
 between -512 and 511)
Message-ID: <20200824095831.5lpkmkafelnvlpi2@linutronix.de>
References: <202008241018.RkyIlLKd%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202008241018.RkyIlLKd%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-24 10:17:19 [+0800], kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d012a7190fc1fd72ed48911e77ca97ba4521bccd
> commit: de8f5e4f2dc1f032b46afda0a78cab5456974f89 lockdep: Introduce wait-type checks
> date:   5 months ago
> config: arc-randconfig-r004-20200824 (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout de8f5e4f2dc1f032b46afda0a78cab5456974f89
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    {standard input}: Assembler messages:
> >> {standard input}:5973: Error: operand out of range (512 is not between -512 and 511)
> 

I have here gcc 10 and the output is:
|  CC      arch/arc/kernel/signal.o
|arch/arc/include/asm/bitops.h: Assembler messages:
|arch/arc/include/asm/bitops.h:236: Error: junk at end of line, first unrecognized character is `0'
|arch/arc/include/asm/bitops.h:236: Error: junk at end of line, first unrecognized character is `0'
|make[3]: *** [scripts/Makefile.build:283: arch/arc/kernel/signal.o] Error 1
|make[2]: *** [scripts/Makefile.build:500: arch/arc/kernel] Error 2
|make[1]: *** [Makefile:1788: arch/arc] Error 2

the reason is that:
| #ifndef CONFIG_ARC_PLAT_EZNPS
| BIT_OPS(set, |, bset)
| BIT_OPS(clear, & ~, bclr)
| BIT_OPS(change, ^, bxor)
| #else
| BIT_OPS(set, |, CTOP_INST_AOR_DI_R2_R2_R3)
| BIT_OPS(clear, & ~, CTOP_INST_AAND_DI_R2_R2_R3)
| BIT_OPS(change, ^, CTOP_INST_AXOR_DI_R2_R2_R3)
| #endif

and the config supplied does not accept CTOP_INST_AAND_DI_R2_R2_R3
(which is
	#define CTOP_INST_AAND_DI_R2_R2_R3              0x4A664C04
)
and the assembler does not like that.
After the removal CONFIG_ARC_PLAT_EZNPS I got to stage 2:
|drivers/irqchip/irq-eznps.c:80:16: error: 'CTOP_AUX_IACK' undeclared (first use in this function)
|   80 |  write_aux_reg(CTOP_AUX_IACK, 1 << irq);

so I removed CONFIG_EZNPS_GIC. And then I ended with:
|  LD      vmlinux.o
|arc-linux-ld: gcc-10.1.0-nolibc/arc-linux/bin/../lib/gcc/arc-linux/10.1.0/arc700/libgcc.a(_muldi3.o): compiled for a little endian system and target is big endian
|arc-linux-ld: failed to merge target specific data of file gcc-10.1.0-nolibc/arc-linux/bin/../lib/gcc/arc-linux/10.1.0/arc700/libgcc.a(_muldi3.o)

Please update CI and ARC.

Sebastian
