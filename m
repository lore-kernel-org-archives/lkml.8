Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B5B2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgERO5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:57:54 -0400
Received: from foss.arm.com ([217.140.110.172]:42182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgERO5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:57:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D2C101E;
        Mon, 18 May 2020 07:57:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84B383F52E;
        Mon, 18 May 2020 07:57:51 -0700 (PDT)
Date:   Mon, 18 May 2020 15:57:49 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Tony Prisk <linux@prisktech.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb/ohci-platform: Fix a warning when hibernating
Message-ID: <20200518145748.puvxkcmyrxc7eqt7@e107158-lin.cambridge.arm.com>
References: <20200424134800.4629-1-qais.yousef@arm.com>
 <Pine.LNX.4.44L0.2004281459240.1555-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2004281459240.1555-100000@netrider.rowland.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/20 15:00, Alan Stern wrote:
> On Fri, 24 Apr 2020, Qais Yousef wrote:
> 
> > The following warning was observed when attempting to suspend to disk
> > using a USB flash as a swap device.
> > 
> > [  111.779649] ------------[ cut here ]------------
> > [  111.788382] URB (____ptrval____) submitted while active
> > [  111.796646] WARNING: CPU: 3 PID: 365 at drivers/usb/core/urb.c:363 usb_submit_urb+0x3d8/0x590
> > [  111.805417] Modules linked in:
> > [  111.808584] CPU: 3 PID: 365 Comm: kworker/3:2 Not tainted 5.6.0-rc6-00002-gdfd1731f9a3e-dirty #545
> > [  111.817796] Hardware name: ARM Juno development board (r2) (DT)
> > [  111.823896] Workqueue: usb_hub_wq hub_event
> > [  111.828217] pstate: 60000005 (nZCv daif -PAN -UAO)
> > [  111.833156] pc : usb_submit_urb+0x3d8/0x590
> > [  111.837471] lr : usb_submit_urb+0x3d8/0x590
> > [  111.841783] sp : ffff800018de38b0
> > [  111.845205] x29: ffff800018de38b0 x28: 0000000000000003
> > [  111.850682] x27: ffff000970530b20 x26: ffff8000133fd000
> > [  111.856159] x25: ffff8000133fd000 x24: ffff800018de3b38
> > [  111.861635] x23: 0000000000000004 x22: 0000000000000c00
> > [  111.867112] x21: 0000000000000000 x20: 00000000fffffff0
> > [  111.872589] x19: ffff0009704e7a00 x18: ffffffffffffffff
> > [  111.878065] x17: 00000000a7c8f4bc x16: 000000002af33de8
> > [  111.883542] x15: ffff8000133fda88 x14: 0720072007200720
> > [  111.889019] x13: 0720072007200720 x12: 0720072007200720
> > [  111.894496] x11: 0000000000000000 x10: 00000000a5286134
> > [  111.899973] x9 : 0000000000000002 x8 : ffff000970c837a0
> > [  111.905449] x7 : 0000000000000000 x6 : ffff800018de3570
> > [  111.910926] x5 : 0000000000000001 x4 : 0000000000000003
> > [  111.916401] x3 : 0000000000000000 x2 : ffff800013427118
> > [  111.921879] x1 : 9d4e965b4b7d7c00 x0 : 0000000000000000
> > [  111.927356] Call trace:
> > [  111.929892]  usb_submit_urb+0x3d8/0x590
> > [  111.933852]  hub_activate+0x108/0x7f0
> > [  111.937633]  hub_resume+0xac/0x148
> > [  111.941149]  usb_resume_interface.isra.10+0x60/0x138
> > [  111.946265]  usb_resume_both+0xe4/0x140
> > [  111.950225]  usb_runtime_resume+0x24/0x30
> > [  111.954365]  __rpm_callback+0xdc/0x138
> > [  111.958236]  rpm_callback+0x34/0x98
> > [  111.961841]  rpm_resume+0x4a8/0x720
> > [  111.965445]  rpm_resume+0x50c/0x720
> > [  111.969049]  __pm_runtime_resume+0x4c/0xb8
> > [  111.973276]  usb_autopm_get_interface+0x28/0x60
> > [  111.977948]  hub_event+0x80/0x16d8
> > [  111.981466]  process_one_work+0x2a4/0x748
> > [  111.985604]  worker_thread+0x48/0x498
> > [  111.989387]  kthread+0x13c/0x140
> > [  111.992725]  ret_from_fork+0x10/0x18
> > [  111.996415] irq event stamp: 354
> > [  111.999756] hardirqs last  enabled at (353): [<ffff80001019ea1c>] console_unlock+0x504/0x5b8
> > [  112.008441] hardirqs last disabled at (354): [<ffff8000100a95d0>] do_debug_exception+0x1a8/0x258
> > [  112.017479] softirqs last  enabled at (350): [<ffff8000100818a4>] __do_softirq+0x4bc/0x568
> > [  112.025984] softirqs last disabled at (343): [<ffff8000101145a4>] irq_exit+0x144/0x150
> > [  112.034129] ---[ end trace dc96030b9cf6c8a3 ]---
> > 
> > The problem was tracked down to a missing call to
> > pm_runtime_set_active() on resume in ohci-platform.
> > 
> > Link: https://lore.kernel.org/lkml/20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com/
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > CC: Tony Prisk <linux@prisktech.co.nz>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: Mathias Nyman <mathias.nyman@intel.com>
> > CC: Oliver Neukum <oneukum@suse.de>
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: linux-usb@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  drivers/usb/host/ohci-platform.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> > index 7addfc2cbadc..4a8456f12a73 100644
> > --- a/drivers/usb/host/ohci-platform.c
> > +++ b/drivers/usb/host/ohci-platform.c
> > @@ -299,6 +299,11 @@ static int ohci_platform_resume(struct device *dev)
> >  	}
> >  
> >  	ohci_resume(hcd, false);
> > +
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_enable(dev);
> > +
> >  	return 0;
> >  }
> >  #endif /* CONFIG_PM_SLEEP */
> 
> For both this patch and the 3/3 patch (ehci-platform):
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks Alan. Did this make it through to any tree? I don't see it on next, nor
on Linus. But it could be queued somewhere else.

I have sent v2 to patch 2 (xhci) as a reply, so hopefully it wasn't missed.
I can resend the whole series if necessary.

Thanks

--
Qais Yousef
