Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FC0C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B0D2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DQk8yzQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCFGQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:16:49 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:53321 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgCFGQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:16:48 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200306061644epoutp03d74338cfc135c02fa44d54fadbfb2167~5on2m4cL_1542915429epoutp03y
        for <linux-kernel@vger.kernel.org>; Fri,  6 Mar 2020 06:16:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200306061644epoutp03d74338cfc135c02fa44d54fadbfb2167~5on2m4cL_1542915429epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583475404;
        bh=9C0MGid2PHbQyNe6yA6AUa7YmbxANZzM1sEsysOYPUw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DQk8yzQHEb8WB3umHV8/+/C7wHQ1MnXYBlfvA62r1HQYImQqn3HsKpuD1CacbVKYe
         yxfxkZ2PWe+UR2IMtP+y5QElxVbnalR4avkaQ17loGZMhzrAvuuRByuGKP5Zo7P1TK
         +SuuDHuuRzpOFeIfVvWyAe9iga1GlaS+KjFKX+kU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200306061644epcas1p4ff2b84e43bb28f348b345319b5139e96~5on2MPTPb1791817918epcas1p4H;
        Fri,  6 Mar 2020 06:16:44 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.164]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48Ycp305SpzMqYlv; Fri,  6 Mar
        2020 06:16:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.C3.48019.ACAE16E5; Fri,  6 Mar 2020 15:16:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200306061642epcas1p15dc9ef2887e3d9d8d706541996221ddd~5on02GtdQ2658026580epcas1p1R;
        Fri,  6 Mar 2020 06:16:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200306061642epsmtrp128eaf79b2c2350afe9ddec0106e41004~5on01dM1B1001210012epsmtrp1M;
        Fri,  6 Mar 2020 06:16:42 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-b8-5e61eacac06d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.B2.06569.ACAE16E5; Fri,  6 Mar 2020 15:16:42 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200306061641epsmtip1cc649414fcb00f8719a06c6354b7b48e~5on0OsV0F2639326393epsmtip1Y;
        Fri,  6 Mar 2020 06:16:41 +0000 (GMT)
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     walken@google.com, bp@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E61EAB6.5080609@samsung.com>
Date:   Fri, 6 Mar 2020 15:16:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200305202443.8de3598558336b1d75afbba7@linux-foundation.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmge6pV4lxBr+PWFvMWb+GzWJiv6ZF
        9+aZjBaXd81hs7i35j+rxb9JtQ5sHjtn3WX3WLCp1GPTp0nsHidm/Gbx2Hy62uPzJrkAtqgc
        m4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygE5QUyhJz
        SoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZ
        mye+YClYolGxbe1E5gbGDQpdjJwcEgImEhvu9zCB2EICOxglTq1WhbA/MUo0/67vYuQCsr8x
        ShzYcJsRpuHW3G1sEIm9jBJbd+xihXDeMkpM625hA6kSFrCTODb1CCuILSKgK7Hq+S7mLkYO
        DmaBXIn2Y7kgYTYBbYn3CyaBlfAKaEn8n7WOBcRmEVCRmLtgBTOILSoQIbFj7kdGiBpBiZMz
        n7CAjOEU8JY4c68IJMwsIC/RvHU2M8gJEgJn2CQmd19lhTjUReLkv6fsELawxKvjW6BsKYmX
        /W3sEA3NjBJvZ25mhHBaGCXubuqFetNYorfnAtTRmhLrd+lDhBUldv6eywixmU/i3dceVpAS
        CQFeiY42IYgSNYmWZ1+hbpCR+PvvGZTtIbFj8ylowAFDt+/0CuYJjAqzkPw2C8lDsxA2L2Bk
        XsUollpQnJueWmxYYIIcwZsYwUlSy2IH455zPocYBTgYlXh4FT4nxAmxJpYVV+YeYpTgYFYS
        4RU2jY8T4k1JrKxKLcqPLyrNSS0+xGgKDO6JzFKiyfnABJ5XEm9oamRsbGxhYmZuZmqsJM77
        MFIzTkggPbEkNTs1tSC1CKaPiYNTqoHR+dD233NesoY/v7159XP+ul0s6qvt4tQv8qp+X+24
        +3DINNftW7+UxE9d1nPgktSykCbb7byz/q9Y8G/3rZL59WdEVSy1blVHrpzHpvs1303U1yK0
        WvzCg+LZL/3P5olx//34k+N8kPPPJwd1rx64tPNbu4wc+z6P1deO2pWEZh76/1ta5LQVgxJL
        cUaioRZzUXEiAA1bvw2oAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO6pV4lxBgfWqljMWb+GzWJiv6ZF
        9+aZjBaXd81hs7i35j+rxb9JtQ5sHjtn3WX3WLCp1GPTp0nsHidm/Gbx2Hy62uPzJrkAtigu
        m5TUnMyy1CJ9uwSujM0TX7AULNGo2LZ2InMD4waFLkZODgkBE4lbc7exgdhCArsZJRbP0IGI
        y0i8Of+UpYuRA8gWljh8uLiLkQuo5DWjxLOdu5lAaoQF7CSOTT3CCmKLCOhKrHq+ixmi6BOj
        xLcXa8CGMgvkSrx7Ng3MZhPQlni/YBJYA6+AlsT/WetYQGwWARWJuQtWMIPYogIREqvXXWOG
        qBGUODnzCdgRnALeEmfuFYGYzALqEuvnCUFMl5do3jqbeQKj4CwkDbMQqmYhqVrAyLyKUTK1
        oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM47LW0djCeOBF/iFGAg1GJh1fhc0KcEGtiWXFl
        7iFGCQ5mJRFeYdP4OCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2Cy
        TBycUg2MLJc01ulUbWG6/G/GOxPNZ78jN4ZKlE6U8uO6t+eyf8WJST4lS6z2cAY8KN59ePOT
        HSpJK/dbRYcnx5zcXxa7ba7BBd+V7vpHLLLaLusmmcTMn7pBfGOtRi3Dk69rZ7VKvzNq3ez9
        +6a9zSHVffPydW+V3kt2dl5bK5zb/F3+zZEj3cz3Z2jEKLEUZyQaajEXFScCALgSxgZ3AgAA
X-CMS-MailID: 20200306061642epcas1p15dc9ef2887e3d9d8d706541996221ddd
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020년 03월 06일 13:24, Andrew Morton wrote:
> On Thu, 5 Mar 2020 10:35:05 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>
>> Hello
>>
>> sorry for build warning.
>> I've changed %d to %ld reported by kbuild.
>> Let me attach full patch again below.
>> --------------------------------------------------
>>
>>
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
>> <3>[  576.024088]  [6:  mmap_infinite:14251] mmap: vm_unmapped_area err:-12 total_vm:0xfee08 flags:0x1 len:0xa00000 low:0x8000 high:0xf3f63000
>>
> hm, I suppose that could be useful.  Although the choice of which info
> to display could be a source of dispute.  Why did you choose this info
> and omit other things?  Perhaps a stack trace could also be useful?
I thought info->align_mask, info->align_offset are not important. But I added them too now.
And I think whole stack trace is not essential. In my opinion, higher layer like userspace mmap or other driver
calling to vm_unmapped_area also should report the error if they need.
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2379,10 +2379,19 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
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
>> +    if (IS_ERR_VALUE(addr) && printk_ratelimit()) {
> Please avoid using printk_ratelimit().  See the comment at the
> printk_ratelimit() definition site:
Thank you for your comment. I changed printk_ratelimit to pr_warn_ratelimited.
To use pr_warn_ratelimited I included <linux/ratelimit.h>
>
> /*
>  * Please don't use printk_ratelimit(), because it shares ratelimiting state
>  * with all other unrelated printk_ratelimit() callsites.  Instead use
>  * printk_ratelimited() or plain old __ratelimit().
>  */
>
>> +        pr_err("%s err:%ld total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx\n",
>> +            __func__, addr, current->mm->total_vm, info->flags,
>> +            info->length, info->low_limit, info->high_limit);
>> +    }
>> +    return addr;
>>  }
>
>

Let me attach changed whole patch below.

-------------------

Subject: [PATCH] mm: mmap: show vm_unmapped_area error log

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
<4>[   68.556470]  [2:  mmap_infinite:12363] mmap: vm_unmapped_area err:-12 total_vm:0xf4c08 flags:0x1 len:0x100000 low:0x8000 high:0xf4583000 mask:0x0 offset:0x0

Fixed type mismatching on previous patch which is reported by kbuild.
Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/linux/mm.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..114055d70752 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -27,6 +27,7 @@
 #include <linux/memremap.h>
 #include <linux/overflow.h>
 #include <linux/sizes.h>
+#include <linux/ratelimit.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -2379,10 +2380,20 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
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
+    if (IS_ERR_VALUE(addr)) {
+        pr_warn_ratelimited("%s err:%ld total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx mask:0x%lx offset:0x%lx\n",
+            __func__, addr, current->mm->total_vm, info->flags,
+            info->length, info->low_limit, info->high_limit,
+            info->align_mask, info->align_offset);
+    }
+    return addr;
 }
