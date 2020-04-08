Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B208C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C59420678
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgDHS0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:26:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:9897 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgDHS0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:26:05 -0400
IronPort-SDR: WPZG6HhFA53Fr8YR0v5ZLwQWzHb8P//uMhtvTw1XRZmWu/3KUXXjXL2i9ziGNAWxmbqYFRd5HC
 lYj3cj/JMTLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 11:25:57 -0700
IronPort-SDR: kzvi+KBl4k5fsZ2oCipAYSwCzSGcXbflV+yrjvAb05aE9aOA86S/6zKzG+UrgYrTmt3oKadiT6
 9CwsxJ+UDTDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="251643727"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 08 Apr 2020 11:25:54 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jMFOf-00Gles-95; Wed, 08 Apr 2020 21:25:57 +0300
Date:   Wed, 8 Apr 2020 21:25:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB
 SoS's
Message-ID: <20200408182557.GR3676135@smile.fi.intel.com>
References: <20200408181406.40389-1-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408181406.40389-1-alcooperx@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 02:14:02PM -0400, Al Cooper wrote:
> v3 - Addressed all of Andy Shevchenko's review comments for
>      ehci-brcm.c.
>    - Fixed the brcm,bcm7445-ehci.yaml dt-bindings document,
>      dt_binding_check now passes.
>    - Added the XHCI functionality to xhci-plat.c instead of creating
>      new brcmstb files, as suggested by Mathias Nyman.

It's nice, but have you heard what Mathias asked / proposed?

> v2 - Addressed Andy Shevchenko's review comments.
>    - Fixed dt_binding_check error pointed out by Rob Herring.
>    - Removed pr_info message in ehci_brcm_init as suggested by
>      Greg Kroah-Hartman.
> 
> This adds support for the XHCI, EHCI and OHCI host controllers found
> in Broadcom STB SoC's. These drivers depend on getting access to the
> new Broadcom STB USB PHY driver through a device-tree phandle and
> will fail if the driver is not available.
> 
> Al Cooper (4):
>   dt-bindings: Add Broadcom STB USB support
>   usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
>   usb: ehci: Add new EHCI driver for Broadcom STB SoC's
>   usb: host: Add ability to build new Broadcom STB USB drivers
> 
>  .../bindings/usb/brcm,bcm7445-ehci.yaml       |  60 ++++
>  .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
>  MAINTAINERS                                   |   8 +
>  drivers/usb/host/Kconfig                      |  16 +
>  drivers/usb/host/Makefile                     |  16 +-
>  drivers/usb/host/ehci-brcm.c                  | 286 ++++++++++++++++++
>  drivers/usb/host/xhci-plat.c                  |  10 +
>  7 files changed, 391 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
>  create mode 100644 drivers/usb/host/ehci-brcm.c
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


