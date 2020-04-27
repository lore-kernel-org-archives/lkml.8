Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29392C82292
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05FBA20661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jhxjU7Ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgD0Wsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:48:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgD0Wsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:48:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RMgMxr003933;
        Mon, 27 Apr 2020 22:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=pKFgRX6d5w2uEwX24diTeOL/7/mmULPy7AZ+rAdkL+w=;
 b=jhxjU7Cho0JPwo5yxwWthzriIOcFeZLrDWxPjEzIMtp+90rv1bKQ+AyfDUg0gfCIjRDV
 YsHKy5BNP+1G2m/JQLJOESdCo3IQrK6iC3mdQjOZWA5AKLiq/tnlfEd1HGhwboFF1FW9
 r/yI3g+wzTtqiEoldWvmnIsCTpuyR1r8+KnQkZiBzoLCfv7Kg00kmgHdDn9nbtJwIWwP
 0DBuA9GS3IMkHV6T7KSJAkYcfm3jAWc5Ec+v4t1yOhC2RCuDbHN8XZEC6BW5eOSvnAV0
 HHspe/9dBN1EoK1V2TfNb+8ZsRggjN9I1AmW8GjpYxnCZHbvy4BdWNOgYLTsdSHy1CKS EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30p2p01vva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 22:48:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RMciTW113021;
        Mon, 27 Apr 2020 22:46:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30mxpe95vn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 22:46:31 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03RMkUTd010592;
        Mon, 27 Apr 2020 22:46:30 GMT
Received: from [192.168.2.157] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 15:46:30 -0700
Subject: Re: [PATCH] [RFC]hugetlbfs: Get unmapped area below
 TASK_UNMAPPED_BASE for hugetlbfs
To:     Shijie Hu <hushijie3@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        nixiaoming@huawei.com, wangxu72@huawei.com,
        wangkefeng.wang@huawei.com, yangerkun@huawei.com,
        wangle6@huawei.com, cg.chen@huawei.com
References: <20200427111036.74983-1-hushijie3@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <68031cc2-e6dc-52ee-9bdc-ffb9e154fb1c@oracle.com>
Date:   Mon, 27 Apr 2020 15:46:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427111036.74983-1-hushijie3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=983 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 4:10 AM, Shijie Hu wrote:
> In 32-bit programs, the address space is limited. When the normal mmap
> consumes the space above TASK_UNMAPPED_BASE on legacy mode, it can still
> successfully obtain unmapped area below TASK_UNMAPPED_BASE, but mmap or
> shmat for huge pages will fail. This seems "not fair".
> 
> When the request for huge pages fails, fall back to reuse mmap_min_addr
> ~ TASK_UNMAPPED_BASE for hugetlbfs.

Just curious.  Have you actually seeing a problem with this code, or is
the reason for the proposed change just the result of code inspection?  I ask
because many architectures have their own version of hugetlb_get_unmapped_area.
So, if you are seeing this issue it would be interesting to know what
architecture you are running.

The routine hugetlb_get_unmapped_area has not changed much since this first
git version.  I suspect this is because it is mostly unused.

I noticed that hugetlb_get_unmapped_area is one of only a few places in arch
independent code calling vm_unmapped_area().  The other callers are arch
independent fall back routines for arch_get_unmapped_area* routines.  If we
move forward with changes to this routine, would it make more sense to use
the arch_get_unmapped_area* routines instead of calling vm_unmapped_area
directly?  This would take advantage of any arch specific if it exists.

-- 
Mike Kravetz

> 
> Signed-off-by: Shijie Hu <hushijie3@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index aff8642f0c2e..0f5997394aaa 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -224,7 +224,21 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	info.high_limit = TASK_SIZE;
>  	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
>  	info.align_offset = 0;
> -	return vm_unmapped_area(&info);
> +	addr = vm_unmapped_area(&info);
> +
> +	/*
> +	 * A failed request for huge pages very likely causes application
> +	 * failure, so fall back to the top-down function here.
> +	 */
> +	if (unlikely(offset_in_page(addr))) {
> +		VM_BUG_ON(addr != -ENOMEM);
> +		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> +		info.low_limit = max(PAGE_SIZE, mmap_min_addr);
> +		info.high_limit = TASK_UNMAPPED_BASE;
> +		addr = vm_unmapped_area(&info);
> +	}
> +
> +	return addr;
>  }
>  #endif
>  
> 
