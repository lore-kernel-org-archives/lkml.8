Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E067C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F98D20720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9Sv+v8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbgFWNis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732631AbgFWNir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:38:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B3C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:38:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i3so5854825qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hZmoB3j6DMmt6J2mPH0zlRMcgJD8yUGmY1ZGf6OliPo=;
        b=E9Sv+v8Id+h0X9CkTgDTZeQ/N1BAkcrMcXheSVFiYV0JhQBmxIbF99ZIbSJOTYD61I
         //f7BROxzrmu+mY9dpl9gy5E/9jYOUdgocHE8cQJiOMU0QuRNmc5YUstbOt0n7Hk1Qtt
         qc5sozHfWB3/8mzEJyjE2eK4AafdgIfgToy0T/Q35AKSa3RU4eDNr/hfY9+ZZkq+r2Lr
         BaBrFXygRrSWTyfhArnj/KY1HRjRK2NesrEUmCMy0LDam5VHC8SE4jBxr80HgCkbqmMV
         yRlGlLGfrIbYb76AOHGdcOPEKzuS0PZaIGlTPM6s0T34HYdU1WZopJvAiGXthDtUcevJ
         cPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hZmoB3j6DMmt6J2mPH0zlRMcgJD8yUGmY1ZGf6OliPo=;
        b=TYzAP4tA4kiVSPfSMLYH4Dt0BERyzk90o+ctzBAfsnpRbDlDzQ9tl7W+PdKEN9EPWM
         sEKGnTqi+kbIlrbHFpXgieKrFvMSrHbG1sTxd2l0WC0DxUPSVSqxJ1vDr9ymgH8fIXy+
         /dvGN3E/KOBrUHO5iyIUospCe+07vzQte+u/So5aYyfTHkiGNl54KAui66EqR1NVEBgu
         pmWI7bI/EvuXflRau58Vtku8UhpS6+fv/7jY7n8D2ZRictNUB6rjtqqND3WUUCWdqRa6
         I101lHIm4BA11l5b0RR2JAlebFGQWXnUxodhFIbABShEaClvNmmYlLID3gQhuru0cSOS
         cdKQ==
X-Gm-Message-State: AOAM531I4Z9NZjmQ6JYrn0CQpav65zIbH4i4YR1hC9nnxCJyMhL81O4Z
        O2GnptQ45Re7J+qUcmpXE6E=
X-Google-Smtp-Source: ABdhPJywdDQwzAmCJ4nVioSFtV7n1s6yuqNZ7h4NTBZRX4HyiV5jQz5+VspX89nnr1X/XxKFPabWcQ==
X-Received: by 2002:aed:2462:: with SMTP id s31mr22334051qtc.188.1592919526753;
        Tue, 23 Jun 2020 06:38:46 -0700 (PDT)
Received: from localhost.localdomain (209-6-208-110.s8556.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.208.110])
        by smtp.gmail.com with ESMTPSA id d2sm577625qti.62.2020.06.23.06.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 06:38:45 -0700 (PDT)
Date:   Tue, 23 Jun 2020 09:38:43 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200623133843.GA5499@localhost.localdomain>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
 <20200124230008.GA1565@ashkalra_ubuntu_server>
 <20200204193500.GA15564@ashkalra_ubuntu_server>
 <20200303170353.GC31627@char.us.oracle.com>
 <20200330222551.GA22743@ashkalra_ubuntu_server>
 <20200427185318.GA8253@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427185318.GA8253@ashkalra_ubuntu_server>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 06:53:18PM +0000, Ashish Kalra wrote:
> Hello Konrad,
> 
> On Mon, Mar 30, 2020 at 10:25:51PM +0000, Ashish Kalra wrote:
> > Hello Konrad,
> > 
> > On Tue, Mar 03, 2020 at 12:03:53PM -0500, Konrad Rzeszutek Wilk wrote:
> > > On Tue, Feb 04, 2020 at 07:35:00PM +0000, Ashish Kalra wrote:
> > > > Hello Konrad,
> > > > 
> > > > Looking fwd. to your feedback regarding support of other memory
> > > > encryption architectures such as Power, S390, etc.
> > > > 
> > > > Thanks,
> > > > Ashish
> > > > 
> > > > On Fri, Jan 24, 2020 at 11:00:08PM +0000, Ashish Kalra wrote:
> > > > > On Tue, Jan 21, 2020 at 03:54:03PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > > > 
> > > > > > > Additional memory calculations based on # of PCI devices and
> > > > > > > their memory ranges will make it more complicated with so
> > > > > > > many other permutations and combinations to explore, it is
> > > > > > > essential to keep this patch as simple as possible by 
> > > > > > > adjusting the bounce buffer size simply by determining it
> > > > > > > from the amount of provisioned guest memory.
> > > > > >> 
> > > > > >> Please rework the patch to:
> > > > > >> 
> > > > > >>  - Use a log solution instead of the multiplication.
> > > > > >>    Feel free to cap it at a sensible value.
> > > > > 
> > > > > Ok.
> > > > > 
> > > > > >> 
> > > > > >>  - Also the code depends on SWIOTLB calling in to the
> > > > > >>    adjust_swiotlb_default_size which looks wrong.
> > > > > >> 
> > > > > >>    You should not adjust io_tlb_nslabs from swiotlb_size_or_default.
> > > > > 
> > > > > >>    That function's purpose is to report a value.
> > > > > >> 
> > > > > >>  - Make io_tlb_nslabs be visible outside of the SWIOTLB code.
> > > > > >> 
> > > > > >>  - Can you utilize the IOMMU_INIT APIs and have your own detect which would
> > > > > >>    modify the io_tlb_nslabs (and set swiotbl=1?).
> > > > > 
> > > > > This seems to be a nice option, but then IOMMU_INIT APIs are
> > > > > x86-specific and this swiotlb buffer size adjustment is also needed
> > > > > for other memory encryption architectures like Power, S390, etc.
> > > 
> > > Oh dear. That I hadn't considered.
> > > > > 
> > > > > >> 
> > > > > >>    Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
> > > > > >>    perhaps add in this code ? Albeit it really should be in it's own
> > > > > >>    file, not in arch/x86/kernel/pci-swiotlb.c
> > > > > 
> > > > > Actually, we piggyback on pci_swiotlb_detect_override which sets
> > > > > swiotlb=1 as x86_64_start_kernel() and invocation of sme_early_init()
> > > > > forces swiotlb on, but again this is all x86 architecture specific.
> > > 
> > > Then it looks like the best bet is to do it from within swiotlb_init?
> > > We really can't do it from swiotlb_size_or_default - that function
> > > should just return a value and nothing else.
> > > 
> > 
> > Actually, we need to do it in swiotlb_size_or_default() as this gets called by
> > reserve_crashkernel_low() in arch/x86/kernel/setup.c and used to
> > reserve low crashkernel memory. If we adjust swiotlb size later in
> > swiotlb_init() which gets called later than reserve_crashkernel_low(),
> > then any swiotlb size changes/expansion will conflict/overlap with the
> > low memory reserved for crashkernel.
> > 
> and will also potentially cause SWIOTLB buffer allocation failures.
> 
> Do you have any feedback, comments on the above ?


The init boot chain looks like this:

initmem_init
	pci_iommu_alloc
		-> pci_swiotlb_detect_4gb
		-> swiotlb_init

reserve_crashkernel
	reserve_crashkernel_low
		-> swiotlb_size_or_default
		..


(rootfs code):
	pci_iommu_init
		-> a bunch of the other IOMMU late_init code gets called..
		->  pci_swiotlb_late_init 

I have to say I am lost to how your patch fixes "If we adjust swiolb
size later .. then any swiotlb size .. will overlap with the low memory
reserved for crashkernel"?

Or are you saying that 'reserve_crashkernel_low' is the _culprit_ and it
is the one changing the size? And hence it modifying the swiotlb size
will fix this problem? Aka _before_ all the other IOMMU get their hand
on it?

If so why not create an
IOMMU_INIT(crashkernel_adjust_swiotlb,pci_swiotlb_detect_override,
NULL, NULL);

And crashkernel_adjust_swiotlb would change the size of swiotlb buffer
if conditions are found to require it.

You also may want to put a #define DEBUG in arch/x86/kernel/pci-iommu_table.c
to check out whether the tree structure of IOMMU entries is correct.



But still I am lost - if say the AMD one does decide for unknown reason
to expand the SWIOTLB you are still stuck with the 'overlap with
the low memory reserved' or so.

Perhaps add a late_init that gets called as the last one to validate
this ? And maybe if the swiotlb gets turned off you also take proper
steps?

> As such i feel, this patch is complete otherwise and can be included as
> it is. 
> 
> Thanks,
> Ashish
