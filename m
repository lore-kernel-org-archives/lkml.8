Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BC5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2517206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgCXNwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:52:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34085 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727266AbgCXNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:52:13 -0400
Received: (qmail 8446 invoked by uid 500); 24 Mar 2020 09:52:12 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Mar 2020 09:52:12 -0400
Date:   Tue, 24 Mar 2020 09:52:12 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Qais Yousef <qais.yousef@arm.com>
cc:     Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
In-Reply-To: <20200324134353.eamiridhnjrmirgt@e107158-lin>
Message-ID: <Pine.LNX.4.44L0.2003240949180.4640-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Qais Yousef wrote:

> On 03/24/20 14:20, Oliver Neukum wrote:
> > Am Dienstag, den 24.03.2020, 10:46 +0000 schrieb Qais Yousef:
> > > 
> > > I should have stuck to what I know then. I misread the documentation. Hopefully
> > > the attached looks better. I don't see the new debug you added emitted.
> > 
> > That is odd. Please try
> > 
> > echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
> > 
> > with the attached improved patch.
> 
> Hmm still no luck
> 
> 
> # history
>    0 echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
>    1 swapoff -a
>    2 echo suspend > /sys/power/disk
>    3 echo disk > /sys/power/state
>    4 dmesg > usb.dmesg

What happens if you omit step 1 (the swapoff)?

> $ git log -p
> commit dfd1731f9a3e7592135d2a6b2a5c5e1640a7eea4 (HEAD)
> Author: Oliver Neukum <oneukum@suse.com>
> Date:   Mon Mar 23 16:34:35 2020 +0100
> 
>     usb: hub additional debugging
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 54cd8ef795ec..12ce2fdc4c2a 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -1629,6 +1629,7 @@ static int hub_configure(struct usb_hub *hub,
>                 ret = -ENOMEM;
>                 goto fail;
>         }
> +       dev_dbg(hub_dev, "%p URB allocated \n", hub->urb);
> 
>         usb_fill_int_urb(hub->urb, hdev, pipe, *hub->buffer, maxp, hub_irq,
>                 hub, endpoint->bInterval);

Oliver, by the way, %p isn't a good way to get pointer values for 
debugging.  Its output depends on how the system is configured.  Use 
%px instead (see Documentation/core-api/printk-formats.rst).

Alan Stern

