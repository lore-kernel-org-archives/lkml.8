Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DDBC47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA2E207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IU2tYRbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgD3Teh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:34:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32574 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD3Teh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588275275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sS8AddF4WlY4FM3AJEU8Vr5dd3INR3Y9YVDuw7T/d9Y=;
        b=IU2tYRbNEfNUOosyw3wmdSPJNp9EGIZRB2Iia4/DOVky3fV5TRPCa4Fs0yKvp5Yc2fr1tr
        z7uGBQJTlt01Wjq0W3wjPRKm2l7c0GlHDLbiAHSarrxehz2rCKOwxysa4AkRyPjpkpqX0a
        O9s016Er//LY18DwOH/bQonEAUNdfYw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-XhESpHWKOR293DbGNB32bQ-1; Thu, 30 Apr 2020 15:34:29 -0400
X-MC-Unique: XhESpHWKOR293DbGNB32bQ-1
Received: by mail-wr1-f72.google.com with SMTP id d17so4362961wrr.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sS8AddF4WlY4FM3AJEU8Vr5dd3INR3Y9YVDuw7T/d9Y=;
        b=h8djAeANTT1KDO1k6HjkGvprKFegn9P5yadSlo0VcZczKYXzQr/PsP1CaI2tsUsAjp
         KnL7697FtVRCqOPXXVJOu8K6Mj4GTWe0tSVwZmEWX7MOFjG38RsfXWtM4Fe0Uuv5ohO6
         1LQY2tqVZfo/JrsHQqUjnNRmMFFdo/VTCUWlV7N1MOPpQJnLAZErhIIX/jEJ4qvqdRZH
         RIjqW/slgh4Ukjs27xT4oEsD9paAxOVqVxmoPbNRZpZG8wGbBOQ80MSIUe5T4x64BpyZ
         QGjYSkkmJswg+/SUhDBzfA2abbJN52l6KSxYd1LsmjKSI6ToHyBCAIdyI1/sAiElls7B
         BLvA==
X-Gm-Message-State: AGi0PuZBnu5NbrpXVPUfRzbSDNSUWtYmVV7JhoSzLpZowP2Aq2E8Zo2t
        2Gg9oWJgpSHq1HDijN0DDPImchCeCQsGolV71y50/h2ZqBZKe06FQ8M5B0YS8nfvqQTI9TBhdoA
        9kS32VYqWwzvLXNq2/gk2Cq1J
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr147540wmh.47.1588275268396;
        Thu, 30 Apr 2020 12:34:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIErEi2OKs7eqnsETBaKuMVCIu+8B3dc0io3m7kIhj79uNOeJtHgco9xaP2TdUr4Pnz00osWA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr147527wmh.47.1588275268199;
        Thu, 30 Apr 2020 12:34:28 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id n6sm831929wmc.28.2020.04.30.12.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:34:27 -0700 (PDT)
Date:   Thu, 30 Apr 2020 15:34:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, Will Deacon <will@kernel.org>,
        konrad.wilk@oracle.com, jasowang@redhat.com,
        stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430152808-mutt-send-email-mst@kernel.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
 <20200430104149.GG19932@willie-the-truck>
 <20200430111156.GI5097@quicinc.com>
 <7bf8bffe-267b-6c66-86c9-40017d3ca4c2@siemens.com>
 <20200430133321.GC3204@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430133321.GC3204@quicinc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 07:03:21PM +0530, Srivatsa Vaddagiri wrote:
> * Jan Kiszka <jan.kiszka@siemens.com> [2020-04-30 14:59:50]:
> 
> > >I believe ivshmem2_virtio requires hypervisor to support PCI device emulation
> > >(for life-cycle management of VMs), which our hypervisor may not support.

PCI is mostly just 2 registers. One sets the affected device, one the data to read/write.

> A
> > >simple shared memory and doorbell or message-queue based transport will work for
> > >us.
> > 
> > As written in our private conversation, a mapping of the ivshmem2 device
> > discovery to platform mechanism (device tree etc.) and maybe even the
> > register access for doorbell and life-cycle management to something
> > hypercall-like would be imaginable. What would count more from virtio
> > perspective is a common mapping on a shared memory transport.
> 
> Yes that sounds simpler for us.
> 
> > That said, I also warned about all the features that PCI already defined
> > (such as message-based interrupts) which you may have to add when going a
> > different way for the shared memory device.
> 
> Is it really required to present this shared memory as belonging to a PCI
> device?

But then you will go on and add MSI, and NUMA, and security, and and and ...

> I would expect the device-tree to indicate the presence of this shared
> memory region, which we should be able to present to ivshmem2 as shared memory
> region to use (along with some handles for doorbell or message queue use).
> 
> I understand the usefulness of modeling the shared memory as part of device so
> that hypervisor can send events related to peers going down or coming up. In our
> case, there will be other means to discover those events and avoiding this
> requirement on hypervisor (to emulate PCI) will simplify the solution for us.
> 
> Any idea when we can expect virtio over ivshmem2 to become available?!

Check out the virtio spec. Right at the beginning it states:

	These devices are
	found in virtual environments, yet by design they look like physical devices to the guest within
	the virtual machine - and this document treats them as such. This similarity allows the guest to
	use standard drivers and discovery mechanisms


> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

