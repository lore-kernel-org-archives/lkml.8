Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ADAC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D2B2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgD3MwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3MwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:52:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B821BC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:52:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 631232A274B;
        Thu, 30 Apr 2020 13:52:08 +0100 (BST)
Date:   Thu, 30 Apr 2020 14:52:05 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Ricardo Ribalda Delgado <ribalda@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH v2] mtd: Fix mtd not the same name not registered if
 nvmem
Message-ID: <20200430145205.06e16bd4@collabora.com>
In-Reply-To: <CAPybu_38B-1MaX-t61WBHrZkXhJ4P8fT4n9cdXzZs3LmBr5vZQ@mail.gmail.com>
References: <20200401100240.445447-1-ribalda@kernel.org>
        <20200402065953.9974-1-ribalda@kernel.org>
        <CAPybu_34nSmbu4JMK-uA3SWrj_eMUftZ8S6zf1Vpg3Etkz3SPw@mail.gmail.com>
        <20200427162222.1c2b2c85@xps13>
        <20200427163711.07614619@collabora.com>
        <20200427164922.5829717f@xps13>
        <20200427211024.174f5830@collabora.com>
        <CAPybu_38B-1MaX-t61WBHrZkXhJ4P8fT4n9cdXzZs3LmBr5vZQ@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 14:26:51 +0200
Ricardo Ribalda Delgado <ribalda@kernel.org> wrote:

> Hi
> 
> On Mon, Apr 27, 2020 at 9:10 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Mon, 27 Apr 2020 16:49:22 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >  
> > > Hi Boris,
> > >
> > > Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 27 Apr
> > > 2020 16:37:11 +0200:
> > >  
> > > > On Mon, 27 Apr 2020 16:22:22 +0200
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >  
> > > > > Hi Ricardo,
> > > > >
> > > > > Ricardo Ribalda Delgado <ribalda@kernel.org> wrote on Tue, 14 Apr 2020
> > > > > 15:47:23 +0200:
> > > > >  
> > > > > > Ping?
> > > > > >
> > > > > > On Thu, Apr 2, 2020 at 8:59 AM Ricardo Ribalda Delgado
> > > > > > <ribalda@kernel.org> wrote:  
> > > > > > >
> > > > > > > When the nvmem framework is enabled, a nvmem device is created per mtd
> > > > > > > device/partition.
> > > > > > >
> > > > > > > It is not uncommon that a device can have multiple mtd devices with
> > > > > > > partitions that have the same name. Eg, when there DT overlay is allowed
> > > > > > > and the same device with mtd is attached twice.
> > > > > > >
> > > > > > > Under that circumstances, the mtd fails to register due to a name
> > > > > > > duplication on the nvmem framework.
> > > > > > >
> > > > > > > With this patch we add a _1, _2, _X to the subsequent names if there is
> > > > > > > a collition, and throw a warning, instead of not starting the mtd
> > > > > > > device.
> > > > > > >
> > > > > > > [    8.948991] sysfs: cannot create duplicate filename '/bus/nvmem/devices/Production Data'
> > > > > > > [    8.948992] CPU: 7 PID: 246 Comm: systemd-udevd Not tainted 5.5.0-qtec-standard #13
> > > > > > > [    8.948993] Hardware name: AMD Dibbler/Dibbler, BIOS 05.22.04.0019 10/26/2019
> > > > > > > [    8.948994] Call Trace:
> > > > > > > [    8.948996]  dump_stack+0x50/0x70
> > > > > > > [    8.948998]  sysfs_warn_dup.cold+0x17/0x2d
> > > > > > > [    8.949000]  sysfs_do_create_link_sd.isra.0+0xc2/0xd0
> > > > > > > [    8.949002]  bus_add_device+0x74/0x140
> > > > > > > [    8.949004]  device_add+0x34b/0x850
> > > > > > > [    8.949006]  nvmem_register.part.0+0x1bf/0x640
> > > > > > > ...
> > > > > > > [    8.948926] mtd mtd8: Failed to register NVMEM device
> > > > > > >
> > > > > > > Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>  
> > > > >
> > > > > Thanks for proposing this change. Indeed we are aware of the problem
> > > > > and the best solution that we could come up with was to create an
> > > > > additional "unique_name" field to the mtd_info structure. This new
> > > > > field would have the form:
> > > > >
> > > > >     [<parent-unique-name><separator>]<mtd-name>
> > > > >
> > > > > The separator might be '~' (but I am completely open on that), and that
> > > > > would give for instance:
> > > > >
> > > > >     my-controller~my-device~my-part~mysub-part  
> > > >
> > > > I'd prefer something slightly more standard for the separator, like '/',
> > > > which is what we usually use when we want to represent a path in a tree.
> > > > I do agree on the general approach though.  
> > >
> > > I am not sure / is a valid separator here we would use this
> > > name to create a sysfs entry. Would it work?  
> >
> > Hm, you're probably right, I didn't check how the name was used by
> > nvmem. I also see that partition names can contain spaces, which is
> > not that great. So, if we want to use mtd->unique_name we should
> > probably sanitize it before passing it to nvmem. All this makes me
> > reconsider your initial proposal: use 'mtdX' as the nvmem name. It's
> > unique and it's simple enough to not require this extra sanitization
> > pass, on the other hand, guessing the nvmem partition based on such an
> > opaque name is not simple, not to mention that the mtd device name can
> > change depending on the probe order.
> >
> > I also wonder if creating nvmem devs unconditionally for all mtd
> > devices is a good idea. Sounds like we should only do that if there's an
> > explicit request to have one partition exposed as an nvmem.
> >
> > Note that, no matter what we decide about nvmem, I think having unique
> > names at the MTD level is a good thing.  
> 
> I have no preference one way or another.
> 
> The issue is that our current master leads to mtds not working fine
> and making the system unusable. Whatever we decide it must be fast and
> the patch backported.
> 
> My original patch follows the same logic as led does where there is a
> duplicated name. I can send a separate patch that uses mtdX and then
> you decide what to pick. Or we can go with a third way, but it needs
> to be soon ;).

Please send a patch using dev_name(&mtd->dev), and let's hope it
doesn't break someone else use case.
