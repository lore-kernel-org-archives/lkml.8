Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF062C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F0021D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582098776;
	bh=bRXfL2GTnznvWkwlNdfHXVNHGjuOP5uo4mDlDjhw/MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=prVLm9Arh7iNpN88eqK0zWxJfDa2lDR5FhUg8YQibHvABkXFEwWLs12xVfawfCAFZ
	 UgNar8tmpHrVQskbk5q07VMlOeYujqvdzMUNgrB2S8izGecZOX63xZDlRrG2U5ov9n
	 wAoPcdeQVNmZYG0JoMjRM0do4RZbx0zwOaNf6H0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgBSHwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:52:55 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38259 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgBSHwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:52:55 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so16617490lfm.5;
        Tue, 18 Feb 2020 23:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pBcXvYpVbcpOivBpwH+KxMjwUZ99WUPQa/e/GZdQhGI=;
        b=HOl3ZPnH9kGEWldoZ6VJkGJrcUkTI97X5hzYlxz88a4LjE3zPG9G4pJV+BFKJ/3ZHC
         wN7IA/IS9O/t+n4UqS8OIyHRJHBp51I7SrPaUHkWWtEDU2KZsoKXsjGvTbCqrhqj+dzP
         gMq+JtBLdaTuGvA30Ds9oIcnLzrMhVlRTEcGrM6eH31RIMJVq8qGSlIl28lXxz0ggEwW
         RID+KLaDl2JQR7/tGQ+uOoENKMDT9lyHYNbtyBiteafMJ5ZNh90YJjiYJSOWmZmkKqBg
         NaYlmKTVxHgEAcX0XrGlWA57byKoqev1oEzMtYk19xFWZcr3cRFcRh9+IkHM0PE9z2k7
         pRqw==
X-Gm-Message-State: APjAAAXQqJe5W0XZy3/Ij+cJGEXx82iQMr7cFaCh4fdfdOtgtHTN0G9T
        rHHOdHi5nC+2u+kLVQMcAec=
X-Google-Smtp-Source: APXvYqxniWWWPPX2NX94mAjgrd5J+QVhCrkvaxE78uLY29DmvxjPj+m2MiISPdQ1Ugvp3CjlSMrY2w==
X-Received: by 2002:ac2:58fa:: with SMTP id v26mr12695059lfo.84.1582098771710;
        Tue, 18 Feb 2020 23:52:51 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id u25sm682904ljj.70.2020.02.18.23.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 23:52:50 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j4KA3-00080g-E8; Wed, 19 Feb 2020 08:52:47 +0100
Date:   Wed, 19 Feb 2020 08:52:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     alexandre.belloni@bootlin.com, b-liu@ti.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ludovic.desroches@microchip.com,
        mathias.nyman@intel.com, nicolas.ferre@microchip.com,
        slemieux.tyco@gmail.com, stern@rowland.harvard.edu, vz@mleia.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/20] usb: remove useless cast for driver.name
Message-ID: <20200219075247.GE2090@localhost>
References: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582054383-35760-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 07:32:43PM +0000, Corentin Labbe wrote:
> This serie remove a useless (char*) cast for some xxx_driver.name.
> pci_driver, device_driver, usb_composite_driver structures have a "name"
> member which is const char * and all the driver patched assigned to it a
> const char[] name, so the cast was bad and unnecessary.
> 
> Corentin Labbe (20):
>   usb: gadget: legacy: gmidi: remove useless cast for driver.name
>   usb: gadget: legacy: inode: remove useless cast for driver.name
>   usb: gadget: udc: amd5536udc_pci: remove useless cast for driver.name
>   usb: gadget: at91_udc: remove useless cast for driver.name
>   usb: gadget: dummy_hcd: remove useless cast for driver.name
>   usb: gadget: fotg210-udc: remove useless cast for driver.name
>   usb: gadget: fusb300_udc: remove useless cast for driver.name
>   usb: gadget: goku_udc: remove useless cast for driver.name
>   usb: gadget: lpc32xx_udc: remove useless cast for driver.name
>   usb: gadget: m66592-udc: remove useless cast for driver.name
>   usb: gadget: net2280: remove useless cast for driver.name
>   usb: gadget: omap_udc: remove useless cast for driver.name
>   usb: gadget: r8a66597-udc: remove useless cast for driver.name
>   usb: gadget: renesas_usb3: remove useless cast for driver.name
>   usb: host: ehci-pci: remove useless cast for driver.name
>   usb: host: ohci-pci: remove useless cast for driver.name
>   usb: host: sl811-hcd: remove useless cast for driver.name
>   usb: host: uhci-pci: remove useless cast for driver.name
>   usb: host: xhci-pci: remove useless cast for driver.name
>   usb: musb: core: remove useless cast for driver.name

Please do trivial conversions like this one in one patch per subsystem
(e.g. all of USB) instead of 20 one-line patches.

You may also want to refer to commit 8d790d740858 ("[PATCH] make
driver's name be const char *") for the historical background for this
in the commit message.

>  drivers/usb/gadget/legacy/gmidi.c       | 2 +-
>  drivers/usb/gadget/legacy/inode.c       | 2 +-
>  drivers/usb/gadget/udc/amd5536udc_pci.c | 2 +-
>  drivers/usb/gadget/udc/at91_udc.c       | 2 +-
>  drivers/usb/gadget/udc/dummy_hcd.c      | 4 ++--
>  drivers/usb/gadget/udc/fotg210-udc.c    | 2 +-
>  drivers/usb/gadget/udc/fusb300_udc.c    | 2 +-
>  drivers/usb/gadget/udc/goku_udc.c       | 2 +-
>  drivers/usb/gadget/udc/lpc32xx_udc.c    | 2 +-
>  drivers/usb/gadget/udc/m66592-udc.c     | 2 +-
>  drivers/usb/gadget/udc/net2280.c        | 2 +-
>  drivers/usb/gadget/udc/omap_udc.c       | 2 +-
>  drivers/usb/gadget/udc/r8a66597-udc.c   | 2 +-
>  drivers/usb/gadget/udc/renesas_usb3.c   | 2 +-
>  drivers/usb/host/ehci-pci.c             | 2 +-
>  drivers/usb/host/ohci-pci.c             | 2 +-
>  drivers/usb/host/sl811-hcd.c            | 2 +-
>  drivers/usb/host/uhci-pci.c             | 2 +-
>  drivers/usb/host/xhci-pci.c             | 2 +-
>  drivers/usb/musb/musb_core.c            | 2 +-
>  20 files changed, 21 insertions(+), 21 deletions(-)

Thanks,
Johan
