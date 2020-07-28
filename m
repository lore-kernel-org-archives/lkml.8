Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A05C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7112C206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvIojDIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgG1NZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:25:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729555AbgG1NZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595942703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPe2kBPPIADxPOO35iN4ImqsjTLCSyuLAf8YdcjEsaI=;
        b=XvIojDIPCmlvzXTkoRRTzDL36UASjINYwQRB1+dGy7d7vcpWCXloZP3o6qe3EXlT+eixOP
        DR8ArjJl8Xo5xWdxYK8cba2O6WOiF1uKV8hlBTJE0lwIIVur9EShVadDuygCa/L/swSyx0
        4FF69SHwBGMTSUqfZ3nfQCwPxdJDeaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-gD3mRHsiM5qQNL6HDHZFVQ-1; Tue, 28 Jul 2020 09:25:01 -0400
X-MC-Unique: gD3mRHsiM5qQNL6HDHZFVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 312FE1005510;
        Tue, 28 Jul 2020 13:24:59 +0000 (UTC)
Received: from localhost (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 900E27B41F;
        Tue, 28 Jul 2020 13:24:56 +0000 (UTC)
Date:   Tue, 28 Jul 2020 21:24:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mhocko@kernel.org, rientjes@google.com, mgorman@suse.de,
        walken@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: Re: [PATCH v4] mm/hugetlb: add mempolicy check in the reservation
 routine
Message-ID: <20200728132453.GB14854@MiWiFi-R3L-srv>
References: <20200728034938.14993-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728034938.14993-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun,

On 07/28/20 at 11:49am, Muchun Song wrote:
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

I think supporting the  mempolicy of MPOL_BIND case is a good idea.
I am wondering what about the other mempolicy cases, e.g MPOL_INTERLEAVE,
MPOL_PREFERRED. Asking these because we already have similar handling in
sysfs, proc nr_hugepages_mempolicy writting. Please see
__nr_hugepages_store_common() for detail.

Thanks
Baoquan

> 
> With this patch applied, the mmap will fail in the step 3) and throw
> "mmap: Cannot allocate memory".
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Jianchao Guo <guojianchao@bytedance.com>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
> changelog in v4:
>  1) Fix compilation errors with !CONFIG_NUMA.
> 
> changelog in v3:
>  1) Do not allocate nodemask on the stack.
>  2) Update comment.
> 
> changelog in v2:
>  1) Reuse policy_nodemask().
> 
>  include/linux/mempolicy.h | 14 ++++++++++++++
>  mm/hugetlb.c              | 22 ++++++++++++++++++----
>  mm/mempolicy.c            |  2 +-
>  3 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index ea9c15b60a96..0656ece1ccf1 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -152,6 +152,15 @@ extern int huge_node(struct vm_area_struct *vma,
>  extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
>  extern bool mempolicy_nodemask_intersects(struct task_struct *tsk,
>  				const nodemask_t *mask);
> +extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
> +
> +static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
> +{
> +	struct mempolicy *mpol = get_task_policy(current);
> +
> +	return policy_nodemask(gfp, mpol);
> +}
> +
>  extern unsigned int mempolicy_slab_node(void);
>  
>  extern enum zone_type policy_zone;
> @@ -281,5 +290,10 @@ static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
>  static inline void mpol_put_task_policy(struct task_struct *task)
>  {
>  }
> +
> +static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_NUMA */
>  #endif
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 589c330df4db..a34458f6a475 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3463,13 +3463,21 @@ static int __init default_hugepagesz_setup(char *s)
>  }
>  __setup("default_hugepagesz=", default_hugepagesz_setup);
>  
> -static unsigned int cpuset_mems_nr(unsigned int *array)
> +static unsigned int allowed_mems_nr(struct hstate *h)
>  {
>  	int node;
>  	unsigned int nr = 0;
> +	nodemask_t *mpol_allowed;
> +	unsigned int *array = h->free_huge_pages_node;
> +	gfp_t gfp_mask = htlb_alloc_mask(h);
> +
> +	mpol_allowed = policy_nodemask_current(gfp_mask);
>  
> -	for_each_node_mask(node, cpuset_current_mems_allowed)
> -		nr += array[node];
> +	for_each_node_mask(node, cpuset_current_mems_allowed) {
> +		if (!mpol_allowed ||
> +		    (mpol_allowed && node_isset(node, *mpol_allowed)))
> +			nr += array[node];
> +	}
>  
>  	return nr;
>  }
> @@ -3648,12 +3656,18 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
>  	 * we fall back to check against current free page availability as
>  	 * a best attempt and hopefully to minimize the impact of changing
>  	 * semantics that cpuset has.
> +	 *
> +	 * Apart from cpuset, we also have memory policy mechanism that
> +	 * also determines from which node the kernel will allocate memory
> +	 * in a NUMA system. So similar to cpuset, we also should consider
> +	 * the memory policy of the current task. Similar to the description
> +	 * above.
>  	 */
>  	if (delta > 0) {
>  		if (gather_surplus_pages(h, delta) < 0)
>  			goto out;
>  
> -		if (delta > cpuset_mems_nr(h->free_huge_pages_node)) {
> +		if (delta > allowed_mems_nr(h)) {
>  			return_unused_surplus_pages(h, delta);
>  			goto out;
>  		}
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 93fcfc1f2fa2..fce14c3f4f38 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1873,7 +1873,7 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
>   * Return a nodemask representing a mempolicy for filtering nodes for
>   * page allocation
>   */
> -static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
> +nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
>  {
>  	/* Lower zones don't get a nodemask applied for MPOL_BIND */
>  	if (unlikely(policy->mode == MPOL_BIND) &&
> -- 
> 2.11.0
> 
> 

