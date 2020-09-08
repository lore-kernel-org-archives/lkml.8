Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649FEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2313421919
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599547344;
	bh=G/unC9tDIykyDy4VNj9lPegEFGYDWJqI75rh2wbFfBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Xx0qXn4pm3mHDawYvxQIfSmKnDnB5mb9n7TWMjE7+RE2SZFScOnBP0IG6qxM/0yxo
	 mH5kcgPw4WpuTqtNHDLa8Cs+RLA1NPCZw67zihi16cdiXgv0fS4iuve36J293gm/IU
	 6nKWqEHmNv53/Q1X3X+tlVer9CgDWGLcVYoLM8mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgIHGmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgIHGmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:42:20 -0400
Received: from coco.lan (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE9821532;
        Tue,  8 Sep 2020 06:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599547339;
        bh=G/unC9tDIykyDy4VNj9lPegEFGYDWJqI75rh2wbFfBc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z/w+D6BkXxTlstn3Ad5ZuhYV0/WVmN6v6LVcxfH0PhSPwOA81ugYYZSgYe4iGrpjv
         xeiT8Za9k9G71FCxXMVPOI3trLO7O3LKobkXL1Pyd51XtgD6h2/k4zwVdPr0SOBBiT
         wrSiaL2FSw3/vkY0yOEoiC04nFzKkpXKO1XWWhIY=
Date:   Tue, 8 Sep 2020 08:42:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v6 04/13] usb: dwc3: Add splitdisable quirk for
 Hisilicon Kirin Soc
Message-ID: <20200908084206.6eeaa599@coco.lan>
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

> >>  static const struct dev_pm_ops dwc3_dev_pm_ops = {
> >>  	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
> >> +	.complete = dwc3_complete,  
> 
> why is this done on complete? Why can't it be done at the end of
> dwc3_resume()?

Updating my answer:

No. I just tested moving the code from .complete to the end of
.resume. After moving it, the HID won't be able to properly enable
the device at resume time (logs filtered to show only relevant msgs):

	# echo reboot > /sys/power/disk; echo disk > /sys/power/state

	...
	[   29.051314] Freezing user space processes ... (elapsed 0.001 seconds) done.
	[   29.059811] OOM killer disabled.
	[   30.171526] PM: hibernation: Creating image:
	[   30.171526] PM: hibernation: Need to copy 164192 pages
	[   30.171526] PM: hibernation: Image created (164192 pages copied)
	[   30.171644] Enabling non-boot CPUs ...
	[   30.293953] dwc3 ff100000.dwc3: dwc3_resume
	[   30.424549] usb usb1-port1: status 0101 change 0001
	[   30.428538] usb usb2-port1: status 0203 change 0001
	[   30.536609] usb 1-1: Waited 0ms for CONNECT
	[   30.543822] usb 1-1: finish reset-resume
	[   30.544619] usb 2-1: Waited 0ms for CONNECT
	[   30.558869] usb 2-1: finish reset-resume
	[   30.676706] usb 1-1: reset high-speed USB device number 2 using xhci-hcd
	[   30.882194] hub 1-1:1.0: hub_reset_resume
	[   30.888479] hub 1-1:1.0: enabling power on all ports
	[   30.960767] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using xhci-hcd
	[   30.994229] hub 2-1:1.0: hub_reset_resume
	[   31.000574] usb 1-1-port1: status 0301 change 0001
	[   31.002088] hub 2-1:1.0: enabling power on all ports
	[   31.009079] usb 1-1-port2: status 0101 change 0001
	[   31.132633] usb 1-1.2: Waited 0ms for CONNECT
	[   31.132665] usb 1-1.1: Waited 0ms for CONNECT
	[   31.140560] usb 1-1.2: finish reset-resume
	[   31.148509] usb 1-1.1: finish reset-resume
	[   31.240760] usb 1-1.2: reset high-speed USB device number 4 using xhci-hcd
	[   32.471492] dwc3 ff100000.dwc3: dwc3_complete
	[   32.480512] PM: Cannot find swap device, try swapon -a
	[   32.489532] PM: Cannot get swap writer
	[   32.575790] Restarting tasks ... 
	[   32.575891] hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
	[   32.575894] hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
	[   32.575896] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0002
	[   32.576570] hub 2-1:1.0: state 7 ports 4 chg 0000 evt 0000
	[   32.576876] done.
	[   32.600094] hub 2-1:1.0: hub_suspend
	[   32.642090] PM: hibernation: hibernation exit
	[   32.650255] usb 2-1: usb auto-suspend, wakeup 1
	[   32.668581] hub 2-0:1.0: hub_suspend
	[   33.122384] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0002
	[   33.378220] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
	[   33.698394] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000
	[   34.882365] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0002
	[   35.138217] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
	[   35.458617] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000
	[   36.642392] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0002
	[   36.898207] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
	[   37.218598] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000
	[   37.672658] kirin9xx-drm e8600000.dpe: [drm:dss_disable_vblank [kirin9xx_drm]] dss_disable_vblank
	[   38.402368] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0002
	[   38.658174] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
	[   38.978594] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000
	[   40.162361] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0002
	[   40.418148] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
	...
	[  397.698132] usb 1-1.1: reset low-speed USB device number 3 using xhci-hcd
	[  398.018565] hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000

Basically, after resume, the code behaves just like the quirk were
not applied.

Explaining with more details, without the splitdisable quirk, what
happens is that the USB URBs return -EPROTO errors, causing
hid-core.c to call hid_io_error(). This function starts a reset
work (usbhid->reset_work), which ends calling (at hid_reset()):

	usb_queue_reset_device(usbhid->intf);

This happens on every HZ/2 intervals, causing an endless reset
loop.

Thanks,
Mauro
