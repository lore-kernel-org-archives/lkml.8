Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFBBC433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FCD207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgGWNxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:53:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbgGWNxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:53:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66E13AB3D;
        Thu, 23 Jul 2020 13:53:18 +0000 (UTC)
Subject: Re: [PATCH 3/3] memory: introduce an option to force onlining of
 hotplug memory
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org
References: <20200723084523.42109-1-roger.pau@citrix.com>
 <20200723084523.42109-4-roger.pau@citrix.com>
 <21490d49-b2cf-a398-0609-8010bdb0b004@redhat.com>
 <20200723122300.GD7191@Air-de-Roger>
 <e94d9556-f615-bbe2-07d2-08958969ee5f@redhat.com>
 <429c2889-93c2-23b3-ba1e-da56e3a76ba4@redhat.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <de0b17e6-6cb1-211b-bc40-e34f4e1b30d0@suse.com>
Date:   Thu, 23 Jul 2020 15:53:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <429c2889-93c2-23b3-ba1e-da56e3a76ba4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.20 15:47, David Hildenbrand wrote:
> On 23.07.20 15:22, David Hildenbrand wrote:
>> On 23.07.20 14:23, Roger Pau Monné wrote:
>>> On Thu, Jul 23, 2020 at 01:37:03PM +0200, David Hildenbrand wrote:
>>>> On 23.07.20 10:45, Roger Pau Monne wrote:
>>>>> Add an extra option to add_memory_resource that overrides the memory
>>>>> hotplug online behavior in order to force onlining of memory from
>>>>> add_memory_resource unconditionally.
>>>>>
>>>>> This is required for the Xen balloon driver, that must run the
>>>>> online page callback in order to correctly process the newly added
>>>>> memory region, note this is an unpopulated region that is used by Linux
>>>>> to either hotplug RAM or to map foreign pages from other domains, and
>>>>> hence memory hotplug when running on Xen can be used even without the
>>>>> user explicitly requesting it, as part of the normal operations of the
>>>>> OS when attempting to map memory from a different domain.
>>>>>
>>>>> Setting a different default value of memhp_default_online_type when
>>>>> attaching the balloon driver is not a robust solution, as the user (or
>>>>> distro init scripts) could still change it and thus break the Xen
>>>>> balloon driver.
>>>>
>>>> I think we discussed this a couple of times before (even triggered by my
>>>> request), and this is responsibility of user space to configure. Usually
>>>> distros have udev rules to online memory automatically. Especially, user
>>>> space should eb able to configure *how* to online memory.
>>>
>>> Note (as per the commit message) that in the specific case I'm
>>> referring to the memory hotplugged by the Xen balloon driver will be
>>> an unpopulated range to be used internally by certain Xen subsystems,
>>> like the xen-blkback or the privcmd drivers. The addition of such
>>> blocks of (unpopulated) memory can happen without the user explicitly
>>> requesting it, and hence not even aware such hotplug process is taking
>>> place. To be clear: no actual RAM will be added to the system.
>>
>> Okay, but there is also the case where XEN will actually hotplug memory
>> using this same handler IIRC (at least I've read papers about it). Both
>> are using the same handler, correct?
>>
>>>
>>>> It's the admin/distro responsibility to configure this properly. In case
>>>> this doesn't happen (or as you say, users change it), bad luck.
>>>>
>>>> E.g., virtio-mem takes care to not add more memory in case it is not
>>>> getting onlined. I remember hyper-v has similar code to at least wait a
>>>> bit for memory to get onlined.
>>>
>>> I don't think VirtIO or Hyper-V use the hotplug system in the same way
>>> as Xen, as said this is done to add unpopulated memory regions that
>>> will be used to map foreign memory (from other domains) by Xen drivers
>>> on the system.
>>
>> Indeed, if the memory is never exposed to the buddy (and all you need is
>> struct pages +  a kernel virtual mapping), I wonder if
>> memremap/ZONE_DEVICE is what you want? Then you won't have user-visible
>> memory blocks created with unclear online semantics, partially involving
>> the buddy.
> 
> And just a note that there is also DCSS on s390x / z/VM which allows to
> map segments into the VM physical address space (e.g., you can share
> segments between VMs). They don't need any memmap (struct page) for that
> memory, though. All they do is create the identity mapping in the kernel
> virtual address space manually. Not sure what the exact requirements on
> the XEN side are. I assume you need a memmap for this memory.

We need to be able to do I/O with that memory via normal drivers and we
need to be able to map it, both from user land and from the kernel.


Juergen
