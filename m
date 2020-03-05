Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66EFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1A421556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583433131;
	bh=KM0uYAqk/5kpfoI8SkJkxTAAEAL/IwWV/D+DdVwkhN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FbCKOAYshAsy5p1dvPoxek4k3QP9qCjSWA/VSMCukOn/h2DAR8aJ+l/h6IYxq4SFq
	 gQLL61L3nLACEknQ/49rHDXejo9D2cF9hzApYOYooi7eUTtOPvpFEQrPd24FC584nY
	 bpeHcCrYsEcgsmkF19XfOD6ZH9Lg9cgO2MiVb9vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCEScI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:32:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCEScH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:32:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85A3208C3;
        Thu,  5 Mar 2020 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583433125;
        bh=KM0uYAqk/5kpfoI8SkJkxTAAEAL/IwWV/D+DdVwkhN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWlx6EJD/iVDV2O/rwdjD6kQBkYUslAly1nbSjuhyAvZC51Ye/muMuU/lrPdTD91A
         5HMr6pSJEb8eMBvsSCL4xYUylv6eQ2P/ksYwBqVR7bDWQVV3ChG7nBgyL0tuKUdAc9
         FWqoxYNLhSoQY5EJRVMcpq1upnLaXWHsMyEyNxtw=
Date:   Thu, 5 Mar 2020 19:32:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunfeng Yun =?utf-8?B?KOS6keaYpeWzsCk=?= 
        <Chunfeng.Yun@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>
Subject: Re: [PATCH] xhci-mtk: Fix NULL pointer dereference with xhci_irq()
 for shared_hcd
Message-ID: <20200305183202.GA2107395@kroah.com>
References: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
 <08f69bab-2ada-d6ab-7bf7-d960e9f148a0@linux.intel.com>
 <1580556039.10835.3.camel@mtkswgap22>
 <39ec1610-1686-6509-02ac-6e73d8be2453@linux.intel.com>
 <1583291775.12083.59.camel@mtkswgap22>
 <ef4d9d96-df4d-be0c-22af-a97a03c39d3a@linux.intel.com>
 <1583377126.12083.63.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583377126.12083.63.camel@mtkswgap22>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:58:46AM +0800, Macpaul Lin wrote:
> On Wed, 2020-03-04 at 16:39 +0200, Mathias Nyman wrote:
> > On 4.3.2020 5.16, Macpaul Lin wrote:
> > > On Tue, 2020-02-04 at 17:44 +0800, Mathias Nyman wrote:
> > >> On 1.2.2020 13.20, Macpaul Lin wrote:
> > >>> On Fri, 2020-01-31 at 16:50 +0200, Mathias Nyman wrote:
> > >>>> On 17.1.2020 9.41, Macpaul Lin wrote:
> > >>>>> According to NULL pointer fix: https://tinyurl.com/uqft5ra
> > >>>>> xhci: Fix NULL pointer dereference with xhci_irq() for shared_hcd
> > >>>>> The similar issue has also been found in QC activities in Mediatek.
> > >>>>>
> > >>>>> Here quote the description from the referenced patch as follows.
> > >>>>> "Commit ("f068090426ea xhci: Fix leaking USB3 shared_hcd
> > >>>>> at xhci removal") sets xhci_shared_hcd to NULL without
> > >>>>> stopping xhci host. This results into a race condition
> > >>>>> where shared_hcd (super speed roothub) related interrupts
> > >>>>> are being handled with xhci_irq happens when the
> > >>>>> xhci_plat_remove is called and shared_hcd is set to NULL.
> > >>>>> Fix this by setting the shared_hcd to NULL only after the
> > >>>>> controller is halted and no interrupts are generated."
> > >>>>>
> > >>>>> Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
> > >>>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> > >>>>> ---
> > >>>>>    drivers/usb/host/xhci-mtk.c | 2 +-
> > >>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > >>>>> index b18a6baef204..c227c67f5dc5 100644
> > >>>>> --- a/drivers/usb/host/xhci-mtk.c
> > >>>>> +++ b/drivers/usb/host/xhci-mtk.c
> > >>>>> @@ -593,11 +593,11 @@ static int xhci_mtk_remove(struct platform_device *dev)
> > >>>>>    	struct usb_hcd  *shared_hcd = xhci->shared_hcd;
> > >>>>>    
> > >>>>>    	usb_remove_hcd(shared_hcd);
> > >>>>> -	xhci->shared_hcd = NULL;
> > >>>>>    	device_init_wakeup(&dev->dev, false);
> > >>>>>    
> > >>>>>    	usb_remove_hcd(hcd);
> > >>>>>    	usb_put_hcd(shared_hcd);
> > >>>>> +	xhci->shared_hcd = NULL;
> > >>>>>    	usb_put_hcd(hcd);
> > >>>>>    	xhci_mtk_sch_exit(mtk);
> > >>>>>    	xhci_mtk_clks_disable(mtk);
> > >>>>>
> > >>>>
> > >>>> Could you share details of the NULL pointer dereference, (backtrace).
> > >>>
> > >>> This bug was found by our QA staff while doing 500 times plug-in and
> > >>> plug-out devices. The backtrace I have was recorded by QA and I didn't
> > >>> reproduce this issue on my own environment. However, after applied this
> > >>> patch the issue seems resolve. Here is the backtrace:
> > >>>
> > >>> Exception Class: Kernel (KE)
> > >>> PC is at [<ffffff8008cccbc0>] xhci_irq+0x728/0x2364
> > >>> LR is at [<ffffff8008ccc788>] xhci_irq+0x2f0/0x2364
> > >>>
> > >>> Current Executing Process:
> > >>> [iptables, 859][netdagent, 770]
> > >>>
> > >>> Backtrace:
> > >>> [<ffffff80080ead58>] __atomic_notifier_call_chain+0xa8/0x130
> > >>> [<ffffff80080eb6d4>] notify_die+0x84/0xac
> > >>> [<ffffff800808e874>] die+0x1d8/0x3b8
> > >>> [<ffffff80080a89b0>] __do_kernel_fault+0x178/0x188
> > >>> [<ffffff80080a81b4>] do_page_fault+0x44/0x3b0
> > >>> [<ffffff80080a811c>] do_translation_fault+0x44/0x98
> > >>> [<ffffff8008080e08>] do_mem_abort+0x4c/0x128
> > >>> [<ffffff80080832d0>] el1_da+0x24/0x3c
> > >>> [<ffffff8008cccbc0>] xhci_irq+0x728/0x2364
> > >>> [<ffffff8008c98804>] usb_hcd_irq+0x2c/0x44
> > >>> [<ffffff8008179bb0>] __handle_irq_event_percpu+0x26c/0x4a4
> > >>> [<ffffff8008179ec8>] handle_irq_event+0x5c/0xd0
> > >>> [<ffffff800817e3c0>] handle_fasteoi_irq+0x10c/0x1e0
> > >>> [<ffffff80081787b0>] __handle_domain_irq+0x32c/0x738
> > >>> [<ffffff800808159c>] gic_handle_irq+0x174/0x1c4
> > >>> [<ffffff8008083cf8>] el0_irq_naked+0x50/0x5c
> > >>> [<ffffffffffffffff>] 0xffffffffffffffff
> > >>>
> > >>
> > >> Thanks,
> > >> Could you help me find out which line of code xhci_irq+0x728 is in your case.
> > >>
> > >> As Guenter pointed out there is a risk of turning the NULL pointer dereference
> > >> into a use after free if we just solve this by setting xhci->shared_hcd = NULL
> > >> later.
> > >>
> > >> If you still have that kernel around, and xhci is compiled in:
> > >> gdb vmlinux
> > >> gdb li *(xhci_irq+0x728)
> > >>
> > > 
> > > Sorry that I couldn't get back to you soon. The internal code version
> > > for this issue was really old and a little bit difficult to rewind to
> > > that version.
> > > However, I think the following dump might be correct for the code base.
> > > 
> > > (gdb) li *(xhci_irq+0x728)
> > > 0xffffff8008cc8634 is in xhci_irq (*stripped*
> > > kernel-4.14/drivers/usb/host/xhci.h:1694).
> > > 1689     */
> > > 1690    #define XHCI_MAX_REXIT_TIMEOUT_MS       20
> > > 1691
> > > 1692    static inline unsigned int hcd_index(struct usb_hcd *hcd)
> > > 1693    {
> > > 1694            if (hcd->speed >= HCD_USB3)
> > > 1695                    return 0;
> > > 1696            else
> > > 1697                    return 1;
> > > 1698    }
> > > (gdb)
> > > 
> > > Thanks
> > > Macpaul Lin
> > > 
> > 
> > Ah, it was a 4.14 kernel.
> > This should be fixed in 4.20 with patch:
> > 1245374e9b83 xhci: handle port status events for removed USB3 hcd
> > 
> > Port arrays/structures were changed completely in 4.18
> > 
> > Something like the below should work for 4.14:
> > 
> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> > index 61fa3007a74a..e7367b9f19c5 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -1640,6 +1640,12 @@ static void handle_port_status(struct xhci_hcd *xhci,
> >  	if ((major_revision == 0x03) != (hcd->speed >= HCD_USB3))
> >  		hcd = xhci->shared_hcd;
> >  
> > +	if (!hcd) {
> > +		xhci_dbg(xhci, "No hcd found for port %u event\n", port_id);
> > +		bogus_port_status = true;
> > +		goto cleanup;
> > +	}
> > +
> >  	if (major_revision == 0) {
> >  		xhci_warn(xhci, "Event for port %u not in "
> >  				"Extended Capabilities, ignoring.\n",
> 
> Thanks for this suggestion, this is much better! I am sorry that we're
> using android kernel that some reported issue might be out of date. I
> will update the suggestion into our code base. Thanks!

Should I backport this to 4.14 and older kernels to prevent this issue
from showing up in newer Android devices that are using these older
kernels?

thanks,

greg k-h
