Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B11C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703F220729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErPraso6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbgGVOwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:52:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45445 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732699AbgGVOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595429562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0s28z06jG0fWNYzLWpKidzlLlRizuZvY9LgUiS8V65o=;
        b=ErPraso6Ga0YX5oEANT77iOcfyLOzTBDbxRKfa8cJmQExi8avULVYVunxerXtLYDFyzl3H
        mth3+G8k3BBZXrlOE5ILPbWLEkZ+7fcl6i9pnq9nqGoNdtOPC/MYlUEGfi/sA923HnH8n+
        6H2nJ/rLouuDA7CTxc/epr6uMySZr7E=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-8Tfs_p2cNNiRVBS3TnlzkQ-1; Wed, 22 Jul 2020 10:52:38 -0400
X-MC-Unique: 8Tfs_p2cNNiRVBS3TnlzkQ-1
Received: by mail-io1-f72.google.com with SMTP id l18so1970804ion.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 07:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0s28z06jG0fWNYzLWpKidzlLlRizuZvY9LgUiS8V65o=;
        b=ZSBku+7EI/b/yL1eorT6MpXggY+IMLmP/06RhCE1QFVgI7oNnTbCDGsW5vh7HZK1bw
         Eg3+LgoI1BGZdTTwKTRPr94xHwy5KnjMbB8xbMztgbq3QA0dP9iKwr7EPyKuVa3XjEKh
         sVPTbW8jI+krHqtuSneWIYWDJ2B2NQzIvUByj6rDqn7j/l9Rmutaup1j+2sNEuiwBUW3
         hKiKFWaHplwJsJ19ZU8RqGvAfc42AJrVYI1KBFcURCQ8FtpZMh2hpOoz/lMzjFaF27r3
         wIQaA3XFz3oBSXqMpFMyAdn3vIEHp72Ey+OjEcdYsA21zCoHc4Fl2Nop3YHB0SzJRXyv
         v3vw==
X-Gm-Message-State: AOAM533zCOdn6rL/I+3dr8Q2BunTnsfoML/iQP1PeQ0SCLVf0Jrr+LXv
        ewWmheVR2N84nYphGtVjnae7T6KdrkCs05XRcdGbmL08fLkcEbCyAfk7+aEOmgIF4t6WvGhwkLz
        T/UDcTQvjSf56REacGx0FKMJPkPnCZL1sNPUWUgGW
X-Received: by 2002:a05:6638:519:: with SMTP id i25mr36391247jar.99.1595429557975;
        Wed, 22 Jul 2020 07:52:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/mkKoHrVRoTH0p1AXihXM+dsrCmS/FbLb9LnEV8KCoL7fZKn7E5Nmh+KoAwY75TVuAxoFW1zvneFYLkM550w=
X-Received: by 2002:a05:6638:519:: with SMTP id i25mr36391213jar.99.1595429557600;
 Wed, 22 Jul 2020 07:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191225192118.283637-1-kasong@redhat.com> <20200222165631.GA213225@google.com>
 <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com>
 <CABeXuvqm1iUGt1GWC9eujuoaACdPiZ2X=3LjKJ5JXKZcXD_z_g@mail.gmail.com>
 <CABeXuvonZpwWfcUef4PeihTJkgH2ZC_RCKuLR3rH3Re4hx36Aw@mail.gmail.com>
 <20200305035329.GD4433@MiWiFi-R3L-srv> <CABeXuvogFGv8-i4jsJYN5ya0hjf35EXLkmPqYWayDUvXaBKidA@mail.gmail.com>
 <20200306093829.GA27711@MiWiFi-R3L-srv>
In-Reply-To: <20200306093829.GA27711@MiWiFi-R3L-srv>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 22 Jul 2020 22:52:26 +0800
Message-ID: <CACPcB9cpEX-uYeTp7DVEXtwDRWBCTVoPCB4dxPbyq1sDeixP_w@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Baoquan He <bhe@redhat.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>, jroedel@suse.de,
        Myron Stowe <myron.stowe@redhat.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Wright <rwright@hpe.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Khalid Aziz <khalid@gonehiking.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 5:38 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 03/04/20 at 08:53pm, Deepa Dinamani wrote:
> > On Wed, Mar 4, 2020 at 7:53 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > +Joerg to CC.
> > >
> > > On 03/03/20 at 01:01pm, Deepa Dinamani wrote:
> > > > I looked at this some more. Looks like we do not clear irqs when we do
> > > > a kexec reboot. And, the bootup code maintains the same table for the
> > > > kexec-ed kernel. I'm looking at the following code in
> > >
> > > I guess you are talking about kdump reboot here, right? Kexec and kdump
> > > boot take the similar mechanism, but differ a little.
> >
> > Right I meant kdump kernel here. And, clearly the is_kdump_kernel() case below.
> >
> > >
> > > > intel_irq_remapping.c:
> > > >
> > > >         if (ir_pre_enabled(iommu)) {
> > > >                 if (!is_kdump_kernel()) {
> > > >                         pr_warn("IRQ remapping was enabled on %s but
> > > > we are not in kdump mode\n",
> > > >                                 iommu->name);
> > > >                         clear_ir_pre_enabled(iommu);
> > > >                         iommu_disable_irq_remapping(iommu);
> > > >                 } else if (iommu_load_old_irte(iommu))
> > >
> > > Here, it's for kdump kernel to copy old ir table from 1st kernel.
> >
> > Correct.
> >
> > > >                         pr_err("Failed to copy IR table for %s from
> > > > previous kernel\n",
> > > >                                iommu->name);
> > > >                 else
> > > >                         pr_info("Copied IR table for %s from previous kernel\n",
> > > >                                 iommu->name);
> > > >         }
> > > >
> > > > Would cleaning the interrupts(like in the non kdump path above) just
> > > > before shutdown help here? This should clear the interrupts enabled
> > > > for all the devices in the current kernel. So when kdump kernel
> > > > starts, it starts clean. This should probably help block out the
> > > > interrupts from a device that does not have a driver.
> > >
> > > I think stopping those devices out of control from continue sending
> > > interrupts is a good idea. While not sure if only clearing the interrupt
> > > will be enough. Those devices which will be initialized by their driver
> > > will brake, but devices which drivers are not loaded into kdump kernel
> > > may continue acting. Even though interrupts are cleaning at this time,
> > > the on-flight DMA could continue triggerring interrupt since the ir
> > > table and iopage table are rebuilt.
> >
> > This should be handled by the IOMMU, right? And, hence you are getting
> > UR. This seems like the correct execution flow to me.
>
> Sorry for late reply.
> Yes, this is initializing IOMMU device.
>
> >
> > Anyway, you could just test this theory by removing the
> > is_kdump_kernel() check above and see if it solves your problem.
> > Obviously, check the VT-d spec to figure out the exact sequence to
> > turn off the IR.
>
> OK, I will talk to Kairui and get a machine to test it. Thanks for your
> nice idea, if you have a draft patch, we are happy to test it.
>
> >
> > Note that the device that is causing the problem here is a legit
> > device. We want to have interrupts from devices we don't know about
> > blocked anyway because we can have compromised firmware/ devices that
> > could cause a DoS attack. So blocking the unwanted interrupts seems
> > like the right thing to do here.
>
> Kairui said it's a device which driver is not loaded in kdump kernel
> because it's not needed by kdump. We try to only load kernel modules
> which are needed, e.g one device is the dump target, its driver has to
> be loaded in. In this case, the device is more like a out of control
> device to kdump kernel.
>

Hi Bao, Deepa, sorry for this very late response. The test machine was
not available for sometime, and I restarted to work on this problem.

For the workaround mention by Deepa (by remote the is_kdump_kernel()
check), it didn't work, the machine still hangs upon shutdown.
The devices that were left in an unknown state and sending interrupt
could be a problem, but it's irrelevant to this hanging problem.

I think I didn't make one thing clear, The PCI UR error never arrives
in kernel, it's the iLo BMC on that HPE machine caught the error, and
send kernel an NMI. kernel is panicked by NMI, I'm still trying to
figure out why the NMI hanged kernel, even with panic=-1,
panic_on_io_nmi, panic_on_unknown_nmi all set. But if we can avoid the
NMI by shutdown the devices in right order, that's also a solution.

--
Best Regards,
Kairui Song

