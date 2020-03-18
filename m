Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A04C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6DC20719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584548192;
	bh=8x//mCLOR5JVQlUFkbOrN8mUH3ezvNAQHdXmT3pjGLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cvSaMV+eriL3OnP13sAPP9L/oy+3ghp5LL+uD1zWrX13yGOF75NL5RN54tD1j0hld
	 7r63Yr4YEoeLuatBcPN0rIBYBjadZljFS4IvSl9Pad7J9zRET5raMEmcp9kfMYPXKl
	 I0hihz9VKV0f7V5mPNliMGkNkjzYrHla/7Xnb4lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgCRQQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:16:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55310 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRQQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:16:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so4084762wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78UWOqjS0lj6VMY9x7/TPa80DlSDYmS0inBUIVzOTXs=;
        b=jQ1TvkwXICDLqklkq8y3CvjT9SGwkLv4TA28gZWQ0n3At5F44huYfI2pbMNZ3DjfNq
         7wKEeJ6TfwOdKc54eSlPY3oe2vjaYSYmRyyPgMrT1S+mUB3SnR2TtKxmMp6WlRckmZMO
         c94VqhB6PdKsc7nX7AkREiRv0cio2ERps/EoORMZGY7Cp4pckkTfHbJCKq+PIYlQZTY+
         OCeQqY7mW8Vqi5nIv+z9pES7Nvz+wX7sr1c3m6x565ouFAiwallsCp4FedRog2RVbsfV
         a7PnIrN5VcQe4/UytWKY/9KASECrrLAUyf22rzONM3ZF1ZGvMsZastJDqAiHUfPgaUnr
         mfDQ==
X-Gm-Message-State: ANhLgQ1zkzNW7zMNfXTpunzstLMvAXC4A0MC/CjRM9iwnypcTOrlVdnH
        xzuNQ5ASFOI4LduZ5r61wr4=
X-Google-Smtp-Source: ADFU+vtiFa59oufIyWkspWa++bxRmex4MItgFiYopT/n2F8x6FTRiJtcWDm7TE5bFYfD2RgUCGvWeA==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr3001184wmj.176.1584548187965;
        Wed, 18 Mar 2020 09:16:27 -0700 (PDT)
Received: from localhost (ip-37-188-180-89.eurotel.cz. [37.188.180.89])
        by smtp.gmail.com with ESMTPSA id d15sm10001233wrp.37.2020.03.18.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:16:27 -0700 (PDT)
Date:   Wed, 18 Mar 2020 17:16:25 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] mm: hugetlb: fix hugetlb_cma_reserve() if CONFIG_NUMA
 isn't set
Message-ID: <20200318161625.GR21362@dhcp22.suse.cz>
References: <20200318153424.3202304-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318153424.3202304-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-03-20 08:34:24, Roman Gushchin wrote:
> If CONFIG_NUMA isn't set, there is no need to ensure that
> the hugetlb cma area belongs to a specific numa node.
> 
> min/max_low_pfn can be used for limiting the maximum size
> of the hugetlb_cma area.
> 
> Also for_each_mem_pfn_range() is defined only if
> CONFIG_HAVE_MEMBLOCK_NODE_MAP is set, and on arm (unlike most
> other architectures) it depends on CONFIG_NUMA. This makes the
> build fail if CONFIG_NUMA isn't set.

CONFIG_HAVE_MEMBLOCK_NODE_MAP has popped out as a problem several times
already. Is there any real reason we cannot make it unconditional?
Essentially make the functionality always enabled and drop the config?
The code below is ugly as hell. Just look at it. You have
for_each_node_state without any ifdefery but the having ifdef
CONFIG_NUMA. That just doesn't make any sense.

> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Andreas Schaufler <andreas.schaufler@gmx.de>
> ---
>  mm/hugetlb.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7a20cae7c77a..a6161239abde 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5439,16 +5439,21 @@ void __init hugetlb_cma_reserve(int order)
>  
>  	reserved = 0;
>  	for_each_node_state(nid, N_ONLINE) {
> -		unsigned long start_pfn, end_pfn;
>  		unsigned long min_pfn = 0, max_pfn = 0;
> -		int res, i;
> +		int res;
> +#ifdef CONFIG_NUMA
> +		unsigned long start_pfn, end_pfn;
> +		int i;
>  
>  		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>  			if (!min_pfn)
>  				min_pfn = start_pfn;
>  			max_pfn = end_pfn;
>  		}
> -
> +#else
> +		min_pfn = min_low_pfn;
> +		max_pfn = max_low_pfn;
> +#endif
>  		size = max(per_node, hugetlb_cma_size - reserved);
>  		size = round_up(size, PAGE_SIZE << order);
>  
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
