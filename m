Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56809C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2308E20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dvj8Q0Ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgBFJBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:01:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45108 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgBFJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580979694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=bMtWohnQIUNzbIHzo8X2PzPCkVKOFCqxtG2H1pSrqWU=;
        b=Dvj8Q0Yeqtl3BsvRO8dxKDmMnYfcIkOA0z1VAkb8+hW7K8w5uByXc6ZgGorfba0syaXRNI
        e/PSS84OEvCgd4h5RqRCRY+DYG9mcpCEby2usMXx1P/0k0GdCViv5T1jGHL3arl5Ykh2Ez
        CwLGJ9ZpaPxu/loY8PyXYyHNCqdbGuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-LAvACh9fO2SDbivVhD2iwA-1; Thu, 06 Feb 2020 04:01:30 -0500
X-MC-Unique: LAvACh9fO2SDbivVhD2iwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49AAF801E74;
        Thu,  6 Feb 2020 09:01:28 +0000 (UTC)
Received: from [10.36.117.188] (ovpn-117-188.ams2.redhat.com [10.36.117.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CF0560BF7;
        Thu,  6 Feb 2020 09:01:22 +0000 (UTC)
Subject: Re: [PATCH v1] mm/memory_hotplug: Easier calculation to get pages to
 next section boundary
To:     Baoquan He <bhe@redhat.com>, Wei Yang <richard.weiyang@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20200205135251.37488-1-david@redhat.com>
 <20200205231945.GB28446@richard> <20200205235007.GA28870@richard>
 <20200206001317.GH8965@MiWiFi-R3L-srv> <20200206003736.GI8965@MiWiFi-R3L-srv>
 <20200206022644.6u7pxf7by2w5trmi@master>
 <20200206024816.GK8965@MiWiFi-R3L-srv>
 <20200206043401.22i2cucwqctsrtps@master>
 <20200206043924.GM8965@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <14cca79e-2e76-28ef-1a17-81f044548c33@redhat.com>
Date:   Thu, 6 Feb 2020 10:01:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200206043924.GM8965@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.20 05:39, Baoquan He wrote:
> On 02/06/20 at 04:34am, Wei Yang wrote:
>> On Thu, Feb 06, 2020 at 10:48:16AM +0800, Baoquan He wrote:
>>> On 02/06/20 at 02:26am, Wei Yang wrote:
>>>> On Thu, Feb 06, 2020 at 08:37:36AM +0800, Baoquan He wrote:
>>>>> On 02/06/20 at 08:13am, Baoquan He wrote:
>>>>>> On 02/06/20 at 07:50am, Wei Yang wrote:
>>>>>>> On Thu, Feb 06, 2020 at 07:19:45AM +0800, Wei Yang wrote:
>>>>>>>> On Wed, Feb 05, 2020 at 02:52:51PM +0100, David Hildenbrand wrot=
e:
>>>>>>>>> Let's use a calculation that's easier to understand and calcula=
tes the
>>>>>>>>> same result. Reusing existing macros makes this look nicer.
>>>>>>>>>
>>>>>>>>> We always want to have the number of pages (> 0) to the next se=
ction
>>>>>>>>> boundary, starting from the current pfn.
>>>>>>>>>
>>>>>>>>> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>>>>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>>>>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>>>>>>> Cc: Baoquan He <bhe@redhat.com>
>>>>>>>>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>>>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>>>
>>>>>>>> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
>>>>>>>>
>>>>>>>> BTW, I got one question about hotplug size requirement.
>>>>>>>>
>>>>>>>> I thought the hotplug range should be section size aligned, whil=
e taking a
>>>>>>>> look into current code function check_hotplug_memory_range() gua=
rd the range.
>>>>>>
>>>>>> A good question. The current code should be block size aligned. I
>>>>>> remember in some places we assume each block comprise all the sect=
ions.
>>>>>> Can't imagine one or some of them are half section filled.
>>>>>
>>>>> I could be wrong, half filled block may not cause problem.=20
>>>>>
>>>>
>>>> David must be angry about our flooding the mail list :-)
>>>
>>> Believe he won't, :-) If you like, we can talk off line.
>>>
>>>>
>>>> Check the code again, there are two memory range check:
>>>>
>>>>   * check_hotplug_memory_range(), block/section aligned
>>>>   * check_pfn_span(), subsection aligned
>>>>
>>>> The second check, check_pfn_span() in __add_pages(), enable the capa=
bility to
>>>> add a memory range with subsection size.
>>>>
>>>> This means hotplug still keeps section alignment.
>>>
>>> memremap_pages() also call add_pages(), it doesn't have the
>>> check_hotplug_memory_range() invocation. check_pfn_span() is made for
>>> it specifically.
>>>
>>
>> If my understanding is correct, memremap_pages() is used to add some d=
ev
>> memory to system. This is the use case which Dan want to enable for
>> sub-section. Since memremap_pages() is not called in mem-hotplug path,=
 this
>> doesn't affect the hotplug range alignment.
>=20
> Yeah, we are on the same page.

We allow sub-section hoy-add only for device memory/hmm. BIOS often
align PMEM devices to sub-sections, and not supporting this makes life
difficult to support these devices. (You cannot simply cut off something
of a disk :) )

System memory can only be hotplugged in memory block granularity, the
same granularity onlining/offlining from user space will happen. Boot
memory, however, can be sub-section aligned, but can never be offlined
(as it contains holes) and therefore never be removed.

>>
>>>>
>>>> BTW, __add_pages() share the same logic as __remove_pages(). Why not=
 change it
>>>> too? Do I miss something or I don't have the latest source code?
>>>
>>> Good question, and I think it need. Just David is refactoring/cleanin=
g
>>> up the remove_pages() code path, this is found out by Segher from pat=
ch
>>> reviewing.
>>
>> Ah, we may need a following cleanup :-)
>=20
> Agree. See what David will say. Fold it into this patch, or anyone post
> a new one.
>=20

Yes, I only cleaned up __remove_pages() for now. I can send a similar
cleanup for __add_pages().

Will resend this patch, also taking care of __add_pages(). Thanks!

--=20
Thanks,

David / dhildenb

