Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63611C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495C62074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFEMY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:24:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:23444 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgFEMY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:24:27 -0400
IronPort-SDR: JL2WcX4YiNUu2xadeHQyUhaHf2mw1oEpuPxcVzG2KeNEykADLbWXGAW5wvsxaQCfEc4VqxlPz3
 Se2IIkdGkvHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 05:24:27 -0700
IronPort-SDR: Nx8uvp7v30SPS1p7EveMjLFW9NkyOtJ0mrRkf/VCiaLf2SSiLrPdR1G9bAYAqvEW4NbIBL3Jqr
 d24R/T6HHpHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="258679361"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 05 Jun 2020 05:24:25 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jhBOe-00B1df-Ar; Fri, 05 Jun 2020 15:24:28 +0300
Date:   Fri, 5 Jun 2020 15:24:28 +0300
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
Message-ID: <20200605122428.GD2428291@smile.fi.intel.com>
References: <042eddd4b87f0db3588a79d829afe6b23fa8365c.1590017578.git.syednwaris@gmail.com>
 <202005310310.EOelU2v3%lkp@intel.com>
 <CACG_h5oHmkAp68q0EFXZEWhG15EQSHLgx=78gZ72aLShZOztFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACG_h5oHmkAp68q0EFXZEWhG15EQSHLgx=78gZ72aLShZOztFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 02:12:54AM +0530, Syed Nayyar Waris wrote:
> On Sun, May 31, 2020 at 12:50 AM kbuild test robot <lkp@intel.com> wrote:

> > >> WARNING: modpost: lib/test_bitmap.o(.data+0xe80): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp1
> > The variable clump_test_data references
> > the variable __initconst clump_exp1
> > If the reference is valid then annotate the
> > variable with or __refdata (see linux/init.h) or name the variable:
> >
> > --
> > >> WARNING: modpost: lib/test_bitmap.o(.data+0xec8): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp2
> > The variable clump_test_data references
> > the variable __initconst clump_exp2
> > If the reference is valid then annotate the
> > variable with or __refdata (see linux/init.h) or name the variable:
> >
> > --
> > >> WARNING: modpost: lib/test_bitmap.o(.data+0xf10): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp3
> > The variable clump_test_data references
> > the variable __initconst clump_exp3
> > If the reference is valid then annotate the
> > variable with or __refdata (see linux/init.h) or name the variable:
> >
> > --
> > >> WARNING: modpost: lib/test_bitmap.o(.data+0xf58): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp4
> > The variable clump_test_data references
> > the variable __initconst clump_exp4
> > If the reference is valid then annotate the
> > variable with or __refdata (see linux/init.h) or name the variable:

> I am unable to reproduce the compilation warning.

You have to enable section mismatch checker.

> I ran the command:
> make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'  lib/
> 
> But the compilation warning didn't show up. Can anyone please point to me
> what I am doing wrong here? How shall I reproduce the warning? Thanks !

You put some data into init section of the object, while you are trying to
access it from non-init one. It's easy-to-fix issue.

-- 
With Best Regards,
Andy Shevchenko


