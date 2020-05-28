Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7800320888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ti+huU+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbgE1Lsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:48:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31076 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388470AbgE1Lsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590666510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnHQtkliN6rluxUd6WzwCffgmVvNtrEVoosP3+lcIzw=;
        b=Ti+huU+44GNfyOr+yKiSYlj1gMS8j8UO0XN4Vt3jY8RC0vlESjfRj7dN9zwuf3P3u7ulkE
        m1ac0B3JPvZ0UP8LwIlMK154M9tRQcWdpbKA2G8dFHcAWouEdatUTaaI7kuB3M341psLk+
        padcKmnMcrdVPVZ23hiJ0haKflpjinE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-hG7-F5FkNdCHgU06SfcwLQ-1; Thu, 28 May 2020 07:48:25 -0400
X-MC-Unique: hG7-F5FkNdCHgU06SfcwLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48208107ACF2;
        Thu, 28 May 2020 11:48:21 +0000 (UTC)
Received: from [10.36.113.56] (ovpn-113-56.ams2.redhat.com [10.36.113.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57FE87A8BA;
        Thu, 28 May 2020 11:48:15 +0000 (UTC)
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova
 address
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
 <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
 <CABe79T7WwD2AyWp2e5pAi8TO2r5=-v5gPb2Gjtf8EhHOn3dogQ@mail.gmail.com>
 <20200528072308.GA414784@myrica>
 <527f25a4-ca5a-10da-150f-0b4ea3839635@redhat.com>
 <20200528083851.GB414784@myrica>
 <0076d965-b180-fc44-103c-9bc9d73fe7f2@redhat.com>
 <25ad278ae9ed4833aeb7b625fcb89d88@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <9aeb1cd5-48de-f581-1212-5c7b95fd8338@redhat.com>
Date:   Thu, 28 May 2020 13:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <25ad278ae9ed4833aeb7b625fcb89d88@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/20 11:15 AM, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: 28 May 2020 09:54
>> To: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Cc: Will Deacon <will@kernel.org>; Joerg Roedel <joro@8bytes.org>;
>> iommu@lists.linux-foundation.org; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; Linux Kernel Mailing List
>> <linux-kernel@vger.kernel.org>; Alex Williamson
>> <alex.williamson@redhat.com>; Srinath Mannam
>> <srinath.mannam@broadcom.com>; BCM Kernel Feedback
>> <bcm-kernel-feedback-list@broadcom.com>; Robin Murphy
>> <robin.murphy@arm.com>; Linux ARM <linux-arm-kernel@lists.infradead.org>
>> Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi
>> iova address
>>
>> Hi,
>>
>> On 5/28/20 10:38 AM, Jean-Philippe Brucker wrote:
>>> [+ Shameer]
>>>
>>> On Thu, May 28, 2020 at 09:43:46AM +0200, Auger Eric wrote:
>>>> Hi,
>>>>
>>>> On 5/28/20 9:23 AM, Jean-Philippe Brucker wrote:
>>>>> On Thu, May 28, 2020 at 10:45:14AM +0530, Srinath Mannam wrote:
>>>>>> On Wed, May 27, 2020 at 11:00 PM Robin Murphy
>> <robin.murphy@arm.com> wrote:
>>>>>>>
>>>>>> Thanks Robin for your quick response.
>>>>>>> On 2020-05-27 17:03, Srinath Mannam wrote:
>>>>>>>> This patch gives the provision to change default value of MSI IOVA base
>>>>>>>> to platform's suitable IOVA using module parameter. The present
>>>>>>>> hardcoded MSI IOVA base may not be the accessible IOVA ranges of
>> platform.
>>>>>>>
>>>>>>> That in itself doesn't seem entirely unreasonable; IIRC the current
>>>>>>> address is just an arbitrary choice to fit nicely into Qemu's memory
>>>>>>> map, and there was always the possibility that it wouldn't suit
>> everything.
>>>>>>>
>>>>>>>> Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe
>> inaccessible
>>>>>>>> DMA address"), inaccessible IOVA address ranges parsed from
>> dma-ranges
>>>>>>>> property are reserved.
>>>>>
>>>>> I don't understand why we only reserve the PCIe windows for DMA
>> domains.
>>>>> Shouldn't VFIO also prevent userspace from mapping them?
>>>>
>>>> VFIO prevents userspace from DMA mapping iovas within reserved regions:
>>>> 9b77e5c79840  vfio/type1: check dma map request is within a valid iova
>> range
>>>
>>> Right but I was asking specifically about the IOVA reservation introduced
>>> by commit aadad097cd46. They are not registered as reserved regions within
>>> the IOMMU core, they are only taken into account by dma-iommu.c when
>>> creating a DMA domain. As VFIO uses UNMANAGED domains, it isn't aware
>> of
>>> those regions and they won't be seen by vfio_iommu_resv_exclude().
>>>
>>> It looks like the PCIe regions used to be common until cd2c9fcf5c66
>>> ("iommu/dma: Move PCI window region reservation back into dma specific
>>> path.") But I couldn't find the justification for this commit.
>>
>> Yes I noticed that as well when debugging the above mentioned case
>> before and after cd2c9fcf5c66. I do not remember about the rationale of
>> removing the DMA host brige windows from the resv regions. Did it break
>> a legacy case?
>>>
> 
> I think yes. And going through the ML discussions, this was done so because with the 
> " vfio/type1: Add support for valid iova list management" series you reported
> an issue with Seattle platform. See the full discussion here,
> 
> https://lore.kernel.org/patchwork/patch/889012/

Hey thank you for reminding me of the Seattle case :-) Now I also recall
that, if I am not wrong, this also caused some trouble on some x86
platforms as well, reported by Alex? Maybe we should still report PCI
host bridge windows in the reserved regions, if possible/feasible tag
them differently from other reserved regions and not reject any VFIO
DMA_MAP colliding with them?

Thanks

Eric
> 
> Cheers,
> Shameer
> 
>>> The thing is, if VFIO isn't aware of the reserved PCIe windows, then
>>> allowing VFIO or userspace to choose MSI_IOVA_BASE won't solve the
>> problem
>>> reported by Srinath, because they could well choose an IOVA within the
>>> PCIe window...
>> I agree with you
>>
>> Thanks
>>
>> Eric
>>>
>>> Thanks,
>>> Jean
>>>
>>>> but it does not prevent the SW MSI region chosen by the kernel from
>>>> colliding with other reserved regions (esp. PCIe host bridge windows).
>>>>
>>>>   If they were
>>>>> part of the common reserved regions then we could have VFIO choose a
>>>>> SW_MSI region among the remaining free space.
>>>> As Robin said this was the initial chosen approach
>>>> [PATCH 10/10] vfio: allow the user to register reserved iova range for
>>>> MSI mapping
>>>> https://patchwork.kernel.org/patch/8121641/
>>>>
>>>> Some additional background about why the static SW MSI region chosen by
>>>> the kernel was later chosen:
>>>> Summary of LPC guest MSI discussion in Santa Fe (was: Re: [RFC 0/8] KVM
>>>> PCIe/MSI passthrough on ARM/ARM64 (Alt II))
>>>>
>> https://lists.linuxfoundation.org/pipermail/iommu/2016-November/019060.ht
>> ml
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>>>
>>>>
>>>>  It would just need a
>>>>> different way of asking the IOMMU driver if a SW_MSI is needed, for
>>>>> example with a domain attribute.
>>>>>
>>>>> Thanks,
>>>>> Jean
>>>>>
>>>>>>>
>>>>>>> That, however, doesn't seem to fit here; iommu-dma maps MSI
>> doorbells
>>>>>>> dynamically, so they aren't affected by reserved regions any more than
>>>>>>> regular DMA pages are. In fact, it explicitly ignores the software MSI
>>>>>>> region, since as the comment says, it *is* the software that manages
>> those.
>>>>>> Yes you are right, we don't see any issues with kernel drivers(PCI EP)
>> because
>>>>>> MSI IOVA allocated dynamically by honouring reserved regions same as
>> DMA pages.
>>>>>>>
>>>>>>> The MSI_IOVA_BASE region exists for VFIO, precisely because in that
>> case
>>>>>>> the kernel *doesn't* control the address space, but still needs some way
>>>>>>> to steal a bit of it for MSIs that the guest doesn't necessarily know
>>>>>>> about, and give userspace a fighting chance of knowing what it's taken.
>>>>>>> I think at the time we discussed the idea of adding something to the
>>>>>>> VFIO uapi such that userspace could move this around if it wanted or
>>>>>>> needed to, but decided we could live without that initially. Perhaps now
>>>>>>> the time has come?
>>>>>> Yes, we see issues only with user-space drivers(DPDK) in which
>> MSI_IOVA_BASE
>>>>>> region is considered to map MSI registers. This patch helps us to fix the
>> issue.
>>>>>>
>>>>>> Thanks,
>>>>>> Srinath.
>>>>>>>
>>>>>>> Robin.
>>>>>>>
>>>>>>>> If any platform has the limitaion to access default MSI IOVA, then it can
>>>>>>>> be changed using "arm-smmu.msi_iova_base=0xa0000000" command
>> line argument.
>>>>>>>>
>>>>>>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>>>>>> ---
>>>>>>>>   drivers/iommu/arm-smmu.c | 5 ++++-
>>>>>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>>>>> index 4f1a350..5e59c9d 100644
>>>>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>>>>> @@ -72,6 +72,9 @@ static bool disable_bypass =
>>>>>>>>   module_param(disable_bypass, bool, S_IRUGO);
>>>>>>>>   MODULE_PARM_DESC(disable_bypass,
>>>>>>>>       "Disable bypass streams such that incoming transactions from
>> devices that are not attached to an iommu domain will report an abort back to
>> the device and will not be allowed to pass through the SMMU.");
>>>>>>>> +static unsigned long msi_iova_base = MSI_IOVA_BASE;
>>>>>>>> +module_param(msi_iova_base, ulong, S_IRUGO);
>>>>>>>> +MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
>>>>>>>>
>>>>>>>>   struct arm_smmu_s2cr {
>>>>>>>>       struct iommu_group              *group;
>>>>>>>> @@ -1566,7 +1569,7 @@ static void
>> arm_smmu_get_resv_regions(struct device *dev,
>>>>>>>>       struct iommu_resv_region *region;
>>>>>>>>       int prot = IOMMU_WRITE | IOMMU_NOEXEC |
>> IOMMU_MMIO;
>>>>>>>>
>>>>>>>> -     region = iommu_alloc_resv_region(MSI_IOVA_BASE,
>> MSI_IOVA_LENGTH,
>>>>>>>> +     region = iommu_alloc_resv_region(msi_iova_base,
>> MSI_IOVA_LENGTH,
>>>>>>>>                                        prot,
>> IOMMU_RESV_SW_MSI);
>>>>>>>>       if (!region)
>>>>>>>>               return;
>>>>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>
>>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

