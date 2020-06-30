Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FA0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113D32073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkEYE1Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgF3HQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:16:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23127 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730638AbgF3HQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593501377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=BfwaBovOOpnQWo6JxnkyepG/5eOB767l9uyBRYw2fp8=;
        b=MkEYE1UknWmm+MCDUthD5AmLj3OqJj/NI79YpfkYahY4imn2I3kTgNsL0UrBD8XfudWf1H
        Hp1tX4OEAfGwZ53d8V28gVH0vezel5poLxcxDVFCu4ncbCGoLK49w2v2hgbkU71upwdbj1
        UD54/hZ/90tKhGT87x7ka2oTK3W0MWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-qxkV0COgMuGcJ6bWBy_wJA-1; Tue, 30 Jun 2020 03:16:15 -0400
X-MC-Unique: qxkV0COgMuGcJ6bWBy_wJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D0651005513;
        Tue, 30 Jun 2020 07:16:13 +0000 (UTC)
Received: from [10.36.114.56] (ovpn-114-56.ams2.redhat.com [10.36.114.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6372B1000079;
        Tue, 30 Jun 2020 07:16:10 +0000 (UTC)
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4gMQsBSQ-kXM6H_zz96ZTJ5F0XnDfq6_mZTn4t9JwmEpA@mail.gmail.com>
 <4D73CD59-BFD5-401A-A001-41F7BF5641BA@redhat.com>
 <CAPcyv4hnsUoavnzX8q5VReiLXrOsOYW0Ef5GDKxQtS+6pQLy4A@mail.gmail.com>
 <20200629083411.GA38188@L-31X9LVDL-1304.local>
 <CAPcyv4gK2PL5YNLkeQjSCLrNZ62P1U_HjuBSNpkEvuHMcyeGOQ@mail.gmail.com>
 <20200629225842.GA38617@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <e98997ed-4a9f-37cc-932b-9ac9c4441291@redhat.com>
Date:   Tue, 30 Jun 2020 09:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629225842.GA38617@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.06.20 00:58, Wei Yang wrote:
> On Mon, Jun 29, 2020 at 03:13:25PM -0700, Dan Williams wrote:
>> On Mon, Jun 29, 2020 at 1:34 AM Wei Yang
>> <richard.weiyang@linux.alibaba.com> wrote:
>>>
>>> On Thu, Jun 25, 2020 at 12:46:43PM -0700, Dan Williams wrote:
>>>> On Wed, Jun 24, 2020 at 10:53 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>>> Am 25.06.2020 um 01:47 schrieb Dan Williams <dan.j.williams@intel.com>:
>>>>>>
>>>>>> ﻿On Wed, Jun 24, 2020 at 3:44 PM Wei Yang
>>>>>> <richard.weiyang@linux.alibaba.com> wrote:
>>>>>> [..]
>>>>>>>> So, you are right that there is a mismatch here, but I think the
>>>>>>>> comprehensive fix is to allow early sections to be partially
>>>>>>>> depopulated/repopulated rather than have section_activate() and
>>>>>>>> section_deacticate() special case early sections. The special casing
>>>>>>>> is problematic in retrospect as section_deactivate() can't be
>>>>>>>> maintained without understand special rules in section_activate().
>>>>>>>
>>>>>>> Hmm... This means we need to adjust pfn_valid() too, which always return true
>>>>>>> for early sections.
>>>>>>
>>>>>> Right, rather than carry workarounds in 3 locations, and the bug that
>>>>>> has resulted from then getting out of sync, just teach early section
>>>>>> mapping to allow for the subsection populate/depopulate.
>>>>>>
>>>>>
>>>>> I prefer the easy fix first - IOW what we Here here. Especially, pfn_to_online_page() will need changes as well.
>>>>
>>>> Agree, yes, let's do the simple fix first for 5.8 and the special-case
>>>> elimination work later.
>>>
>>> Dan,
>>>
>>> A quick test shows this is not a simple task.
>>
>> Thanks for taking a look...
>>
>>> First, early sections don't set subsection bitmap, which is necessary for the
>>> hot-add/remove.
>>>
>>> To properly set subsection bitmap, we need to know how many subsections in
>>> early section. While current code doesn't has a alignment requirement for
>>> last early section. We mark the whole last early section as present.
>>
>> I was thinking that the subsection map does not need to be accurate on
>> initial setup, it only needs to be accurate after the first removal.
>> However, that would result in new special casing that somewhat defeats
>> the purpose. The hardest part is potentially breaking up a PMD mapping
>> of the page array into a series of PTE mappings without disturbing
>> in-flight pfn_to_page() users.
>>
>>> I don't find a way to enable this.
>>
>> While I don't like that this bug crept into the mismatched special
>> casing of early sections, I'm now coming around to the same opinion.
>> I.e. that making the memmap for early sections permanent is a simpler
>> mechanism to maintain.
> 
> I think so ...
> 

Yes, and I think having to replace quite some pfn_valid_within() - nops
- by pfn_valid() just to handle one corner case might not be worth it.
At least for now.

-- 
Thanks,

David / dhildenb

