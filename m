Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE850C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B83220739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuL2Xlc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbgDMStO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728106AbgDMStN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:49:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE77CC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:49:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id r14so4890577pfl.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWzgyXi8WfP9fFqRcnSoD6ax3gruQnjDGFT7CkNEe90=;
        b=IuL2Xlc6Ngob+hEzb4FR9FbaRnFNySDm/v5r80j0lBK4mFlBc1c6rvqaUrfaY7opGG
         2vFr0x0huqQWXeSrRRIPTlMkNIqk7KcPJJbvsF7zjOQFGG8+Oqx8d/u4VdBmMbNe7vil
         vBb7S/B15bdmIUmZbh+TdoAiA7t5eKIc3MxPjCVXc/+Z3fNotmodQzCArhtTQOzDkWg7
         ISUWtVmeeOL39dc7asEjTW4wPeIWCOyYW9GePv3rZDhIxDJtV+8IB9QD++01X8Q3jGO8
         UFkBslz7Rz7h/HsH8B4bqYyRzPa0ZOMJdkBiEEsjPm5WIfDlJmNkUi9LMgFGlto23ISa
         Teuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWzgyXi8WfP9fFqRcnSoD6ax3gruQnjDGFT7CkNEe90=;
        b=GFao2ATRA/Ih4hbd626LxkBoO89H7aLmK/+zIAoCWQtHF+klOiCmvBgyBkyzNItUk8
         iZGAqiug+2DmQBOxPstp7Mvw9k4+RJWW2cuYw8Jk7b9v9O/HHr/Ep0kw/aoNGld/mA92
         cV/DoHYqFwUiownhxF2GrHtWSfGCUvtHpbg38Aq5N3CfyD91W8N5a9zWyM4Iz+dIx/qu
         AMfDKJfNj4PobLAR1N5bQJU4hg9C/QAtUAdPVOTlbz3MwdAU/9yRXmoQQXvptWgnBk+c
         yYZoNM75rW/nfngMLed7W6egE9d6Mlvim2e67OLUq4AypYiEQ1YxmyZOS46JXSXPI9YM
         XA9A==
X-Gm-Message-State: AGi0PuZUhKxTDGlQ6xr67GQM2OTU16dzV7x8LvuiuBL2excwwOIwz6IX
        up2wGuWhmDvm3T+C1V+Ur0rD8RYv575Rdyx/vici0w==
X-Google-Smtp-Source: APiQypLcJ5fyu+qRWXQkBZJz9QkXuUhNA8ePI4WAVg9yDsP4/9hqvWqWJgspKjUdhjXquJPbDsP38+m6fvyyWO+0X7E=
X-Received: by 2002:a63:6604:: with SMTP id a4mr17387267pgc.381.1586803751929;
 Mon, 13 Apr 2020 11:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <202004131704.6MH1jcq3%lkp@intel.com>
In-Reply-To: <202004131704.6MH1jcq3%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 11:49:00 -0700
Message-ID: <CAKwvOdnfKF5FqGENvv=BaN-S+V_pE+hLPhVWYuxNdNqhOPUWmA@mail.gmail.com>
Subject: Re: arch/powerpc/platforms/52xx/mpc52xx_pm.c:58:5: error: stack frame
 size of 1040 bytes in function 'mpc52xx_pm_prepare'
To:     kbuild test robot <lkp@intel.com>
Cc:     Dirk Mueller <dmueller@suse.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the wrong report.  This did uncover three new issues for us:
https://github.com/ClangBuiltLinux/linux/issues/989
https://github.com/ClangBuiltLinux/linux/issues/990
https://github.com/ClangBuiltLinux/linux/issues/991

On Mon, Apr 13, 2020 at 2:29 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Dirk,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8f3d9f354286745c751374f5f1fcafee6b3f3136
> commit: e33a814e772cdc36436c8c188d8c42d019fda639 scripts/dtc: Remove redundant YYLOC global declaration
> date:   2 weeks ago
> config: powerpc-randconfig-a001-20200413 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project dd030036f0a2ace74d0bd2242cfdbcf726ef565d)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e33a814e772cdc36436c8c188d8c42d019fda639
>         # save the attached .config to linux build tree
>         COMPILER=clang make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> arch/powerpc/platforms/52xx/mpc52xx_pm.c:58:5: error: stack frame size of 1040 bytes in function 'mpc52xx_pm_prepare' [-Werror,-Wframe-larger-than=]
>    int mpc52xx_pm_prepare(void)
>        ^
>    1 error generated.
> --
> >> arch/powerpc/platforms/embedded6xx/wii.c:195:7: error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
>            if (!machine_is(wii))
>                 ^
>    arch/powerpc/include/asm/machdep.h:248:19: note: expanded from macro 'machine_is'
>                            __attribute__((weak));           \
>                                           ^
>    arch/powerpc/platforms/embedded6xx/wii.c:175:1: note: previous definition is here
>    define_machine(wii) {
>    ^
>    arch/powerpc/include/asm/machdep.h:243:23: note: expanded from macro 'define_machine'
>            struct machdep_calls mach_##name __machine_desc =
>                                 ^
>    <scratch space>:89:1: note: expanded from here
>    mach_wii
>    ^
>    1 error generated.
> --
> >> arch/powerpc/platforms/embedded6xx/mvme5100.c:135:58: error: incompatible pointer types passing 'phys_addr_t *' (aka 'unsigned long long *') to parameter of type 'u32 *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
>            early_read_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_1, &pci_membase);
>                                                                    ^~~~~~~~~~~~
>    arch/powerpc/include/asm/pci-bridge.h:139:32: note: passing argument to parameter 'val' here
>                            int dev_fn, int where, u32 *val);
>                                                        ^
>    1 error generated.
> --
> >> lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                    umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                    ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:790:20: note: expanded from macro 'umul_ppmm'
>            : "=r" ((USItype) ph) \
>                    ~~~~~~~~~~^~
>    1 error generated.
> --
> >> lib/mpi/generic_mpih-mul2.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                    umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                    ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:790:20: note: expanded from macro 'umul_ppmm'
>            : "=r" ((USItype) ph) \
>                    ~~~~~~~~~~^~
>    1 error generated.
> --
> >> lib/mpi/generic_mpih-mul3.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                    umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                    ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:790:20: note: expanded from macro 'umul_ppmm'
>            : "=r" ((USItype) ph) \
>                    ~~~~~~~~~~^~
>    1 error generated.
> --
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:750:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:751:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:757:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:758:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:764:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:765:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:771:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:772:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:778:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:779:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:18: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:725:21: note: expanded from macro 'add_ssaaaa'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:22: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~
>    lib/mpi/longlong.h:726:20: note: expanded from macro 'add_ssaaaa'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:18: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:732:21: note: expanded from macro 'add_ssaaaa'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:22: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~
>    lib/mpi/longlong.h:733:20: note: expanded from macro 'add_ssaaaa'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:18: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:739:21: note: expanded from macro 'add_ssaaaa'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:22: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~
>    lib/mpi/longlong.h:740:20: note: expanded from macro 'add_ssaaaa'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:129:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                            umul_ppmm(n1, n0, d0, q);
>                                            ~~~~~~~~~~^~~~~~~~~~~~~~
>    lib/mpi/longlong.h:790:20: note: expanded from macro 'umul_ppmm'
>            : "=r" ((USItype) ph) \
>                    ~~~~~~~~~~^~
>    lib/mpi/mpih-div.c:137:17: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                            sub_ddmmss(n1, n0, n1, n0, 0, d0);
>                                            ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:750:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:137:21: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                            sub_ddmmss(n1, n0, n1, n0, 0, d0);
>                                            ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:751:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    fatal error: too many errors emitted, stopping now [-ferror-limit=]
>    20 errors generated.
>
> vim +/mpc52xx_pm_prepare +58 arch/powerpc/platforms/52xx/mpc52xx_pm.c
>
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   57
> e6c5eb9541f219 Rafael J. Wysocki       2007-10-18  @58  int mpc52xx_pm_prepare(void)
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   59  {
> 75ca399e82726f Grant Likely            2008-01-18   60          struct device_node *np;
> 66ffbe490b6156 Grant Likely            2008-01-24   61          const struct of_device_id immr_ids[] = {
> 66ffbe490b6156 Grant Likely            2008-01-24   62                  { .compatible = "fsl,mpc5200-immr", },
> 66ffbe490b6156 Grant Likely            2008-01-24   63                  { .compatible = "fsl,mpc5200b-immr", },
> 66ffbe490b6156 Grant Likely            2008-01-24   64                  { .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
> 66ffbe490b6156 Grant Likely            2008-01-24   65                  { .type = "builtin", .compatible = "mpc5200", }, /* efika */
> 66ffbe490b6156 Grant Likely            2008-01-24   66                  {}
> 66ffbe490b6156 Grant Likely            2008-01-24   67          };
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   68          struct resource res;
> 75ca399e82726f Grant Likely            2008-01-18   69
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   70          /* map the whole register space */
> 66ffbe490b6156 Grant Likely            2008-01-24   71          np = of_find_matching_node(NULL, immr_ids);
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   72
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   73          if (of_address_to_resource(np, 0, &res)) {
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   74                  pr_err("mpc52xx_pm_prepare(): could not get IMMR address\n");
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   75                  of_node_put(np);
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   76                  return -ENOSYS;
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   77          }
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   78
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   79          mbar = ioremap(res.start, 0xc000); /* we should map whole region including SRAM */
> fb73538e10c7fc Dmitry Eremin-Solenikov 2010-06-11   80
> 75ca399e82726f Grant Likely            2008-01-18   81          of_node_put(np);
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   82          if (!mbar) {
> 75ca399e82726f Grant Likely            2008-01-18   83                  pr_err("mpc52xx_pm_prepare(): could not map registers\n");
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   84                  return -ENOSYS;
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   85          }
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   86          /* these offsets are from mpc5200 users manual */
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   87          sdram   = mbar + 0x100;
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   88          cdm     = mbar + 0x200;
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   89          intr    = mbar + 0x500;
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   90          gpiow   = mbar + 0xc00;
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   91          sram    = mbar + 0x8000;        /* Those will be handled by the */
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   92          sram_size = 0x4000;             /* bestcomm driver soon */
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   93
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   94          /* call board suspend code, if applicable */
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   95          if (mpc52xx_suspend.board_suspend_prepare)
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   96                  mpc52xx_suspend.board_suspend_prepare(mbar);
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   97          else {
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   98                  printk(KERN_ALERT "%s: %i don't know how to wake up the board\n",
> 2e1ee1f76684c5 Domen Puncer            2007-05-07   99                                  __func__, __LINE__);
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  100                  goto out_unmap;
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  101          }
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  102
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  103          return 0;
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  104
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  105   out_unmap:
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  106          iounmap(mbar);
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  107          return -ENOSYS;
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  108  }
> 2e1ee1f76684c5 Domen Puncer            2007-05-07  109
>
> :::::: The code at line 58 was first introduced by commit
> :::::: e6c5eb9541f2197a3ffab90b1c7a3250a9b51bf6 PM: Rework struct platform_suspend_ops
>
> :::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
> :::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202004131704.6MH1jcq3%25lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
