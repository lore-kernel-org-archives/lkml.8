Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B525C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC122074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgFHNSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:18:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:13756 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbgFHNSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:18:55 -0400
IronPort-SDR: QuIEVe3jP3QwaDP6Mwyrv8DcJALxwt8VvnbdvlTP2AW1eACa+QjYkS0WZXve5bSh9MPn1fELd1
 En5Vk+qZdXgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 06:18:54 -0700
IronPort-SDR: 7clb7IzBaVpT99eAC8o442QCzH0KAHncz2sY0WF5Tpu9+lg+gzLCTk8oXg8MDuQzrHoWVkg7Ri
 FWFu632oKRIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="446731287"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2020 06:18:51 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jiHfy-00Bgfu-GJ; Mon, 08 Jun 2020 16:18:54 +0300
Date:   Mon, 8 Jun 2020 16:18:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/4] lib/test_bitmap.c: Add for_each_set_clump test
 cases
Message-ID: <20200608131854.GR2428291@smile.fi.intel.com>
References: <042eddd4b87f0db3588a79d829afe6b23fa8365c.1590017578.git.syednwaris@gmail.com>
 <202005310310.EOelU2v3%lkp@intel.com>
 <CACG_h5oHmkAp68q0EFXZEWhG15EQSHLgx=78gZ72aLShZOztFA@mail.gmail.com>
 <20200605122428.GD2428291@smile.fi.intel.com>
 <CACG_h5pHC1gQ62zAatUvgHakuGO6P-OLEwMHoU4_ObNDufXFqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACG_h5pHC1gQ62zAatUvgHakuGO6P-OLEwMHoU4_ObNDufXFqA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 04:45:19AM +0530, Syed Nayyar Waris wrote:
> On Fri, Jun 5, 2020 at 5:54 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Jun 05, 2020 at 02:12:54AM +0530, Syed Nayyar Waris wrote:
> > > On Sun, May 31, 2020 at 12:50 AM kbuild test robot <lkp@intel.com> wrote:
> >
> > > > >> WARNING: modpost: lib/test_bitmap.o(.data+0xe80): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp1
> > > > The variable clump_test_data references
> > > > the variable __initconst clump_exp1
> > > > If the reference is valid then annotate the
> > > > variable with or __refdata (see linux/init.h) or name the variable:
> > > >
> > > > --
> > > > >> WARNING: modpost: lib/test_bitmap.o(.data+0xec8): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp2
> > > > The variable clump_test_data references
> > > > the variable __initconst clump_exp2
> > > > If the reference is valid then annotate the
> > > > variable with or __refdata (see linux/init.h) or name the variable:
> > > >
> > > > --
> > > > >> WARNING: modpost: lib/test_bitmap.o(.data+0xf10): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp3
> > > > The variable clump_test_data references
> > > > the variable __initconst clump_exp3
> > > > If the reference is valid then annotate the
> > > > variable with or __refdata (see linux/init.h) or name the variable:
> > > >
> > > > --
> > > > >> WARNING: modpost: lib/test_bitmap.o(.data+0xf58): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp4
> > > > The variable clump_test_data references
> > > > the variable __initconst clump_exp4
> > > > If the reference is valid then annotate the
> > > > variable with or __refdata (see linux/init.h) or name the variable:
> >
> > > I am unable to reproduce the compilation warning.
> >
> > You have to enable section mismatch checker.
> >
> > > I ran the command:
> > > make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'  lib/
> > >
> > > But the compilation warning didn't show up. Can anyone please point to me
> > > what I am doing wrong here? How shall I reproduce the warning? Thanks !
> >
> > You put some data into init section of the object, while you are trying to
> > access it from non-init one. It's easy-to-fix issue.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> 
> Thanks! I have made code changes for the above warning. Actually I am
> still unable to reproduce the compilation warning. But I believe the
> following code fix will fix the compilation warning:
> 
> In file lib/test_bitmap.c
> 
> @@ -692,7 +692,7 @@ struct clump_test_data_params {
>         unsigned long const *exp;
>  };
> 
> -struct clump_test_data_params clump_test_data[] =
> +static struct clump_test_data_params clump_test_data[] __initdata =
>                                         { {{0}, 2, 0, 64, 8, clump_exp1},
>                                         {{0}, 8, 2, 240, 24, clump_exp2},
>                                         {{0}, 8, 10, 240, 30, clump_exp3},
> 
> 
> 
> Let me know if I should submit a new patchset (v8) for
> 'for_each_set_clump' including above code fix.
> 
> Just to share how I attempted to reproduce the warning (but unsuccessful):
> 
> Step 1: Use the config file in attachment. Download, extract, rename
> file to .config at the root of the tree.
> Step 2: '$ make lib/'
> No warning reproduced after above step 2.
> Step 3: '$ make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix
> -D__CHECK_ENDIAN__' lib/'
> After step 3 I got error in build:
> scripts/kconfig/conf  --syncconfig Kconfig
>   CHECK   scripts/mod/empty.c
> No such file: asan-globals=1
> scripts/Makefile.build:266: recipe for target 'scripts/mod/empty.o' failed
> make[1]: *** [scripts/mod/empty.o] Error 1
> Makefile:1147: recipe for target 'prepare0' failed
> make: *** [prepare0] Error 2
> 
> The command in above step 3 was mentioned in the bot mail.

You need to take their configuration as well.

-- 
With Best Regards,
Andy Shevchenko


