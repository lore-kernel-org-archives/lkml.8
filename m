Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05BEC3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6606620870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nm7ZML9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgCEBfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:35:22 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:60501 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCEBfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:35:20 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200305013518epoutp03869271f5f5ed0b8a2439a481d5f6d858~5RI2D2-Sv0547705477epoutp03Q
        for <linux-kernel@vger.kernel.org>; Thu,  5 Mar 2020 01:35:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200305013518epoutp03869271f5f5ed0b8a2439a481d5f6d858~5RI2D2-Sv0547705477epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583372118;
        bh=bPqGA3cE7AS/7i8TvKCXXDU96aSBdBQAAtaycbaMcxw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Nm7ZML9G6miaegWyblNDmjV0dT/XSDy4cDMhT4KCY0CAFSmbR+FdFvzMO+Rc/lSNC
         4FEOOSf9hCn5WzH9UdbukgejyRr9VkogAGxWJ5DseU6KZzLZZj51p8sVAe6iuMF9ad
         Rd8sYS4jXDLGA5yX1GFXFC/17RMHn044uQgXfppo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200305013518epcas1p2b537cb3b41fdd977885d6baaded7eada~5RI1uS_Ew0547605476epcas1p2u;
        Thu,  5 Mar 2020 01:35:18 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48Xtbn21s2zMqYl2; Thu,  5 Mar
        2020 01:35:17 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.11.52419.457506E5; Thu,  5 Mar 2020 10:35:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200305013516epcas1p161b533498cef3e71a7b2e3150dc7ffa6~5RIzwCdH-1200012000epcas1p1m;
        Thu,  5 Mar 2020 01:35:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200305013516epsmtrp2fe1fd23b0962b85eae1714cb2224bd13~5RIzvbIrv2757027570epsmtrp2h;
        Thu,  5 Mar 2020 01:35:16 +0000 (GMT)
X-AuditID: b6c32a37-a10cb9c00001ccc3-07-5e605754dfae
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.A4.06569.357506E5; Thu,  5 Mar 2020 10:35:16 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200305013515epsmtip2ddbe21acefc691bc8efec2216cce7173~5RIzLLPjc0207602076epsmtip2y;
        Thu,  5 Mar 2020 01:35:15 +0000 (GMT)
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
To:     walken@google.com, bp@suse.de, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E605749.9050509@samsung.com>
Date:   Thu, 5 Mar 2020 10:35:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200304030206.1706-1-jaewon31.kim@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmnm5IeEKcweO1MhZz1q9hs5jYr2nR
        vXkmo8XlXXPYLO6t+c9q8W9SrQObx85Zd9k9Fmwq9dj0aRK7x4kZv1k8Np+u9vi8SS6ALSrH
        JiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoBCWFssSc
        UqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgaFBgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk7G
        3imLWAqmyVU8nbyJrYHxgEQXIyeHhICJxIPfR9i7GLk4hAR2MErcv/2SFcL5xChx8PM5Ngjn
        G6PEr863zDAtfxd1s0Ak9jJK/Fk2nQnCecso8eTjRRaQKmEBO4ljU4+wgtgiAjYSt2esBbOZ
        BXwk5kyCsNkEtCXeL5gEZHNw8ApoSTw+HggSZhFQkWj7vQFsmahAhMSOuR8ZQWxeAUGJkzOf
        gI3nFLCVmLRrFTPESHmJ5q2zoY47wSZxemI5yEgJAReJ6Ue8IcLCEq+Ob2GHsKUkPr/bC/aY
        hEAzo8TbmZsZIZwWRom7m3oZIaqMJXp7LjCDDGIW0JRYv0sfIqwosfP3XEaIvXwS7772sELs
        4pXoaBOCKFGTaHn2lRXClpH4++8ZlO0hsWPzKWiATmCU+HvzHesERoVZSF6bheSdWQibFzAy
        r2IUSy0ozk1PLTYsMEaO4U2M4DSpZb6DccM5n0OMAhyMSjy8DjPi44RYE8uKK3MPMUpwMCuJ
        8AqbAoV4UxIrq1KL8uOLSnNSiw8xmgJDeyKzlGhyPjCF55XEG5oaGRsbW5iYmZuZGiuJ8z6M
        1IwTEkhPLEnNTk0tSC2C6WPi4JRqYJzyrOuCAm9LyslHQWuTWsW5T6id+tzy7cfO4xeVNL7/
        2G2c1nBzmdbVqtClzJyxQmt7D/fGu1V6H3U032QgdqEpbJ/eSZ5JcZdUbDYU67P35+5bnXKL
        W0f1QtCBPP0zJlMu5tZ+8PTXmS/Z2hO6J+HRxltBcv1RWcKTneN3FUkr5F3dUSt8RomlOCPR
        UIu5qDgRAF+QX8GpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvG5IeEKcwXt9iznr17BZTOzXtOje
        PJPR4vKuOWwW99b8Z7X4N6nWgc1j56y77B4LNpV6bPo0id3jxIzfLB6bT1d7fN4kF8AWxWWT
        kpqTWZZapG+XwJWxd8oiloJpchVPJ29ia2A8INHFyMkhIWAi8XdRN0sXIxeHkMBuRolvu14z
        QSRkJN6cfwqU4ACyhSUOHy4GCQsJvGaUuPcuAcQWFrCTODb1CCuILSJgI3F7xlpWiDkTGCX2
        tFxkBkkwC/hIzJm0FqyITUBb4v2CSawgM3kFtCQeHw8ECbMIqEi0/d4AVi4qECGxet01MJtX
        QFDi5MwnLCA2p4CtxKRdq6BGqkv8mXcJypaXaN46m3kCo+AsJC2zkJTNQlK2gJF5FaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcOBrae1gPHEi/hCjAAejEg+vw4z4OCHWxLLiytxD
        jBIczEoivMKmQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTByc
        Ug2MkQl/P8znWc41/fJ98/S/TwTynZ4Fv5lkFWdpKfbQbg33MjtFLTZNNwlVJtV1kXmSsXZT
        hX8UpkiIXyhsVZ90a8sf5TVsEX6XrGzZth62WGR6bGKOUIPP32+myw577VvucHDKv9cXmFZ0
        V4YVbe/bvOqpevGk2ckTtz1MZnj7aU551Y5VLEZuSizFGYmGWsxFxYkAmEnUeHgCAAA=
X-CMS-MailID: 20200305013516epcas1p161b533498cef3e71a7b2e3150dc7ffa6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
        <20200304030206.1706-1-jaewon31.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

sorry for build warning.
I've changed %d to %ld reported by kbuild.
Let me attach full patch again below.
--------------------------------------------------


Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
Virtual memory space shortage of a task on mmap is reported to userspace
as -ENOMEM. It can be confused as physical memory shortage of overall
system.

The vm_unmapped_area can be called to by some drivers or other kernel
core system like filesystem. It can be hard to know which code layer
returns the -ENOMEM.

Print error log of vm_unmapped_area with rate limited. Without rate
limited, soft lockup ocurrs on infinite mmap sytem call.

i.e.)
<3>[  576.024088]  [6:  mmap_infinite:14251] mmap: vm_unmapped_area err:-12 total_vm:0xfee08 flags:0x1 len:0xa00000 low:0x8000 high:0xf3f63000

Fixed type mismatching on previous patch which is reported by kbuild.
Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/linux/mm.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..ecf9e1fcde79 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2379,10 +2379,19 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 static inline unsigned long
 vm_unmapped_area(struct vm_unmapped_area_info *info)
 {
+    unsigned long addr;
+
     if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
-        return unmapped_area_topdown(info);
+        addr = unmapped_area_topdown(info);
     else
-        return unmapped_area(info);
+        addr = unmapped_area(info);
+
+    if (IS_ERR_VALUE(addr) && printk_ratelimit()) {
+        pr_err("%s err:%ld total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx\n",
+            __func__, addr, current->mm->total_vm, info->flags,
+            info->length, info->low_limit, info->high_limit);
+    }
+    return addr;
 }



On 2020년 03월 04일 12:02, Jaewon Kim wrote:
> Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
> Virtual memory space shortage of a task on mmap is reported to userspace
> as -ENOMEM. It can be confused as physical memory shortage of overall
> system.
>
> The vm_unmapped_area can be called to by some drivers or other kernel
> core system like filesystem. It can be hard to know which code layer
> returns the -ENOMEM.
>
> Print error log of vm_unmapped_area with rate limited. Without rate
> limited, soft lockup ocurrs on infinite mmap sytem call.
>
> i.e.)
> <3>[  576.024088]  [6:  mmap_infinite:14251] mmap: vm_unmapped_area err:-12 total_vm:0xfee08 flags:0x1 len:0xa00000 low:0x8000 high:0xf3f63000
>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  include/linux/mm.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52269e56c514..ee822d65ebb7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2379,10 +2379,19 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
>  static inline unsigned long
>  vm_unmapped_area(struct vm_unmapped_area_info *info)
>  {
> +	unsigned long addr;
> +
>  	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
> -		return unmapped_area_topdown(info);
> +		addr = unmapped_area_topdown(info);
>  	else
> -		return unmapped_area(info);
> +		addr = unmapped_area(info);
> +
> +	if (IS_ERR_VALUE(addr) && printk_ratelimit()) {
> +		pr_err("%s err:%d total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx\n",
> +			__func__, addr, current->mm->total_vm, info->flags,
> +			info->length, info->low_limit, info->high_limit);
> +	}
> +	return addr;
>  }
>  
>  /* truncate.c */

