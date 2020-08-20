Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D48C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465A1207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgHTMja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:39:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56372 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgHTJrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:47:09 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6967429A219;
        Thu, 20 Aug 2020 10:47:07 +0100 (BST)
Date:   Thu, 20 Aug 2020 11:47:02 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] i3c: master: fix for SETDASA and DAA process
Message-ID: <20200820114702.4c4cd58a@collabora.com>
In-Reply-To: <DM5PR07MB31965D54B61E191E3C1325FEC15A0@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1590053467-32079-1-git-send-email-pthombar@cadence.com>
        <1590053581-803-1-git-send-email-pthombar@cadence.com>
        <20200819101238.760d4e90@collabora.com>
        <DM5PR07MB31965D54B61E191E3C1325FEC15A0@DM5PR07MB3196.namprd07.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 09:23:25 +0000
Parshuram Raju Thombare <pthombar@cadence.com> wrote:

> Hi Boris,
> 
> Thanks for your comments.
> 
> >> +	 * We anyway don't attach devices which are not addressable  
> >
> >You can drop the anyway.  
> Sure, I will make above mentioned change in the comment.
> 
> >> +	 * (no static_addr and dyn_addr) and devices with static_addr
> >> +	 * but no init_dyn_addr will participate in DAA.
> >> +	 */
> >> +	if (!boardinfo->static_addr || !boardinfo->init_dyn_addr)
> >> +		return -EINVAL;  
> >
> >If we consider this as an error, we should probably check that before
> >calling i3c_master_pre_assign_dyn_addr() in i3c_master_bus_init().  
> Ok, I will move this check to i3c_master_bus_init(), before calling
> i3c_master_pre_assign_dyn_addr. It will probably add extra if condition,
> but will save one function call.
> 
> >>   * 5. Pre-assign dynamic addresses requested by the FW with SETDASA for I3C
> >> - *    devices that have a static address
> >> + *    devices that have a static address and attach corresponding statically
> >> + *    defined I3C devices to the master.  
> >
> >					     and attach them to the
> >					     master if
> >	  the dynamic address assignment succeeds  
> Sure, I will append above mentioned change to the comment.
> 
> >> +		/*
> >> +		 * Free reserved init_dyn_addr so that attach can
> >> +		 * get it before trying setnewda.
> >> +		 */
> >> +		if (i3cboardinfo->init_dyn_addr)
> >> +			i3c_bus_set_addr_slot_status(&master->bus,
> >> +						     init_dyn_addr,
> >> +						     I3C_ADDR_SLOT_FREE);  
> >
> >Hm, it's a bit more complicated. I don't think we can unconditionally
> >release the init_dyn_addr here. Say you have a device that's been
> >assigned its init_dyn_addr, and userspace decided to re-assign a new
> >one (the feature is not available yet, but I thought about letting
> >userspace write to the dyn_addr sysfs entry and wire that to a SETDA).
> >The init_dyn_addr can now be re-assigned to a different device. After
> >some time the device ends up resetting and thus lose its DA. A new DAA
> >is issued to re-discover it, but you want this device to be assigned its
> >last known address not the init address. And when
> >i3c_master_attach_boardinfo() is called on this new device, you release
> >a slot that's no longer yours.
> >
> >That was the rational behind the "address slots are attached to i3cdevs
> >not boardinfo". Maybe we should have another list where we keep i3c
> >devs that have not been discovered yet but have boardinfo attached to
> >them. This way we can reserve dynamic addresses without blocking a
> >slot in the master device table.  
> 
> I think the sequence of events you are discussing here is
> 1. User assign address to device A with init_dyn_addr in boardinfo.
> 2. That particular init_dyn_addr is assigned to device B, which may be hotplugged ?
>     and don't have boardinfo or init_dyn_addr in boardinfo ? 
> 3. Device A resets and trigger DAA due to hot plug ?
>    A. Here now init_dyn_addr is already assigned to device B so device A shouldn't be freeing it.
>    B. Now preferable dyn_addr is the one received from user in step 1.

No, that's not what I'm talking about. I meant:

1. Device A is assigned a default init address X in the DT.
2. Device B has no init address
3. The framework reserves address X for and assigns it to device A
   when it appears on the bus (DAA, SETDASA or HJ+DDA)
4. Device B is assigned address Y
5. User decides to explicitly assign a different address to device A by
   issuing "echo Z > /sys/bus/i3c/..../<i3c-dev>/dyn_addr" (not yet
   supported, but I think we should allow that at some point), such
   that device A gets a lower/higher priority
6. User manually assigns address X to device B (that should be allowed
   since device A no longer uses X)
7. Device A is reset for some reason and loses its dynamic address,
   thus requiring a new DAA (or HJ+DAA). During this new discovery,
   device A is re-assigned its last known address (Z), but in the
   meantime you've marked address X as free (when attaching boardinfo
   to the newdev object).

> 
> If we are to prefer init_dyn_addr always, that will rule out possibility of making init_dyn_addr 
> available to any other device when original device is assigned with user or master
> provided address owing to SETDATA or SETNEWDA failures. And we can be sure of not freeing
> init_dyn_addr inadvertently while it is being used by any other device.
> 
> Else if we want to prefer user provided address even across resets, since we don't need init_dyn_addr
> anymore, it can be used to store user provided address. This will serve both the purposes A and B stated above.
>  
> And in my opinion this can be handled when we add code to allow user to change the device address.

If we go for a temporary solution, I'd opt for relaxing the test done
in i3c_master_get_i3c_addrs() to not reserve the init address (since it
should have been reserved at probe time) and keep those init addressed
reserved.
