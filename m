Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B677EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D02F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 01:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gEILaMts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgG3BAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 21:00:12 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4279 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgG3BAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:00:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f221b6d0000>; Wed, 29 Jul 2020 17:59:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 18:00:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jul 2020 18:00:11 -0700
Received: from [10.2.54.252] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jul
 2020 01:00:10 +0000
Subject: Re: [PATCH v2] drivers/virt/fsl_hypervisor: Correcting error handling
 path
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <jgg@ziepe.ca>, <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>, <mchehab+samsung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.carpenter@oracle.com>
References: <1596049269-14950-1-git-send-email-jrdr.linux@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <692e6a9b-6caa-7c60-d685-6cc951ee9483@nvidia.com>
Date:   Wed, 29 Jul 2020 18:00:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596049269-14950-1-git-send-email-jrdr.linux@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596070766; bh=xf06fm8gUfOPKwbhKrIi//8iK9C11cakFrO0HCloz2Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gEILaMtsYMRkmmzOYkBKoUCW7ORe8sHzQ8Z17ZgXXwwz0S76K7qDAtKdRxv4gVJ4T
         JkIX7lu9uE7lMqJXFV/SRAWAtkubxpQAI3mIQxanlUVPQ0R2cfbW2QHDxyAZLbJcGd
         QNrHuAl3p/V9zn2+Phib2hwDJdq7/T4N5kvGIZqvVPcgiyczHaesiVwhm8PxYHRNgP
         k9NTWViRX3Ts7xm8jDWmBdKzRhyOCHBSYjCnlnMpXN/FTG6zi0PtOZlxXuzOXF8reS
         WnwLka1cjwXx98OgOx1QoDi7Efmmmiy1QL2siEwC3R3g8vGgq+87Yys5OzYyTsqnzD
         LluOq8d8kVNbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 12:01 PM, Souptick Joarder wrote:
> First, when memory allocation for sg_list_unaligned failed, there
> is no point of calling put_pages() as we haven't pinned any pages.
> 
> Second, if get_user_pages_fast() failed we should unpinned num_pinned
> pages, no point of checking till num_pages.

Hi Souptick,

For both of the above, the wording "no point" is so overly gentle as
to be misleading. That's because calling put_page() on any pages beyond
num_pinned is a *bug*.

So let's reword that. And let's change the patch subject from "Correcting" to
"fix".

And probably good to add a Fixes: tag, too.

More:

> 
> This will address both.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
> v2:
> 	Added review tag.
> 
>   drivers/virt/fsl_hypervisor.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
> index 1b0b11b..ea344d7 100644
> --- a/drivers/virt/fsl_hypervisor.c
> +++ b/drivers/virt/fsl_hypervisor.c
> @@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   
>   	unsigned int i;
>   	long ret = 0;
> -	int num_pinned; /* return value from get_user_pages() */
> +	int num_pinned = 0; /* return value from get_user_pages() */
>   	phys_addr_t remote_paddr; /* The next address in the remote buffer */
>   	uint32_t count; /* The number of bytes left to copy */
>   
> @@ -293,7 +293,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   
>   exit:
>   	if (pages) {
> -		for (i = 0; i < num_pages; i++)
> +		for (i = 0; i < num_pinned; i++)
>   			if (pages[i])

I suspect that this "if" is unnecessary now.

Either way, the diff itself looks good to me, so with the wording changes to
the commit description, you can add:

     Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

>   				put_page(pages[i]);
>   	}
> 

