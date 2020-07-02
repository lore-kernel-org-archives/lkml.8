Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3DBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5BB20720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGBIUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:20:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:15731 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgGBIUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:20:12 -0400
IronPort-SDR: hv3mNLHAGHEb/4CzPa84XlGrEy1DLbxlTGnN/43uqUXcMZR8CR5yrQToAoHuBj4pQHXXwuB2Qi
 qDlgzVtNQKxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144983374"
X-IronPort-AV: E=Sophos;i="5.75,303,1589266800"; 
   d="scan'208";a="144983374"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 01:20:11 -0700
IronPort-SDR: XwXnoTDj8T9XWW5RTVju94T4eRwNlJtCABeYOFuF9P1hRscb3Vwx8U8FZlhUoS1s/7oygMS2P2
 PZdcM1MsNVQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,303,1589266800"; 
   d="scan'208";a="481919787"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2020 01:20:08 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jquS0-00HAaT-W2; Thu, 02 Jul 2020 11:20:08 +0300
Date:   Thu, 2 Jul 2020 11:20:08 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, Petr Mladek <pmladek@suse.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kurt@linutronix.de, "S, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
Message-ID: <20200702082008.GE3703480@smile.fi.intel.com>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain>
 <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <20200702051213.GB3450@jagdpanzerIV.localdomain>
 <20200702054033.GC3450@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702054033.GC3450@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 02:40:33PM +0900, Sergey Senozhatsky wrote:
> On (20/07/02 14:12), Sergey Senozhatsky wrote:
> > From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > On (20/06/30 11:02), Tony Lindgren wrote:

...

> > I think we can do it. serial8250_do_startup() and irq handler take
> > port->lock, so they should be synchronized.
> 
> Hmm, hold on. Why does it disable IRQ in the first place? IRQ handlers
> should grab the port->lock. So if there is already running IRQ, then
> serial8250_do_startup() will wait until IRQ handler unlocks the port->lock.
> If serial8250_do_startup() grabs the port->lock first, then IRQ will wait
> for serial8250_do_startup() to unlock it. serial8250_do_startup() does
> not release the port->unlock until its done:
> 
> 		spin_lock_irqsave(&port->lock, flags);
> 
> 		wait_for_xmitr(up, UART_LSR_THRE);
> 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> 		udelay(1); /* allow THRE to set */
> 		iir1 = serial_port_in(port, UART_IIR);
> 		serial_port_out(port, UART_IER, 0);
> 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
> 		udelay(1); /* allow a working UART time to re-assert THRE */
> 		iir = serial_port_in(port, UART_IIR);
> 		serial_port_out(port, UART_IER, 0);
> 
> 		spin_unlock_irqrestore(&port->lock, flags);
> 
> so IRQ will not see the inconsistent device state.
> 
> What exactly is the purpose of disable_irq_nosync()? Can we just remove
> disable_irq_nosync()/enable_irq() instead? Are there any IRQ handlers
> that don't acquire the port->lock?

I didn't look into this deeply, but my understanding that this is something for
special case when you have several UART ports sharing the IRQ (multi-port card)
and IRQ even maybe undesirable b/c it will confuse real IRQ handler. I don't
remember details, but AFAIR IRQ handler does a busyloop to service as much as
possible and in between it may release the lock (again, multi-port UART cards),
that's why we better avoid IRQ event in the first place.
But it's my pure speculation.

-- 
With Best Regards,
Andy Shevchenko


