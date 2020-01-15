Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F34C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62AA2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgAOI6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:58:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:26344 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgAOI6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:58:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 00:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="252589836"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 15 Jan 2020 00:58:36 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 15 Jan 2020 10:58:36 +0200
Date:   Wed, 15 Jan 2020 10:58:36 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 26/36] mfd: intel_soc_pmic: Add SCU IPC member to
 struct intel_soc_pmic
Message-ID: <20200115085836.GZ2838@lahna.fi.intel.com>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
 <20200113135623.56286-27-mika.westerberg@linux.intel.com>
 <20200115084410.GG325@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115084410.GG325@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 08:44:10AM +0000, Lee Jones wrote:
> On Mon, 13 Jan 2020, Mika Westerberg wrote:
> 
> > Both PMIC drivers (intel_soc_pmic_mrfld and intel_soc_pmic_bxtwc) will
> > be using this field going forward to access the SCU IPC instance.
> > 
> > While there add kernel-doc for the intel_soc_pmic structure.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/linux/mfd/intel_soc_pmic.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
> > index bfecd6bd4990..bda22d750be6 100644
> > --- a/include/linux/mfd/intel_soc_pmic.h
> > +++ b/include/linux/mfd/intel_soc_pmic.h
> > @@ -13,6 +13,20 @@
> >  
> >  #include <linux/regmap.h>
> >  
> > +/**
> > + * struct intel_soc_pmic - Intel SoC PMIC data
> > + * @irq: Interrupt number
> 
> Whose IRQ is this?  I guess the parent's/PMIC's?

Yes, I'll fix it up.

> > + * @regmap: Pointer to the regmap structure
> 
> Whose Regmap is this?  I guess the parent's/PMIC's?

Ditto

> > + * @irq_chip_data: IRQ chip data for the PMIC itself
> > + * @irq_chip_data_pwrbtn: Chained IRQ chip data for the power button
> > + * @irq_chip_data_tmu: Chained IRQ chip data for the TMU
> > + * @irq_chip_data_bcu: Chained IRQ chip data for the BCU
> > + * @irq_chip_data_adc: Chained IRQ chip data for the ADC
> > + * @irq_chip_data_chgr: Chained IRQ chip data for the CHGR
> > + * @irq_chip_data_crit: Chained IRQ chip data for the CRIT
> 
> Documentation is an ideal place to expand out these abbreviations.

OK, I'll try to expand them (not familiar with all of them).

> > + * @dev: Pointer to the PMIC device
> > + * @scu: SCU IPC pointer used for IPC operations
> 
> By this description I would have expected to find a struct of ops
> (operations [call-backs]), but instead I found this:
> 
>  struct intel_scu_ipc_dev {
>          struct device *dev;
>          void __iomem *ipc_base;
>          void __iomem *i2c_base;
>          struct completion cmd_complete;
>          u8 irq_mode;
>  };
> 
> Probably better to describe it as a "pointer to SCU (whatever that
> means) IPC (slightly more common, but still better to expand I think)
> device data structure".

Sure.
