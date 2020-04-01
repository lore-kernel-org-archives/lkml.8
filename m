Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211E1C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27CD20787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHbUf6mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgDAHcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:32:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731861AbgDAHcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585726371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=er5PhZKmj1VjxisaWzK7w2rQSjkemW6KF003piclXVY=;
        b=XHbUf6mwQwPfGY3QA55NlH4Xo/fBgHcWDBFhOXEhv5s/5/S76Tlpne4h8h6TNXrzcXnKZy
        5sVA9/MajfwLNGUNxSdu23HvplAGGawo7Iu0cFYrfRifAoBP5Wrq6bAHDzqPboPc7l/MMR
        SjWLKevsD7KkcEdML3FO1IiBCwZzYog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-wzVRvjV2M9etq3cxccPC5g-1; Wed, 01 Apr 2020 03:32:47 -0400
X-MC-Unique: wzVRvjV2M9etq3cxccPC5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BA841007269;
        Wed,  1 Apr 2020 07:32:45 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33AB85D9CA;
        Wed,  1 Apr 2020 07:32:39 +0000 (UTC)
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
 <3215b83c-81f7-a30f-fe82-a51f29d7b874@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D800D67@SHSMSX104.ccr.corp.intel.com>
 <20200331135807.4e9976ab@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803C33@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21D52E@SHSMSX104.ccr.corp.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <d1cd2852-876a-b072-8576-962a6e61b9a9@redhat.com>
Date:   Wed, 1 Apr 2020 09:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A21D52E@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/1/20 9:13 AM, Liu, Yi L wrote:
>> From: Tian, Kevin <kevin.tian@intel.com>
>> Sent: Wednesday, April 1, 2020 2:30 PM
>> To: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Subject: RE: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate func=
tion
>>
>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Sent: Wednesday, April 1, 2020 4:58 AM
>>>
>>> On Tue, 31 Mar 2020 02:49:21 +0000
>>> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>>>
>>>>> From: Auger Eric <eric.auger@redhat.com>
>>>>> Sent: Sunday, March 29, 2020 11:34 PM
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 3/28/20 11:01 AM, Tian, Kevin wrote:
>>>>>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>>>>> Sent: Saturday, March 21, 2020 7:28 AM
>>>>>>>
>>>>>>> When Shared Virtual Address (SVA) is enabled for a guest OS via
>>>>>>> vIOMMU, we need to provide invalidation support at IOMMU API
>>>>>>> and
>>>>> driver
>>>>>>> level. This patch adds Intel VT-d specific function to
>>>>>>> implement iommu passdown invalidate API for shared virtual addres=
s.
>>>>>>>
>>>>>>> The use case is for supporting caching structure invalidation
>>>>>>> of assigned SVM capable devices. Emulated IOMMU exposes queue
>>>>  [...]
>>>>  [...]
>>>>> to
>>>>>>> + * VT-d granularity. Invalidation is typically included in the
>>>>>>> unmap
>>>>> operation
>>>>>>> + * as a result of DMA or VFIO unmap. However, for assigned
>>>>>>> devices
>>>>> guest
>>>>>>> + * owns the first level page tables. Invalidations of
>>>>>>> translation caches in
>>>>> the
>>>>  [...]
>>>>  [...]
>>>>  [...]
>>>>>
>>> inv_type_granu_map[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_
>>>>>>> NR] =3D {
>>>>>>> +	/*
>>>>>>> +	 * PASID based IOTLB invalidation: PASID selective (per
>>>>>>> PASID),
>>>>>>> +	 * page selective (address granularity)
>>>>>>> +	 */
>>>>>>> +	{0, 1, 1},
>>>>>>> +	/* PASID based dev TLBs, only support all PASIDs or
>>>>>>> single PASID */
>>>>>>> +	{1, 1, 0},
>>>>>>
>>>>>> Is this combination correct? when single PASID is being
>>>>>> specified, it is essentially a page-selective invalidation since
>>>>>> you need provide Address and Size.
>>>>> Isn't it the same when G=3D1? Still the addr/size is used. Doesn't
>>>>> it
>>>>
>>>> I thought addr/size is not used when G=3D1, but it might be wrong. I=
'm
>>>> checking with our vt-d spec owner.
>>>>
>>>
>>>>> correspond to IOMMU_INV_GRANU_ADDR with
>> IOMMU_INV_ADDR_FLAGS_PASID
>>>>> flag unset?
>>>>>
>>>>> so {0, 0, 1}?
>>>>
>>> I am not sure I got your logic. The three fields correspond to
>>> 	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective
>>> invalidation */
>>> 	IOMMU_INV_GRANU_PASID,	/* PASID-selective invalidation */
>>> 	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation *
>>>
>>> For devTLB, we use domain as global since there is no domain. Then I
>>> came up with {1, 1, 0}, which means we could have global and pasid
>>> granu invalidation for PASID based devTLB.
>>>
>>> If the caller also provide addr and S bit, the flush routine will put
>>
>> "also" -> "must", because vt-d requires addr/size must be provided in
>> devtlb
>> descriptor, that is why Eric suggests {0, 0, 1}.
>=20
> I think it should be {0, 0, 1} :-) addr field and S field are must, pas=
id
> field depends on G bit.

On my side, I understood from the spec that addr/S are always used
whatever the granularity, hence the above suggestion.

As a comparison, for PASID based IOTLB invalidation, it is clearly
stated that if G matches PASID selective invalidation, address field is
ignored. This is not written that way for PASID-based device TLB inv.
>=20
> I didn=E2=80=99t read through all comments. Here is a concern with this=
 2-D table,
> the iommu cache type is defined as below. I suppose there is a problem =
here.
> If I'm using IOMMU_CACHE_INV_TYPE_PASID, it will beyond the 2-D table.
>=20
> /* IOMMU paging structure cache */
> #define IOMMU_CACHE_INV_TYPE_IOTLB      (1 << 0) /* IOMMU IOTLB */
> #define IOMMU_CACHE_INV_TYPE_DEV_IOTLB  (1 << 1) /* Device IOTLB */
> #define IOMMU_CACHE_INV_TYPE_PASID      (1 << 2) /* PASID cache */
> #define IOMMU_CACHE_INV_TYPE_NR         (3)
oups indeed

Thanks

Eric
>=20
>>>
>>>> I have one more open:
>>>>
>>>> How does userspace know which invalidation type/gran is supported?
>>>> I didn't see such capability reporting in Yi's VFIO vSVA patch set.
>>>> Do we want the user/kernel assume the same capability set if they
>>>> are architectural? However the kernel could also do some
>>>> optimization e.g. hide devtlb invalidation capability given that the
>>>> kernel already invalidate devtlb automatically when serving iotlb
>>>> invalidation...
>>>>
>>> In general, we are trending to use VFIO capability chain to expose
>>> iommu capabilities.
>>>
>>> But for architectural features such as type/granu, we have to assume
>>> the same capability between host & guest. Granu and types are not
>>> enumerated on the host IOMMU either.
>>>
>>> For devTLB optimization, I agree we need to expose a capability to th=
e
>>> guest stating that implicit devtlb invalidation is supported.
>>> Otherwise, if Linux guest runs on other OSes may not support implicit
>>> devtlb invalidation.
>>>
>>> Right Yi?
>>
>> Thanks for explanation. So we are assumed to support all operations
>> defined in spec, so no need to expose them one-by-one. For optimizatio=
n,
>> I'm fine to do it later.
>=20
> yes. :-)
>=20
> Regards,
> Yi Liu
>=20

