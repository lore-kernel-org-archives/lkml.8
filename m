Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C203C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D1322C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgGTN66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:58:58 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46519 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726095AbgGTN66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:58:58 -0400
Received: (qmail 1229238 invoked by uid 1000); 20 Jul 2020 09:58:57 -0400
Date:   Mon, 20 Jul 2020 09:58:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200720135857.GB1228057@rowland.harvard.edu>
References: <20200720083956.GA4074@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720083956.GA4074@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:39:56AM +0200, Michal Hocko wrote:
> Hi,
> I am not sure when this started happening but at least 5.6, 5.7 and
> 5.8-rc6 all exhibit this problem. Please note that the this is happining
> on a laptop which is not completely healthy. The BIOS complains that the
> Battery cannot be charged because the power supply cannot be recognized.
> This is somehting I have for a longer time without noticing the
> kworker/0:3+pm problem so I do not think they are related but who knows.
> 
> Anyway, kworker/0:3+pm is hogging CPU. /proc/<pid>/0:3+pm is very often
> empty so I suspect it just schedules very often and performs only small
> amount of work. Here are few backtraces I've managed to catch
> 
> [<0>] preempt_schedule_thunk+0x16/0x18
> [<0>] usb_hcd_submit_urb+0x686/0x773
> [<0>] usb_start_wait_urb+0x59/0xc8
> [<0>] usb_control_msg+0xd4/0x10d
> [<0>] get_port_status+0x51/0x6f
> [<0>] hub_port_status+0x41/0xa3
> [<0>] hub_activate+0x230/0x4ee
> [<0>] hub_resume+0x20/0x9a
> [<0>] usb_resume_interface.isra.0+0xb0/0xd0
> [<0>] usb_suspend_both+0xf6/0x20c
> [<0>] usb_runtime_suspend+0x32/0x62
> [<0>] __rpm_callback+0x70/0xd4
> [<0>] rpm_callback+0x55/0x6b
> [<0>] rpm_suspend+0x2af/0x440
> [<0>] __pm_runtime_suspend+0x48/0x62
> [<0>] usb_runtime_idle+0x26/0x2d
> [<0>] __rpm_callback+0x70/0xd4
> [<0>] rpm_idle+0x179/0x1df
> [<0>] pm_runtime_work+0x6b/0x81
> [<0>] process_one_work+0x1bd/0x2c6
> [<0>] worker_thread+0x19c/0x240
> [<0>] kthread+0x11b/0x123
> [<0>] ret_from_fork+0x22/0x30
> 
> [<0>] slab_pre_alloc_hook+0x15/0x46
> [<0>] __kmalloc+0x148/0x15a
> [<0>] usb_hcd_submit_urb+0x5c6/0x773
> [<0>] usb_start_wait_urb+0x59/0xc8
> [<0>] usb_control_msg+0xd4/0x10d
> [<0>] get_port_status+0x51/0x6f
> [<0>] hub_port_status+0x41/0xa3
> [<0>] hub_activate+0x230/0x4ee
> [<0>] hub_resume+0x20/0x9a
> [<0>] usb_resume_interface.isra.0+0xb0/0xd0
> [<0>] usb_suspend_both+0xf6/0x20c
> 
> [<0>] slab_pre_alloc_hook+0x15/0x46
> [<0>] __kmalloc+0x148/0x15a
> [<0>] usb_hcd_submit_urb+0x5c6/0x773
> [<0>] usb_start_wait_urb+0x59/0xc8
> [<0>] usb_control_msg+0xd4/0x10d
> [<0>] set_port_feature+0x33/0x38
> [<0>] hub_suspend+0x15c/0x16a
> [<0>] usb_suspend_both+0x91/0x20c
> [<0>] usb_runtime_suspend+0x32/0x62
> [<0>] __rpm_callback+0x70/0xd4
> [<0>] rpm_callback+0x55/0x6b
> [<0>] rpm_suspend+0x2af/0x440
> [<0>] __pm_runtime_suspend+0x48/0x62
> [<0>] usb_runtime_idle+0x26/0x2d
> [<0>] __rpm_callback+0x70/0xd4
> [<0>] rpm_idle+0x179/0x1df
> [<0>] pm_runtime_work+0x6b/0x81
> [<0>] process_one_work+0x1bd/0x2c6
> [<0>] worker_thread+0x19c/0x240
> [<0>] kthread+0x11b/0x123
> [<0>] ret_from_fork+0x22/0x30
> 
> Is this something known or something I can give more information about?
> From a very quick look into the code it sounds as if the system wanted
> to suspend an USB device/controller but that keeps failing again and
> again.

Yes, that's what it looks like to me too.  Or maybe the suspend succeeds 
but then the device/controller immediately gets woken up again.

Can you provide the contents of /sys/kernel/debug/usb/devices and also a 
usbmon trace showing a few rounds of this recurring activity?  Perhaps a 
section of the dmesg log with dynamic debugging enabled for the usbcore 
module, as well.

Alan Stern
