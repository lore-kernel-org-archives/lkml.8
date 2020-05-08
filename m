Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0350EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA14920746
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rz/6BM5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgEHGo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:44:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgEHGo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588920297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldgRmfrU61jak98QbW+ZRtHuHZaSuicPr557G5QWVUo=;
        b=Rz/6BM5o9Wn/WJ4WOgogGGeaUBae39WvJalA+rCCvU9VhtTl6joZ8nHU4tOiFWpytwZfRw
        Nz0+gRopweNAmJUTQxat7Vv6Ajs0ZJhfbf3pyQXNWGRisGafSU9018VvqO3g7AZwMdysvz
        fwlSvE7X0YjYZnhBiYARFWWSGvED0cA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-xbTrrzdBMpeHOn8_IOa8PA-1; Fri, 08 May 2020 02:44:55 -0400
X-MC-Unique: xbTrrzdBMpeHOn8_IOa8PA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C698D1B18BC6;
        Fri,  8 May 2020 06:44:53 +0000 (UTC)
Received: from [10.72.13.98] (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96B2810429AF;
        Fri,  8 May 2020 06:44:46 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] vfio-pci: Fault mmaps to enable vma tracking
To:     Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <158871569380.15589.16950418949340311053.stgit@gimli.home>
 <20200507214744.GP228260@xz-x1> <20200507160334.4c029518@x1.home>
 <20200507222223.GR228260@xz-x1> <20200507235633.GL26002@ziepe.ca>
 <20200508021656.GS228260@xz-x1>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0ee2fd04-d544-d03b-0a7c-90c22275aac9@redhat.com>
Date:   Fri, 8 May 2020 14:44:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508021656.GS228260@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/8 上午10:16, Peter Xu wrote:
> On Thu, May 07, 2020 at 08:56:33PM -0300, Jason Gunthorpe wrote:
>> On Thu, May 07, 2020 at 06:22:23PM -0400, Peter Xu wrote:
>>> On Thu, May 07, 2020 at 04:03:34PM -0600, Alex Williamson wrote:
>>>> On Thu, 7 May 2020 17:47:44 -0400
>>>> Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>>> Hi, Alex,
>>>>>
>>>>> On Tue, May 05, 2020 at 03:54:53PM -0600, Alex Williamson wrote:
>>>>>> +/*
>>>>>> + * Zap mmaps on open so that we can fault them in on access and therefore
>>>>>> + * our vma_list only tracks mappings accessed since last zap.
>>>>>> + */
>>>>>> +static void vfio_pci_mmap_open(struct vm_area_struct *vma)
>>>>>> +{
>>>>>> +	zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
>>>>> A pure question: is this only a safety-belt or it is required in some known
>>>>> scenarios?
>>>> It's not required.  I originally did this so that I'm not allocating a
>>>> vma_list entry in a path where I can't return error, but as Jason
>>>> suggested I could zap here only in the case that I do encounter that
>>>> allocation fault.  However I still like consolidating the vma_list
>>>> handling to the vm_ops .fault and .close callbacks and potentially we
>>>> reduce the zap latency by keeping the vma_list to actual users, which
>>>> we'll get to eventually anyway in the VM case as memory BARs are sized
>>>> and assigned addresses.
>>> Yes, I don't see much problem either on doing the vma_list maintainance only in
>>> .fault() and .close().  My understandingg is that the worst case is the perf
>>> critical applications (e.g. DPDK) could pre-fault these MMIO region easily
>>> during setup if they want.  My question was majorly about whether the vma
>>> should be guaranteed to have no mapping at all when .open() is called.  But I
>>> agree with you that it's always good to have that as safety-belt anyways.
>> If the VMA has a mapping then that specific VMA has to be in the
>> linked list.
>>
>> So if the zap is skipped then the you have to allocate something and
>> add to the linked list to track the VMA with mapping.
>>
>> It is not a 'safety belt'
> But shouldn't open() only be called when the VMA is created for a memory range?
> If so, does it also mean that the address range must have not been mapped yet?


Probably not, e.g when VMA is being split.

Thanks


>
> Thanks,
>

