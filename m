Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB1EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B578C2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ou2+hLOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389878AbgFYFtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:49:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7510 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389617AbgFYFtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:49:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef43aa10000>; Wed, 24 Jun 2020 22:48:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jun 2020 22:49:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jun 2020 22:49:03 -0700
Received: from [10.2.59.206] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jun
 2020 05:49:02 +0000
Subject: Re: [PATCH 2/2] xen/privcmd: Convert get_user_pages*() to
 pin_user_pages*()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        Paul Durrant <xadimgnik@gmail.com>
References: <1593054160-12628-1-git-send-email-jrdr.linux@gmail.com>
 <1593054160-12628-2-git-send-email-jrdr.linux@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <59afe2fe-3718-85aa-f3b5-83ca0b9df577@nvidia.com>
Date:   Wed, 24 Jun 2020 22:49:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593054160-12628-2-git-send-email-jrdr.linux@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593064097; bh=hWnF3N0wCKATLkkSfY0YFbwq7TYcYG70FRiPZLz+TCA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ou2+hLOaCBz5atm+9GHKtzk2bsBzKjQpsnvnwY2SlNbHVBzzL+/gQ3IF+qLThXkSb
         u4uehwdHRm+7H+ISGqx9LuSs62EgWyvSOnyTPq8gAuSVnA/OmC6ysPb59sBzr2usdn
         aEnDnmC1GhNwFrZOk7VLroiVZqtLYB/tiUXMSSh+8+G09UySSwK17c44IFFvw+C4jE
         YokJFSjzFST3CpV1TMAJWqlA8A1sPBaZzZBJ1cjuOYLmTIlxudkBQePekA1XbpiYMy
         yiKYBAWwKB7/h5LGmYbn844WExZQR3Zep0YtJkMbmQg5w/QxcCBpmdh/1Epgu/kxJ1
         H2nDpVqD51F+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 20:02, Souptick Joarder wrote:
> In 2019, we introduced pin_user_pages*() and now we are converting
> get_user_pages*() to the new API as appropriate. [1] & [2] could
> be referred for more information. This is case 5 as per document [1].
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>          https://lwn.net/Articles/807108/
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Paul Durrant <xadimgnik@gmail.com>
> ---
> Hi,
> 
> I'm compile tested this, but unable to run-time test, so any testing
> help is much appriciated.
> 
>   drivers/xen/privcmd.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index 0da417c..eb05254 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -595,7 +595,7 @@ static int lock_pages(
>   		if (requested > nr_pages)
>   			return -ENOSPC;
>   
> -		page_count = get_user_pages_fast(
> +		page_count = pin_user_pages_fast(
>   			(unsigned long) kbufs[i].uptr,
>   			requested, FOLL_WRITE, pages);
>   		if (page_count < 0) {
> @@ -612,13 +612,7 @@ static int lock_pages(
>   
>   static void unlock_pages(struct page *pages[], unsigned int nr_pages)
>   {
> -	unsigned int i;
> -
> -	for (i = 0; i < nr_pages; i++) {
> -		if (!PageDirty(page))
> -			set_page_dirty_lock(page);
> -		put_page(pages[i]);
> -	}
> +	unpin_user_pages_dirty_lock(pages, nr_pages, 1);

"true", not "1", is the correct way to call that function.

Also, this approach changes the behavior slightly, but I think it's
reasonable to just set_page_dirty_lock() on the whole range--hard to
see much benefit in checking PageDirty first.


>   }
>   
>   static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
> 

thanks,
-- 
John Hubbard
NVIDIA
