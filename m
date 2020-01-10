Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23598C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF722077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0sOJP5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgAJJcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:32:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41232 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbgAJJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578648729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=iKMkOoDRxkVplffIq8jmwKYmNRWBeyWiU140IOAbbFo=;
        b=e0sOJP5rrpvaWwZtWyMs4pd5+RtPWsQ0N4HmfKjv8TEtBuG0nKMzua3HJzEdnk4jlqGQ6Q
        VXv5ls/YM3LNWUqBosH6AE91bCc/Igq5/VOZIDl/lTRF3fS22UJ+lq9TVeVsGjLgfF3X1o
        FoOtsHCctS7HXL0Myjf42FsY5YS0M0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-vQ6vLDNuPwqyg9Wh-ur3eQ-1; Fri, 10 Jan 2020 04:32:06 -0500
X-MC-Unique: vQ6vLDNuPwqyg9Wh-ur3eQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F41710054E3;
        Fri, 10 Jan 2020 09:32:04 +0000 (UTC)
Received: from [10.36.117.139] (ovpn-117-139.ams2.redhat.com [10.36.117.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABC6F7C3F5;
        Fri, 10 Jan 2020 09:32:02 +0000 (UTC)
Subject: Re: [PATCH v4] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        mhocko@suse.com, Scott Cheloha <cheloha@linux.ibm.com>
References: <20200109142758.659c1545cb8df2d05f299a4a@linux-foundation.org>
 <F8AD9915-061E-4829-8670-B35D5F2DFC03@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <bc21eec6-7251-4c91-2f57-9a0671f8d414@redhat.com>
Date:   Fri, 10 Jan 2020 10:32:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <F8AD9915-061E-4829-8670-B35D5F2DFC03@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.20 23:35, David Hildenbrand wrote:
>> Am 09.01.2020 um 23:28 schrieb Andrew Morton <akpm@linux-foundation.or=
g>:
>>
>> =EF=BB=BFOn Thu, 9 Jan 2020 23:17:09 +0100 David Hildenbrand <david@re=
dhat.com> wrote:
>>
>>>
>>>
>>>>> Am 09.01.2020 um 23:00 schrieb Andrew Morton <akpm@linux-foundation=
.org>:
>>>>
>>>> =EF=BB=BFOn Thu,  9 Jan 2020 15:25:16 -0600 Scott Cheloha <cheloha@l=
inux.vnet.ibm.com> wrote:
>>>>
>>>>> Searching for a particular memory block by id is an O(n) operation
>>>>> because each memory block's underlying device is kept in an unsorte=
d
>>>>> linked list on the subsystem bus.
>>>>>
>>>>> We can cut the lookup cost to O(log n) if we cache the memory block=
s in
>>>>> a radix tree.  With a radix tree cache in place both memory subsyst=
em
>>>>> initialization and memory hotplug run palpably faster on systems wi=
th a
>>>>> large number of memory blocks.
>>>>>
>>>>> ...
>>>>>
>>>>> @@ -56,6 +57,13 @@ static struct bus_type memory_subsys =3D {
>>>>>   .offline =3D memory_subsys_offline,
>>>>> };
>>>>>
>>>>> +/*
>>>>> + * Memory blocks are cached in a local radix tree to avoid
>>>>> + * a costly linear search for the corresponding device on
>>>>> + * the subsystem bus.
>>>>> + */
>>>>> +static RADIX_TREE(memory_blocks, GFP_KERNEL);
>>>>
>>>> What protects this tree from racy accesses?
>>>
>>> I think the device hotplug lock currently (except during boot where n=
o races can happen).
>>>
>>
>> So this?
>>
>> --- a/drivers/base/memory.c~drivers-base-memoryc-cache-blocks-in-radix=
-tree-to-accelerate-lookup-fix
>> +++ a/drivers/base/memory.c
>> @@ -61,6 +61,9 @@ static struct bus_type memory_subsys =3D {
>>  * Memory blocks are cached in a local radix tree to avoid
>>  * a costly linear search for the corresponding device on
>>  * the subsystem bus.
>> + *
>> + * Protected by mem_hotplug_lock in mem_hotplug_begin(), and by the g=
uaranteed
>> + * single-threadness at boot time.
>>  */
>> static RADIX_TREE(memory_blocks, GFP_KERNEL);
>>
>>
>> But are we sure this is all true?
>=20
> I think the device hotplug lock, not the memory hotplug lock. Will doub=
le check later.

So all writers either hold the device_hotplug_lock or run during boot.
Documented e.g., for memory_dev_init(), create_memory_block_devices(),
remove_memory_block_devices().

The readers are mainly
- find_memory_block()
 -> called via online_pages()/offline_pages() where we hold the
    device_hotplug_lock
 -> called from arch/powerpc/platforms/pseries/hotplug-memory.c,
    where we always hold the device_hotplug_lock
- walk_memory_blocks()
 -> Callers in drivers/acpi/acpi_memhotplug.c either hold the
    device_hotplug_lock or are called early during boot
 -> Callers in mm/memory_hotplug.c either hold the
    device_hotplug_lock or are called early during boot
 -> link_mem_sections() is called either early during boot or via
    add_memory_resource() (whereby all callers either hold the
    device_hotplug_lock or are called early during boot)
 -> Callers in arch/powerpc/platforms/powernv/memtrace.c hold the
    device_hotplug_lock

So we are fine.

I suggest we document that expected behavior via

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 799b43191dea..8c8dc081597e 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -585,6 +585,8 @@ static struct memory_block
*find_memory_block_by_id(unsigned long block_id)
  * tree or something here.
  *
  * This could be made generic for all device subsystems.
+ *
+ * Called under device_hotplug_lock.
  */
 struct memory_block *find_memory_block(struct mem_section *section)
 {
@@ -837,6 +839,8 @@ void __init memory_dev_init(void)
  *
  * In case func() returns an error, walking is aborted and the error is
  * returned.
+ *
+ * Called under device_hotplug_lock.
  */
 int walk_memory_blocks(unsigned long start, unsigned long size,
                       void *arg, walk_memory_blocks_func_t func)


Please note that the memory hotplug lock is not safe on the reader side.
But also not on the writer side after
https://lkml.kernel.org/r/157863061737.2230556.3959730620803366776.stgit@=
dwillia2-desk3.amr.corp.intel.com


--=20
Thanks,

David / dhildenb

