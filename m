Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B11C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5E824656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAVTbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:31:31 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:39196 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726099AbgAVTba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:31:30 -0500
Received: (qmail 4435 invoked by uid 2102); 22 Jan 2020 14:31:29 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2020 14:31:29 -0500
Date:   Wed, 22 Jan 2020 14:31:29 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Zimmerman <pauldzim@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [REGRESSION][BISECTED] 5.5-rc suspend/resume failure caused by
 patch a4f55d8b8c14 ("usb: hub: Check device descriptor before resusciation")
In-Reply-To: <20200121193131.070a28bf@EliteBook>
Message-ID: <Pine.LNX.4.44L0.2001221249190.1636-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020, Paul Zimmerman wrote:

> On Mon, 20 Jan 2020 13:52:15 -0700 Paul Zimmerman <pauldzim@gmail.com> wrote:
> 
> > On Mon, 20 Jan 2020 10:23:11 -0500 (EST) Alan Stern <stern@rowland.harvard.edu> wrote:
> >   
> > > On Sun, 19 Jan 2020, Paul Zimmerman wrote:
> > >     
> > > > I reported this regression last week (see
> > > > https://lore.kernel.org/linux-usb/20200115153714.03d5b3aa@EliteBook/T/#u)
> > > > but I got no response to my email. Today I have retested with
> > > > 5.5-rc7 and verified that the problem still exists. So I am
> > > > resending with a different subject line to see if anyone responds.
> > > > 
> > > > The $subject patch causes a regression on my HP EliteBook laptop
> > > > with a built-in USB bluetooth adapter. About 50% of the time, a
> > > > suspend/resume cycle will cause the bluetooth adapter to stop
> > > > working.
> > > > 
> > > > The dmesg log below shows two suspend/resume cycles. At time
> > > > 63.928 you can see the bluetooth adapter being successfully
> > > > resumed, and at time 140.969 you can see it fail. After reverting
> > > > the patch, the bluetooth adapter resumes 100% of the time.
> > > > 
> > > > I also included below a lsusb -v of the bluetooth adapter. Is
> > > > there any other debugging info you'd like me to send?      
> > > 
> > > It looks like your dmesg log was made without enabling debugging 
> > > messages in usbcore.  Can you collect another log with debugging 
> > > messages turned on?
> > > 
> > > 	echo 'module usbcore =p'    
> > > >/sys/kernel/debug/dynamic_debug/control    
> > > 
> > > Also, it might not hurt to collect and post a usbmon trace for a bad
> > > suspend-resume cycle.    
> > 
> > Hi Alan,
> > 
> > Thanks for responding. The new dmesg log and the usbmon trace are
> > below. The dmesg shows a good suspend/resume followed by a bad one.
> > The bluetooth device is usb 2-3.2 I believe. The usbmon trace is only
> > for the failed suspend/resume case.  

It might be interesting to have a usbmon trace of a successful resume 
as well, for comparison.  However I suspect it would just show that 
the new Get-Device-Descriptor request worked and everything else 
continued on normally.

> I did some more debugging on this using ftrace, here is an annotated
> log that shows what I think is happening on a failed resume. Note that
> hub_port_connect_change() is the function that the patch modified to
> call usb_get_device_descriptor() in some circumstances.
> 
> This first call to hub_port_connect_change() is for a different device,
> not the failing one. There are multiple other calls to that function in
> the trace, but they are not for the device in question:
>      kworker/1:6-19987 [001]  7803.175058: funcgraph_entry:                      |  hub_port_connect_change() {
>      kworker/1:6-19987 [001]  7803.175069: funcgraph_entry:      ! 11911.151 us  |    usb_get_device_descriptor();
>      kworker/2:5-20675 [002]  7803.179333: funcgraph_entry:                      |  usb_probe_interface() {
> 
> Starting here is a worker thread that is trying to setup the bluetooth
> adapter after the resume:
>    kworker/u17:1-3175  [002]  7803.179457: funcgraph_entry:                      |  hci_power_on() {
>    kworker/u17:1-3175  [002]  7803.179458: funcgraph_entry:                      |    hci_dev_do_open() {
>    kworker/u17:1-3175  [002]  7803.179468: funcgraph_entry:                      |      btusb_setup_intel() {
>      kworker/2:5-20675 [002]  7803.179480: funcgraph_exit:       ! 147.596 us    |  }
> 
> And here is a worker thread that is handling the connect change on the USB
> port with the bluetooth device. This happens while the btusb_setup_intel()
> function called by the other thread above is still running:
>      kworker/3:1-16790 [003]  7803.181323: funcgraph_entry:                      |  hub_port_connect_change() {
>      kworker/3:1-16790 [003]  7803.181330: funcgraph_entry:                      |    usb_get_device_descriptor() {
>      kworker/0:2-19962 [000]  7803.184885: funcgraph_entry:        6.016 us      |  hub_port_connect_change();
>      kworker/0:2-19962 [000]  7803.187208: funcgraph_entry:        5.462 us      |  hub_port_connect_change();
>      kworker/1:6-19987 [001]  7803.187835: funcgraph_exit:       ! 12776.810 us  |  }
>      kworker/1:6-19987 [001]  7803.187846: funcgraph_entry:      ! 767445.344 us |  hub_port_connect_change();
> 
> By this point the failure has happened ("Bluetooth: hci0: Reading Intel
> version information failed (-110)") , and it looks like somebody
> queues another work to try setting up the bluetooth adapter again:
>        hciconfig-21074 [000]  7803.193549: funcgraph_entry:                      |  hci_dev_open() {
>      kworker/1:6-19987 [001]  7803.955315: funcgraph_entry:      ! 144039.307 us |  hub_port_connect_change();
>    kworker/u17:1-3175  [003]  7805.203325: funcgraph_exit:       ! 2023855 us    |      }
>    kworker/u17:1-3175  [003]  7805.211728: funcgraph_exit:       ! 2032269 us    |    }
>    kworker/u17:1-3175  [003]  7805.211731: funcgraph_exit:       ! 2032273 us    |  }
>        hciconfig-21074 [000]  7805.211760: funcgraph_entry:                      |    hci_dev_do_open() {
>        hciconfig-21074 [000]  7805.211777: funcgraph_entry:      ! 3069605 us    |      btusb_setup_intel();
> 
> And here the usb_get_device_descriptor() call made by the USB worker thread
> finally completes. It also fails ("kworker/3:1 timed out on ep0in len=0/18"):
>      kworker/3:1-16790 [003]  7808.277224: funcgraph_exit:       ! 5095893 us    |    }
>        hciconfig-21074 [001]  7808.283313: funcgraph_exit:       ! 3071554 us    |    }
>        hciconfig-21074 [001]  7808.283315: funcgraph_exit:       ! 5089767 us    |  }
> 
> So if I'm understanding this correctly, there are two threads that are
> trying to access the USB bluetooth device at the same time. I have no
> idea if that is how it's supposed to work.

In fact it isn't, although in principle this shouldn't cause any
trouble.  It looks like your bluetooth device is deficient: It
sometimes crashes if it receives a Get-Device-Descriptor request while
it is busy with something else.

Still, since there was no real connection change at the port, there's
no reason to call hub_port_connect_change() here.  Let's see if the
patch below fixes your problem.

Alan Stern



Index: usb-devel/drivers/usb/core/hub.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hub.c
+++ usb-devel/drivers/usb/core/hub.c
@@ -1216,11 +1216,6 @@ static void hub_activate(struct usb_hub
 #ifdef CONFIG_PM
 			udev->reset_resume = 1;
 #endif
-			/* Don't set the change_bits when the device
-			 * was powered off.
-			 */
-			if (test_bit(port1, hub->power_bits))
-				set_bit(port1, hub->change_bits);
 
 		} else {
 			/* The power session is gone; tell hub_wq */

