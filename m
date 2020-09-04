Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B449C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11C6204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599227450;
	bh=O1F77+F2CbXL8/RLWmEBkPJ5LNw+lLLEgzH4w9M2Hg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rCFF3rD+GqViLKrZ1bRovnwk0GrJ6jSoEM80fUsAKtnnC5vY7dmGO4cBsOHpwUoaP
	 mLIEq6Kf05wySuheQg2CpxcGwpFDfhYEbzc0n4KakrTLpmVOb52/CWMxqMZYRuLbPK
	 Py+Bji5V4Mn8xbWHeaOIvl0bwfHa+Pdl+Ap6OCWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgIDNu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730655AbgIDNrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:47:21 -0400
Received: from coco.lan (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29B0220658;
        Fri,  4 Sep 2020 13:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599227241;
        bh=O1F77+F2CbXL8/RLWmEBkPJ5LNw+lLLEgzH4w9M2Hg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uD52rfjGv8uJOFrjddc0DoGc7nhEsxV22N9O9ZHlkxSJtzRKzHgDQKXTtIrt9gco9
         ewL5ZMSSkIouQYcRZSwb4iRMxdCre3aIn8w3PLhyw9yGpERCeRvhMacjsRnwgI7uNk
         KwnrNjBkRouiyjYS8fmMEHFeO1kbCb0rnq/pNsCU=
Date:   Fri, 4 Sep 2020 15:47:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 09/10] misc: hisi_hikey_usb: add support for Hikey 970
Message-ID: <20200904154715.70cba0d3@coco.lan>
In-Reply-To: <20200904124523.GE4625@sirena.org.uk>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
        <f45f7663b694b16214604b55527f38eb9232f95b.1599214329.git.mchehab+huawei@kernel.org>
        <20200904122303.GC4625@sirena.org.uk>
        <20200904143848.535d4c13@coco.lan>
        <20200904124523.GE4625@sirena.org.uk>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 4 Sep 2020 13:45:23 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Fri, Sep 04, 2020 at 02:38:48PM +0200, Mauro Carvalho Chehab wrote:
> > Em Fri, 4 Sep 2020 13:23:03 +0100
> > Mark Brown <broonie@kernel.org> escreveu:
> >   
> > > On Fri, Sep 04, 2020 at 12:23:31PM +0200, Mauro Carvalho Chehab wrote:
> > >   
> > > > +	regulator = devm_regulator_get_optional(&pdev->dev, "hub-vdd");
> > > > +	if (IS_ERR(regulator)) {
> > > > +		if (PTR_ERR(regulator) == -EPROBE_DEFER) {
> > > > +			dev_info(&pdev->dev,
> > > > +				 "waiting for hub-vdd-supply to be probed\n");
> > > > +			return PTR_ERR(regulator);
> > > > +		}
> > > > +
> > > > +		/* let it fall back to regulator dummy */
> > > > +		regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
> > > > +		if (IS_ERR(regulator)) {
> > > > +			dev_err(&pdev->dev,
> > > > +				"get hub-vdd-supply failed with error %ld\n",
> > > > +				PTR_ERR(regulator));
> > > > +			return PTR_ERR(regulator);
> > > > +		}
> > > > +	}    
> 
> > > This seems weird - if the supply is non-optional why is the code trying
> > > with devm_regulator_get_optional()?  Just use normal get directly.  
> 
> > That's meant to avoid problems with EPROBE_DEFER.  
> 
> Which problems and in what way does it avoid them?
> 
> > See, Hikey 970 need to initialize 4 drivers for the regulators:
> > SPMI core, SPMI bus controller, MFD and regulator. This can take
> > some time. So, a first call to *regulator_get() may return
> > EPROBE_DEFER, specially if both regulator drivers and USB HUB
> > are builtin.  
> 
> This is totally normal and works fine with normal regulator_get().

When I was porting the drm driver (first from OOT Kernel 4.9 to 4.19.5,
and then from 4.19.5 to 5.7), I'm pretty sure I got several of those
messages:

	"supply %s not found, using dummy regulator\n"

due to EPROBE_DEFER. I remember I ended checked the implementation
of the regulator code on that time. Yet, looking at the current 
implementation of _regulator_get():

        rdev = regulator_dev_lookup(dev, id);
        if (IS_ERR(rdev)) {
                ret = PTR_ERR(rdev);

I see that devm_regulator_get() will do the right thing with
EPROBE_DEFER.

So, I'll replace it at the driver. Thanks for the review!

Thanks,
Mauro
