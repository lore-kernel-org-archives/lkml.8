Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2473CC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC545218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599547769;
	bh=1mKSHi4avXLKOb4x4GPVRosfO4em7UMRCY8U1TVyBWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HFShAcVNkZhRG5x1PPar+FEb2BTg4vXpLSknMYu9i0jJuTA0mCVQ2TeV12t8U5/mX
	 mdONN8OJkjXU5PA1S4uFWeDdcMCmXICUDNVi20sZv3cot+hu6wlVllhIgn+NINnLG5
	 qsFk5OlOCXo/egY5J7lTfYaCKHxQx3BA01UtAwCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgIHGt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgIHGtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:49:24 -0400
Received: from coco.lan (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45092065E;
        Tue,  8 Sep 2020 06:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599547763;
        bh=1mKSHi4avXLKOb4x4GPVRosfO4em7UMRCY8U1TVyBWM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KpaSWzryFcdclEShzr9+OabQGQ7I+B9F8b0J7t5+LDwo7wB81tVPqtvDerbNlM1Ye
         MVi6x28bMN4alQ56udfHPcCOKWoqsF1ehMUrZ09nh0X4pfLd0hEv1vJHt9OVodv83R
         U7SL2QkHs1/qXEaPsudsAkopFxWSsQzPPhwqRwK8=
Date:   Tue, 8 Sep 2020 08:49:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20200908084915.5a8c18fc@coco.lan>
In-Reply-To: <87r1rcn6j9.fsf@kernel.org>
References: <20190420064019.57522-1-chenyu56@huawei.com>
        <20190420064019.57522-5-chenyu56@huawei.com>
        <20200907150631.70e1bce0@coco.lan>
        <874ko9of80.fsf@kernel.org>
        <20200907165000.7c42a6da@coco.lan>
        <87r1rcn6j9.fsf@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 08 Sep 2020 09:09:46 +0300
Felipe Balbi <balbi@kernel.org> escreveu:

> >> Why does it affect only Hikey kirin?   
> >
> > As John Stultz didn't re-submit this one (and looking at the DT
> > between Kirin 960 and 970 from the original Kernel 4.9 official
> > drivers), I suspect that only Kirin 970 requires this quirk.
> >
> > It could well be due to some Dwc3 revision, but it could also be due
> > to some differences at the USB part of the SoC, as there are a  
> 
> the reason I ask is that if it's caused by dwc3 revision, then we don't
> need the extra dt property, we can rely on a revision check. If it's
> something that can't be detected in runtime, then we need a property.

Yeah, if it would be possible to auto-detect, that would be
better. Yet, hard to say if it would be possible to do that, 
without access to the Dwc3 docs, and without different hardware 
for testing it.

> > few other things different between hikey 960 and 970: it has a
> > different PHY driver, and there are also some differences at the
> > USB HUB which is connected into it.
> >
> > On both devices, the USB physical ports are actually connected
> > into a HUB. In the case of Hikey 970, the hub seems to be a
> > TI TUSB8041 4-Port Hub:
> > 	
> > 	$ lsusb
> > 	Bus 002 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub
> > 	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > 	Bus 001 Device 004: ID 090c:1000 Silicon Motion, Inc. - Taiwan (formerly Feiya Technology Corp.) Flash Drive
> > 	Bus 001 Device 003: ID 413c:301a Dell Computer Corp. Dell MS116 Optical Mouse
> > 	Bus 001 Device 002: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port Hub
> > 	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> >  
> >> What's the dwc3 revision on
> >> that SoC (grep SNPSID /sys/kernel/debugfs/*dwc3/regdump)?  
> >
> > 	GSNPSID = 0x33313130  
> 
> This isn't even listed as a known revision in dwc3/core.h. Thinh, could
> the issue being described here caused by a known Erratum with this
> particular revision?

Maybe. Again, hard to tell without any documentation from Synopsys.

Maybe some of the Synopsys folks at USB MK can shed a light.

Thanks,
Mauro
