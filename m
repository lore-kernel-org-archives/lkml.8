Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625F7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185D22070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/dKUbQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbgAXQcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:32:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47040 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730705AbgAXQcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579883518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ekuXRJ86wPqyakHxIiDbjjojQWI5mCri1FZoTPYQHF8=;
        b=P/dKUbQ3QV22f+K7BtDutbRxIal4azP1tXesI89dHgn3uoPyVBeZF588rXxHNmqpSxbRE1
        9tAdxNUf+sH+NdkYzGolcCdkkDOKKpqgy6VI0DnMFWVuBcUobckbU9yAlx5qowISL5BJXE
        7C3Mbc6yGCz0jFIs4hDaQqP5QfcCi9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-8ebv1ziMOh2UuhfBNkH2zA-1; Fri, 24 Jan 2020 11:31:54 -0500
X-MC-Unique: 8ebv1ziMOh2UuhfBNkH2zA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 457DB8C5C77;
        Fri, 24 Jan 2020 16:31:52 +0000 (UTC)
Received: from [10.36.116.39] (ovpn-116-39.ams2.redhat.com [10.36.116.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61A6F393B;
        Fri, 24 Jan 2020 16:31:50 +0000 (UTC)
Subject: Re: [PATCH v1] driver core: check for dead devices before
 onlining/offlining
From:   David Hildenbrand <david@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20200120104909.13991-1-david@redhat.com>
 <20200124090052.GA2958140@kroah.com>
 <6dd0ea5a-e5c3-c4b6-2b2e-93537571d7d6@redhat.com>
 <20200124091221.GA2983380@kroah.com>
 <bda4fa77-3e58-bcab-8881-9f6512b0bd15@redhat.com>
 <a37a0017-97ac-5fbb-6fc2-6b659cafa9e9@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <918e3f17-7dc8-115a-a3b9-2974959a7ecd@redhat.com>
Date:   Fri, 24 Jan 2020 17:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <a37a0017-97ac-5fbb-6fc2-6b659cafa9e9@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.20 14:48, David Hildenbrand wrote:
> On 24.01.20 14:31, David Hildenbrand wrote:
>> On 24.01.20 10:12, Greg Kroah-Hartman wrote:
>>> On Fri, Jan 24, 2020 at 10:09:03AM +0100, David Hildenbrand wrote:
>>>> On 24.01.20 10:00, Greg Kroah-Hartman wrote:
>>>>> On Mon, Jan 20, 2020 at 11:49:09AM +0100, David Hildenbrand wrote:
>>>>>> We can have rare cases where the removal of a device races with
>>>>>> somebody trying to online it (esp. via sysfs). We can simply check
>>>>>> if the device is already removed or getting removed under the dev->lock.
>>>>>>
>>>>>> E.g., right now, if memory block devices are removed (remove_memory()),
>>>>>> we do a:
>>>>>>
>>>>>> remove_memory() -> lock_device_hotplug() -> mem_hotplug_begin() ->
>>>>>> lock_device() -> dev->dead = true
>>>>>>
>>>>>> Somebody coming via sysfs (/sys/devices/system/memory/memoryX/online)
>>>>>> triggers a:
>>>>>>
>>>>>> lock_device_hotplug_sysfs() -> device_online() -> lock_device() ...
>>>>>>
>>>>>> So if we made it just before the lock_device_hotplug_sysfs() but get
>>>>>> delayed until remove_memory() released all locks, we will continue
>>>>>> taking locks and trying to online the device - which is then a zombie
>>>>>> device.
>>>>>>
>>>>>> Note that at least the memory onlining path seems to be protected by
>>>>>> checking if all memory sections are still present (something we can then
>>>>>> get rid of). We do have other sysfs attributes
>>>>>> (e.g., /sys/devices/system/memory/memoryX/valid_zones) that don't do any
>>>>>> such locking yet and might race with memory removal in a similar way. For
>>>>>> these users, we can then do a
>>>>>>
>>>>>> device_lock(dev);
>>>>>> if (!device_is_dead(dev)) {
>>>>>> 	/* magic /*
>>>>>> }
>>>>>> device_unlock(dev);
>>>>>>
>>>>>> Introduce and use device_is_dead() right away.
>>>>>>
>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>> Cc: Saravana Kannan <saravanak@google.com>
>>>>>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>> ---
>>>>>>
>>>>>> Am I missing any obvious mechanism in the device core that handles
>>>>>> something like this already? (especially also for other sysfs attributes?)
>>>>>
>>>>> So is a sysfs attribute causing the device itself to go away?  We have
>>>>
>>>> nope, removal is triggered via the driver, not via a sysfs attribute.
>>>
>>> But the idea is the same, it comes from the driver, not the driver core.
>>>
>>>> Regarding this patch: Is there anything prohibiting the possible
>>>> scenario I document above (IOW, is this patch applicable, or is there
>>>> another way to fence it properly (e.g., the "specific call" you mentioned))?
>>>
>>> I think it's the same thing, look at how scsi does it.
>>
>> I think you are talking about doing a "transport_remove_device(dev)"
>> before doing the "device_del(dev)", combined with proper locking.
>>
>> Will look into that for the memory subsystem ...
> 
> ... looking into transports, it most probably does not apply here, hmm ...
> 

/me digging through random code

I think you were referring to

1. sysfs_break_active_protection()
2. sysfs_unbreak_active_protection()

Which can be used to implement a self-removal of devices via attributes
(e.g., sdev_store_delete())

I don't see yet how that would solve the race between some driver
removing an offline device and someone being stuck in an attribute,
waiting for a lock - but maybe I am looking at the wrong function again :)

-- 
Thanks,

David / dhildenb

