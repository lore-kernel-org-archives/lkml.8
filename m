Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E85CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17F422B43
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Od6GA2Ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgGaSXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:23:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26709 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730040AbgGaSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596219832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNpcdsYn9B2kxIJXPQv8FKNGYI77IPCjCGNgFBGg9TU=;
        b=Od6GA2GaEp5hqASKk4nL2N5EgdeCQxp67P0vp/BUlLuAPwEFX0T4rtfDksN8Q9GpaZ86DM
        s9QMNNyy7y455eH0roUII7iJS69uLNEOeUMbEuYbgrhdYR/aSqQOlbxK0d+klWZ+Irb2et
        +R+30nhocq9v27OHG0MlRmJdzbpY9qM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-b8WkqDzhPyCYOdVodpMmfw-1; Fri, 31 Jul 2020 14:23:50 -0400
X-MC-Unique: b8WkqDzhPyCYOdVodpMmfw-1
Received: by mail-lf1-f72.google.com with SMTP id u26so5756001lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNpcdsYn9B2kxIJXPQv8FKNGYI77IPCjCGNgFBGg9TU=;
        b=rTPw3CDF2M5tGDE7oliWqRMx1WcidcX5HxVf8WnbQsbQwim0tP7L0h4S/rWQ1uPJaE
         ehnJdhleNgHAyP0oUhszsTUIMC96czK/r8DCcFm/YBsBV9xDDMv07Gjmanz9argZFgCf
         Z/EqKUH+hYEEPw2Z1YMnowZoHJRMR8nnet4a78wk0Uxi7FJCZTKKj0CYos1kvAcjBeao
         V0S0iUo/Ae35ndwsM7ltOb9ZhTly12kHBovkYjWOV7KPLo0I80Y+CZHX/7Tgf9J4K3+O
         FK8yze8/95dZwfi6PB7ZQ8SH4MTwauTT2AxLViOkLkBUp8eVpnTZRW4SChP8zDOAJXNN
         CLEg==
X-Gm-Message-State: AOAM533254mn3+KE9Evy6zavKX8HEjwmtaJgEW5eEbVqcGiq90yj5S0l
        sBxaDsQdxNsFBg5EyrbL1+VjUxNmeA7CUdzk/biXP7uTzhy7oyyU4McK7Nsq0ow4fZEmU7tEznH
        Qb9n0bBUy659W1sKw+MDg80Q1qU8LpjTCz48fgj/a
X-Received: by 2002:a2e:9b92:: with SMTP id z18mr2632601lji.364.1596219828876;
        Fri, 31 Jul 2020 11:23:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4Ant7fRiaPouV8KSdgTTmMLlIjwSIMUXrC6ApBECDS2mEDf33c4K66gE4HFkxWsG1WUkVTH6tWl9p/Sj0yXU=
X-Received: by 2002:a2e:9b92:: with SMTP id z18mr2632592lji.364.1596219828575;
 Fri, 31 Jul 2020 11:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200730193510.578309-1-jusual@redhat.com> <CAHp75VcyRjAr3ugmAWYcKMrAeea6ioQOPfJnj-Srntdg_W8ScQ@mail.gmail.com>
 <873658kpj2.fsf@vitty.brq.redhat.com>
In-Reply-To: <873658kpj2.fsf@vitty.brq.redhat.com>
From:   Julia Suvorova <jusual@redhat.com>
Date:   Fri, 31 Jul 2020 20:23:37 +0200
Message-ID: <CAMDeoFUO7UqDx05dK3fJBCfWMDCmEJ+K=nVAvvnPZiTz2+gSTg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Use MMCONFIG for all PCI config space accesses
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:VFIO DRIVER" <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 11:22 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
> > On Thu, Jul 30, 2020 at 10:37 PM Julia Suvorova <jusual@redhat.com> wrote:
> >>
> >> Using MMCONFIG instead of I/O ports cuts the number of config space
> >> accesses in half, which is faster on KVM and opens the door for
> >> additional optimizations such as Vitaly's "[PATCH 0/3] KVM: x86: KVM
> >> MEM_PCI_HOLE memory":
> >
> >> https://lore.kernel.org/kvm/20200728143741.2718593-1-vkuznets@redhat.com
> >
> > You may use Link: tag for this.
> >
> >> However, this change will not bring significant performance improvement
> >> unless it is running on x86 within a hypervisor. Moreover, allowing
> >> MMCONFIG access for addresses < 256 can be dangerous for some devices:
> >> see commit a0ca99096094 ("PCI x86: always use conf1 to access config
> >> space below 256 bytes"). That is why a special feature flag is needed.
> >>
> >> Introduce KVM_FEATURE_PCI_GO_MMCONFIG, which can be enabled when the
> >> configuration is known to be safe (e.g. in QEMU).
> >
> > ...
> >
> >> +static int __init kvm_pci_arch_init(void)
> >> +{
> >> +       if (raw_pci_ext_ops &&
> >> +           kvm_para_has_feature(KVM_FEATURE_PCI_GO_MMCONFIG)) {
> >
> > Better to use traditional pattern, i.e.
> >   if (not_supported)
> >     return bail_out;
> >
> >   ...do useful things...
> >   return 0;
> >
> >> +               pr_info("PCI: Using MMCONFIG for base access\n");
> >> +               raw_pci_ops = raw_pci_ext_ops;
> >> +               return 0;
> >> +       }
> >
> >> +       return 1;
> >
> > Hmm... I don't remember what positive codes means there. Perhaps you
> > need to return a rather error code?
>
> If I'm reading the code correctly,
>
> pci_arch_init() has the following:
>
>         if (x86_init.pci.arch_init && !x86_init.pci.arch_init())
>                 return 0;
>
>
> so returning '1' here means 'continue' and this seems to be
> correct. (E.g. Hyper-V's hv_pci_init() does the same). What I'm not sure
> about is 'return 0' above as this will result in skipping the rest of
> pci_arch_init(). Was this desired or should we return '1' in both cases?

This is intentional because pci_direct_init() is about to overwrite
raw_pci_ops. And since QEMU doesn't have anything in
pciprobe_dmi_table, it is safe to skip it.

Best regards, Julia Suvorova.

