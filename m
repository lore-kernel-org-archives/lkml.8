Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BBDC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4982420732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DyVBqO5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJTZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:25:16 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2299 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJTZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:25:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e90c7b20000>; Fri, 10 Apr 2020 12:23:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Apr 2020 12:25:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Apr 2020 12:25:15 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 19:25:15 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 10 Apr 2020 19:25:15 +0000
Subject: Re: [PATCH] mm: ksm: Fix a typo in comment "alreaady"->"already"
To:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200410162427.13927-1-ethp@qq.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f22aed5e-174f-7908-04fd-4be7da6f2827@nvidia.com>
Date:   Fri, 10 Apr 2020 12:25:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200410162427.13927-1-ethp@qq.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586546611; bh=Kaknvfscwtzkixhoi00aANWLRo6OoWqfw+t1zrV+N0I=;
        h=X-PGP-Universal:Subject:To:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DyVBqO5ZkYGE/aJg6aDaW+f99I6jWQipoSvS7xTWpIibqKcVke+iwkarcr99DjogM
         XvoLA5cri6v2dUVPXwB8seq8ucPlpg34cA4fckGABfUyTPlAD0PgmUuowITEj/Eimu
         e/xwlCnN4pkPtswmZD4/hx3DWSXJYZcp5P2B5gxU5TcjY1xJi0okJdg3gBT2K00s90
         FnC+E55jVOkBGOUG1cFqx+pULsDelWfgVffCrVdnAYt6OpQYXR74M/tvpIworfHgzY
         Ea+hAzCiP7sfTi+BgsYP8wnbMznEicwvezbfm2HnmskuRlaX3UhumnV56EyxHf1AXt
         8L5JnInBW4IdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/20 9:24 AM, Ethon Paul wrote:
> There is a typo in comment, fix it.
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

Maybe also change line 615, 1846, s/wrprotected/write protected
and line 2004, s/undeflow/underflow

> ---
>   mm/ksm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index a558da9e7177..7ff8fc180a4b 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1148,7 +1148,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>   
>   	/*
>   	 * No need to check ksm_use_zero_pages here: we can only have a
> -	 * zero_page here if ksm_use_zero_pages was enabled alreaady.
> +	 * zero_page here if ksm_use_zero_pages was enabled already.
>   	 */
>   	if (!is_zero_pfn(page_to_pfn(kpage))) {
>   		get_page(kpage);
> 
