Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF29C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69093206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgA0KFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:05:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:6723 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgA0KFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:05:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 02:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; 
   d="scan'208";a="228918331"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2020 02:05:41 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iw1H4-00029T-6C; Mon, 27 Jan 2020 12:05:42 +0200
Date:   Mon, 27 Jan 2020 12:05:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH v1] kbuild: Fix off-by-one error when generate a new
 version
Message-ID: <20200127100542.GV32742@smile.fi.intel.com>
References: <20200124195859.86991-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124195859.86991-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 09:58:59PM +0200, Andy Shevchenko wrote:
> When build on, for example, x86 using `make O=... -j64` the version
> in the built kernel comes from include/generated/compile.h, which is:
> 
> 	#define UTS_VERSION "#351 SMP Fri Jan 24 18:46:34 EET 2020"
> 
> While at the end the x86 specific Makefile prints the contents of
> the .version file:
> 
> 	Kernel: arch/x86/boot/bzImage is ready  (#352)
> 
> Obviously the latter is not true. This happens because we first
> check compile.h and update it and then generate new version, which is
> incorrect flow:
> 
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   ...
>   GEN     .version
> 
> In order to fix this, move the version generation from link-vmlinux.sh
> to scripts/version.sh and re-use it in init/Makefile.
> 
> Additionally provide a unified way to get the current version of the build
> and use this in few callers. This will respect the KBUILD_BUILD_VERSION
> in case it's provided.

Hmm... It looks like a mess in my build tree.
I have to setup more experiments here.

-- 
With Best Regards,
Andy Shevchenko


