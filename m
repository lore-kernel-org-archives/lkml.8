Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4250C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C08B920678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nBNTu43w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHCKB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:01:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15355 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgHCKB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:01:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596448917; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=0DuhPig/BdjwtnY2fgM6R8kgAL7yGAywFUS6sxjdcPY=; b=nBNTu43wdX/GgqjfRTWAPthqakxiG+kU9wRV5HH7/YO8xMlZQTS8wcA5mwNz+DoF9GHjebQa
 xT7GEHy9BdVTdg33cqvxAWtyx0mBv0EoCw2NlleD+W01HvJmxfNA1qkQ41tsA8ZlBYZDopPW
 Lt1Bmo2UervLJs/jCaRxdtfwFsc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f27e05714acd1952ba7381a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 Aug 2020 10:00:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D8C3C4339C; Mon,  3 Aug 2020 10:00:53 +0000 (UTC)
Received: from [192.168.0.105] (unknown [103.248.210.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B2DB4C433C6;
        Mon,  3 Aug 2020 10:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2DB4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com
References: <1593785835-27250-1-git-send-email-vjitta@codeaurora.org>
 <1593785835-27250-2-git-send-email-vjitta@codeaurora.org>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <29f44540-44f8-570d-886f-2090596a3b8e@codeaurora.org>
Date:   Mon, 3 Aug 2020 15:30:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1593785835-27250-2-git-send-email-vjitta@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2020 7:47 PM, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> When ever an iova alloc request fails we free the iova
> ranges present in the percpu iova rcaches and then retry
> but the global iova rcache is not freed as a result we could
> still see iova alloc failure even after retry as global
> rcache is holding the iova's which can cause fragmentation.
> So, free the global iova rcache as well and then go for the
> retry.
> 
> Change-Id: Ib8236dc88ba5516b73d4fbf6bf8e68bbf09bbad2
> Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
> ---
>  drivers/iommu/iova.c | 23 +++++++++++++++++++++++
>  include/linux/iova.h |  6 ++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 4e77116..5836c87 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -442,6 +442,7 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
>  		flush_rcache = false;
>  		for_each_online_cpu(cpu)
>  			free_cpu_cached_iovas(cpu, iovad);
> +		free_global_cached_iovas(iovad);
>  		goto retry;
>  	}
>  
> @@ -1055,5 +1056,27 @@ void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>  	}
>  }
>  
> +/*
> + * free all the IOVA ranges of global cache
> + */
> +void free_global_cached_iovas(struct iova_domain *iovad)
> +{
> +	struct iova_rcache *rcache;
> +	unsigned long flags;
> +	int i, j;
> +
> +	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +		rcache = &iovad->rcaches[i];
> +		spin_lock_irqsave(&rcache->lock, flags);
> +		for (j = 0; j < rcache->depot_size; ++j) {
> +			iova_magazine_free_pfns(rcache->depot[j], iovad);
> +			iova_magazine_free(rcache->depot[j]);
> +			rcache->depot[j] = NULL;
> +		}
> +		rcache->depot_size = 0;
> +		spin_unlock_irqrestore(&rcache->lock, flags);
> +	}
> +}
> +
>  MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index a0637ab..a905726 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -163,6 +163,7 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>  struct iova *split_and_remove_iova(struct iova_domain *iovad,
>  	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
>  void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
> +void free_global_cached_iovas(struct iova_domain *iovad);
>  #else
>  static inline int iova_cache_get(void)
>  {
> @@ -270,6 +271,11 @@ static inline void free_cpu_cached_iovas(unsigned int cpu,
>  					 struct iova_domain *iovad)
>  {
>  }
> +
> +static inline void free_global_cached_iovas(struct iova_domain *iovad)
> +{
> +}
> +
>  #endif
>  
>  #endif
> 

ping?
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
