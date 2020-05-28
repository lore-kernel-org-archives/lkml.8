Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C70BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CCD207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgZbRJWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgE1HWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:22:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50753 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgE1HV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590650517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEBM0q4fZKyfjw7D1kyoHM1xb9sriIyKbIiYsNtDAYk=;
        b=KgZbRJWmJOOTW8jTKbf6lqP3lTKEobDoLRc0+EYDE1JF68OXGYG+IJ3XSkcU9g+E6LgMZa
        4fvIqfuXB4+VPbYcA4Jha+Kw/vqc8rf9V6TBhyRPzmrXM8PUWA2DtsfNDztmNYXaRLpr5J
        ygg6nwLbYlAXcVNL2RcwlzvtwtaYATg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-coeiy8M4OwqtVw4hX2GvfQ-1; Thu, 28 May 2020 03:21:55 -0400
X-MC-Unique: coeiy8M4OwqtVw4hX2GvfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCF0C107ACCD;
        Thu, 28 May 2020 07:21:53 +0000 (UTC)
Received: from [10.36.113.56] (ovpn-113-56.ams2.redhat.com [10.36.113.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8AA410013DB;
        Thu, 28 May 2020 07:21:48 +0000 (UTC)
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova
 address
To:     Robin Murphy <robin.murphy@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
 <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <8de9d9dd-16f9-482b-0ecf-f2f103ede86b@redhat.com>
Date:   Thu, 28 May 2020 09:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/27/20 7:30 PM, Robin Murphy wrote:
> On 2020-05-27 17:03, Srinath Mannam wrote:
>> This patch gives the provision to change default value of MSI IOVA base
>> to platform's suitable IOVA using module parameter. The present
>> hardcoded MSI IOVA base may not be the accessible IOVA ranges of
>> platform.
> 
> That in itself doesn't seem entirely unreasonable; IIRC the current
> address is just an arbitrary choice to fit nicely into Qemu's memory
> map,
correct
 and there was always the possibility that it wouldn't suit everything.

Indeed I also recently had this case of PCI host bridge collision with
the SW MSI reserved window - maybe that's the same ;-) -.
> 
>> Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible
>> DMA address"), inaccessible IOVA address ranges parsed from dma-ranges
>> property are reserved.
> 
> That, however, doesn't seem to fit here; iommu-dma maps MSI doorbells
> dynamically, so they aren't affected by reserved regions any more than
> regular DMA pages are. In fact, it explicitly ignores the software MSI
> region, since as the comment says, it *is* the software that manages those.
> 
> The MSI_IOVA_BASE region exists for VFIO, precisely because in that case
> the kernel *doesn't* control the address space, but still needs some way
> to steal a bit of it for MSIs that the guest doesn't necessarily know
> about, and give userspace a fighting chance of knowing what it's taken.
> I think at the time we discussed the idea of adding something to the
> VFIO uapi such that userspace could move this around if it wanted or
> needed to, but decided we could live without that initially.

Yes indeed ;-)

 Perhaps now
> the time has come?

Do you mean you would welcome a VFIO based approach or would a driver
parameter be sufficient?

Thanks

Eric


> 
> Robin.
> 
>> If any platform has the limitaion to access default MSI IOVA, then it can
>> be changed using "arm-smmu.msi_iova_base=0xa0000000" command line
>> argument.
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> ---
>>   drivers/iommu/arm-smmu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 4f1a350..5e59c9d 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -72,6 +72,9 @@ static bool disable_bypass =
>>   module_param(disable_bypass, bool, S_IRUGO);
>>   MODULE_PARM_DESC(disable_bypass,
>>       "Disable bypass streams such that incoming transactions from
>> devices that are not attached to an iommu domain will report an abort
>> back to the device and will not be allowed to pass through the SMMU.");
>> +static unsigned long msi_iova_base = MSI_IOVA_BASE;
>> +module_param(msi_iova_base, ulong, S_IRUGO);
>> +MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
>>     struct arm_smmu_s2cr {
>>       struct iommu_group        *group;
>> @@ -1566,7 +1569,7 @@ static void arm_smmu_get_resv_regions(struct
>> device *dev,
>>       struct iommu_resv_region *region;
>>       int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>>   -    region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
>> +    region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
>>                        prot, IOMMU_RESV_SW_MSI);
>>       if (!region)
>>           return;
>>
> 

