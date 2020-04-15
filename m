Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA9AC38A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E678120768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aQ68SjUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441609AbgDOTJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:09:52 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5825 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416831AbgDOSgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:36:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9753f80000>; Wed, 15 Apr 2020 11:35:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Apr 2020 11:36:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Apr 2020 11:36:34 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Apr
 2020 18:36:34 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 15 Apr 2020 18:36:34 +0000
Subject: Re: [PATCH] mm/filemap: Fix a typo in comment
 "unneccssary"->"unnecessary"
To:     Ethon Paul <ethp@qq.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200411065141.15936-1-ethp@qq.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <9677805f-5194-b6e8-8949-6ff0cbeb504e@nvidia.com>
Date:   Wed, 15 Apr 2020 11:36:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200411065141.15936-1-ethp@qq.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586975736; bh=8gZsuwi5w93RudMDltCOMy7meITl1tlRbvtCKpuFw0Q=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=aQ68SjUuAS5+47wiMjXyzY239UTmYz8j1W8ndEbYt0WEeRiiA1e2q7YxRa1THkXIC
         1o4LLvDvdloQWzNOTOuOyEBDiviRvmXmGexjJMUlFQAD9AiTN+jJ2m5yoiqQUYIvNB
         CcwKbgSfeA7CiVBQbL9z76kxnsNnotf2diOL5oIPuF2vrSu2mHc3DYSxNUZxBxQtzC
         uAFo6Q+6kHo7TnRpIQi25EYfQOHbX/8qwOHu6he8V/vFlayDB6lUDPj1xtZHFoOz4u
         xXE62CW7aPGrwiVynxrR+/84ogQ1yVoim5Rr+uvP1zIH03+8eAjbH29WEa32Iol4kG
         cUnTDayEkx6pQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/20 11:51 PM, Ethon Paul wrote:
> There is a typo in comment, fix it.
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/filemap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 23a051a7ef0f..de6d01a519e4 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1259,7 +1259,7 @@ EXPORT_SYMBOL_GPL(add_page_wait_queue);
>    * instead.
>    *
>    * The read of PG_waiters has to be after (or concurrently with) PG_locked
> - * being cleared, but a memory barrier should be unneccssary since it is
> + * being cleared, but a memory barrier should be unnecessary since it is
>    * in the same byte as PG_locked.
>    */
>   static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem)
> 
