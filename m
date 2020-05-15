Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3878FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B2620709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589504616;
	bh=67KeMOOHllPtjB4niROag3k8A8DvU7fdhWlbPOcGW1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JJDUTo53DivMShKDBRRc6sFU/JcuZSz6sLXnBFh1ALNHks73pDaaljchwP4fXA3ZH
	 7tPmM6w5wVdrmrX+BJGq+TwI04KvS14SJVt2XNj2iNEv6IyFNcZDswWAq67BrfzLpA
	 e31fRd/mso3R6GGYKcmQhCq87H+S5kLwq/5B9EsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEOBDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgEOBDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:03:34 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D83FC20760
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589504614;
        bh=67KeMOOHllPtjB4niROag3k8A8DvU7fdhWlbPOcGW1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sh1zxBz+d9fkmcicP8jvyuLHjND0Tftcj+cMN9e1ot4NhKJZKsR635Bg8oKx/rCfx
         JH5EDkUaOykToWV9LlVeJSPMet1Yv3kPj9s8twooW8hUBbnGpLjKRKBZGX1OLb2YpR
         Yo12O+RHuFE1RRByr3o8tsHKIReXsET2ciIEJiOU=
Received: by mail-wr1-f52.google.com with SMTP id j5so1427154wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 18:03:33 -0700 (PDT)
X-Gm-Message-State: AOAM5314Gj2Q96vYGPUXvEHsmop5Vseh/8E7QedN2jTaoPWNX4EyE+cH
        slFxCCJU9mfAFoV6XSUtY76nDRTLSvgg2LX03KIpJg==
X-Google-Smtp-Source: ABdhPJwChWt2wQEEg3Hjs6bFAQrFplWyheRat8eiTxJYXZxeUWE24J6YSsSLj6y4jGmWqmRd2H44t28JQzqxAMaYfJE=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr1246285wro.70.1589504612293;
 Thu, 14 May 2020 18:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200514180540.52407-1-vkuznets@redhat.com> <20200514220516.GC449815@xz-x1>
 <20200514225623.GF15847@linux.intel.com>
In-Reply-To: <20200514225623.GF15847@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 18:03:20 -0700
X-Gmail-Original-Message-ID: <CALCETrUf3qMgpYGfF=b6dt2gneodTv5eYGGwKZ=xDSYDa9aTVg@mail.gmail.com>
Message-ID: <CALCETrUf3qMgpYGfF=b6dt2gneodTv5eYGGwKZ=xDSYDa9aTVg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] KVM: x86: KVM_MEM_ALLONES memory
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 3:56 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Thu, May 14, 2020 at 06:05:16PM -0400, Peter Xu wrote:
> > On Thu, May 14, 2020 at 08:05:35PM +0200, Vitaly Kuznetsov wrote:
> > > The idea of the patchset was suggested by Michael S. Tsirkin.
> > >
> > > PCIe config space can (depending on the configuration) be quite big but
> > > usually is sparsely populated. Guest may scan it by accessing individual
> > > device's page which, when device is missing, is supposed to have 'pci
> > > holes' semantics: reads return '0xff' and writes get discarded. Currently,
> > > userspace has to allocate real memory for these holes and fill them with
> > > '0xff'. Moreover, different VMs usually require different memory.
> > >
> > > The idea behind the feature introduced by this patch is: let's have a
> > > single read-only page filled with '0xff' in KVM and map it to all such
> > > PCI holes in all VMs. This will free userspace of obligation to allocate
> > > real memory and also allow us to speed up access to these holes as we
> > > can aggressively map the whole slot upon first fault.
> > >
> > > RFC. I've only tested the feature with the selftest (PATCH5) on Intel/AMD
> > > with and wiuthout EPT/NPT. I haven't tested memslot modifications yet.
> > >
> > > Patches are against kvm/next.
> >
> > Hi, Vitaly,
> >
> > Could this be done in userspace with existing techniques?
> >
> > E.g., shm_open() with a handle and fill one 0xff page, then remap it to
> > anywhere needed in QEMU?
>
> Mapping that 4k page over and over is going to get expensive, e.g. each
> duplicate will need a VMA and a memslot, plus any PTE overhead.  If the
> total sum of the holes is >2mb it'll even overflow the mumber of allowed
> memslots.

How about a tiny character device driver /dev/ones?
