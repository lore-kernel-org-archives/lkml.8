Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6C6C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887DF214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UwHtk/jL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBFXSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:18:39 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18203 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgBFXSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:18:39 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3c9eb60000>; Thu, 06 Feb 2020 15:18:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 15:18:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Feb 2020 15:18:38 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 23:18:38 +0000
Subject: Re: [PATCH -next] mm: mark a intentional data race in page_zonenum()
To:     Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <jack@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200206035235.2537-1-cai@lca.pw>
 <480a7dde-f678-c07b-2231-4da8e0a38753@nvidia.com>
 <1580997681.7365.14.camel@lca.pw>
 <CANpmjNNX1apK0izjPhRG3kG-O_iKG1nGrOEL+PAvpH86QLXZMg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <423eb3c6-6db2-87d2-e0b7-a32600ee1cd4@nvidia.com>
Date:   Thu, 6 Feb 2020 15:18:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CANpmjNNX1apK0izjPhRG3kG-O_iKG1nGrOEL+PAvpH86QLXZMg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581031094; bh=PdilNaQrZxxz1fWGtubUhLAYgVoDyL92AlOifHo37ao=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UwHtk/jLgLnK/y9T2Xp1RnOxFN5WEqMbD/IU0bNJfpKr5X+rY1brqO2FgOpVfRMB3
         SEN1A2//5oLgJct/nw8ZdK7N1QArZt/IG8P0S85RCiAb650rKQZ61ChecQKuVCJZRH
         Ket2HVWzfYxuIWThf5TBjG6Oxx050NfEwIjO1NEcby7T4pHmcppawHJVchbRRXWCHl
         zJcpi942JX9wflQy/4SFMZ8+KwXx9qDb87Txk9EaYOJdiLcyXCYigUYR4ViotLkB8T
         zyaA6smP7gpxt8gc5evjLB8h2mJriTAegIprszeokhOqLZtwosv9vroq8//+M0/ydq
         +EqXNE4B1Sxcw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 6:35 AM, Marco Elver wrote:
...
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 52269e56c514..cafccad584c2 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -920,7 +920,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
>>>>
>>>>   static inline enum zone_type page_zonenum(const struct page *page)
>>>>   {
>>>> -   return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
>>>> +   return data_race((page->flags >> ZONES_PGSHIFT) & ZONES_MASK);
>>>
>>>
>>> I don't know about this. Lots of the kernel is written to do this sort
>>> of thing, and adding a load of "data_race()" everywhere is...well, I'm not
>>> sure if it's really the best way.  I wonder: could we maybe teach this
>>> kcsan thing to understand a few of the key idioms, particularly about page
>>> flags, instead of annotating all over the place?
>>
>> My understanding is that it is rather difficult to change the compilers, but it
>> is a good question and I Cc Marco who is the maintainer for KCSAN that might
>> give you a definite answer.
> 
> The problem is that there is no general idiom where we could say with
> confidence that a data race is safe across the whole kernel. Here it


Yes. I'm grasping at straws now, but...what about the idiom that page_zonenum()
uses: a set of bits that are "always" (after a certain early point) read-only?
What are your thoughts on that?


> might not matter, but somewhere else it might matter a lot.
> 
> If you think that it turns out the entire file may be littered with
> 'data_race()', and you do not want to use annotations, you can
> blacklist the file. I already had to do this for other files in mm/,
> because concurrent flag modification/checking is pervasive and a lot
> of them seem 'benign'. We decided to revisit those files later.
> 
> Feel free to add 'KCSAN_SANITIZE_memory.o := n' or whatever other
> files you think are full of these to mm/Makefile.
> 
> The only problem I see with that is that it's not obvious what is
> concurrently modified and what isn't. The annotations would have
> helped document what is happening.
> 
> Thanks,
> -- Marco
> 


thanks,
-- 
John Hubbard
NVIDIA
