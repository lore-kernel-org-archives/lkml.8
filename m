Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA5AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC07F2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595576387;
	bh=a4hWIMrh+qwIIc7AFiVP+pQ2EN8A6GdeNnREygT6KNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nO/VFIt5HB2aPEr3BvGAj8zojUJHaLT4Dgd2c59XcNL9mbWTqcdjvVcsKNaK+Rkuv
	 vdxjm80vvS/Sv4u766Ta9FkgQl0/ww7IoVn1dShm9dMKtakIDi/8q8MAvDqFiBI6Dg
	 w5/c9DJ+3f/uQqBctygtIqtmdP2i3DbGfo5g3xlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXHjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:39:46 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:36324 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGXHjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:39:46 -0400
Received: by mail-ej1-f65.google.com with SMTP id n22so9000222ejy.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+dWEBXOdKu2J17/zaLlrrBCGiaktg+YjWZUQCCKpoDg=;
        b=sN25GfxyugvJp9m/7IcY27e0WHhO/5oQ0MJ3xfkMzn+wE8tMfCUBEyVGXzjlWy9e4G
         LL+F0tWNeiTxGmRNkXlMTnthm9DlbqpGDikUAbZX+5KGCF47r7uYBLk+sorbLWUYg9R2
         ONdd3aqyadSjfh8oIya4yr2YS40v3lMOOTRdXNWxCqL0XiJmL1xnGPd1iny4p+DIk0qg
         xg4Fdkgk5a6Pb17oLtv5gx7qJDWnDOnus/5s1cqsHr5B8E/Q7YFhJ0GiByJLS5wx0XbZ
         nnBdplE+JL2+i5qnoS2J2j4/1siA0FLQJRgyPmqBEpaPWjhnaWfdxbB06/1rYU3YeYzh
         x3NQ==
X-Gm-Message-State: AOAM530pKozk7vomL7wVuqnwp3WSPbWLHgyAa7/OwpJvuBucZsW14b21
        8cHZBb0L9sgAA9RXCR+u+LVuD8vv
X-Google-Smtp-Source: ABdhPJw7r+YCk9FDnRZpBOan7KpGvH4l56uwfW55RQG3OsS8sOf0Ae0nMZKVfwK2f+GYg3hf2tP9Fg==
X-Received: by 2002:a17:906:2b9b:: with SMTP id m27mr8018657ejg.19.1595576384388;
        Fri, 24 Jul 2020 00:39:44 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id cq7sm161592edb.66.2020.07.24.00.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 00:39:43 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:39:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: Re: [PATCH] mm/hugetlb: add mempolicy check in the reservation
 routine
Message-ID: <20200724073942.GE4061@dhcp22.suse.cz>
References: <20200723074417.89467-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723074417.89467-1-songmuchun@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-07-20 15:44:17, Muchun Song wrote:
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

Cpusets and mempolicy interaction has always been a nightmare and
semantic might get really awkward in some cases. In this case I am not
really sure anybody really does soemthing like that but anyway...

[...]

> -static unsigned int cpuset_mems_nr(unsigned int *array)
> +static nodemask_t *mempolicy_current_bind_nodemask(void)
> +{
> +	struct mempolicy *mpol;
> +	nodemask_t *nodemask;
> +
> +	mpol = get_task_policy(current);
> +	if (mpol->mode == MPOL_BIND)
> +		nodemask = &mpol->v.nodes;
> +	else
> +		nodemask = NULL;
> +
> +	return nodemask;
> +}

We already have policy_nodemask which tries to do this. Is there any
reason to not reuse it?
-- 
Michal Hocko
SUSE Labs
