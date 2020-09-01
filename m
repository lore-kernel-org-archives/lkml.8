Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A8C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24592078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fliXsxSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgIAVaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:30:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7168 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgIAVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:30:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4ebceb0001>; Tue, 01 Sep 2020 14:28:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 14:30:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 14:30:19 -0700
Received: from [10.2.63.6] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Sep
 2020 21:30:18 +0000
Subject: Re: [linux-next PATCH v4] drivers/virt/fsl_hypervisor: Fix error
 handling path
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <jgg@ziepe.ca>, <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>, <timur@freescale.com>,
        <linux-kernel@vger.kernel.org>, <dan.carpenter@oracle.com>
References: <1598995271-6755-1-git-send-email-jrdr.linux@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a3b36dfa-b7bb-e69b-95d5-e7d6dd7bda3f@nvidia.com>
Date:   Tue, 1 Sep 2020 14:30:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1598995271-6755-1-git-send-email-jrdr.linux@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598995692; bh=bJ0AvRFOeKaBU0OzseOoDtmXAo41HBvW7nwl0IHgiTM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fliXsxSNeIMqSZY5YVw5jSsPl3+0/o5IRA+9EANbQp/zIWqN7jXavd/VGcgfvvkxY
         96SNMi66eENkdctZA7PsGz9omeatFHMhYWr75tqs10szH1gVscU+98pz7KU2gyHubo
         +GURvE4r+FL3gzEJ8/Qk8smFSd8Jg93BHC5NkcyD00g4+EeskX++jCc/pHNu/LxKR0
         u1rdcpHsqZEL8/yW/c0or76mxgBQqYYL4KhiU7F/3eIpSQsh4bc2f91YFuiCQHyREn
         bamDRByrNDWAnfF+tqYb43UVsy76hNCcqZalzNXlyVeiAjRu5rfovf2WywQnTegb3d
         4XHqWpjhWzXhA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 2:21 PM, Souptick Joarder wrote:
> First, when memory allocation for sg_list_unaligned failed, there
> is a bug of calling put_pages() as we haven't pinned any pages.
> 
> Second, if get_user_pages_fast() failed we should unpin num_pinned
> pages.
> 
> This will address both.
> 
> As part of these changes, minor update in documentation.
> 
> Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor
> management driver")
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---

This looks good to me.

thanks,
-- 
John Hubbard
NVIDIA

> v2:
>     Added review tag.
> 
> v3:
>     Address review comment on v2 from John.
>     Added review tag.
> 
> v4:
>    Address another set of review comments from John.
> 
>   drivers/virt/fsl_hypervisor.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
> index 1b0b11b..46ee0a0 100644
> --- a/drivers/virt/fsl_hypervisor.c
> +++ b/drivers/virt/fsl_hypervisor.c
> @@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   
>   	unsigned int i;
>   	long ret = 0;
> -	int num_pinned; /* return value from get_user_pages() */
> +	int num_pinned = 0; /* return value from get_user_pages_fast() */
>   	phys_addr_t remote_paddr; /* The next address in the remote buffer */
>   	uint32_t count; /* The number of bytes left to copy */
>   
> @@ -174,7 +174,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   		return -EINVAL;
>   
>   	/*
> -	 * The array of pages returned by get_user_pages() covers only
> +	 * The array of pages returned by get_user_pages_fast() covers only
>   	 * page-aligned memory.  Since the user buffer is probably not
>   	 * page-aligned, we need to handle the discrepancy.
>   	 *
> @@ -224,7 +224,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   
>   	/*
>   	 * 'pages' is an array of struct page pointers that's initialized by
> -	 * get_user_pages().
> +	 * get_user_pages_fast().
>   	 */
>   	pages = kcalloc(num_pages, sizeof(struct page *), GFP_KERNEL);
>   	if (!pages) {
> @@ -241,7 +241,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   	if (!sg_list_unaligned) {
>   		pr_debug("fsl-hv: could not allocate S/G list\n");
>   		ret = -ENOMEM;
> -		goto exit;
> +		goto free_pages;
>   	}
>   	sg_list = PTR_ALIGN(sg_list_unaligned, sizeof(struct fh_sg_list));
>   
> @@ -250,7 +250,6 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   		num_pages, param.source != -1 ? FOLL_WRITE : 0, pages);
>   
>   	if (num_pinned != num_pages) {
> -		/* get_user_pages() failed */
>   		pr_debug("fsl-hv: could not lock source buffer\n");
>   		ret = (num_pinned < 0) ? num_pinned : -EFAULT;
>   		goto exit;
> @@ -292,13 +291,13 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   		virt_to_phys(sg_list), num_pages);
>   
>   exit:
> -	if (pages) {
> -		for (i = 0; i < num_pages; i++)
> -			if (pages[i])
> -				put_page(pages[i]);
> +	if (pages && (num_pinned > 0)) {
> +		for (i = 0; i < num_pinned; i++)
> +			put_page(pages[i]);
>   	}
>   
>   	kfree(sg_list_unaligned);
> +free_pages:
>   	kfree(pages);
>   
>   	if (!ret)
> 

