Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDCBC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BE1206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQkOKLSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGZSgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:36:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48439 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726072AbgGZSgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595788565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CCd534kbcEa29GKpOVkxv14/VG61uCp+SScamUpw60w=;
        b=eQkOKLSp4/HmH/mQc9lqo93C6Tj34Dx8bTHiCBPvI+tlRyNDScWTCCQvY7eV0r2qOesvQ/
        sfHkumiGrnAaWbH/bHtX+XzV2riFPFCGlxnv2HPXpUKPqRZ0Bxa0/gryedsGE/X4mOj+gJ
        CyiiSt616lnTnNrrXMsjKE9MJIP0Ldk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-cfygYChVPMOk_SkIQ234zQ-1; Sun, 26 Jul 2020 14:36:00 -0400
X-MC-Unique: cfygYChVPMOk_SkIQ234zQ-1
Received: by mail-lf1-f69.google.com with SMTP id c204so3634588lfg.16
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCd534kbcEa29GKpOVkxv14/VG61uCp+SScamUpw60w=;
        b=OWGhmWDmX/idLH9XcU5Ut5RG+RNj9GN5LoCyZLP3lBe34BX39mB2SdUPbKzG3cTuco
         RV0W6G4dXTYMpQtKxvhxXMKmFgWUCu4842GNcAUA6I2qe6leGoYGmzBUMjswcyL5rE03
         03cns1SdbYvcPdN71qoi6VUU24byRf8cE6BlF3/NX/9We67p3Co69aBsMxIeSBn63Bvn
         yPAybrCXOdru0IVKouMinpJGlGoX9fHkrIDvoFbd8blRo9E+z/fpLGjLCi3lTUU8yjJy
         rpr88rL/qepwVxmfKoRe+03s2xEsuoTGDEpAHONG133Vb+vzGD+06C0vvBmQOYFYHESI
         R45w==
X-Gm-Message-State: AOAM533FXFJWRrPJYGSh7TjMYUXB6nactMsDEJByxxo9UTBmDQy9YhYG
        0eNEE/XcB1jKEG49sqNZTzcuXzaMGmMaCAt/FA6z7WSi72G08kbjrtNP+SvFoaBmd9UnM2Uei+e
        Rka/hdf7ZCU/T828HDTYNel2HysyOcCLhD+MeMsc2
X-Received: by 2002:a2e:9b92:: with SMTP id z18mr9314060lji.364.1595788559259;
        Sun, 26 Jul 2020 11:35:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1lHoPJwvL5EM6n1PDeRsl+1rX1UoAqAxy4vd1au5G+5bbJterCXOdiLnTTIPwJ6s0wGjsAu/UhtjZxJXB7f8=
X-Received: by 2002:a2e:9b92:: with SMTP id z18mr9314053lji.364.1595788559035;
 Sun, 26 Jul 2020 11:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200722001513.298315-1-jusual@redhat.com> <87d04nq40h.fsf@vitty.brq.redhat.com>
In-Reply-To: <87d04nq40h.fsf@vitty.brq.redhat.com>
From:   Julia Suvorova <jusual@redhat.com>
Date:   Sun, 26 Jul 2020 20:35:47 +0200
Message-ID: <CAMDeoFX0oF3TSfzY8Yifd+9hBhdpKL40t8KFseBj2TsQYRYS8w@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:43 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Julia Suvorova <jusual@redhat.com> writes:
>
> > Scanning for PCI devices at boot takes a long time for KVM guests. It
> > can be reduced if KVM will handle all configuration space accesses for
> > non-existent devices without going to userspace [1]. But for this to
> > work, all accesses must go through MMCONFIG.
> > This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
> > guests making MMCONFIG the default access method.
> >
> > [1] https://lkml.org/lkml/2020/5/14/936
> >
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
> > +
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
> >
> >       return 1;
> >  }
>
> This implies mmconfig access method is always functional (when present)
> for all KVM guests, regardless of hypervisor version/which KVM userspace
> is is use/... In case the assumption is true the patch looks good (to
> me) but in case it isn't or if we think that more control over this
> is needed we may want to introduce a PV feature bit for KVM.

Ok, I'll introduce a feature bit and turn it on in QEMU.

> Also, I'm thinking about moving this to arch/x86/kernel/kvm.c: we can
> override x86_init.pci.arch_init and reassign raw_pci_ops after doing
> pci_arch_init().

This might be a good idea.

Best regards, Julia Suvorova.

