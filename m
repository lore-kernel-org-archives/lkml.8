Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04812C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E122074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 00:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gd3/GZhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgG3A21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:28:27 -0400
Received: from gateway20.websitewelcome.com ([192.185.54.2]:31082 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbgG3A21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:28:27 -0400
X-Greylist: delayed 1245 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2020 20:28:26 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 3AAAB40515241
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 17:44:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0w5fkCwuSRQIV0w5fkeyFv; Wed, 29 Jul 2020 19:06:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O9pd5wZFyMlo2KIw2w7Jr68x5gB033RYBnB9J5fYDs8=; b=gd3/GZhDMc/bVV0PV5dtEt3bWR
        EMH5E0gwCIB5xwWmdRUGdRutDmV5ckeKvscXTN6jlaVrfbzSTLtnVdo0O7dbeNVCDfkjydN5ktvvw
        lcl982UJNymyU2OKDizVuZwZCcveNsgCLq+c5XytdvZxnx6CeHVD2VgOyJkg0bBCvCTYvzA4GsaaA
        WoiPJS3LD+K3NC58oCl8EYiTuFxkTv9Ea7loz+9F36IcZyqr8PBouVL4IaE1GQ8aL7xF60WTVNa/H
        l1u9u+wEd/NCPQ704rbRxP8I8+EvLELU0r8JHKSVo1DgKixKUgMo0etiJscBj+CrbL7fjqJ97PT5v
        78BmJkuQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:51790 helo=[192.168.15.3])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1k0w5f-0031yi-A5; Wed, 29 Jul 2020 19:06:31 -0500
To:     Qianli Zhao <zhaoqianligood@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, zhaoqianli@xiaomi.com
References: <1596034214-15010-1-git-send-email-zhaoqianligood@gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Subject: Re: [PATCH] mm: slab: Avoid the use of one-element array and use
 struct_size() helper
Message-ID: <90b2c9f3-cc2b-b2e6-51ef-998d2f79123a@embeddedor.com>
Date:   Wed, 29 Jul 2020 19:12:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1596034214-15010-1-git-send-email-zhaoqianligood@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1k0w5f-0031yi-A5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.3]) [187.162.31.110]:51790
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If you are going to copy/paste this, please at least CC the people
that is originally working on these changes, in this case _me_. One
needs to be very careful when doing these transformations. This
code doesn't even exist in linux-next.

If you want to land your first kernel patch, I encourage you to start
in drivers/staging/, while you get the hang of the kernel development
process and you know how to work with linux-next. :)

Thanks
--
Gustavo

On 7/29/20 09:50, Qianli Zhao wrote:
> From: Qianli Zhao <zhaoqianli@xiaomi.com>
> 
> There is a regular need in the kernel to provide a way to declare having a
> dynamically sized set of trailing elements in a structure. Kernel code should
> always use “flexible array members”[1] for these cases. The older style of
> one-element or zero-length arrays should no longer be used[2].
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://github.com/KSPP/linux/issues/21
> 
> Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> ---
>  mm/slab.h        | 2 +-
>  mm/slab_common.c | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 74f7e09..c12fb65 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -34,7 +34,7 @@ struct kmem_cache {
>  
>  struct memcg_cache_array {
>  	struct rcu_head rcu;
> -	struct kmem_cache *entries[0];
> +	struct kmem_cache *entries[];
>  };
>  
>  /*
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index fe8b684..56f4818 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -166,9 +166,7 @@ static int init_memcg_params(struct kmem_cache *s,
>  	if (!memcg_nr_cache_ids)
>  		return 0;
>  
> -	arr = kvzalloc(sizeof(struct memcg_cache_array) +
> -		       memcg_nr_cache_ids * sizeof(void *),
> -		       GFP_KERNEL);
> +	arr = kvzalloc(struct_size(arr, entries, memcg_nr_cache_ids), GFP_KERNEL);
>  	if (!arr)
>  		return -ENOMEM;
>  
> @@ -199,8 +197,7 @@ static int update_memcg_params(struct kmem_cache *s, int new_array_size)
>  {
>  	struct memcg_cache_array *old, *new;
>  
> -	new = kvzalloc(sizeof(struct memcg_cache_array) +
> -		       new_array_size * sizeof(void *), GFP_KERNEL);
> +	new = kvzalloc(struct_size(new, entries, new_array_size), GFP_KERNEL);
>  	if (!new)
>  		return -ENOMEM;
>  
> 
