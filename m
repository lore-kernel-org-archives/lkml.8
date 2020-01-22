Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08761C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82AC24685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAVMxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:53:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:10066 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbgAVMxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:53:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 04:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,350,1574150400"; 
   d="scan'208";a="283659268"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Jan 2020 04:53:02 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 22 Jan 2020 14:53:00 +0200
Date:   Wed, 22 Jan 2020 14:53:00 +0200
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
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 37/38] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200122125300.GO2665@lahna.fi.intel.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-38-mika.westerberg@linux.intel.com>
 <20200122123454.GL15507@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122123454.GL15507@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 12:34:54PM +0000, Lee Jones wrote:
> > +static int intel_pmc_probe(struct platform_device *pdev)
> > +{
> > +	struct intel_scu_ipc_pdata pdata = {};
> > +	struct intel_pmc_dev *pmc;
> > +	int ret;
> > +
> > +	pmc = devm_kzalloc(&pdev->dev, sizeof(*pmc), GFP_KERNEL);
> > +	if (!pmc)
> > +		return -ENOMEM;
> > +
> > +	pmc->dev = &pdev->dev;
> > +	spin_lock_init(&pmc->gcr_lock);
> > +
> > +	ret = intel_pmc_get_resources(pdev, pmc, &pdata);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to request resources\n");
> > +		return ret;
> > +	}
> > +
> > +	pmc->scu = devm_intel_scu_ipc_register(&pdev->dev, &pdata);
> > +	if (IS_ERR(pmc->scu))
> > +		return PTR_ERR(pmc->scu);
> 
> *_register is better than *_probe.  If it was called that (or maybe
> *_init) initially I may have missed the issue altogether ...
> 
> However, I still think it the SCU IPC *device* needs to be a device
> driver and abide by the rules, ensuring it uses the device driver
> model/API.  As such, it should be registered and probed as a device.

Which type of device you suggest here? And which bus it should be
registered to? I think we can make this create a platform_device but
then we would need to do that from the PCI driver as well which seems
unnecessary since we already have the struct pci_dev.

For instance in drivers/mfd/intel-lpss* we use similar approach (the
core part is library that gets called by probe drivers (ACPI, PCI). We
don't create any additional platform_devices.

There is another twist. Ideally we would like to see the SCU IPC probed
and intialized before the MFD children so that we know the SCU IPC is
ready by the time the children devices are created. I guess we could
work it around by returning -EPROBE_DEFER but that does not feel right
to be honest.

Thanks!
