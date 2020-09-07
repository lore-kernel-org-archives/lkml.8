Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01064C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BB421741
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494315;
	bh=ucJr+saLVcP0I55uqGtU5DQWyYXMW2U5WBZWrLtx+zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0L/4lg4MWgyR4RieLv8Mc6TLc55DR0ICd8k/uFf/1y8RN8rzCRXDW2nZrIrpOJ0Vy
	 5kTtJsnIlti1IIYYTts7CT0bnJheyCklsODsiYzfppTaXBVDK/Crq7R8eNxewcp6UL
	 vzof7yA/3GJ9Zezq/eZy6sAGOTHg+lMwkyLEdV3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgIGP6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbgIGOuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:50:09 -0400
Received: from coco.lan (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650DE21532;
        Mon,  7 Sep 2020 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599490208;
        bh=ucJr+saLVcP0I55uqGtU5DQWyYXMW2U5WBZWrLtx+zk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jJTNEKN6B2ykUQfSlOxxOquiv+y2ri4qBpvBA0yy2WBHyYQ7U60vuSx9SEBF9QlBn
         Ar+/7pK9BivK2eSYEDscpEZzduRbW2j7hxwiRljDzqT3vtxs/9Pq1T4PlIi/i4lUpu
         MPpNKwTKS8Igkyfh9QzkF30mEKEu4P5RLAI0SoJo=
Date:   Mon, 7 Sep 2020 16:50:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>, Yu Chen <chenyu56@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v6 04/13] usb: dwc3: Add splitdisable quirk for
 Hisilicon Kirin Soc
Message-ID: <20200907165000.7c42a6da@coco.lan>
In-Reply-To: <874ko9of80.fsf@kernel.org>
References: <20190420064019.57522-1-chenyu56@huawei.com>
        <20190420064019.57522-5-chenyu56@huawei.com>
        <20200907150631.70e1bce0@coco.lan>
        <874ko9of80.fsf@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 07 Sep 2020 17:04:31 +0300
Felipe Balbi <balbi@kernel.org> escreveu:

> Hi Mauro,
> 
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Felipe/Greg,
> >
> > What's the status of this patch?   
> 
> to be frank, I don't think I have this in my inbox anymore.
> 
> > I tested here, together with the Hikey 970 phy RFC patches I sent
> > last week.
> >
> > Without this patch, the USB HID driver receives -EPROTO from
> > submitted URBs, causing it to enter into an endless reset cycle
> > on every 500 ms, at the hid_io_error() logic.  
> 
> > Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >
> > If you prefer, I can re-submit this one with my SOB.  
> 
> Please do, but since you're changing device tree, I need Rob's acked-by.

Ok, I'll do that.

> > Thanks,
> > Mauro
> >
> > Em Sat, 20 Apr 2019 14:40:10 +0800
> > Yu Chen <chenyu56@huawei.com> escreveu:
> >  
> >> SPLIT_BOUNDARY_DISABLE should be set for DesignWare USB3 DRD Core
> >> of Hisilicon Kirin Soc when dwc3 core act as host.  
> 
> is this Kirin-specific or is this something that we should do a revision
> check? 

I've no idea. I don't have any datasheets from this device.

> Why does it affect only Hikey kirin? 

As John Stultz didn't re-submit this one (and looking at the DT
between Kirin 960 and 970 from the original Kernel 4.9 official
drivers), I suspect that only Kirin 970 requires this quirk.

It could well be due to some Dwc3 revision, but it could also be due
to some differences at the USB part of the SoC, as there are a
few other things different between hikey 960 and 970: it has a
different PHY driver, and there are also some differences at the
USB HUB which is connected into it.

On both devices, the USB physical ports are actually connected
into a HUB. In the case of Hikey 970, the hub seems to be a
TI TUSB8041 4-Port Hub:
	
	$ lsusb
	Bus 002 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 004: ID 090c:1000 Silicon Motion, Inc. - Taiwan (formerly Feiya Technology Corp.) Flash Drive
	Bus 001 Device 003: ID 413c:301a Dell Computer Corp. Dell MS116 Optical Mouse
	Bus 001 Device 002: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

> What's the dwc3 revision on
> that SoC (grep SNPSID /sys/kernel/debugfs/*dwc3/regdump)?

	GSNPSID = 0x33313130

> 
> >> @@ -1825,10 +1834,27 @@ static int dwc3_resume(struct device *dev)
> >>  
> >>  	return 0;
> >>  }
> >> +
> >> +static void dwc3_complete(struct device *dev)
> >> +{
> >> +	struct dwc3	*dwc = dev_get_drvdata(dev);
> >> +	u32		reg;
> >> +
> >> +	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
> >> +			dwc->dis_split_quirk) {
> >> +		dev_dbg(dwc->dev, "set DWC3_GUCTL3_SPLITDISABLE\n");  
> 
> no more dev_dbg() should be added. This driver relies exclusively on
> tracepoints for debugging.

Ok. 

> 
> >> +		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
> >> +		reg |= DWC3_GUCTL3_SPLITDISABLE;
> >> +		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
> >> +	}
> >> +}
> >> +#else
> >> +#define dwc3_complete NULL
> >>  #endif /* CONFIG_PM_SLEEP */
> >>  
> >>  static const struct dev_pm_ops dwc3_dev_pm_ops = {
> >>  	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
> >> +	.complete = dwc3_complete,  
> 
> why is this done on complete? Why can't it be done at the end of
> dwc3_resume()?

Again, no idea. I didn't actually tried to suspend/resume.

Maybe the original author can shed a light on it.

Thanks,
Mauro
