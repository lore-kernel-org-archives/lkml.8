Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EA1C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444FE2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="wp6/HAL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMLHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:07:24 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:60246 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgAMLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:07:24 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 0F5642E09CF;
        Mon, 13 Jan 2020 14:07:20 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id Rv5G6xBeJO-7JGKlpYd;
        Mon, 13 Jan 2020 14:07:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578913640; bh=7A8U24cNSxtKxM1dDLkIYVI0pQDqGLVjnFI8h+PV7AA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=wp6/HAL4CpigeLPfs2sS6vI/ouXZYOKUuCs4qkjpx1YK9bKKSljNCyFCYsrOry+Ww
         Dbm/62EWNJbrUHxrw08QrPjMrgJHDC9jX4377k7a5NyBdW32mH6B3SQ75p+N0Hk692
         pLB3gOwGicO1nJpFVeCAlfkOS2dJ/ECPE+0s1CLM=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id jjNaPQiYGK-7JV4ER96;
        Mon, 13 Jan 2020 14:07:19 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2 1/2] mm/rmap: fix and simplify reusing mergeable
 anon_vma as parent when fork
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Li Xinhai <lixinhai.lxh@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>
References: <20200108023211.GC13943@richard>
 <b019b294-61fa-85fc-cf43-c6d3e9fddc71@yandex-team.ru>
 <20200109025240.GA2000@richard>
 <b8269278-85b5-9fd2-9bce-6defffcad6e8@yandex-team.ru>
 <20200110023029.GB16823@richard> <20200110112357351531132@gmail.com>
 <20200110053442.GA27846@richard>
 <d89587b7-f59f-3897-968b-969b946a9e8a@yandex-team.ru>
 <20200111223820.GA15506@richard>
 <a6a7bb3b-434e-277c-694f-d5a18e629d2c@yandex-team.ru>
 <20200113003343.GA27210@richard>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <1cf002fa-a3cb-bcef-57dc-ac9c09dcf2eb@yandex-team.ru>
Date:   Mon, 13 Jan 2020 14:07:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113003343.GA27210@richard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2020 03.33, Wei Yang wrote:
> On Sun, Jan 12, 2020 at 12:55:45PM +0300, Konstantin Khlebnikov wrote:
>>
>>
>> On 12/01/2020 01.38, Wei Yang wrote:
>>> On Fri, Jan 10, 2020 at 11:11:23AM +0300, Konstantin Khlebnikov wrote:
>>> [...]
>>>>>>>>
>>>>>>>> series of vma in parent with shared AV:
>>>>>>>>
>>>>>>>> SRC1 - AV0
>>>>>>>> SRC2 - AV0
>>>>>>>> SRC3 - AV0
>>>>>>>> ...
>>>>>>>> SRCn - AV0
>>>>>>>>
>>>>>>>> in child after fork
>>>>>>>>
>>>>>>>> DST1 - AV_OLD_1 (some old vma, picked by anon_vma_clone) plus DST1 is attached to same AVs as SRC1
>>>>>>>> DST2 - AV_OLD_2 (other old vma) plus DST1 is attached to same AVs as SRC2
>>>>>>>> DST2 - AV1 prev AV parent does not match AV0, no old vma found for reusing -> allocate new one (child of AV0)
>>>>>>>> DST3 - AV1 - DST2->AV->parent == SRC3->AV (AV0) -> share AV with prev
>>>>>>>> DST4 - AV1 - same thing
>>>>>>>> ...
>>>>>>>> DSTn - AV1
>>>>>>>>
>>>
>>> To focus on the point, I rearranged the order a little. Suppose your following
>>> comments is explaining the above behavior.
>>>
>>>      I've illustrated how two heuristics (reusing-old and sharing-prev) _could_ work together.
>>>      But they both are optional.
>>>      At cloning first vma SRC1 -> DST1 there is no prev to share anon vma,
>>>      thus works common code which _could_ reuse old vma because it have to.
>>>      If there is no old anon-vma which have to be reused then DST1 will allocate
>>>      new anon-vma (AV1) and it will be used by DST2 and so on like on your picture.
>>>
>>> I agree with your 3rd paragraph, but confused with 2nd.
>>>
>>> At cloning first vma SRC1 -> DST1, there is no prev so anon_vma_clone() would
>>> pick up a reusable anon_vma. Here you named it AV_OLD_1. This looks good to
>>> me. But I am not sure why you would picked up AV_OLD_2 for DST2? In parent,
>>> SRC1 and SRC2 has the same anon_vma, AV0. So in child, DST1 and DST2 could
>>> also share the same anon_vma, AV_OLD_1.
>>>
>>> Sorry for my poor understanding, would you mind giving me more hint on this
>>> change?
>>
>> For DST2 heuristic "share-with-prev" will not work because if prev (DST1)
>> uses old AV (AV_OLD_1) and AV_OLD_1->parent isn't SRC2->AV (AV0).
>> So DST2 could only pick another old AV or allocate new.
> 
> I know this behavior after your change, my question is why you want to do so.

Because I want to keep both heuristics.
This seems most sane way of interaction between them.

Unfortunately even this patch is slightly broken.
Condition prev->anon_vma->parent == pvma->anon_vma doesn't guarantee that
prev vma has the same set of anon-vmas like current vma.
I.e. anon_vma_clone(vma, prev) might be not enough for keeping connectivity.
Building such case isn't trivial job but I see nothing that could prevent it.

> 
>>
>> My patch uses condition dst->prev->anon_vma->parent == src->anon_vma rather
>> than obvious src->prev->anon_vma == src->anon_vma because in this way it
>> eliminates all unwanted corner cases and explicitly verifies that we going to
>> share related anon-vma.
>>
> 
> This do eliminates some corner case, but as you showed child and parent don't
> share the same AV topology. To keep the same AV topology is the purpose of my
> commit.
> 
> I agree you found some bug that previous commit doesn't do it is expected. But
> since you change the design a little, I suggest you split this idea to a
> separate patch so that reviewer and audience in the future could understand
> your approach clearly. Otherwise audience would be confused and hard to track
> this change.
> 
> For example, you describe the behavior after your change. The second vma would
> probably have a different AV from first vma.
> 
>> Heuristic "reuse-old" uses fact that VMA links and AV parent chain are tracked
>> independently: when VMA reuses old AV it still links to all related AV even
>> if VMA->AV points into some old AV in the middle of inheritance chain.
>>
>>>
>>>>>>>
>>>>>>> Yes, your code works for DST3..DSTn. They will pick up AV1 since
>>>>>>> (DST2->AV->parent == SRC3->AV).
>>>>>>>
>>>>>>> My question is why DST1 and DST2 has different AV? The purpose of my patch
>>>>>>> tries to make child has the same topology and parent. So the ideal look of
>>>>>>> child is:
>>>>>>>
>>>>>>> DST1 - AV1
>>>>>>> DST2 - AV1
>>>>>>> DST2 - AV1
>>>>>>> DST3 - AV1
>>>>>>> DST4 - AV1
>>>>>>>
>>>>>>> Would you mind putting more words on DST1 and DST2? I didn't fully understand
>>>>>>> the logic here.
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>
>>>>>> I think that the first version is doing the work as you expected, but been
>>>>>> revised in second version, to limits the number of users of reused old
>>>>>> anon(which is picked in anon_vma_clone() and keep the tree structure.
>>>>>>
>>>>>
>>>>> Any reason to reduce the reuse? Maybe I lost some point.
>>>>
>>>>>
>>>>>>> --
>>>>>>> Wei Yang
>>>>>>> Help you, Help me
>>>>>
>>>
>
