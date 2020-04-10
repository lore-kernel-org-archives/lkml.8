Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C7AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756DE20732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QDmuuTca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDJTAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:00:43 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1954 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgDJTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:00:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e90c24e0000>; Fri, 10 Apr 2020 12:00:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Apr 2020 12:00:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Apr 2020 12:00:43 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 19:00:43 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 19:00:42 +0000
Subject: Re: [PATCH] mm: mmap: Fix a typo in comment
 "compatbility"->"compatibility"
To:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200410163206.14016-1-ethp@qq.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <fe7aba6e-3fc0-1c9d-c18e-d1179a7e9dfe@nvidia.com>
Date:   Fri, 10 Apr 2020 12:00:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200410163206.14016-1-ethp@qq.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586545230; bh=8kdNTTwtIm8EhuVGWiIb+CzxLfpi2hgYnUNz95DqTuU=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QDmuuTcaaVKtW/VCiLZUT2KLttqzbJ8KKT5nBnoX2bdQp/rawpfuuX+ZtzjlZADi0
         JbUnN4B9UMZ7//4y3GLVkp2sP25L4oq5s4ZoJIPwJITGLDoUOQ16fnEogCmUhsGavL
         11ulyVS1yI0iJO7EKcE1yoaRqKAmOv1AVsylRHKaesJIEteX3InKC2Q378g3ZeGeVD
         y3l/j7+59SYOeTe54tVIwS+mChRJMnhLrwARh/vATNyRZWSEuUiY2YUrPP6oyJ+8IH
         qGCU9X630R+dZH23vckoEi2jF254dNaSo/fAHydzvd92+sx5RWJ15+ngVEYhzjfkaM
         9Ka+8BtYuJX1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/20 9:32 AM, Ethon Paul wrote:
> There is a typo in comment, fix it.
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8d77dbbb80fe..e14230d11845 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1207,7 +1207,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
>   }
>   
>   /*
> - * Rough compatbility check to quickly see if it's even worth looking
> + * Rough compatibility check to quickly see if it's even worth looking
>    * at sharing an anon_vma.
>    *
>    * They need to have the same vm_file, and the flags can only differ
> 
