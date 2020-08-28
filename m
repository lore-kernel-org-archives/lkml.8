Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22781C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB89020776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgH1JIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:08:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:32332 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgH1JIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:08:52 -0400
IronPort-SDR: L8a78WkmjigQ90vn0e3dLlOoEZMGcfIDSxjEaEpGFTfkIh/CcyRC7hqC9Nnj9T0ScASL8K4diR
 A5sVNt9Zi8MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="220882682"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="220882682"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 02:08:38 -0700
IronPort-SDR: A5E330doqR0ANFgd8uqrSRaKrCDQfRcDXTne+VNDyJh2zNQDw0hmFE2L/z7xl+bH71iSO0N1T2
 lZkNXOb/uPcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="403696200"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 28 Aug 2020 02:08:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 28 Aug 2020 12:08:32 +0300
Date:   Fri, 28 Aug 2020 12:08:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajmohan Mani <rajmohan.mani@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org, pmalani@chromium.org,
        bleung@chromium.org
Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Message-ID: <20200828090832.GB174928@kuha.fi.intel.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200828074359.GC942935@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828074359.GC942935@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Aug 28, 2020 at 09:43:59AM +0200, Greg Kroah-Hartman wrote:
> I still find this crazy that a whole separate driver is created just to
> read a single 32bit value.
> 
> Why not put this logic in the driver that wants to read that value?
> That would be much simpler, smaller, and more obvious.

That would mean that we start maintaining something like DMI quirk
table in those drivers. Unfortunately the IOM device is not available
on every platform. Also, even on platforms that do have it, there is
no guarantee that the device is always going to be mapped to the same
address.

Nevertheless, I was originally hoping that we could hide the handling
of IOM somehow in ACPI without the need for an actual device object,
but it now turns out that the other features of the IOM chip have
created interest. At least our i915 guys probable have some use for it
(I don't know exactly what they are planning to use it for).

So the fact that we may later need the device for something else, on
top of the clumsiness and most importantly risks involved with using
ACPI to take care of extra tasks (ASL tends to have bugs - bugs that
may never ever get fixed), I think the IOM device object, and the
driver that binds to it, do have a valid reason for existing.


thanks,

-- 
heikki
