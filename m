Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1960C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98826208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fzK/KHQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgEAVdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:33:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7746 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:33:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eac95770000>; Fri, 01 May 2020 14:32:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 May 2020 14:33:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 May 2020 14:33:46 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 1 May
 2020 21:33:46 +0000
Received: from [10.2.55.159] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 1 May 2020
 21:33:46 +0000
Subject: Re: [PATCH] mm/gup.c: Handle error at earliest for incorrect nr_pages
 value
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1588277518-21425-1-git-send-email-jrdr.linux@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c25cf212-8684-a107-bc9c-c7067dea7447@nvidia.com>
Date:   Fri, 1 May 2020 14:33:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588277518-21425-1-git-send-email-jrdr.linux@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588368759; bh=/ss50mYtclSvHtRZUxtjzklZeDRr5uBZhGcufaww9YQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fzK/KHQnVa/a6WZRuvTdd3i9GOn1hnFmBgNAX7C8VTnV8Vy9YGPiHtsyzcq7dFHSQ
         tLcOa12Ng3TZAe9DuDCBKayi0igPsizn0cdbOk41LB+1IZ2hwcELvaW5qa5DXqzB9c
         Gxir0rmabitEWeAX7fK2vHn2fdOx8NAEZkBuvB5ODs8YKyOVq2y/WsZgHLZqR+JQNy
         BqFKI4+gylvLuK1OYmuGa/3tp09hoB+KOtGM9dqU40pFm559EBkLnr9jQ4xNFb+RoN
         vsXi7nt+tw6aAb0nBucSt3qRkI0tX0ONqS0uulbdTAqcqV7fR7rUQfj6tO6eWiOJEi
         jfL/+ugqsykeA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-30 13:11, Souptick Joarder wrote:
> As per documentation, pin_user_pages_fast() & get_user_pages_fast()
> will return 0, if nr_pages <= 0. But this can be figure out only after
> going inside the internal_get_user_pages_fast().
> 
> This can be handled early. Adding a check for the same.


Please, no. For precisely the reasons that Andrew gave: you are
attempting to optimize for a case that doesn't matter other than
for error handling, and which is already handled adequately. And
as he also pointed out, it very slightly UN-optimizes the path that
we *do* care about. So why are you still advocating for this?

If you want to change the gup/pup API so that asking for zero pages
means -EINVAL, then fine, go for it. That's a large thing, and a
tree-wide audit, but if you feel it's worth pursuing then it's at
least consistent.

But this patch here needs to be abandoned.


thanks,
-- 
John Hubbard
NVIDIA

> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>   mm/gup.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 50681f0..a13aaa6 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2817,6 +2817,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>   	 */
>   	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
>   		return -EINVAL;
> +	if (nr_pages <= 0)
> +		return 0;
>   
>   	/*
>   	 * The caller may or may not have explicitly set FOLL_GET; either way is
> @@ -2854,6 +2856,8 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
>   	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>   	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>   		return -EINVAL;
> +	if (nr_pages <= 0)
> +		return 0;
>   
>   	gup_flags |= FOLL_PIN;
>   	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
> 

