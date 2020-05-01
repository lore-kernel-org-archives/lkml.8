Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2BAC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726B7208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgEALum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:50:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:9550 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgEALum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:50:42 -0400
IronPort-SDR: S/o9RZ/p10+pZqi0HsN1eP9VzAzdwnT1emvlc4GaiZ+QIlgmRpzULP+jt2JfTQeLYMmphgLeFI
 YqEAoYUcvYlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 04:50:41 -0700
IronPort-SDR: hqMFSgZLASAlQcWYW03TkQ8qd5QH8tn9pkeAZ/ID7QSH+bipk8LG6FD5/VeMX0DgUY+ve0j0sI
 PSX0HFj6mddA==
X-IronPort-AV: E=Sophos;i="5.73,339,1583222400"; 
   d="scan'208";a="433292060"
Received: from dalessan-mobl1.ir.intel.com ([10.252.13.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 04:50:39 -0700
Message-ID: <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paul J Murphy <paul.j.murphy@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 01 May 2020 12:50:36 +0100
In-Reply-To: <20200501081002.GA1055721@kroah.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
         <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
         <20200501081002.GA1055721@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your feedback.

> 
> First off, there is a "proper" way to send patches to the kernel
> community that Intel has that I do not think you are
> following.  Please
> work with the Intel "Linux group" to do that first, as odds are they
> would have caught all of these issues beforehand (hint, which is why
> that process is in place...)
> 

I actually followed that process and got the OK to try to upstream.

I think the issues you identified went uncaught mainly due to the
limited Linux ARM expertise within that group (and Intel in general).

Anyway, I'll keep working with our Linux Kernel people to try to reduce
the burden on you and the other kernel maintainers.

> > diff --git a/drivers/soc/keembay/Kconfig
> > b/drivers/soc/keembay/Kconfig
> > new file mode 100644
> > index 000000000000..2161bce131b3
> > --- /dev/null
> > +++ b/drivers/soc/keembay/Kconfig
> > @@ -0,0 +1,22 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Keem Bay SoC drivers.
> > +#
> > +
> > +menu "Keem Bay SoC drivers"
> > +
> > +config KEEMBAY_IMR
> > +	bool "Clean-up Keem Bay bootloader IMR at boot"
> > +	depends on ARM64
> > +	help
> > +	  This option makes the Kernel clean up the Isolated Memory
> > Region
> > +	  (IMR) set up by Keem Bay bootloader (U-boot) to protect
> > itself during
> > +	  early boot.
> > +
> > +	  The IMR number to be cleaned up is taken from the device tree
> > +	  (property 'u-boot-imr' of the 'chosen' node).
> > +
> > +	  If you are compiling the Kernel for a Keem Bay SoC select Y,
> > +	  otherwise select N.
> 
> No module support?
> 
> What about kernels that support more than one ARM device in the same
> kernel, you just broke that :(
> 

<cut>

> 
> > +}
> > +early_initcall(kmb_imr_init);
> 
> Like I said above, you just broke multi-system kernels by always
> trying
> to do this.  Trigger off of a hardware device that only your platform
> has in order to properly load and run.  As-is, you don't want to do
> this.

My bad, I didn't consider the issue of multi-platform ARM kernels.

The problem is that I need this code to be run early at boot, so I
don't think I can make this a module.

But I'm sure there is a proper way to achieve what I need without
breaking multi-system kernels. I'll do my homework and try to find it.

> 
> Anyway, Intel owes me more liquor for this review as the resources
> you
> had to get review of this were obviously not taken advantage of.
> 
> greg k-h

