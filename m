Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D81C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B08E20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgHNMym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:54:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:47986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgHNMym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:54:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF0B4B039;
        Fri, 14 Aug 2020 12:55:02 +0000 (UTC)
Subject: Re: [PATCH v4 2/2] xen: add helpers to allocate unpopulated memory
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, Wei Liu <wl@xen.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-3-roger.pau@citrix.com>
 <20200813073337.GA16160@infradead.org> <20200813075420.GC975@Air-de-Roger>
 <20200814072920.GA6126@infradead.org> <20200814095629.GJ975@Air-de-Roger>
 <a907ff4a-c887-7d02-1d45-140d7749afa4@suse.com>
 <20200814124724.GK975@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <fc10d3a5-fe79-335e-353a-1bf480af7c7c@suse.com>
Date:   Fri, 14 Aug 2020 14:54:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814124724.GK975@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.20 14:47, Roger Pau Monné wrote:
> On Fri, Aug 14, 2020 at 12:27:32PM +0200, Jürgen Groß wrote:
>> On 14.08.20 11:56, Roger Pau Monné wrote:
>>> On Fri, Aug 14, 2020 at 08:29:20AM +0100, Christoph Hellwig wrote:
>>>> On Thu, Aug 13, 2020 at 09:54:20AM +0200, Roger Pau Monn?? wrote:
>>>>> On Thu, Aug 13, 2020 at 08:33:37AM +0100, Christoph Hellwig wrote:
>>>>>> On Tue, Aug 11, 2020 at 11:44:47AM +0200, Roger Pau Monne wrote:
>>>>>>> If enabled (because ZONE_DEVICE is supported) the usage of the new
>>>>>>> functionality untangles Xen balloon and RAM hotplug from the usage of
>>>>>>> unpopulated physical memory ranges to map foreign pages, which is the
>>>>>>> correct thing to do in order to avoid mappings of foreign pages depend
>>>>>>> on memory hotplug.
>>>>>>
>>>>>> So please just select ZONE_DEVICE if this is so much better rather
>>>>>> than maintaining two variants.
>>>>>
>>>>> We still need to other variant for Arm at least, so both need to be
>>>>> maintained anyway, even if we force ZONE_DEVICE on x86.
>>>>
>>>> Well, it still really helps reproducability if you stick to one
>>>> implementation of x86.
>>>>
>>>> The alternative would be an explicit config option to opt into it,
>>>> but just getting a different implementation based on a random
>>>> kernel option is strange.
>>>
>>> Would adding something like the chunk below to the patch be OK?
>>>
>>> ---8<---
>>> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
>>> index 018020b91baa..5f321a1319e6 100644
>>> --- a/drivers/xen/Kconfig
>>> +++ b/drivers/xen/Kconfig
>>> @@ -328,7 +328,14 @@ config XEN_FRONT_PGDIR_SHBUF
>>>    	tristate
>>>    config XEN_UNPOPULATED_ALLOC
>>> -	bool
>>> -	default y if ZONE_DEVICE && !ARM && !ARM64
>>> +	bool "Use unpopulated memory ranges for guest mappings"
>>> +	depends on X86
>>> +	select ZONE_DEVICE
>>> +	default y
>>
>> I'd rather use "default XEN_BACKEND" here, as mappings of other guest's
>> memory is rarely used for non-backend guests.
> 
> There's also the privcmd and gnt devices which make heavy use of this,
> so I'm not sure only selecting by default on XEN_BACKEND is the best
> option.

I just want to avoid that kernels built for running as Xen guest, but
not as dom0, will be forced to select ZONE_DEVICE.

As privcmd is dom0-only, this is no problem.

In case you are worrying about gnt devices, I'd be fine to switch to

default XEN_BACKEND || XEN_GNTDEV


Juergen

