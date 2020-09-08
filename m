Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A0FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3BA2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgIHSlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:41:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:44110 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbgIHQIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:08:02 -0400
IronPort-SDR: uLxPuV8d9XkW6JGSbKn9vizfXWT1McBTUjcaMaRCXJm0ufVZv7vWcqy5QTq2UpPc9Ly0A27bjb
 jNozPR3zfH7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="145840204"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="145840204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 06:50:28 -0700
IronPort-SDR: pq8KqwTDLKt08i4BP3htSDweMGmnV1y1djrner8hpQN/ww/skM9AC3AdwSijS44hBYu4ALm5Jr
 +wiqc8WsZV7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="333478908"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2020 06:50:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kFduY-00FDX6-P7; Tue, 08 Sep 2020 16:43:50 +0300
Date:   Tue, 8 Sep 2020 16:43:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v1] x86/defconfigs: Unbreak 32-bit defconfig builds
Message-ID: <20200908134350.GX1891694@smile.fi.intel.com>
References: <20200908100018.50188-1-andriy.shevchenko@linux.intel.com>
 <20200908121354.GA3848343@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908121354.GA3848343@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 02:13:54PM +0200, Ingo Molnar wrote:
> 
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > After the commit 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
> > 32-bit builds using defconfig become broken because on x86_64 build host
> > with no ARCH provided the default behaviour is to assume 64-bit independently
> > on the configuration file name. The crucial part is CONFIG_64BIT option
> > that used to be explicit. Let restore the latter option in order to unbreak
> > 32-bit builds.
> 
> So exactly which build method broke due to this? The typical way to do a defconfig build is:
> 
>   make ARCH=i386 defconfig
> 
> which still works fine AFAICS.

uname => x86_64
make i386_defconfig

It was very convenient to not supply ARCH when build on multi-arch host.

-- 
With Best Regards,
Andy Shevchenko


