Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B4C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09C920E65
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IZsks4VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHaW61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:58:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19977 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHaW6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:58:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d80100002>; Mon, 31 Aug 2020 15:56:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 15:58:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 15:58:22 -0700
Received: from [10.2.61.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 22:58:19 +0000
Subject: Re: [linux-next PATCH v3] drivers/virt/fsl_hypervisor: Fix error
 handling path
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <jgg@ziepe.ca>, <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
        <timur@freescale.com>, <galak@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>
References: <1598911668-6178-1-git-send-email-jrdr.linux@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <82329783-739b-a315-8957-2c49a3ab1350@nvidia.com>
Date:   Mon, 31 Aug 2020 15:58:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1598911668-6178-1-git-send-email-jrdr.linux@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598914576; bh=TGbcOgWMBQrR6HoM9TqhW7DLJxby0yalp8RA7tyq11I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IZsks4VG2MbZ+4dX+lLjarLc9qeUz+mXVNRwhF+IivrMtmHZ4TJtDQG5e5FSeZj8S
         WLu3Cub+0Z/SDyXKc4kSfZCtXdXf5r1XSrMQGgl1ps+3QrX20/E6mSqyaMvfl+7Hpq
         7W015RHgK+pYBI7OUifKE7d0kjiUE3TNqM8SnMysDSFOXYWlteRc9tQ82osoLk2A/D
         UDyPvq6/y6DQZbDVlXDP5kXmMsRsfBOLBVlOr08fVB+iGIQIlExvwYl0FYr+c3i0nU
         cdx01Wwx1kOwds82D9pqoJeXMCL7JM1muKdVb2dDUxmekMh/Z2EFVaQVf+JMalaAjB
         Tn5xAhMXqqM9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 3:07 PM, Souptick Joarder wrote:
> First, when memory allocation for sg_list_unaligned failed, there
> is a bug of calling put_pages() as we haven't pinned any pages.

"we should unpin"

...
>   
> @@ -250,7 +250,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   		num_pages, param.source != -1 ? FOLL_WRITE : 0, pages);
>   
>   	if (num_pinned != num_pages) {
> -		/* get_user_pages() failed */
> +		/* get_user_pages_fast() failed */

Let's please just delete that particular comment entirely. It's of
questionable accuracy (partial success is allowed with this API), and it
is echoing the code too closely to be worth the line that it consumes.

More importantly, though, we need to split up the cases of gup_fast
returning a negative value, and a zero or positive value. Either here,
or at "exit:", the negative return case should just skip any attempt to
do any put_page() calls at all. Because it's a maintenance hazard to
leave in a loop that depends on looping from zero, to -ERRNO, and *not*
doing any loops--especially in the signed/unsigned soupy mess around gup
calls.


>   		pr_debug("fsl-hv: could not lock source buffer\n");
>   		ret = (num_pinned < 0) ? num_pinned : -EFAULT;
>   		goto exit;
> @@ -293,12 +293,12 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>   
>   exit:
>   	if (pages) {
> -		for (i = 0; i < num_pages; i++)
> -			if (pages[i])
> -				put_page(pages[i]);
> +		for (i = 0; i < num_pinned; i++)
> +			put_page(pages[i]);

Looks correct. I sometimes wonder why more callers don't use
release_pages() in situations like this, but that's beyond the scope of
your work here.


thanks,
-- 
John Hubbard
NVIDIA
