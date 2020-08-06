Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B59C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0A822CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 00:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVPRz5ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgHFASr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:18:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbgHFASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596673125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MJRT7zSpZFX2l/kmuMRr1EyvfjsdpbwTsB/NIpr52Vg=;
        b=hVPRz5juCk1UPHRpTQ7LINvKwjch3Px/1ZF8lKV14XStP0B7tr8eBWdE+toNInzecpS5R3
        mniXrNFT+rLRY+l2HO/wuEkbRRm/KPP9N82tozS0RBb9wsRpmSj61z+Ab/HJDHqlMzLevz
        t+LoEUf+uaJI1A6V+ajkh0Jx4PRKQaA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-4NIuWPPqO6WilGKRc-Y4AA-1; Wed, 05 Aug 2020 20:18:43 -0400
X-MC-Unique: 4NIuWPPqO6WilGKRc-Y4AA-1
Received: by mail-wr1-f71.google.com with SMTP id k11so13524402wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 17:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MJRT7zSpZFX2l/kmuMRr1EyvfjsdpbwTsB/NIpr52Vg=;
        b=hOXs2qGoUTt++qTiZoC0bTgjpi0GB5RecuXNtlcahky21wpcDVpZO3z1CeNWL3KLqW
         ++XO/HHqVmrLIZX+8qNuEGxysVxDWN9Uaj1+ty3Lk85CyPGMueQEUtgJ7q8pHhzvVz9G
         5fBlTPe0QSAMOQzENWvFgGPuT/e1+riySAMwwkRPODKg0I4ALupK4ymxtXTL3oGLZLnr
         8QJ7wiBxVm0u6kUQN96Q+GGeQNTQfhWRY2qskaQDXbXQJ42F33eVjoXl8goL4iMJgJ6Q
         QxkCztrGWL/LNF6/s8gwdwhZ+wP5p9xsZaHtYyurEQM6uD4prCeYV5npP/wewWLj+wWQ
         GZww==
X-Gm-Message-State: AOAM532MycohmZYtL3SqNNmmD9e8yHNF1eKuY54RoKoEmOtMN7aYvARi
        HwrIXPN9K2qgBVw33Y0EfsGZ5zzq1xYJ7fCKUGbOj+70h/urvIunBBPJIzES8dd1fIGsuOaeG8Y
        fobDQx3HJvx+v9XKivyXO2DKM
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr4761728wrx.354.1596673122281;
        Wed, 05 Aug 2020 17:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIUgCo8JmpOWMKH0QebbmqgBGb/LD/AwNZ3OZiBAbeJF9gifgU0NvT9R6cIHZlnE7BhL8MxA==
X-Received: by 2002:a05:6000:120c:: with SMTP id e12mr4761704wrx.354.1596673122078;
        Wed, 05 Aug 2020 17:18:42 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id g3sm5035425wrb.59.2020.08.05.17.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 17:18:41 -0700 (PDT)
Date:   Wed, 5 Aug 2020 20:18:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Peter Xu <peterx@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] KVM: x86: introduce KVM_MEM_PCI_HOLE memory
Message-ID: <20200805201702-mutt-send-email-mst@kernel.org>
References: <20200728143741.2718593-1-vkuznets@redhat.com>
 <20200728143741.2718593-3-vkuznets@redhat.com>
 <CALMp9eSWsvufDXMuTUR3Fmh91O7tHUaqpDbAoavSMc=prpcDzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eSWsvufDXMuTUR3Fmh91O7tHUaqpDbAoavSMc=prpcDzg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:05:40AM -0700, Jim Mattson wrote:
> On Tue, Jul 28, 2020 at 7:38 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > PCIe config space can (depending on the configuration) be quite big but
> > usually is sparsely populated. Guest may scan it by accessing individual
> > device's page which, when device is missing, is supposed to have 'pci
> > hole' semantics: reads return '0xff' and writes get discarded. Compared
> > to the already existing KVM_MEM_READONLY, VMM doesn't need to allocate
> > real memory and stuff it with '0xff'.
> 
> Note that the bus error semantics described should apply to *any*
> unbacked guest physical addresses, not just addresses in the PCI hole.
> (Typically, this also applies to the standard local APIC page
> (0xfee00xxx) when the local APIC is either disabled or in x2APIC mode,
> which is an area that kvm has had trouble with in the past.)

Well ATM from KVM's POV unbacked -> exit to userspace, right?
Not sure what you are suggesting here ...

-- 
MST

