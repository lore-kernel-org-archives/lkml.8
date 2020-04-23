Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FCC55185
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD17E2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 02:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDWCIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:08:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:61411 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgDWCIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 22:08:40 -0400
IronPort-SDR: sBqXayEWg52F/pFDSKUPQU96zpZzbNqqk93B3C6tWHbhq+/9J/ftyQsgUNSUbyfzoDYeKEVCNW
 nuGw/n8ZgQUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 19:08:40 -0700
IronPort-SDR: dW+7VQ4x7y7AnryNYI928QMWa+IOoOhxCpxCXaekQfalHh+BhiXW4m3BH5Fi7otb06liJKPxrc
 P+ythg9ZNHUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,305,1583222400"; 
   d="scan'208";a="402756503"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2020 19:08:39 -0700
Message-ID: <ac04f1aa46234496fc88354add386da725d883ab.camel@intel.com>
Subject: Re: [PATCH 1/1] platform/x86: Add Slim Bootloader firmware update
 signaling driver
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        maurice.ma@intel.com, ravi.p.rangarajan@intel.com,
        sean.v.kelley@intel.com, kuo-lang.tseng@intel.com,
        jithu.joseph@intel.com
Date:   Wed, 22 Apr 2020 19:02:42 -0700
In-Reply-To: <CAHp75VeV+HOditUphBkFoy6LLh6QKfBoC-eLixquAHLTwaz4RQ@mail.gmail.com>
References: <20200420194405.8281-1-jithu.joseph@intel.com>
         <20200420194405.8281-2-jithu.joseph@intel.com>
         <CAHp75VeV+HOditUphBkFoy6LLh6QKfBoC-eLixquAHLTwaz4RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Appreciate your valuable feedback. I think I understood most of your
comments but I need clarification regarding the last comment in this
reply.

On Wed, 2020-04-22 at 16:42 +0300, Andy Shevchenko wrote:
> On Mon, Apr 20, 2020 at 10:50 PM Jithu Joseph <jithu.joseph@intel.com
> > wrote:
> > 
> > 
> > This driver only implements a signaling mechanism, the actual
> > firmware
> > update process and various details like firmware update image
> > format,
> > firmware image location etc are defined by SBL [2] and are not in
> > the
> > scope of this driver.
> 
> I have noticed that it misses ABI documentation. So, please add. Also
> some comments below.

I will add one via a new Documentation/ABI/testing/sysfs-platform-sbl-
fwu-wmi file

> 
> ...
> 
> > [1] https://slimbootloader.github.io
> > [2] https://slimbootloader.github.io/security/firmware-update.html
> 
> Can you add a DocLink: tag below for the reference to the official
> documentation?

I wasnt aware of this tag. Will add this.

> 
> ...
> 
> > +SLIM BOOTLOADER (SBL) FIRMWARE UPDATE WMI DRIVER
> > +M:     Jithu Joseph <jithu.joseph@intel.com>
> > +R:     Maurice Ma <maurice.ma@intel.com>
> > +S:     Maintained
> > +W:     
> > https://slimbootloader.github.io/security/firmware-update.html
> > +F:     drivers/platform/x86/sbl_fwu_wmi.c
> 
> I hope you run latest and greatest version of checkpatch.pl and it's
> okay with this section.

Yes it was fine, chekpatch.pl was merely asking to update the
MAINTAINERS file. And the ordering of the section matches with that of
parse-maintainers.pl

> 
> ...
> 
> > @@ -114,6 +114,16 @@ config XIAOMI_WMI
> >           To compile this driver as a module, choose M here: the
> > module will
> >           be called xiaomi-wmi.
> > 
> > +config SBL_FWU_WMI
> > +       tristate "WMI driver for Slim Bootloader firmware update
> > signaling"
> > +       depends on ACPI_WMI
> > +       help
> > +         Say Y here if you want to be able to use the WMI
> > interface to signal
> > +         Slim Bootloader to trigger update on next reboot.
> > +
> > +         To compile this driver as a module, choose M here: the
> > module will
> > +         be called sbl-fwu-wmi.
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)   += intel-
> > wmi-thunderbolt.o
> >  obj-$(CONFIG_MXM_WMI)                  += mxm-wmi.o
> >  obj-$(CONFIG_PEAQ_WMI)                 += peaq-wmi.o
> >  obj-$(CONFIG_XIAOMI_WMI)               += xiaomi-wmi.o
> > +obj-$(CONFIG_SBL_FWU_WMI)              += sbl_fwu_wmi.o
> 
> I didn't get an ordering schema in above files.
> Shouldn't be rather alphasort?

Looks like there is an ordering within the wmi related files, so I will
move mine in between PEAQ_WMI and XIAOMI_WMI .

> 
> ...
> 
> > +static ssize_t firmware_update_request_store(struct device *dev,
> > +                                            struct
> > device_attribute *attr,
> > +                                            const char *buf,
> > size_t count)
> > +{
> > +       bool val;
> > +       int ret;
> > +
> > +       ret = kstrtobool(buf, &val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = set_fwu_request(dev, val ? 1 : 0);
> 
> Hmm... If you are going to extend this, why not to pass integer
> directly? (And thus take one from user)

We have also been thinking about  extensibility …

So I will modify the code to allow any u32 input by the user  to be
passed down via wmi_set_block(), though 0 and 1 will be the only
inputs  documented  in the ABI today.( Or did you still mean  to error
out if the user input is something other than 0 or 1 ?)

Thanks
Jithu

