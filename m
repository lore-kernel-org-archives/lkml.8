Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51B8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1312075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHTTDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:03:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34600 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgHTTDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 15:03:16 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5861929ABEB;
        Thu, 20 Aug 2020 20:03:14 +0100 (BST)
Date:   Thu, 20 Aug 2020 21:03:11 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: Re: [PATCH v3] i3c: master: fix for SETDASA and DAA process
Message-ID: <20200820210311.5934fc2a@collabora.com>
In-Reply-To: <DM5PR07MB3196085F8628478E7E2F5FC8C15A0@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1597930706-15744-1-git-send-email-pthombar@cadence.com>
        <20200820164820.4fec97b3@collabora.com>
        <DM5PR07MB3196085F8628478E7E2F5FC8C15A0@DM5PR07MB3196.namprd07.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 18:16:14 +0000
Parshuram Raju Thombare <pthombar@cadence.com> wrote:

> >Hm, not sure that qualifies as a fix. The current implementation was
> >correct, it was just reserving a slot in the device table for devices
> >that didn't have an init address or on which SETDASA failed.  
> If I3C controllers like ours use hardware slots to store slave devices info, 
> due to limited available slots this can cause issue. 
>  If some slots are lost due to
> 1. only init_dyn_addr and no static_addr in DT 
> OR
> 2. SETDASA failed

Well, having a slot with a static address is valid, though I agree
it's not really useful.

> at the end of DAA some devices may be left without dyn_addr allocated from master
> and hence can't work properly.

My point is, there's no address or device slot leak, it's just that
reserving a slot for I3C devices that only have a static address is
kind of useless. But let's be honest, given the number of I3C devices
available out there, I don't think it will hurt us before quite some
time :P. That's not to say we shouldn't address that, I just don't
think it deserves a Fixes tag.

> I think during our discussion we recognized this change as a bug.

IIRC, I was talking about the first patch in the series.

> That is the reason I added fixes tag, but if you think otherwise I can remove this tag.
>  
> >> -static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
> >> +static int i3c_master_pre_assign_dyn_addr(struct i3c_master_controller  
> >That function now does more than just assigning a dynamic address: it
> >also creates the i3c_dev_desc. It should be renamed accordingly
> >(i3c_master_early_i3c_dev_add() maybe).  
> Ok
> 
> >You should reserve the address before calling
> >i3c_master_pre_assign_dyn_addr():
> >
> >		/*
> >		 * We don't attach devices which are not addressable
> >		 * (no static_addr and dyn_addr) and devices with
> >		 * static_addr but no init_dyn_addr will participate in DAA.
> >		 */
> >		if (!i3cboardinfo->init_dyn_addr ||
> >		    !i3cboardinfo->static_addr)
> >			continue;  
> Don't we want to cover the case when only init_dyn_addr is present ?

Uh, yes, my bad.

> I am not sure if we can't have init_dyn_addr without static_addr.

You can, when you want to assign a specific dynamic address to a device
that doesn't have a static address (see the 'try to assign init_addr
dance' in i3c_dev_add()).

> May be what we need is 
> 		if (!i3cboardinfo->init_dyn_addr)
> 			continue;
> 
> 		ret = i3c_bus_get_addr_slot_status(&master->bus,
> 						   i3cboardinfo->init_dyn_addr);
> 		if (ret != I3C_ADDR_SLOT_FREE) {
> 			ret = -EBUSY;
> 			goto err_rstdaa;
> 		}
> 
> 		i3c_bus_set_addr_slot_status(&master->bus,
> 					     i3cboardinfo->init_dyn_addr,
> 					     I3C_ADDR_SLOT_I3C_DEV);
> 
> 		if (i3cboardinfo->static_addr)
> 			i3c_master_pre_assign_dyn_addr(master, i3cboardinfo);

Yep, that's correct.

> IMHO this is functionally same to what I sent. Just that init_dyn_addr is reserved before,
> and we leverage the change in reattach to bypass failure due to second attempt
> to get init_dyn_addr in reattach called from i3c_master_pre_assign_dyn_addr().

Unless I'm missing something, your solution didn't reserve the
init address when there's no static address, and we definitely want
that to happen, otherwise another device might steal it during DAA.
