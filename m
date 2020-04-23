Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8838EC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67429206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDWGXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbgDWGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 02:23:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0618C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 23:23:34 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jRVGl-0002OR-Tz; Thu, 23 Apr 2020 08:23:31 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1jRVGl-0003UA-Il; Thu, 23 Apr 2020 08:23:31 +0200
Date:   Thu, 23 Apr 2020 08:23:31 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to upload fpga firmware
Message-ID: <20200423062331.GR1694@pengutronix.de>
References: <20200422114432.GM1694@pengutronix.de>
 <20200423013648.GA2430@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423013648.GA2430@epycbox.lan>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:30:23 up 63 days, 13:00, 78 users,  load average: 0.29, 0.13,
 0.10
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz,

On Wed, Apr 22, 2020 at 06:36:48PM -0700, Moritz Fischer wrote:
> Hi Sascha,
> 
> On Wed, Apr 22, 2020 at 01:44:32PM +0200, Sascha Hauer wrote:
> > Hi,
> > 
> > I wonder what can be done with the mainline state of drivers/fpga/. The
> > entry to the framework seems to be fpga_mgr_load(). The only user of
> > this function is fpga_region_program_fpga(). This in turn is only called
> > in response of applying a device tree overlay. A device tree overlay is
> > applied with of_overlay_fdt_apply() which has no users in the Kernel.
> 
> Yes. It is waiting for dt_overlays one way or another. I personally
> don't currently have the bandwidth to work actively on this.
> 
> > My current task is to load a firmware to a FPGA. The code all seems to
> > be there in the Kernel, it only lacks a way to trigger it. I am not very
> > interested in device tree overlays since the FPGA appears as a PCI
> > device (although applying a dtbo could enable the PCIe controller device
> > tree node). Is there some mainline way to upload FPGA firmware? At the
> > moment we are using the attached patch to trigger loading the firmware
> > from userspace. Would something like this be acceptable for mainline?
> 
> We've looked into this sort of patches over the years and never came to
> a general interface that really works.
> 
> The OPAE folks (and other users I know of) usually use FPGA Manager with
> a higher layer on top of it that moves the bitstream into the kernel via
> an ioctl().
> 
> One concept I had toyed with mentally, but haven't really gotten around
> to implement is a 'discoverable' region, that would deal with the
> necessary re-enumeration via a callback and have a sysfs interface
> similar to what the patch below has.
> This would essentially cover use-cases where you have a discoverable
> device implemented in FPGA logic, such as say an FPGA hanging off of
> PCIe bus that can get loaded over USB, a CPLD or some other side-band
> mechanism. After loading the image you'd have to rescan the PCIe bus -
> which - imho is the kernel's job.
> 
> What I really wanna avoid is creating another /dev/fpga0 / /dev/xdevcfg
> that completely leaves the kernel in the dark about the fact that it
> reconfigures a bit of hardware hanging off the bus.

Yes, makes sense. While this would suffice my needs at the moment it
really sounds like a dead end.

> 
> In my ideal world you'd create a pci driver that binds to your device,
> and creates mfd style subdevices for whatever you'd want your design to
> do. One of these devices would be an FPGA and a FPGA region attached to
> that FPGA manager. Your top level driver would co-ordinate the fact that
> you are re-programming parts of the FPGA and create / destroy devices as
> needed for the hardware contained in the bitstream.

In my case there is no pci device visible before loading the firmware,
so creating a pci driver is not an option. Maybe pci host controllers
could register themselves as fpga-bridges. With this we could put the
pci host controller (or the pci device, AFAIK there is a PCI device tree
binding) where the fpga is connected into the fpga-bridges phandles list
of the fpga-region.

Regards,
  Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
