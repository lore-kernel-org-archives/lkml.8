Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B2AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2279F206E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595590462;
	bh=0T/N/rPO4JlqTu+GdEWGPPuhHkl8uprYGfFWZveWKJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wJTQj5Ik3at4zSQ41TRMSiTZAaoLk+Xate3/Jnj3kclBZmBuUVgwlsDvmwVvaYxLx
	 UIGCxyS2FR3e2Tqednm9sVbVdLBKZ+nvWkdZ/inFqyK5/8CD3gPyydwFSabQx+FY4x
	 xa9Q6gbh87JPoF85i2RbeoQjTSdYe4AO7uabk3qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGXLeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:34:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44480 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXLeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:34:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id by13so6768393edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M110HA4nMMKBLYGy/DI8jTdSDD0jpS2wTCc48wWnBmY=;
        b=jEft8tzJS/Z8/qtfwUz1DIv5+73cMtTQtIKn2Fa3V3NVjNiCJXBs35xWBZgtLyGdV8
         Tr6M8xtWETXMlndVdUwWvvv5AFzodDIa54JNhXsXcZY9JZxi9Mvw+I9FAATA4ALwSO7B
         wy7E3qL56Ja29TRA8db5PIjRG8cqIOYyAR3QrBftlqKRqqmgejSaBccedIQNGrEbmzDh
         lCiDmhnwy3lJoUxiNPdrnduUJ580mN0DBtJCeRERcYzQr1PzVlQto5RvNIa7eMTC5I4Z
         zzSbmdsmj3SR6MxjhqEBFv0QMGRzsHHH2++4cyJfA+0YvZ+gZ56aGtlaV7fS+MjbFW1w
         I55A==
X-Gm-Message-State: AOAM533mxTLsNQD31skzCnF6WAiVvo7dkQaOj/PlAZISrhqfBXPjgVlr
        xZMIqxQz5TYz/S4vytd6ZrY=
X-Google-Smtp-Source: ABdhPJz4nnh7QTvkeAbcVkZTca3Hx6YW1ikFfwsIPl+KbdGmUHOgsbm6KIfTaIaKeQqwCU6W2POzhQ==
X-Received: by 2002:a05:6402:2d7:: with SMTP id b23mr8635662edx.145.1595590458024;
        Fri, 24 Jul 2020 04:34:18 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id q21sm496212ejr.75.2020.07.24.04.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:34:17 -0700 (PDT)
Date:   Fri, 24 Jul 2020 13:34:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        rientjes@google.com, mgorman@suse.de, walken@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: Re: [PATCH v2] mm/hugetlb: add mempolicy check in the reservation
 routine
Message-ID: <20200724113415.GG4061@dhcp22.suse.cz>
References: <20200724100306.33457-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724100306.33457-1-songmuchun@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24-07-20 18:03:06, Muchun Song wrote:
> In the reservation routine, we only check whether the cpuset meets
> the memory allocation requirements. But we ignore the mempolicy of
> MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
> memory allocation may fail due to mempolicy restrictions and receives
> the SIGBUS signal. This can be reproduced by the follow steps.
> 
>  1) Compile the test case.
>     cd tools/testing/selftests/vm/
>     gcc map_hugetlb.c -o map_hugetlb
> 
>  2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
>     system. Each node will pre-allocate one huge page.
>     echo 2 > /proc/sys/vm/nr_hugepages
> 
>  3) Run test case(mmap 4MB). We receive the SIGBUS signal.
>     numactl --membind=0 ./map_hugetlb 4
> 
> With this patch applied, the mmap will fail in the step 3) and throw
> "mmap: Cannot allocate memory".
> 
> Reported-by: Jianchao Guo <guojianchao@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> 
> changelog in v2:
>  1) Reuse policy_nodemask().
> 
>  include/linux/mempolicy.h |  1 +
>  mm/hugetlb.c              | 19 ++++++++++++++++---
>  mm/mempolicy.c            |  2 +-
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index ea9c15b60a96..6b9640f1c990 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -152,6 +152,7 @@ extern int huge_node(struct vm_area_struct *vma,
>  extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
>  extern bool mempolicy_nodemask_intersects(struct task_struct *tsk,
>  				const nodemask_t *mask);
> +extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
>  extern unsigned int mempolicy_slab_node(void);
>  
>  extern enum zone_type policy_zone;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 589c330df4db..a753fe8591b4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3463,12 +3463,25 @@ static int __init default_hugepagesz_setup(char *s)
>  }
>  __setup("default_hugepagesz=", default_hugepagesz_setup);
>  
> -static unsigned int cpuset_mems_nr(unsigned int *array)
> +static unsigned int allowed_mems_nr(struct hstate *h)
>  {
>  	int node;
>  	unsigned int nr = 0;
> +	struct mempolicy *mpol = get_task_policy(current);
> +	nodemask_t *mpol_allowed, *mems_allowed, nodemask;
> +	unsigned int *array = h->free_huge_pages_node;
> +	gfp_t gfp_mask = htlb_alloc_mask(h);
> +
> +	mpol_allowed = policy_nodemask(gfp_mask, mpol);
> +	if (mpol_allowed) {
> +		nodes_and(nodemask, cpuset_current_mems_allowed,
> +			  *mpol_allowed);
> +		mems_allowed = &nodemask;
> +	} else {
> +		mems_allowed = &cpuset_current_mems_allowed;
> +	}

I believe you can simplify this and use a similar pattern as the page
allocator. Something like

	for_each_node_mask(node, mpol_allowed) {
		if (node_isset(node, &cpuset_current_mems_allowed))
			nr += array[node];
	}

There shouldn't be any need to allocate a potentially large nodemask on
the stack.
-- 
Michal Hocko
SUSE Labs
