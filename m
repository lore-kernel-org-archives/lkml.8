Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8112AC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6255E206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEv5Mn1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGZS7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:59:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbgGZS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595789942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MnkAVzbcQmzJaGdzKxUV0o/LhPkQD/MG1aQW4yPzWQI=;
        b=FEv5Mn1rN/PISX3iRiqXq0A1iUasNRC5eLDwavrmbovGI2r1voMno3nvp8ae/sf3dpDvO7
        6W1Rggev9AydqR+cyFLbegS/Sh94J4LlLZ/WwZSyzLZdsOb7/AfB+mmpPYv3mM5talcMdW
        IhtdimPPaisjFhfTicdI2F1qYeZxu/0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-9TwZfCTyPHm6V4PFUJh5HA-1; Sun, 26 Jul 2020 14:58:57 -0400
X-MC-Unique: 9TwZfCTyPHm6V4PFUJh5HA-1
Received: by mail-lj1-f197.google.com with SMTP id x24so1916358ljm.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnkAVzbcQmzJaGdzKxUV0o/LhPkQD/MG1aQW4yPzWQI=;
        b=IzjPCxA+HiXhCXKc/PJNiITKuUIbWj22Wv8vCzJThvIqY9UW9Dqirx7JAHvSdNdOoV
         dgidEKO64TKj2AuAm+jh16ycsRhg8CvCodFjfZz4a2+O9cuUQIZf3GNAOXtGgz/4IqW2
         S3Td7FfjG+rIoUEgSOQeWT0v8dOdS4oD/JkD3KbEMNeew7bf1FYY6Rfw2vXGIuGBPwhK
         xh34d9YH2K1IeEBp2mTGHa1y35BVKmzcDMVL9d5Z0eLmxw53Ow0irNBOjXOydenqL/6K
         VIhOqfuqOrjO67w1ckD3D4ieUB1sppi3ioS5DfUyVvd+rIWf9i7kQfgP0hKIm7iqI3nb
         oZQA==
X-Gm-Message-State: AOAM531+v4BykOf0bcLf9RANjEluzsSVoQ8cmel98yXB/U1EHw/VnZeI
        +kT5GzLzOSyOywx0Pp56VVl1JBYSU0bSB6y/K563uQ2Bt6Osz1QYpbU7OPQ+w03+Ivodn1kJc6g
        uZlVkPmDBv3H7rLGqXCf04W89wfZtEhkuwPx+3Kpi
X-Received: by 2002:a19:cc9:: with SMTP id 192mr10065169lfm.61.1595789936290;
        Sun, 26 Jul 2020 11:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoAU0F4Ib7Y/A1tK4UvEwFvUVRP7nlxAUZAt9rZgjV7Xt99Rt0nAxaSItJ8sR8FbQvjEju4c0GJyrk4aOUV4M=
X-Received: by 2002:a19:cc9:: with SMTP id 192mr10065155lfm.61.1595789936004;
 Sun, 26 Jul 2020 11:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200722001513.298315-1-jusual@redhat.com> <20200722231929.GA1314067@bjorn-Precision-5520>
In-Reply-To: <20200722231929.GA1314067@bjorn-Precision-5520>
From:   Julia Suvorova <jusual@redhat.com>
Date:   Sun, 26 Jul 2020 20:58:45 +0200
Message-ID: <CAMDeoFUCanfvrxAmW4_QH=L9BExCAydCifE_tvRaW_XTd0OQXw@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 1:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jul 22, 2020 at 02:15:13AM +0200, Julia Suvorova wrote:
> > Scanning for PCI devices at boot takes a long time for KVM guests. It
> > can be reduced if KVM will handle all configuration space accesses for
> > non-existent devices without going to userspace [1]. But for this to
> > work, all accesses must go through MMCONFIG.
> > This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
> > guests making MMCONFIG the default access method.
>
> The above *looks* like it's intended to be two paragraphs, which would
> be easier to read with a blank line between.
>
> The last sentence should say what the patch actually *does*, e.g.,
> "Use pci_mmcfg as raw_pci_ops ..."
>
> > [1] https://lkml.org/lkml/2020/5/14/936
>
> Please use a lore.kernel.org URL instead because it's more usable and
> I'd rather depend on kernel.org than lkml.org.
>
> > Signed-off-by: Julia Suvorova <jusual@redhat.com>
> > ---
> >  arch/x86/pci/direct.c      | 5 +++++
> >  arch/x86/pci/mmconfig_64.c | 3 +++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/x86/pci/direct.c b/arch/x86/pci/direct.c
> > index a51074c55982..8ff6b65d8f48 100644
> > --- a/arch/x86/pci/direct.c
> > +++ b/arch/x86/pci/direct.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/init.h>
> >  #include <linux/dmi.h>
> > +#include <linux/kvm_para.h>
> >  #include <asm/pci_x86.h>
> >
> >  /*
> > @@ -264,6 +265,10 @@ void __init pci_direct_init(int type)
> >  {
> >       if (type == 0)
> >               return;
> > +
> > +     if (raw_pci_ext_ops && kvm_para_available())
> > +             return;
> >       printk(KERN_INFO "PCI: Using configuration type %d for base access\n",
> >                type);
> >       if (type == 1) {
> > diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> > index 0c7b6e66c644..9eb772821766 100644
> > --- a/arch/x86/pci/mmconfig_64.c
> > +++ b/arch/x86/pci/mmconfig_64.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/init.h>
> >  #include <linux/acpi.h>
> >  #include <linux/bitmap.h>
> > +#include <linux/kvm_para.h>
> >  #include <linux/rcupdate.h>
> >  #include <asm/e820/api.h>
> >  #include <asm/pci_x86.h>
> > @@ -122,6 +123,8 @@ int __init pci_mmcfg_arch_init(void)
> >               }
> >
> >       raw_pci_ext_ops = &pci_mmcfg;
> > +     if (kvm_para_available())
> > +             raw_pci_ops = &pci_mmcfg;
>
> The idea of using MMCONFIG for *all* config space, not just extended
> config space, makes sense to me, although the very long discussion at
> https://lore.kernel.org/lkml/20071225032605.29147200@laptopd505.fenrus.org/
> makes me wary.  Of course I realize you're talking specifically about
> KVM, not doing this in general.
>
> But it doesn't seem right to make this specific to KVM, since it's not
> obvious to me that there's a basis in PCI for making this distinction.

Bugs that were fixed (or more accurately, avoided) by a0ca99096094
("PCI x86: always use conf1 to access config space below 256 bytes")
are still present. And to enable MMCONFIG for the entire config space,
we need to re-introduce all these fixes or at least identify affected
devices, which may be impossible.

We can avoid KVM-specific changes in the generic PCI code by
implementing x86_init.pci.arch_init inside KVM code, as Vitaly
suggested. What do you think?

Best regards, Julia Suvorova.

