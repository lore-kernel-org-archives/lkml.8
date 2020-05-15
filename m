Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9739CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712DF204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eg/D5Yhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgEOLPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:15:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44598 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEOLPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589541344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wj1hRCTkHQCZJH+c9WShqi9qUC8IADHSYNNh6gBVfN4=;
        b=eg/D5YhuPDgxMiOCOPlEELCfbd5WRSx3JOd/psOKteqaqUDaO4/mzoZ8vL7/8IqYr4cdEn
        JCKPPdMBJJH9t5ZKhl91mjUdP/Sm17ZTnei6RdlyeGiV2AHYiD0R70O80H64h6YbDZSW2s
        dGCOc2TyGtkdNL6sj+nLp11x8i6xH/g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-7fB8KjlANnWXBkPAbKVJZg-1; Fri, 15 May 2020 07:15:42 -0400
X-MC-Unique: 7fB8KjlANnWXBkPAbKVJZg-1
Received: by mail-qt1-f199.google.com with SMTP id o11so1999886qti.23
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wj1hRCTkHQCZJH+c9WShqi9qUC8IADHSYNNh6gBVfN4=;
        b=rweaQQZs4YKe9w7eKpz/YA8bfuduvWjIwZUQok3Q98DnPcYDf5VVEpimiyqM5Har/n
         iXNUqLXh7LoDWWbP2wdAd5CJB1J6YDmL/ScWE/hrFEmQ6vn5Ua4krREJFCBljqakNsCE
         EWsHdKVmzs5Ia1oCSq8pVKUt1Lis5CzcQV0NhICc7WDTwn5+c2CatF/FYhwySiMtN8df
         3EIPH36Gr/Fn4yYyPsfb4eor7rjq/6fiEMAyfTd1Lzpc+CdPnaijzl1OSKtOVRoQAFmr
         f++9AyE/HF1E6xIGtiYcy8GIO2DAASX57DVxWtKLxvhb5Upl2z12u5He82nXZUuqHWDW
         fzzg==
X-Gm-Message-State: AOAM531R7KDmLbY3tr+6DP/CLjuLGr1HQedizERF5YLtMGskMs6TbDQU
        oVL3UX66EbYFoO6LMoTS4SNdWcFiminn8rMDS2UWyJAPN5gPO9hsvDKTpLtSyJd61999+aYUtNL
        0E9ksY+4qwXfsbqmvDQLYdyb9
X-Received: by 2002:a37:9bcf:: with SMTP id d198mr2701588qke.423.1589541342363;
        Fri, 15 May 2020 04:15:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6k0Wxp/fggTGTEhGVsnY3c8zWZpwXaG8sjFGKb5wDstAflNu6HHHSCA7aDXYrrL/lD2v3kw==
X-Received: by 2002:a37:9bcf:: with SMTP id d198mr2701562qke.423.1589541342093;
        Fri, 15 May 2020 04:15:42 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t12sm1303890qkt.77.2020.05.15.04.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 04:15:41 -0700 (PDT)
Date:   Fri, 15 May 2020 07:15:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH RFC 0/5] KVM: x86: KVM_MEM_ALLONES memory
Message-ID: <20200515111539.GA497380@xz-x1>
References: <20200514180540.52407-1-vkuznets@redhat.com>
 <20200514220516.GC449815@xz-x1>
 <20200514225623.GF15847@linux.intel.com>
 <CALCETrUf3qMgpYGfF=b6dt2gneodTv5eYGGwKZ=xDSYDa9aTVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrUf3qMgpYGfF=b6dt2gneodTv5eYGGwKZ=xDSYDa9aTVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 06:03:20PM -0700, Andy Lutomirski wrote:
> On Thu, May 14, 2020 at 3:56 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > On Thu, May 14, 2020 at 06:05:16PM -0400, Peter Xu wrote:
> > > On Thu, May 14, 2020 at 08:05:35PM +0200, Vitaly Kuznetsov wrote:
> > > > The idea of the patchset was suggested by Michael S. Tsirkin.
> > > >
> > > > PCIe config space can (depending on the configuration) be quite big but
> > > > usually is sparsely populated. Guest may scan it by accessing individual
> > > > device's page which, when device is missing, is supposed to have 'pci
> > > > holes' semantics: reads return '0xff' and writes get discarded. Currently,
> > > > userspace has to allocate real memory for these holes and fill them with
> > > > '0xff'. Moreover, different VMs usually require different memory.
> > > >
> > > > The idea behind the feature introduced by this patch is: let's have a
> > > > single read-only page filled with '0xff' in KVM and map it to all such
> > > > PCI holes in all VMs. This will free userspace of obligation to allocate
> > > > real memory and also allow us to speed up access to these holes as we
> > > > can aggressively map the whole slot upon first fault.
> > > >
> > > > RFC. I've only tested the feature with the selftest (PATCH5) on Intel/AMD
> > > > with and wiuthout EPT/NPT. I haven't tested memslot modifications yet.
> > > >
> > > > Patches are against kvm/next.
> > >
> > > Hi, Vitaly,
> > >
> > > Could this be done in userspace with existing techniques?
> > >
> > > E.g., shm_open() with a handle and fill one 0xff page, then remap it to
> > > anywhere needed in QEMU?
> >
> > Mapping that 4k page over and over is going to get expensive, e.g. each
> > duplicate will need a VMA and a memslot, plus any PTE overhead.  If the
> > total sum of the holes is >2mb it'll even overflow the mumber of allowed
> > memslots.
> 
> How about a tiny character device driver /dev/ones?

Yeah, this looks very clean.

Or I also like Sean's idea about using the slow path - I think the answer could
depend on a better knowledge on the problem to solve (PCI scan for small VM
boots) to firstly justify that the fast path is required.  E.g., could we even
workaround that inefficient reading of 0xff's for our use case?  After all what
the BIOS really needs is not those 0xff's, but some other facts.

Thanks!

-- 
Peter Xu

