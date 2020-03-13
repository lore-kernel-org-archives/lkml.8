Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D949C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493E4206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCMQSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:18:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:11114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgCMQSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:18:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 09:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="261935961"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2020 09:18:35 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCn1A-009IkE-Vj; Fri, 13 Mar 2020 18:18:36 +0200
Date:   Fri, 13 Mar 2020 18:18:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/4] Add XHCI, EHCI and OHCI support for Broadcom STB
 SoS's
Message-ID: <20200313161836.GX1922688@smile.fi.intel.com>
References: <20200313141545.31943-1-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313141545.31943-1-alcooperx@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 10:15:41AM -0400, Al Cooper wrote:
> This adds support for the XHCI, EHCI and OHCI host controllers found
> in Broadcom STB SoC's. These drivers depend on getting access to the
> new Broadcom STB USB PHY driver through a device-tree phandle and
> will fail if the driver is not available.

Hint to the future:

	scripts/get_maintainer.pl --git --git-min-percent=67 ...

> 
> Al Cooper (4):
>   dt-bindings: Add Broadcom STB USB support
>   usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
>   usb: ehci: Add new EHCI driver for Broadcom STB SoC's
>   usb: host: Add ability to build new Broadcom STB USB drivers
> 
>  .../bindings/usb/brcm,bcm7445-ehci.yaml       |  60 ++++
>  .../devicetree/bindings/usb/usb-xhci.txt      |   1 +
>  MAINTAINERS                                   |   9 +
>  drivers/usb/host/Kconfig                      |  20 ++
>  drivers/usb/host/Makefile                     |  20 +-
>  drivers/usb/host/ehci-brcm.c                  | 288 ++++++++++++++++++
>  drivers/usb/host/xhci-brcm.c                  |  16 +
>  drivers/usb/host/xhci-brcm.h                  |  16 +
>  drivers/usb/host/xhci-plat.c                  |  11 +
>  9 files changed, 435 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
>  create mode 100644 drivers/usb/host/ehci-brcm.c
>  create mode 100644 drivers/usb/host/xhci-brcm.c
>  create mode 100644 drivers/usb/host/xhci-brcm.h
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


