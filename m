Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0253C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F87221744
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 09:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="BRCiRzje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbgALJzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 04:55:50 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36598 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732545AbgALJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 04:55:50 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 53B4A2E0DBD;
        Sun, 12 Jan 2020 12:55:47 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id B2PIGpo5Xh-tkW01GBU;
        Sun, 12 Jan 2020 12:55:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578822947; bh=rOLVBONEBziUYshGUMG5uQS0vfmDbQkCc6Vf0mb6A+8=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=BRCiRzjexyHs0KHl4MAbY9JmB/wcODy4/mire7I8KP5WCLP30tEc3LlNImeluHjDr
         2ZR/ftMokaRPIDcWEDk4tWz960yH/oOfs44+izK3nHbJfagbsVdqP8/fMvvzaVwcsO
         RfDC9rfvLVg7MmRWjNlqaS1y6YdsjUItOGUIB6fs=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8305::1:0])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 21n1R1spZg-tkVSOajX;
        Sun, 12 Jan 2020 12:55:46 +0300
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
References: <157839239609.694.10268055713935919822.stgit@buzz>
 <20200108023211.GC13943@richard>
 <b019b294-61fa-85fc-cf43-c6d3e9fddc71@yandex-team.ru>
 <20200109025240.GA2000@richard>
 <b8269278-85b5-9fd2-9bce-6defffcad6e8@yandex-team.ru>
 <20200110023029.GB16823@richard> <20200110112357351531132@gmail.com>
 <20200110053442.GA27846@richard>
 <d89587b7-f59f-3897-968b-969b946a9e8a@yandex-team.ru>
 <20200111223820.GA15506@richard>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <a6a7bb3b-434e-277c-694f-d5a18e629d2c@yandex-team.ru>
Date:   Sun, 12 Jan 2020 12:55:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200111223820.GA15506@richard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2020 01.38, Wei Yang wrote:
> On Fri, Jan 10, 2020 at 11:11:23AM +0300, Konstantin Khlebnikov wrote:
> [...]
>>>>>>
>>>>>> series of vma in parent with shared AV:
>>>>>>
>>>>>> SRC1 - AV0
>>>>>> SRC2 - AV0
>>>>>> SRC3 - AV0
>>>>>> ...
>>>>>> SRCn - AV0
>>>>>>
>>>>>> in child after fork
>>>>>>
>>>>>> DST1 - AV_OLD_1 (some old vma, picked by anon_vma_clone) plus DST1 is attached to same AVs as SRC1
>>>>>> DST2 - AV_OLD_2 (other old vma) plus DST1 is attached to same AVs as SRC2
>>>>>> DST2 - AV1 prev AV parent does not match AV0, no old vma found for reusing -> allocate new one (child of AV0)
>>>>>> DST3 - AV1 - DST2->AV->parent == SRC3->AV (AV0) -> share AV with prev
>>>>>> DST4 - AV1 - same thing
>>>>>> ...
>>>>>> DSTn - AV1
>>>>>>
> 
> To focus on the point, I rearranged the order a little. Suppose your following
> comments is explaining the above behavior.
> 
>     I've illustrated how two heuristics (reusing-old and sharing-prev) _could_ work together.
>     But they both are optional.
>     
>     At cloning first vma SRC1 -> DST1 there is no prev to share anon vma,
>     thus works common code which _could_ reuse old vma because it have to.
>     
>     If there is no old anon-vma which have to be reused then DST1 will allocate
>     new anon-vma (AV1) and it will be used by DST2 and so on like on your picture.
> 
> I agree with your 3rd paragraph, but confused with 2nd.
> 
> At cloning first vma SRC1 -> DST1, there is no prev so anon_vma_clone() would
> pick up a reusable anon_vma. Here you named it AV_OLD_1. This looks good to
> me. But I am not sure why you would picked up AV_OLD_2 for DST2? In parent,
> SRC1 and SRC2 has the same anon_vma, AV0. So in child, DST1 and DST2 could
> also share the same anon_vma, AV_OLD_1.
> 
> Sorry for my poor understanding, would you mind giving me more hint on this
> change?

For DST2 heuristic "share-with-prev" will not work because if prev (DST1)
uses old AV (AV_OLD_1) and AV_OLD_1->parent isn't SRC2->AV (AV0).
So DST2 could only pick another old AV or allocate new.

My patch uses condition dst->prev->anon_vma->parent == src->anon_vma rather
than obvious src->prev->anon_vma == src->anon_vma because in this way it
eliminates all unwanted corner cases and explicitly verifies that we going to
share related anon-vma.

Heuristic "reuse-old" uses fact that VMA links and AV parent chain are tracked
independently: when VMA reuses old AV it still links to all related AV even
if VMA->AV points into some old AV in the middle of inheritance chain.

> 
>>>>>
>>>>> Yes, your code works for DST3..DSTn. They will pick up AV1 since
>>>>> (DST2->AV->parent == SRC3->AV).
>>>>>
>>>>> My question is why DST1 and DST2 has different AV? The purpose of my patch
>>>>> tries to make child has the same topology and parent. So the ideal look of
>>>>> child is:
>>>>>
>>>>> DST1 - AV1
>>>>> DST2 - AV1
>>>>> DST2 - AV1
>>>>> DST3 - AV1
>>>>> DST4 - AV1
>>>>>
>>>>> Would you mind putting more words on DST1 and DST2? I didn't fully understand
>>>>> the logic here.
>>>>>
>>>>> Thanks
>>>>>
>>>>
>>>> I think that the first version is doing the work as you expected, but been
>>>> revised in second version, to limits the number of users of reused old
>>>> anon(which is picked in anon_vma_clone() and keep the tree structure.
>>>>
>>>
>>> Any reason to reduce the reuse? Maybe I lost some point.
>>
>>>
>>>>> --
>>>>> Wei Yang
>>>>> Help you, Help me
>>>
> 
