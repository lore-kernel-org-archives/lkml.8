Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49153C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE37206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xkFQAUV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgBUPjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:39:47 -0500
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:15041
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728103AbgBUPjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:39:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abT6exM+v1u0+JJxWukobjMj7ussusuNimTh6AzxfLMZpRpKfLTbMzulDRqMIxavjGpk0YOQzpV4fURy4YPYlNXIT4A1uE1QqoChoGown0hh19jcwgpJJ3ysx3xsxxY+SvzQOi/n/WNPCF6hWQpQqFxf6awO6elpmn7pYhmtajwVTehiVn4pvj20DAD1kcfiYtLJCIzrhPR9U+nWGiMDwvQ2mb40aRFHKVslONM7QuiDpqPYBUb+Y6oW5m1WSKxGNuQpkDkRz0pGbnUuXqjk1vBbUoSvWFDqQZzqvtgYDvJAPvbP0jKfCQ4yXEDSA3tzA+BWkDFzixo2ILeIaRhf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAsCEjbkMd7SswwzVt6n1uk4Dl2nyauawTUDL/848lg=;
 b=HC70/Qw0tgh21BqoPGl5uTz7ZzsncqGeG0a9zTRKbKXbw/Ug57WEapsQPUtDooKBWWmHiSOZZntjg61WobMznHdLhPDFFB19FEyjvOCui9Y9n1if0eBhSa3jmlHzbdPPlqHQUMDue3o6H1Xh0adrXzYNM+v3iL40ygpN0ZDm9XxsxcwOAhWKIogVbftG/pI+EDG7iZowggiakJqce2hmnvsJp2ABBrYbuVt9xg+B4ce/RgQVcXNcbE1383GMCFJadthvNfw1UcuMZo1CDHOWKQWSbopORju5pZYqGfk63HXd4P+vwYMTHTj0x9vbZvl4gqYU17KcCH6E1RNhcC6vTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAsCEjbkMd7SswwzVt6n1uk4Dl2nyauawTUDL/848lg=;
 b=xkFQAUV/iGZVeWU3LnplCc+FeLJJQxEhjwPWPBVZ+SZVEr1Qam/sL7dh2bh6b2YLTw8dZqL/CIuDej+cXesudJcsi21bo6it6pYQ61GTCpmOGXy3r+JxEFWkU9XhzMmBaazUE4nJJx71pezKJKO6RdZjS7KwbOYtibPpIE1qS60=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.71.154) by
 DM6PR12MB3003.namprd12.prod.outlook.com (20.178.198.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 21 Feb 2020 15:39:41 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 15:39:41 +0000
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
To:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Michael Mueller <mimu@linux.ibm.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Huang, Wei" <wei.huang2@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220154904-mutt-send-email-mst@kernel.org>
 <20200221141230.13eebc35.pasic@linux.ibm.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <bf0c87a2-adc6-a05a-835f-f98e7cd0cd3b@amd.com>
Date:   Fri, 21 Feb 2020 09:39:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200221141230.13eebc35.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:5:14c::20) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
Received: from [10.236.30.74] (165.204.77.1) by DM6PR11CA0043.namprd11.prod.outlook.com (2603:10b6:5:14c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 15:39:39 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c11eca75-43d6-4527-f6de-08d7b6e44433
X-MS-TrafficTypeDiagnostic: DM6PR12MB3003:|DM6PR12MB3003:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3003CDE23F9F15E3131CAC28EC120@DM6PR12MB3003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(189003)(199004)(31686004)(66476007)(2616005)(26005)(4326008)(66946007)(7416002)(6486002)(956004)(16526019)(186003)(53546011)(81166006)(110136005)(81156014)(2906002)(52116002)(316002)(66556008)(8676002)(8936002)(54906003)(478600001)(36756003)(31696002)(86362001)(5660300002)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3003;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eypPsZtXAq1/aKm+laE1A2QPN+g5DT0u+b4tkBVQdH8GLsf8j4YFtapXhFk5CO+d8wVyd11+yZH0ggklm6oJ1JE7fDTjT9mbMzHI00rruL1CIAfm9jy0L9JRuxqkt+tKHMsszHcMQZEa6A2gk/9oDOZONYYxQw3An2c4rdVf8FQGLy9fFr3Yj2H9iiSQ5YeNCoqIITJCwzKdJ5Rjb1MIct2byKvlzVQu+s519giHsLXwHW88rtGS9yARUGIifyCFRKgG8gUPGU4JemIQwIpuVEYHLIOJrTrMFvKb/l45Lbuo13CDbaHEelpYQnWWZgL/wXHHDIcu+YbONgoP88m4CE1iCa1E/g4FMxxGfSt7GDO6Tag+cZ5kaX/9+AkXvZTnpxVBMqv101iu1j/m4f6zlvZKdm7BHM3Ugg0uWexPDxYUjewgAeMBO+lRGk2WwyXY
X-MS-Exchange-AntiSpam-MessageData: zeUSTSynyH3Z332Mw3nmW9pDfrUfHSsWU8dm+8+bxWT70w3RXAILc5hS2jL0ajYvACw+EkVVs6bpJ5oH63n95rb6TmiGDl02Ug0NyIXyvkVHzNhzpEUBVd//tN6kCPAi9Yq/amXsRsFryDwh+L9rHA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11eca75-43d6-4527-f6de-08d7b6e44433
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 15:39:41.2337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPtE2ywCzAM6WL5bUwRlZEIq6d6ANi0HnIg+rZqGJ/4Rz1Vq9Nu9NbKETlKhuOD1+I2TfGkZD7OgMGNlegwGvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 7:12 AM, Halil Pasic wrote:
> On Thu, 20 Feb 2020 15:55:14 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
>>> Currently the advanced guest memory protection technologies (AMD SEV,
>>> powerpc secure guest technology and s390 Protected VMs) abuse the
>>> VIRTIO_F_IOMMU_PLATFORM flag to make virtio core use the DMA API, which
>>> is in turn necessary, to make IO work with guest memory protection.
>>>
>>> But VIRTIO_F_IOMMU_PLATFORM a.k.a. VIRTIO_F_ACCESS_PLATFORM is really a
>>> different beast: with virtio devices whose implementation runs on an SMP
>>> CPU we are still fine with doing all the usual optimizations, it is just
>>> that we need to make sure that the memory protection mechanism does not
>>> get in the way. The VIRTIO_F_ACCESS_PLATFORM mandates more work on the
>>> side of the guest (and possibly he host side as well) than we actually
>>> need.
>>>
>>> An additional benefit of teaching the guest to make the right decision
>>> (and use DMA API) on it's own is: removing the need, to mandate special
>>> VM configuration for guests that may run with protection. This is
>>> especially interesting for s390 as VIRTIO_F_IOMMU_PLATFORM pushes all
>>> the virtio control structures into the first 2G of guest memory:
>>> something we don't necessarily want to do per-default.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>> Tested-by: Ram Pai <linuxram@us.ibm.com>
>>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>>
>> This might work for you but it's fragile, since without
>> VIRTIO_F_ACCESS_PLATFORM hypervisor assumes it gets
>> GPA's, not DMA addresses.
>>
> 
> Thanks for your constructive approach. I do want the hypervisor to
> assume it gets GPA's. My train of thought was that the guys that need
> to use IOVA's that are not GPA's when force_dma_unencrypted() will have
> to to specify VIRTIO_F_ACCESS_PLATFORM (at the device) anyway, because
> otherwise it won't work. But I see your point: in case of a
> mis-configuration and provided the DMA API returns IOVA's one could end
> up trying to touch wrong memory locations. But this should be similar to
> what would happen if DMA ops are not used, and memory is not made accessible.
> 
>>
>>
>> IOW this looks like another iteration of:
>>
>> 	virtio: Support encrypted memory on powerpc secure guests
>>
>> which I was under the impression was abandoned as unnecessary.
> 
> Unnecessary for powerpc because they do normal PCI. In the context of
> CCW there are only guest physical addresses (CCW I/O has no concept of
> IOMMU or IOVAs).
> 
>>
>>
>> To summarize, the necessary conditions for a hack along these lines
>> (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:
>>
>>   - secure guest mode is enabled - so we know that since we don't share
>>     most memory regular virtio code won't
>>     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM
> 
> force_dma_unencrypted(&vdev->dev) is IMHO exactly about this.
> 
>>   - DMA API is giving us addresses that are actually also physical
>>     addresses
> 
> In case of s390 this is given. I talked with the power people before
> posting this, and they ensured me they can are willing to deal with
> this. I was hoping to talk abut this with the AMD SEV people here (hence
> the cc).

Yes, physical addresses are fine for SEV - the key is that the DMA API is
used so that an address for unencrypted, or shared, memory is returned.
E.g. for a dma_alloc_coherent() call this is an allocation that has had
set_memory_decrypted() called or for a dma_map_page() call this is an
address from SWIOTLB, which was mapped shared during boot, where the data
will be bounce-buffered.

We don't currently support an emulated IOMMU in our SEV guest because that
would require a lot of support in the driver to make IOMMU data available
to the hypervisor (I/O page tables, etc.). We would need hardware support
to really make this work easily in the guest.

Thanks,
Tom

> 
>>   - Hypervisor is buggy and didn't enable VIRTIO_F_ACCESS_PLATFORM
>>
> 
> I don't get this point. The argument where the hypervisor is buggy is a
> bit hard to follow for me. If hypervisor is buggy we have already lost
> anyway most of the time, or?
>  
>> I don't see how this patch does this.
> 
> I do get your point. I don't know of a good way to check that DMA API
> is giving us addresses that are actually physical addresses, and the
> situation you describe definitely has some risk to it.
> 
> Let me comment on other ideas that came up. I would be very happy to go
> with the best one. Thank you very much.
> 
> Regards,
> Halil
> 
>>
>>
>>> ---
>>>  drivers/virtio/virtio_ring.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index 867c7ebd3f10..fafc8f924955 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>>>  	if (!virtio_has_iommu_quirk(vdev))
>>>  		return true;
>>>  
>>> +	if (force_dma_unencrypted(&vdev->dev))
>>> +		return true;
>>> +
>>>  	/* Otherwise, we are left to guess. */
>>>  	/*
>>>  	 * In theory, it's possible to have a buggy QEMU-supposed
>>> -- 
>>> 2.17.1
>>
> 
