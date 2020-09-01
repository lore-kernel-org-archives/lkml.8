Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03528C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B354422208
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATRqzzRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgIAOo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:44:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21140 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728591AbgIAOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598971411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GPbP04lPt1v0iZ449hyOji4fcc1kzdBh1pIqDA8zHp0=;
        b=ATRqzzRklr3EHlpf8qRXvCiX+RiMq8U7B5RoXM4y7UY0x3MR0DANBAiVnT9O2sJSfbbpG7
        RUUpfcWM3avs4mAgyAP7J+J4vp1VGf8jESztr8Ap3NgTAVW6EVLTTuT1SQGzQkXXdh1Q6f
        2NNpkF8sf67zBUucg0Oi0b99i1Hn/oU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-hexgGdO1MiSP2Lk88VGIPw-1; Tue, 01 Sep 2020 10:43:28 -0400
X-MC-Unique: hexgGdO1MiSP2Lk88VGIPw-1
Received: by mail-wr1-f72.google.com with SMTP id k11so668606wrw.16
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 07:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GPbP04lPt1v0iZ449hyOji4fcc1kzdBh1pIqDA8zHp0=;
        b=Ja3LUs0FQnBSUa3N0zz5yIljckVU1RFK2ubYLd8ITTnsgqrQDMmoFgbQbgRDsC4vwd
         zIL+/XOBVBddCSXKxMdvk+xrVVLdB37KstcgOWFTsIAKZ058TyUhSs8yfDbElsxKOsd4
         xTbQdrI1b6lYS5C5CLq2IXjAV4vAJ52kgzVCGLloqxGKExbVa4IhpWtzPa/ir7+PF3wa
         Oqdi9Yns2EeruyPDDQg/HG0NbQP1UZOxMe+JIP7CDMnRWzaE2zvFPxNy8203yVAIlmVD
         rIMqfVX0Ia8y3xAaHJnsIgQLkifbYu4ThQyFg7HEfMTdMlOVUwjlPeDRymmxMzxGJ4cU
         RqyA==
X-Gm-Message-State: AOAM531fqL/7FucUeCeSpxBdDwGvLGWNFQyz6mrbYld4iyLXa7VBWoYc
        M0k0nzb+YlY/bQ5BrC43H0sCjRzsSHp1GGYN17tWWtwQ5f/gbFIpWv0ImO/zfvKOWsrPhCH9OIp
        ZUGQVPo4f9J5m43WT5fC1mcmq
X-Received: by 2002:adf:db52:: with SMTP id f18mr2217332wrj.397.1598971406999;
        Tue, 01 Sep 2020 07:43:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJzKR8a+SsyTI8zecqTgZ0D4P1NUMXQNbFg4Z1fpLhaO9xme/Gd1HwibnnhuJcxZ1jjgroFg==
X-Received: by 2002:adf:db52:: with SMTP id f18mr2217303wrj.397.1598971406756;
        Tue, 01 Sep 2020 07:43:26 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p16sm2574255wro.71.2020.09.01.07.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:43:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] KVM: x86: KVM_MEM_PCI_HOLE memory
In-Reply-To: <20200825212526.GC8235@xz-x1>
References: <20200807141232.402895-1-vkuznets@redhat.com> <20200825212526.GC8235@xz-x1>
Date:   Tue, 01 Sep 2020 16:43:25 +0200
Message-ID: <87eenlwoaa.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Fri, Aug 07, 2020 at 04:12:29PM +0200, Vitaly Kuznetsov wrote:
>> When testing Linux kernel boot with QEMU q35 VM and direct kernel boot
>> I observed 8193 accesses to PCI hole memory. When such exit is handled
>> in KVM without exiting to userspace, it takes roughly 0.000001 sec.
>> Handling the same exit in userspace is six times slower (0.000006 sec) so
>> the overal; difference is 0.04 sec. This may be significant for 'microvm'
>> ideas.
>
> Sorry to comment so late, but just curious... have you looked at what's those
> 8000+ accesses to PCI holes and what they're used for?  What I can think of are
> some port IO reads (e.g. upon vendor ID field) during BIOS to scan the devices
> attached.  Though those should be far less than 8000+, and those should also be
> pio rather than mmio.

And sorry for replying late)

We explicitly want MMIO instead of PIO to speed things up, afaiu PIO
requires two exits per device (and we exit all the way to
QEMU). Julia/Michael know better about the size of the space.

>
> If this is only an overhead for virt (since baremetal mmios should be fast),
> I'm also thinking whether we can make it even better to skip those pci hole
> reads.  Because we know we're virt, so it also gives us possibility that we may
> provide those information in a better way than reading PCI holes in the guest?

This means let's invent a PV interface and if we decide to go down this
road, I'd even argue for abandoning PCI completely. E.g. we can do
something similar to Hyper-V's Vmbus.

-- 
Vitaly

