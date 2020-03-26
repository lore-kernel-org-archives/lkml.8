Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A50C2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD5D20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ESl69Xjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgCZRLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:11:54 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:16207 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585242713; x=1616778713;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7dKViaTkqgkOuleKzCaJ8koVRSroLTuB4+O9Hh8aggM=;
  b=ESl69Xjo8HJb0mcrmO8q/uKsDwwFYjWckhJDaireykIMpyt7eTlp37qN
   78uEP7kgjVZAbI8fIMDZilKBeajLr9xgsEgTtw7ISRDSassWjjQOZwKKN
   brpTKJCSKiWOUruMvcq549sbK0nq22ZycvJK2bn7BYuf1aE2OGX0qWISu
   8=;
IronPort-SDR: VLVG9KdHa9SYDLOS5XHvQwlSi5CKx1/HQVCocDXLl0fRLLxFzUUQLhJik/SBPYR9NgJKGCXbkw
 vTgHetDIaOrA==
X-IronPort-AV: E=Sophos;i="5.72,309,1580774400"; 
   d="scan'208";a="23030054"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 26 Mar 2020 17:11:39 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 15434A2102;
        Thu, 26 Mar 2020 17:11:39 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Mar 2020 17:11:38 +0000
Received: from 38f9d3867b82.ant.amazon.com (10.43.162.39) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Mar 2020 17:11:34 +0000
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
To:     Christoph Hellwig <hch@lst.de>
CC:     <iommu@lists.linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <x86@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <dwmw@amazon.com>,
        <benh@amazon.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        <alcioa@amazon.com>, <aggh@amazon.com>, <aagch@amazon.com>,
        <dhr@amazon.com>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200326170516.GB6387@lst.de>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <cef4f2f5-3530-82f8-c0f5-ee0c2701ce6a@amazon.com>
Date:   Thu, 26 Mar 2020 18:11:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326170516.GB6387@lst.de>
Content-Language: en-US
X-Originating-IP: [10.43.162.39]
X-ClientProxiedBy: EX13D36UWA004.ant.amazon.com (10.43.160.175) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.03.20 18:05, Christoph Hellwig wrote:
> =

> On Thu, Mar 26, 2020 at 05:29:22PM +0100, Alexander Graf wrote:
>> The swiotlb is a very convenient fallback mechanism for bounce buffering=
 of
>> DMAable data. It is usually used for the compatibility case where devices
>> can only DMA to a "low region".
>>
>> However, in some scenarios this "low region" may be bound even more
>> heavily. For example, there are embedded system where only an SRAM region
>> is shared between device and CPU. There are also heterogeneous computing
>> scenarios where only a subset of RAM is cache coherent between the
>> components of the system. There are partitioning hypervisors, where
>> a "control VM" that implements device emulation has limited view into a
>> partition's memory for DMA capabilities due to safety concerns.
>>
>> This patch adds a command line driven mechanism to move all DMA memory i=
nto
>> a predefined shared memory region which may or may not be part of the
>> physical address layout of the Operating System.
>>
>> Ideally, the typical path to set this configuration would be through Dev=
ice
>> Tree or ACPI, but neither of the two mechanisms is standardized yet. Als=
o,
>> in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
>> instead configure the system purely through kernel command line options.
>>
>> I'm sure other people will find the functionality useful going forward
>> though and extend it to be triggered by DT/ACPI in the future.
> =

> I'm totally against hacking in a kernel parameter for this.  We'll need
> a proper documented DT or ACPI way.  =


I'm with you on that sentiment, but in the environment I'm currently =

looking at, we have neither DT nor ACPI: The kernel gets purely =

configured via kernel command line. For other unenumerable artifacts on =

the system, such as virtio-mmio platform devices, that works well enough =

and also basically "hacks a kernel parameter" to specify the system layout.

> We also need to feed this information
> into the actual DMA bounce buffering decisions and not just the swiotlb
> placement.

Care to elaborate a bit here? I was under the impression that =

"swiotlb=3Dforce" basically allows you to steer the DMA bounce buffering =

decisions already.


Thanks!

Alex



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



