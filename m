Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327ECC2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132522078E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDIMaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:30:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:32630 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIMaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:30:09 -0400
IronPort-SDR: tLcE/I/nyxdIntRi+kIFpwB43fynvVDm2JC34IXFaiNzWqh4X8nHQ0P3bP8zFqKEDPGGnrdsgG
 0cqcL8Bo37OA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 05:30:09 -0700
IronPort-SDR: jNckGK922sv43RdgPwXtoSA0NNEQdR62cPtNEuay78mLz49CqmwXBAhFjv+7kH0lXUfRn2pGQ2
 DHLGdtuAjqJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,362,1580803200"; 
   d="scan'208";a="362140105"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2020 05:30:03 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jMWJp-00GxB8-3x; Thu, 09 Apr 2020 15:30:05 +0300
Date:   Thu, 9 Apr 2020 15:30:05 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 4/4] usb: host: Add ability to build new Broadcom STB
 USB drivers
Message-ID: <20200409123005.GZ3676135@smile.fi.intel.com>
References: <20200408181406.40389-1-alcooperx@gmail.com>
 <20200408181406.40389-5-alcooperx@gmail.com>
 <CAHp75Vd_nbgwdE5Fbm3oxd_+51BJZ=67sVyjKiN2zLS+J4X-Fw@mail.gmail.com>
 <CAOGqxeXQE0z=+6yuEME48am__2vtJhBpetYd_sZamJmm1h_TLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGqxeXQE0z=+6yuEME48am__2vtJhBpetYd_sZamJmm1h_TLQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 07:49:52AM -0400, Alan Cooper wrote:
> On Thu, Apr 9, 2020 at 5:08 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Apr 9, 2020 at 12:52 AM Al Cooper <alcooperx@gmail.com> wrote:
> > >
> > > Add the build system changes needed to get the Broadcom STB XHCI,
> > > EHCI and OHCI functionality working. The OHCI support does not
> > > require anything unique to Broadcom so the standard ohci-platform
> > > driver is being used. The link order for XHCI was changed in the
> > > Makefile because of the way STB XHCI, EHCI and OHCI controllers
> > > share a port which requires that the XHCI driver be initialized
> > > first. Also update MAINTAINERS.
> >
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3477,6 +3477,14 @@ S:       Supported
> > >  F:     drivers/i2c/busses/i2c-brcmstb.c
> > >  F:     Documentation/devicetree/bindings/i2c/brcm,brcmstb-i2c.yaml
> > >
> > > +BROADCOM BRCMSTB USB EHCI DRIVER
> > > +M:     Al Cooper <alcooperx@gmail.com>
> > > +L:     linux-usb@vger.kernel.org
> > > +L:     bcm-kernel-feedback-list@broadcom.com
> > > +S:     Maintained
> > > +F:     drivers/usb/host/ehci-brcm.*
> > > +F:     Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
> >
> > This has ordering issues.
> > Run parse-maintainer.pl to fix. (Note, it creates by default a new
> > file, you might need to run diff manually to see the difference).
> 
> I'm not sure what you mean.
> I ran "./scripts/parse-maintainers.pl" and did "diff MAINTAINERS
> MAINTAINERS.new" and there are no differences in or around my entry.

Perhaps --order should be added.

-- 
With Best Regards,
Andy Shevchenko


