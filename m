Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270ACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEC020FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m3xSbxSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgFPNO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:14:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43958 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgFPNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:14:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GDBOeP133417;
        Tue, 16 Jun 2020 13:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qCwHLgGDJGYtof/VU1ESrOwhoFFyi44I/rNwbgIZF0A=;
 b=m3xSbxSp6U/DI1O01qDc5H0GkuhmIxx9OewQ+w24m3+rIZODeK7bh4aSlcfsrXCpVLRk
 qmgigNLZ93FyD5bccBRmHhFq/qhUKah7lCPHA4yo59IW80g/ma3PZaF6YFnDBQ/HTm0d
 nnOu7lCFxGdOUee9OxYeVsvp+VB366EyRBFvGjfKXCqmolRv61bZL19qGH4yWd81hiXK
 i/Y8JDTmxsGbUQI5jG0ye0uFtezE0OUBVkdnnpT5VY2ozgZSv/oz4aV9+Z54TvCQNpAT
 k6fNtNz6qOIxegGI4/Dzi7NSqGmV7xq3BXE1v9yQIwIgKAZs12OLipMxKvtW6TcbSPMS rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31p6e5xqb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 13:14:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GDD6NZ080499;
        Tue, 16 Jun 2020 13:14:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31p6s764g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 13:14:51 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05GDEpIa017109;
        Tue, 16 Jun 2020 13:14:51 GMT
Received: from [10.175.44.246] (/10.175.44.246)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 06:14:51 -0700
Subject: Re: [merged] exec-open-code-copy_string_kernel.patch removed from -mm
 tree
To:     linux-kernel@vger.kernel.org, hch@lst.de,
        mm-commits@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200605201952.V2waw9dhw%akpm@linux-foundation.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <079d08bb-f8de-e119-a427-4ff0274f4616@oracle.com>
Date:   Tue, 16 Jun 2020 15:14:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605201952.V2waw9dhw%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-06-05 22:19, akpm@linux-foundation.org wrote:
> The patch titled
>       Subject: exec: open code copy_string_kernel
> has been removed from the -mm tree.  Its filename was
>       exec-open-code-copy_string_kernel.patch
> 
> This patch was dropped because it was merged into mainline or a subsystem tree
> 
> ------------------------------------------------------
> From: Christoph Hellwig <hch@lst.de>
> Subject: exec: open code copy_string_kernel
> 
> Currently copy_string_kernel is just a wrapper around copy_strings that
> simplifies the calling conventions and uses set_fs to allow passing a
> kernel pointer.  But due to the fact the we only need to handle a single
> kernel argument pointer, the logic can be sigificantly simplified while
> getting rid of the set_fs.
> 
> Link: http://lkml.kernel.org/r/20200501104105.2621149-3-hch@lst.de
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   fs/exec.c |   45 +++++++++++++++++++++++++++++++++++----------
>   1 file changed, 35 insertions(+), 10 deletions(-)
> 
> --- a/fs/exec.c~exec-open-code-copy_string_kernel
> +++ a/fs/exec.c
> @@ -592,17 +592,42 @@ out:
>    */
>   int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
>   {
> -	int r;
> -	mm_segment_t oldfs = get_fs();
> -	struct user_arg_ptr argv = {
> -		.ptr.native = (const char __user *const  __user *)&arg,
> -	};
> -
> -	set_fs(KERNEL_DS);
> -	r = copy_strings(1, argv, bprm);
> -	set_fs(oldfs);
> +	int len = strnlen(arg, MAX_ARG_STRLEN) + 1 /* terminating NUL */;
> +	unsigned long pos = bprm->p;
>   
> -	return r;
> +	if (len == 0)
> +		return -EFAULT;

Just a quick question, how can len ever be 0 here when len was set to
strnlen() + 1? Should the test be different?

The old version (i.e. copy_strings()) seems to return -EFAULT when
strnlen() returns 0.


Vegard

> +	if (!valid_arg_len(bprm, len))
> +		return -E2BIG;
> +
> +	/* We're going to work our way backwards. */
> +	arg += len;
> +	bprm->p -= len;
> +	if (IS_ENABLED(CONFIG_MMU) && bprm->p < bprm->argmin)
> +		return -E2BIG;
> +
> +	while (len > 0) {
> +		unsigned int bytes_to_copy = min_t(unsigned int, len,
> +				min_not_zero(offset_in_page(pos), PAGE_SIZE));
> +		struct page *page;
> +		char *kaddr;
> +
> +		pos -= bytes_to_copy;
> +		arg -= bytes_to_copy;
> +		len -= bytes_to_copy;
> +
> +		page = get_arg_page(bprm, pos, 1);
> +		if (!page)
> +			return -E2BIG;
> +		kaddr = kmap_atomic(page);
> +		flush_arg_page(bprm, pos & PAGE_MASK, page);
> +		memcpy(kaddr + offset_in_page(pos), arg, bytes_to_copy);
> +		flush_kernel_dcache_page(page);
> +		kunmap_atomic(kaddr);
> +		put_arg_page(page);
> +	}
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL(copy_string_kernel);
>   
