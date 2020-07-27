Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449EEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0C42065E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlnuqN9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgG0P4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:56:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29036 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726944AbgG0P4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595865362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TDBVj7bHt6Fay5LTDY6rfY9vuNNASLukydt89FqrzTY=;
        b=OlnuqN9NYCnRCbAzaY6OBbz2YyqKurS6A+XKuNK9tflmwwzmOpASzHCmZek4rcBF8lNANE
        ti+4Vcxo1+PPvaut2oElMnSp+Ja0G9K0C1b7fnj5vnyXQCTln0f2Q0DhpAjlcg6HVt4DhK
        6BR+2lelTNepHugjByCy+PZSxXytXDs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-u6h2zuAnPaOtFZ6eXjo-cA-1; Mon, 27 Jul 2020 11:55:58 -0400
X-MC-Unique: u6h2zuAnPaOtFZ6eXjo-cA-1
Received: by mail-ed1-f70.google.com with SMTP id u25so5773392edq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TDBVj7bHt6Fay5LTDY6rfY9vuNNASLukydt89FqrzTY=;
        b=FYtNXvIBrxfR0FsFhaKXOkcVuylXu6zCLDEJjIyhkZrn7M6b7xcV7tHdVaLqUm8+Q+
         5060ZmtM1Fw6LGSzlNsQgEw8LWUB7ql6nahWhzPB+lZbJfqQGiVDidIfPP/aIIzAKCcC
         bmcvlvA6XvkTocam7dFT9eL6BPDgSNEv09opVQjtSZMMLbBbAplrbKMx9YgLlv/9K6ar
         HxyVr6TYezTkQNqorhETPyGrxgFYXwpO9ykgzMXG52PbCpoUKgVIgasS9LmuVL9yYnqX
         AzcS8q+D6ni59CvgtGdLzt/sCX7mOCVD3I1RA/XBf5yUqmAeVrsGvI05NnnO7/moKtIE
         o9lA==
X-Gm-Message-State: AOAM532bbv7dGHAEualIcmRlEDWRdTXqhclRMQCypqHyLhUSEBL0Zc9f
        0SMZ8WJ7qPvn4xrXzwYY/el5IIdz4QXdgA0qrnZOnDd+08W8lpQdIAyhBoxY5hLsaOeS8ZDZs9y
        +BrEeoyEqMUAhh9de1rsa14BR
X-Received: by 2002:a17:906:8316:: with SMTP id j22mr2275456ejx.20.1595865356852;
        Mon, 27 Jul 2020 08:55:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYP4hsrj5jhbksZ3bHS+m22n8MBnPkqWri7tfe/lVqT8nyCOh1YNkb5qxrkUlGB6A+j62Chg==
X-Received: by 2002:a17:906:8316:: with SMTP id j22mr2275433ejx.20.1595865356545;
        Mon, 27 Jul 2020 08:55:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a1sm7311678ejk.125.2020.07.27.08.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:55:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Julia Suvorova <jusual@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "open list\:VFIO DRIVER" <kvm@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] x86/PCI: Use MMCONFIG by default for KVM guests
In-Reply-To: <CAHp75VfLjYvFUVw+uHbMJCeoNfs6nb4Qh1OoQraA5bTkR9SeRg@mail.gmail.com>
References: <20200722001513.298315-1-jusual@redhat.com> <87d04nq40h.fsf@vitty.brq.redhat.com> <CAHp75VfLjYvFUVw+uHbMJCeoNfs6nb4Qh1OoQraA5bTkR9SeRg@mail.gmail.com>
Date:   Mon, 27 Jul 2020 17:55:55 +0200
Message-ID: <87lfj5lzp0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Wed, Jul 22, 2020 at 12:47 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>> Julia Suvorova <jusual@redhat.com> writes:
>
>> > Scanning for PCI devices at boot takes a long time for KVM guests. It
>> > can be reduced if KVM will handle all configuration space accesses for
>> > non-existent devices without going to userspace [1]. But for this to
>> > work, all accesses must go through MMCONFIG.
>> > This change allows to use pci_mmcfg as raw_pci_ops for 64-bit KVM
>> > guests making MMCONFIG the default access method.
>
> I'm not sure it won't break anything.

It likely will as it's really hard to check all possible KVM
configurations in existence and that's why we are converging on adding a
feature bit which KVM userspace (e.g. QEMU) will set when the
configuration is known to be good.

>
>> > [1] https://lkml.org/lkml/2020/5/14/936
>
> use Link: tag and better to use lore.kernel.org.
>
>> This implies mmconfig access method is always functional (when present)
>> for all KVM guests, regardless of hypervisor version/which KVM userspace
>> is is use/... In case the assumption is true the patch looks good (to
>> me) but in case it isn't or if we think that more control over this
>> is needed we may want to introduce a PV feature bit for KVM.
>>
>> Also, I'm thinking about moving this to arch/x86/kernel/kvm.c: we can
>> override x86_init.pci.arch_init and reassign raw_pci_ops after doing
>> pci_arch_init().
>
> % git grep -n -w x86_init.pci.arch_init -- arch/x86/
> arch/x86/hyperv/hv_init.c:400:  x86_init.pci.arch_init = hv_pci_init;
> arch/x86/kernel/apic/apic_numachip.c:203:       x86_init.pci.arch_init
> = pci_numachip_init;
> arch/x86/kernel/jailhouse.c:207:        x86_init.pci.arch_init
>  = jailhouse_pci_arch_init;
> arch/x86/pci/init.c:20: if (x86_init.pci.arch_init && !x86_init.pci.arch_init())
> arch/x86/platform/intel-mid/intel-mid.c:172:    x86_init.pci.arch_init
> = intel_mid_pci_init;
> arch/x86/platform/olpc/olpc.c:309:              x86_init.pci.arch_init
> = pci_olpc_init;
> arch/x86/xen/enlighten_pv.c:1411:
> x86_init.pci.arch_init = pci_xen_init;
>
> Are you going to update all these? Or how this is supposed to work (I
> may be missing something)?

My suggestion was to do exactly the same for KVM guests instead of
switching ops in pci_mmcfg_arch_init() depending on kvm_para_available()
output. Basically, keep all KVM-related tunings in one place
(arch/x86/kernel/kvm.c).

-- 
Vitaly

