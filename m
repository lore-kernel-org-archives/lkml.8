Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A77C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77E9217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAVT3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:29:17 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:46775 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgAVT3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:29:16 -0500
Received: from [62.209.224.147] (helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1iuLgR-0005vX-EF; Wed, 22 Jan 2020 14:29:06 -0500
Date:   Wed, 22 Jan 2020 14:28:56 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     l00520965 <liuchao173@huawei.com>, linfeilong@huawei.com,
        hushiyuan@huawei.com, linux-kernel@vger.kernel.org,
        PJ Waskiewicz <peter.waskiewicz.jr@intel.com>
Subject: Re: [RFC] irq: Skip printing irq when desc->action is null even if
 any_count is not zero
Message-ID: <20200122192856.GA2852@localhost.localdomain>
References: <20200121130959.22589-1-liuchao173@huawei.com>
 <87k15jek6v.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k15jek6v.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 01:42:48PM +0100, Thomas Gleixner wrote:
> Chao,
> 
> l00520965 <liuchao173@huawei.com> writes:
> 
> > When desc->action is empty, there is no need to print out the irq and its'
> > count in each cpu. The desc is not alloced in request_irq or freed in
> > free_irq.
> 
> request/free_irq() never allocate/free irq descriptors. 
> 
> > So some PCI devices, such as rtl8139, uses request_irq and free_irq,
> 
> All PCI devices use some variant of request_irq()/free_irq(). The
> interrupt descriptors are allocated by the underlying PCI
> machinery. They are only allocated/freed when the device driver is
> loaded/removed.
> 
> And this property exists for _ALL_ interrupts independent of PCI.
> 
> > which only modify the action of desc. So /proc/interrupts could be
> > like this:
> 
> I think you want to explain:
> 
>   If an interrupt is released via free_irq() without removing the
>   underlying irq descriptor, the interrupt count of the irq descriptor
>   is not reset. /proc/interrupt shows such interrupts with an empty
>   action handler name:
>   
> >            CPU0       CPU1
> >  38:         46          0     GICv3  36 Level     ehci_hcd:usb1
> >  39:         66          0     GICv3  37 Level
> 
>   irqbalance fails to detect that this interrupt is not longer in use
>   and parses the last word in the line 'Level' as the action handler
>   name.
> 
> > Irqbalance gets the list of interrupts according to /proc/interrupts. In
> > this case, irqbalance does not remove the interrupt from the balance list,
> > and the last string in this line,which is Level, is used as irq_name.
> 
> Right, this is historic behaviour and I don't know how irqbalance dealt
> with that in the past 20+ years. At least I haven't seen any complaints.
> 
> I'm not opposed to suppress the output, but I really want the opinion of
> the irqbalance maintainers on that.
> 
Actually, irqbalance ignores the trailing irq name (or it should at
least), so you should be able to drop that portion of /proc/irqbalance,
though I cant speak for any other users of it.

> > Or we can clear desc->kstat_irqs in each cpu in free_irq when
> > desc->action is null?
> 
> No, we can't. The historic behaviour is that the total interrupt count
> for a device is maintained independent of the number of
> request/free_irq() pairs.
> 
> > Signed-off-by: LiuChao <liuchao173@huawei.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> I really can't remember that I have reviewed this patch already. Please
> don't add tags which claim that some one has reviewed or acked your
> patch unless you really got that Reviewed-by or Acked-by from that
> person.
> 
> Thanks,
> 
>         tglx
> 
