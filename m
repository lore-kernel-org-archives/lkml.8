Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515E8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5FF2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s+HlAHIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgEOSo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:44:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36544 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgEOSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:44:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FIfCOb178670;
        Fri, 15 May 2020 18:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Y1ZB+quIhLJg/wI83w/JcQWCUY7lLmfngECGZeGD7Qw=;
 b=s+HlAHIPyQCCPgI79KUBi0mXkKY31ZTyRycJJyB/gvouDXFKcAYsPpM6uYXLgqcpX1pl
 XfzL/196Zn4ZLeWimyKbZvIh7oYxJFqygnxRS97lyWz9ReokJK/ckVpThusqg+yUUFvm
 Y9z4DNXvQItUynOHb5BBaaoq/zX4u50UMmJurWZPPbuPkTT7sQDKZkllDy22jNYC8r9M
 svrW2+RCwDjeRBCEbOO1B8X+8z22GLXMl/e4m53g6E6hLwBA8mbD53NmK9FD+R6vjDwr
 lTuiyftajPeLHggDyVTD4Wix3Z4QykOJHr8U8zY86HDihgjM+KrhQPAyezP6E6E3r7+q ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 311nu5n96d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 18:44:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FIiCMR043342;
        Fri, 15 May 2020 18:44:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3100yfajvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 18:44:13 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04FIi57v017411;
        Fri, 15 May 2020 18:44:06 GMT
Received: from [192.168.2.157] (/50.38.34.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 May 2020 11:44:05 -0700
Subject: Re: [PATCH v5] hugetlbfs: Get unmapped area below TASK_UNMAPPED_BASE
 for hugetlbfs
To:     Shijie Hu <hushijie3@huawei.com>
Cc:     will@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nixiaoming@huawei.com,
        wangxu72@huawei.com, wangkefeng.wang@huawei.com,
        yangerkun@huawei.com, wangle6@huawei.com, cg.chen@huawei.com,
        chenjie6@huawei.com, alex.huangjianhui@huawei.com
References: <20200514143134.73775-1-hushijie3@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e458014c-57a7-46a5-3528-2b33f23a6756@oracle.com>
Date:   Fri, 15 May 2020 11:44:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514143134.73775-1-hushijie3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9622 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9622 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 cotscore=-2147483648
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005150156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 7:31 AM, Shijie Hu wrote:
> Here is a final patch to solve that hugetlb_get_unmapped_area() can't
> get unmapped area below mmap base for huge pages based on a few previous
> discussions and patches from me.
> 
> I'm so sorry. When sending v2 and v3 patches, I forget to cc:
> linux-mm@kvack.org and linux-kernel@vger.kernel.org. No records of these
> two patches found on the https://lkml.org/lkml/.
> 
> Patch V1: https://lkml.org/lkml/2020/4/27/440
> Patch V4: https://lkml.org/lkml/2020/5/13/980
> 
> Changes in V2:
> * Follow Mike's suggestions, move hugetlb_get_unmapped_area() routines
> from "fs/hugetlbfs/inode.c" to "arch/arm64/mm/hugetlbpage.c", without
> changing core code.
> * Add mmap_is_legacy() function, and only fall back to the bottom-up
> function on no-legacy mode.
> 
> Changes in V3:
> * Add *bottomup() and *topdown() two function, and check if
> mm->get_unmapped_area is equal to arch_get_unmapped_area() instead of
> checking mmap_is_legacy() to determine which function should be used.
> 
> Changes in V4:
> * Follow the suggestions of Will and Mike, move back this patch to core
> code.
> 
> Changes in V5:
> * Fix kbuild test error.
> 
> ------
> 
> In a 32-bit program, running on arm64 architecture. When the address
> space below mmap base is completely exhausted, shmat() for huge pages
> will return ENOMEM, but shmat() for normal pages can still success on
> no-legacy mode. This seems not fair.
> 
> For normal pages, get_unmapped_area() calling flows are:
>     => mm->get_unmapped_area()
> 	if on legacy mode,
> 	    => arch_get_unmapped_area()
> 			=> vm_unmapped_area()
> 	if on no-legacy mode,
> 	    => arch_get_unmapped_area_topdown()
> 			=> vm_unmapped_area()
> 
> For huge pages, get_unmapped_area() calling flows are:
>     => file->f_op->get_unmapped_area()
> 		=> hugetlb_get_unmapped_area()
> 			=> vm_unmapped_area()
> 
> To solve this issue, we only need to make hugetlb_get_unmapped_area() take
> the same way as mm->get_unmapped_area(). Add *bottomup() and *topdown()
> two functions, and check current mm->get_unmapped_area() to decide which
> one to use. If mm->get_unmapped_area is equal to arch_get_unmapped_area(),
> hugetlb_get_unmapped_area() calls bottomup routine, otherwise calls topdown
> routine.
> 
> Signed-off-by: Shijie Hu <hushijie3@huawei.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  fs/hugetlbfs/inode.c | 62 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 991c60c7ffe0..61418380f492 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -38,6 +38,7 @@
>  #include <linux/uio.h>
>  
>  #include <linux/uaccess.h>
> +#include <linux/sched/mm.h>
>  
>  static const struct super_operations hugetlbfs_ops;
>  static const struct address_space_operations hugetlbfs_aops;
> @@ -191,13 +192,60 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  
>  #ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
>  static unsigned long
> +hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
> +		unsigned long len, unsigned long pgoff, unsigned long flags)
> +{
> +	struct hstate *h = hstate_file(file);
> +	struct vm_unmapped_area_info info;
> +
> +	info.flags = 0;
> +	info.length = len;
> +	info.low_limit = current->mm->mmap_base;
> +	info.high_limit = TASK_SIZE;
> +	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
> +	info.align_offset = 0;
> +	return vm_unmapped_area(&info);
> +}
> +
> +static unsigned long
> +hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
> +		unsigned long len, unsigned long pgoff, unsigned long flags)
> +{
> +	struct hstate *h = hstate_file(file);
> +	struct vm_unmapped_area_info info;
> +
> +	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> +	info.length = len;
> +	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
> +	info.high_limit = current->mm->mmap_base;
> +	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
> +	info.align_offset = 0;
> +	addr = vm_unmapped_area(&info);
> +
> +	/*
> +	 * A failed mmap() very likely causes application failure,
> +	 * so fall back to the bottom-up function here. This scenario
> +	 * can happen with large stack limits and large mmap()
> +	 * allocations.
> +	 */
> +	if (unlikely(offset_in_page(addr))) {
> +		VM_BUG_ON(addr != -ENOMEM);
> +		info.flags = 0;
> +		info.low_limit = current->mm->mmap_base;
> +		info.high_limit = TASK_SIZE;
> +		addr = vm_unmapped_area(&info);
> +	}
> +
> +	return addr;
> +}
> +
> +static unsigned long
>  hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  		unsigned long len, unsigned long pgoff, unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	struct hstate *h = hstate_file(file);
> -	struct vm_unmapped_area_info info;
>  
>  	if (len & ~huge_page_mask(h))
>  		return -EINVAL;
> @@ -218,13 +266,11 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  			return addr;
>  	}
>  
> -	info.flags = 0;
> -	info.length = len;
> -	info.low_limit = TASK_UNMAPPED_BASE;
> -	info.high_limit = TASK_SIZE;
> -	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
> -	info.align_offset = 0;
> -	return vm_unmapped_area(&info);
> +	if (mm->get_unmapped_area == arch_get_unmapped_area)
> +		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
> +				pgoff, flags);
> +	return hugetlb_get_unmapped_area_topdown(file, addr, len,
> +			pgoff, flags);

I like this code using the value of mm->get_unmapped_area to determine
which routine to call.  It is used by a few architectures.   However, I
noticed that on at least one architecture (powerpc) mm->get_unmapped_area
may be assigned to routines other than arch_get_unmapped_area or
arch_get_unmapped_area_topdown.  In such a case, we would call the 'new'
topdown routine.  I would prefer that we call the bottomup routine in this
default case.

In reality, this does not impact powerpc as that architecture has it's
own hugetlb_get_unmapped_area routine.

Because of this, I suggest we add a comment above this code and switch
the if/else order.  For example,

+       /*
+        * Use mm->get_unmapped_area value as a hint to use topdown routine.
+        * If architectures have special needs, they should define their own
+        * version of hugetlb_get_unmapped_area.
+        */
+       if (mm->get_unmapped_area == arch_get_unmapped_area_topdown)
+               return hugetlb_get_unmapped_area_topdown(file, addr, len,
+                               pgoff, flags);
+       return hugetlb_get_unmapped_area_bottomup(file, addr, len,
+                       pgoff, flags);


Thoughts?
-- 
Mike Kravetz


>  }
>  #endif
>  
> 
