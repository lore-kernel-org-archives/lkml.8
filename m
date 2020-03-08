Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387BCC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C021D206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pI1ynQ8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgCHKKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:10:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:44297 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgCHKKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:10:17 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200308101014epoutp022005489245f14025e31f79668a34eb03~6TGTD2rp02224922249epoutp02i
        for <linux-kernel@vger.kernel.org>; Sun,  8 Mar 2020 10:10:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200308101014epoutp022005489245f14025e31f79668a34eb03~6TGTD2rp02224922249epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583662214;
        bh=dj8wrT87gwIwUumGo2+U5nhUFUBeWGuHvc3Tx8kj+Ww=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pI1ynQ8aKUzfDicyASWd2DT/E1yhN7uCReWU5dVjPn0ibV5pPTQQQLuy0b50ctrs3
         1VRmtClByqrWV88/IFKZ+/O5jxot0XwhE9RQqau0HIpVYJX2TvzbW1KPZBt5336QSs
         w4fmY8WleTNdPBi+1fE28nAoDtg6ffy00zMgr52s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200308101014epcas1p13e634b039ea19ec9fcdf813ca5841334~6TGSoAL9K1703617036epcas1p1V;
        Sun,  8 Mar 2020 10:10:14 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.159]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48ZxtY1ZdJzMqYlm; Sun,  8 Mar
        2020 10:10:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.8A.48019.584C46E5; Sun,  8 Mar 2020 19:10:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200308101012epcas1p3c8aeffab67893672ab20adc018b6e177~6TGQ8Alks0506805068epcas1p3f;
        Sun,  8 Mar 2020 10:10:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200308101012epsmtrp14238519fceb5231bf43fdea45dc72cc7~6TGQ4lr6U1090810908epsmtrp1X;
        Sun,  8 Mar 2020 10:10:12 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-a5-5e64c485ec6b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.61.06569.484C46E5; Sun,  8 Mar 2020 19:10:12 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200308101011epsmtip2709b9f07a923c5692b0cbf844b9d291f~6TGQZoEYD0124201242epsmtip2M;
        Sun,  8 Mar 2020 10:10:11 +0000 (GMT)
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     walken@google.com, bp@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E64C47D.50105@samsung.com>
Date:   Sun, 8 Mar 2020 19:10:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200307154744.acd523831b45efa8d0fc1dfa@linux-foundation.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGeXe3u2u0eJuZB4tc14hmWFtzeiu1KMlBHxj1R0Wpl+22Sfti
        d4vMgizTMEOTjJyOhKJIKmurXFJBc61VJkVBXxh9KoV9WBmFqW27i/zvdx6ew3nOeV+KkDeS
        KVSp1ck5rKyZJieIr3QpVRn7g4YiVXBIyrS0nyWZw3VK5qCvCTGPOltI5uXZMQkz2rB7Kam7
        6u6V6lq9Lp33W4NUFz42LNb57pXrvntnFJKbzDkmjjVwDgVn1dsMpVZjLr1yXfHyYm2WSp2h
        Xshk0wora+Fy6fxVhRkrSs2RCLRiO2t2RaRClufp+Xk5DpvLySlMNt6ZS3N2g9muVtnn8ayF
        d1mN8/Q2yyK1SrVAG3GWmE111SOk/U7yDl9NlXgPei6vQQkU4Eyo6HgorUETKDn2I3D/qpYI
        xTcEp/x7pVGXHP9EUH+y4F/Hn6aHSDBdR/DkXFe8+ITgZvijJOpKxHkQagzGeArOgLb+TqIG
        URSBLVAdskRlEs+FL60Nkqgsw3Pg+IguKovxLLg7LMxNwhvA7xlEUZbhyXCn6Z04ygl4JfwJ
        vI0xgVNh3+VmQsjWTcJg71qB86H1wrBU4ET4ePtSnFPgQ11VbGPA+xB8avIhoahE0Os9hASX
        Bg7VPohnVkJ753xBnglXhz1IGDwJPg/VxvIDlsGBqvhFZ0Nl35BE4OkwMtoXZx34fXdJ4VSP
        RdAduiWpRwr3uN3c4/Zx/5/ciog2NJWz8xYjx6vtmeMf2ItiXzKd8aNrPasCCFOInigr6dEX
        ySXsdr7MEkBAEfQUWUV6RJIZ2LKdnMNW7HCZOT6AtJFzHyZSkvS2yAe3OovV2gUajYbJzMrO
        0mroZNnrjcoiOTayTm4bx9k5x78+EZWQsgdNnbjeOLfyiCg48HMrvFLVJul/rxH3ncmtF4nk
        jtCynRdevzhRcjqcdgOH07eU3bNt7g8s9Xh2NXakDf4Y6FnSf2lgbEP2m67UgqNzXn1tuegZ
        qHs6Kf/F5iVpHaVKzQn94ivl5dTyZ49H20xV3fb7wTM3mlf3Fh5rPv9j2th7z2hyAS3mTaw6
        nXDw7F8re0RlqAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvG7LkZQ4g/PfuS3mrF/DZjGxX9Oi
        e/NMRovLu+awWdxb85/V4t+kWgc2j52z7rJ7LNhU6rHp0yR2jxMzfrN4bD5d7fF5k1wAWxSX
        TUpqTmZZapG+XQJXRn/7X7aCk+IVm7vaWBoYbwl1MXJySAiYSPyZeZGxi5GLQ0hgN6PE36+r
        2CESMhJvzj9l6WLkALKFJQ4fLoaoec0osXXNfTaQGmEBO4ljU4+wgtgiAroSq57vYoYousIk
        cfjPY7AiZoFciXfPpoHZbALaEu8XTGIFGcoroCEx/68HSJhFQEXi1O8msL2iAhESq9ddYwax
        eQUEJU7OfMICYnMKeEv8OfQY7B5mAXWJ9fOEIKbLSzRvnc08gVFwFpKOWQhVs5BULWBkXsUo
        mVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERz4Wlo7GE+ciD/EKMDBqMTDu+NCcpwQa2JZ
        cWXuIUYJDmYlEd5GLaAQb0piZVVqUX58UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUw
        WSYOTqkGRt+5E+KSq3+uydob+trQ7tt3BudgyZ+WJZJMfnwaQU4mz3aqhW9oUHXvdi+Jau+1
        v3G81NXpzenjK/QC5+kE1SwOPlj5J//tgksnY6bmZf439fUpVJ37S6fcxFHdI5cr6Mb7I2Hn
        mVm3tFveP/rVV1H1ActWnR/6Zv++WYfuW8QzM/foxUgZJZbijERDLeai4kQACRt7TXgCAAA=
X-CMS-MailID: 20200308101012epcas1p3c8aeffab67893672ab20adc018b6e177
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
        <20200304030206.1706-1-jaewon31.kim@samsung.com>
        <5E605749.9050509@samsung.com>
        <20200305202443.8de3598558336b1d75afbba7@linux-foundation.org>
        <5E61EAB6.5080609@samsung.com>
        <20200307154744.acd523831b45efa8d0fc1dfa@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 08일 08:47, Andrew Morton wrote:
> On Fri, 6 Mar 2020 15:16:22 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
>> Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
>> Virtual memory space shortage of a task on mmap is reported to userspace
>> as -ENOMEM. It can be confused as physical memory shortage of overall
>> system.
>>
>> The vm_unmapped_area can be called to by some drivers or other kernel
>> core system like filesystem. It can be hard to know which code layer
>> returns the -ENOMEM.
>>
>> Print error log of vm_unmapped_area with rate limited. Without rate
>> limited, soft lockup ocurrs on infinite mmap sytem call.
>>
>> i.e.)
>> <4>[   68.556470]  [2:  mmap_infinite:12363] mmap: vm_unmapped_area err:-12 total_vm:0xf4c08 flags:0x1 len:0x100000 low:0x8000 high:0xf4583000 mask:0x0 offset:0x0
>>
>> ...
>>
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
> This patch was messed up by your email client (tabs expanded to spaces).
Sorry for this. Let me fix when I resubmit.
>> @@ -27,6 +27,7 @@
>>  #include <linux/memremap.h>
>>  #include <linux/overflow.h>
>>  #include <linux/sizes.h>
>> +#include <linux/ratelimit.h>
>>  
>>  struct mempolicy;
>>  struct anon_vma;
>> @@ -2379,10 +2380,20 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
>>  static inline unsigned long
>>  vm_unmapped_area(struct vm_unmapped_area_info *info)
>>  {
>> +    unsigned long addr;
>> +
>>      if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
>> -        return unmapped_area_topdown(info);
>> +        addr = unmapped_area_topdown(info);
>>      else
>> -        return unmapped_area(info);
>> +        addr = unmapped_area(info);
>> +
>> +    if (IS_ERR_VALUE(addr)) {
>> +        pr_warn_ratelimited("%s err:%ld total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx mask:0x%lx offset:0x%lx\n",
>> +            __func__, addr, current->mm->total_vm, info->flags,
>> +            info->length, info->low_limit, info->high_limit,
>> +            info->align_mask, info->align_offset);
>> +    }
>> +    return addr;
>>  }
> pr_warn_ratelimited() contains static state.  Using it in an inlined
> function means that each callsite gets its own copy of that state, so
> we're ratelimiting the vm_unmapped_area() output on a per-callsite
> basis, not on a kernelwide basis.
>
> Maybe that's what we want, maybe it's not.  But I think
> vm_unmapped_area() has become too large to be inlined anyway, so I
> suggest making it a regular out-of-line function in mmap.c.  I don't
> believe that function needs to be exported to modules.
Thank you for your comment.
Though, on v5.6-rc4, I just found couple of code which calls to vm_unmapped_area,
I may be able to move this to out-of-line function on next patch version.

By the way, I need to discuss userspace triggered printk with Matthew Wilcox.
If possible, I'd like to hear your opinion for this.

Thank you
>
>
>

