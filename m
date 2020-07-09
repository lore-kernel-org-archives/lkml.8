Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7705AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50FB520720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594336486;
	bh=xW5ZUIaFUZ8F2ryg/MIMBCIIAxCs7IdqX8LbQneFc7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BRYph4+/7bkbPmbcK+YwWB0Wg7Qq8oljZ+vBBEqnzbMYdoYOaoFI9HogPkyo22Amj
	 mQ0vL15oDQms2500a36OHeCgkZ4RkxRa/Yr3ZN/s3bQiiOXlhoTIcURpIJ1bflmlsA
	 pDxPKfL1AkOrwGpifDxE5HiVl/Wi9d8vedCSem34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGIXOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:14:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgGIXOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:14:44 -0400
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6A7207BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 23:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594336483;
        bh=xW5ZUIaFUZ8F2ryg/MIMBCIIAxCs7IdqX8LbQneFc7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bckmLmkh9Po8YtNpm/27zrbSWu9uADo71The/uKMl+NtnwAjze0dbixC2Gb02cnUk
         GCKKbJeGCGfSRQGOn8Nh0+ND/xJtSLNZ8zRsE4QZ6wt5ei8HIPkbj3y4XyGu21FyjL
         4wbCG115cs3eRkqlqODpeZZ4oiH0HcbxbHJOVBMM=
Received: by mail-lj1-f169.google.com with SMTP id e4so4301857ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 16:14:43 -0700 (PDT)
X-Gm-Message-State: AOAM5329j25T0G2qYaNICIk6xIkZ5pgZdr8Hioz+wB/ltlZeIsDb5o+N
        vfU7XiiJSl3cMLXOgam9xRGWYmPeI3VjwNpsu+0=
X-Google-Smtp-Source: ABdhPJwEIg1gh2RQ0lo5ghXyLmW2nxdEoAepmZkUERcCZ9+1cvlukxeXZzpSMK2A1oy6jjUFX6tXioZRFEqBMIVHoEc=
X-Received: by 2002:a2e:864e:: with SMTP id i14mr36040422ljj.441.1594336481830;
 Thu, 09 Jul 2020 16:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <1594279697-72511-1-git-send-email-guoren@kernel.org> <202007100213.k2Bq4lQ3%lkp@intel.com>
In-Reply-To: <202007100213.k2Bq4lQ3%lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 10 Jul 2020 07:14:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTyw4d5TQWrvVhq3zT5iT4HpNLc2w3GYA1OwSjcc_xGMw@mail.gmail.com>
Message-ID: <CAJF2gTTyw4d5TQWrvVhq3zT5iT4HpNLc2w3GYA1OwSjcc_xGMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: Add STACKPROTECTOR supported
To:     kernel test robot <lkp@intel.com>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Atish Patra <atish.patra@wdc.com>, kbuild-all@lists.01.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I didn't test riscv32-gcc and it needs to be 16UL.

On Fri, Jul 10, 2020 at 2:37 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.8-rc4 next-20200709]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/guoren-kernel-org/riscv-Add-STACKPROTECTOR-supported/20200709-153112
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
> config: riscv-randconfig-s031-20200709 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-37-gc9676a3b-dirty
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/stackprotector.h:10,
>                     from arch/riscv/kernel/process.c:28:
>    arch/riscv/include/asm/stackprotector.h: In function 'boot_init_stack_canary':
> >> arch/riscv/include/asm/stackprotector.h:26:23: warning: left shift count >= width of type [-Wshift-count-overflow]
>       26 |  canary += tsc + (tsc << 32UL);
>          |                       ^~
>    arch/riscv/kernel/process.c: At top level:
>    arch/riscv/kernel/process.c:42:6: warning: no previous prototype for 'show_regs' [-Wmissing-prototypes]
>       42 | void show_regs(struct pt_regs *regs)
>          |      ^~~~~~~~~
>    arch/riscv/kernel/process.c:103:5: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
>      103 | int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>          |     ^~~~~~~~~~~~~~~~~~~~
>
> vim +26 arch/riscv/include/asm/stackprotector.h
>
>     11
>     12  /*
>     13   * Initialize the stackprotector canary value.
>     14   *
>     15   * NOTE: this must only be called from functions that never return,
>     16   * and it must always be inlined.
>     17   */
>     18  static __always_inline void boot_init_stack_canary(void)
>     19  {
>     20          unsigned long canary;
>     21          unsigned long tsc;
>     22
>     23          /* Try to get a semi random initial value. */
>     24          get_random_bytes(&canary, sizeof(canary));
>     25          tsc = get_cycles();
>   > 26          canary += tsc + (tsc << 32UL);
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
