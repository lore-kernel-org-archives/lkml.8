Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15946C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22E2207ED
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591386288;
	bh=tWbprt1tmqKCRlEefzFpJKpoBttgK56xmPrvB00gxIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hbZVvHkBIomew1ttPUr3ssj/Y2iymsAl5In91SlUkgUkUDwp1v+6sBln5wfFYr8fk
	 isNYOOOvfBrfsa5vgNKVY38lrSqdODt4T3WQmM1W44RNNGpcuBoudT85tq89DIXjf3
	 qJY4y+z4xLw29GS5U8PQZL6ygMYks3fuV31p7vkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgFETos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:44:48 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39987 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgFETor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:44:47 -0400
Received: by mail-vs1-f68.google.com with SMTP id u17so6256362vsu.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7O2pzME1vhDGlSU4vtoXmUIFM9CRZIMY/qMgNmXhNzE=;
        b=oOaBN7Cmmy1JMrC2+RLdPNtSGf7mfPPf4scvgN/y241gi5HLRcSeZI9vZP3ByfJlLL
         ryqh+U6oljxC2C+H61OQR+refFL7d1FikfhKK9ZUIY3Z/LgEIwYs+KPOwyXU2/4912VY
         5zxzzvNEHVujnf1Uz3RBoovnW5Zn9tqpqBQwIW6VTHFfxUZRJ1UsC5M7ylol37jcIcTj
         bKb737f/cvx4nvmWy2aGY9qJalSIi1D6JNxxsT1GIncnytwqtYqzDa0AQS1Yk90ct032
         0iHuPG9iK5c9/auJUP5LUkirQa/qbYqUMgU35RVdZmnSPXqPbcKtZZxnUMHAQLb/vto5
         NvBA==
X-Gm-Message-State: AOAM530n9f7azOKGwbPNuTnBsCKSW3aa6bbvUWyzqb5Tr6Q6nND+MgFL
        w/erqTkR5HiWDpJ2cf6v5Po=
X-Google-Smtp-Source: ABdhPJxi3wTB0D2ZCuYcHfkn/Z14lRXDjvpemIQD8fMCnjN6oWo3DnaDcnWW8UOh+rafBSIJJbRhIQ==
X-Received: by 2002:a67:800f:: with SMTP id b15mr4351196vsd.220.1591386286149;
        Fri, 05 Jun 2020 12:44:46 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id e193sm1243243vke.49.2020.06.05.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 12:44:45 -0700 (PDT)
Date:   Fri, 5 Jun 2020 19:44:43 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] percpu: return number of released bytes from
 pcpu_free_area()
Message-ID: <20200605194443.GA224745@google.com>
References: <20200528232508.1132382-1-guro@fb.com>
 <20200528232508.1132382-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528232508.1132382-2-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:25:04PM -0700, Roman Gushchin wrote:
> To implement accounting of percpu memory we need the information
> about the size of freed object. Return it from pcpu_free_area().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/percpu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 696367b18222..aa36b78d45a6 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1211,11 +1211,14 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
>   *
>   * This function determines the size of an allocation to free using
>   * the boundary bitmap and clears the allocation map.
> + *
> + * RETURNS:
> + * Number of freed bytes.
>   */
> -static void pcpu_free_area(struct pcpu_chunk *chunk, int off)
> +static int pcpu_free_area(struct pcpu_chunk *chunk, int off)
>  {
>  	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
> -	int bit_off, bits, end, oslot;
> +	int bit_off, bits, end, oslot, freed;
>  
>  	lockdep_assert_held(&pcpu_lock);
>  	pcpu_stats_area_dealloc(chunk);
> @@ -1230,8 +1233,10 @@ static void pcpu_free_area(struct pcpu_chunk *chunk, int off)
>  	bits = end - bit_off;
>  	bitmap_clear(chunk->alloc_map, bit_off, bits);
>  
> +	freed = bits * PCPU_MIN_ALLOC_SIZE;
> +
>  	/* update metadata */
> -	chunk->free_bytes += bits * PCPU_MIN_ALLOC_SIZE;
> +	chunk->free_bytes += freed;
>  
>  	/* update first free bit */
>  	chunk_md->first_free = min(chunk_md->first_free, bit_off);
> @@ -1239,6 +1244,8 @@ static void pcpu_free_area(struct pcpu_chunk *chunk, int off)
>  	pcpu_block_update_hint_free(chunk, bit_off, bits);
>  
>  	pcpu_chunk_relocate(chunk, oslot);
> +
> +	return freed;
>  }
>  
>  static void pcpu_init_md_block(struct pcpu_block_md *block, int nr_bits)
> -- 
> 2.25.4
> 

Sorry for the delay.

Acked-by: Dennis Zhou <dennis@kernel.org>

What's the status of the depending patches? It might be easiest to have
Andrew pick these up once the depending patch series is settled.

Thanks,
Dennis
