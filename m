Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E3BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F63A2467A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCjP0s0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbgAVN1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:27:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40603 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbgAVN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:27:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so7244469wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 05:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jxYjF1m7XVJ6yybgNC7PWK2OFBXviRpzBklnqTmBfrc=;
        b=KCjP0s0u1syQwG7xSgBAkB7NM6G2zwgALAMpMu4MUwf57nzgUcuDYJveJ4U9g+6xYW
         G6PKJc8TiUZCoUm7cCu4MQUE+8H19cfQwiZ4uC61vqiypTbUm/KMMsl8CDG/7qqQGjbG
         yn0y4ljg3jMtahbG8BkbDkg1k4DhiYnrgytUdWXC7K8o1B/RP7lJfpPoHGlmep+KGpOo
         DmR22mqQ3cKgZtb4G5hRfHvGt/IMLpUJPR0ANOa34je3lBDJdRQv5lpIf7pYlMVWOPyf
         8eJ5Z0ROAIkZA0Iy+NltNxg8SeamFHZrXnrr0zY5ZfSfbtrh2DUDJ/LdiQtZve3Zcf/B
         CaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jxYjF1m7XVJ6yybgNC7PWK2OFBXviRpzBklnqTmBfrc=;
        b=M+N6KF8MgaRCT+GcUrN8EZ1lNy9yW/Sffy42T2Y0cWK6BmyR3LoBUm+Y/3QHuQBC4U
         +DJYgOm5YhgsUGDvg0ATSMHr4756UTmXh1Bpb9Rv57khuwEVSfJ6xgcBbSWpDRkYSCCR
         37TAxGqz1rICKczZoOF5oRdv5eO065FOQMqvMeEs8Opt050zN+bxkIjJF+tDKuL0eQX0
         TGJePPhpyEj2MBwOJsQi/05d/ESrGJBZgc9PCCFKPZoN35tPSbFbTG95h6k3ysIpzD69
         tOPPIMfRF130VXHvBo8H/Q9XInVXIuf5NCaIYFa+Tm3rys4O1ZeNsLPLzLE5hqdnbMB5
         0tGA==
X-Gm-Message-State: APjAAAVHkNWyPQRD5qwts5pjP/v8xhMt1NbJ9jA+qen4ZU4lEVyt/8ul
        yhGr5kjJ2UK8nhyRY5Q84u4stQ==
X-Google-Smtp-Source: APXvYqxRR7C7wAkzSx2A3Iw/Hy6BV0R2oBVkQXOxu3NbXbaRXGg2QsuNN71lzk4nBUNqTavF8LqBCQ==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr11301374wrr.266.1579699664807;
        Wed, 22 Jan 2020 05:27:44 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id p18sm4086602wmg.4.2020.01.22.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 05:27:44 -0800 (PST)
Date:   Wed, 22 Jan 2020 13:27:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
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
Message-ID: <20200122132757.GM15507@dell>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-38-mika.westerberg@linux.intel.com>
 <20200122123454.GL15507@dell>
 <20200122125300.GO2665@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200122125300.GO2665@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020, Mika Westerberg wrote:

> On Wed, Jan 22, 2020 at 12:34:54PM +0000, Lee Jones wrote:
> > > +static int intel_pmc_probe(struct platform_device *pdev)
> > > +{
> > > +	struct intel_scu_ipc_pdata pdata = {};
> > > +	struct intel_pmc_dev *pmc;
> > > +	int ret;
> > > +
> > > +	pmc = devm_kzalloc(&pdev->dev, sizeof(*pmc), GFP_KERNEL);
> > > +	if (!pmc)
> > > +		return -ENOMEM;
> > > +
> > > +	pmc->dev = &pdev->dev;
> > > +	spin_lock_init(&pmc->gcr_lock);
> > > +
> > > +	ret = intel_pmc_get_resources(pdev, pmc, &pdata);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Failed to request resources\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	pmc->scu = devm_intel_scu_ipc_register(&pdev->dev, &pdata);
> > > +	if (IS_ERR(pmc->scu))
> > > +		return PTR_ERR(pmc->scu);
> > 
> > *_register is better than *_probe.  If it was called that (or maybe
> > *_init) initially I may have missed the issue altogether ...
> > 
> > However, I still think it the SCU IPC *device* needs to be a device
> > driver and abide by the rules, ensuring it uses the device driver
> > model/API.  As such, it should be registered and probed as a device.
> 
> Which type of device you suggest here? And which bus it should be
> registered to? I think we can make this create a platform_device but
> then we would need to do that from the PCI driver as well which seems
> unnecessary since we already have the struct pci_dev.

What kind of device is it?

Refrain from using platform device, unless it is one please.

> For instance in drivers/mfd/intel-lpss* we use similar approach (the
> core part is library that gets called by probe drivers (ACPI, PCI). We
> don't create any additional platform_devices.

That's different.  Here the *-acpi.c and *-pci.c are only used as
registration hooks into the same device.  The semantics we're
discussing are seemingly used to probe/init a different device in a
separate subsystem.

> There is another twist. Ideally we would like to see the SCU IPC probed
> and intialized before the MFD children so that we know the SCU IPC is
> ready by the time the children devices are created. I guess we could
> work it around by returning -EPROBE_DEFER but that does not feel right
> to be honest.

That's precisely what -EPROBE_DEFER was designed for.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
