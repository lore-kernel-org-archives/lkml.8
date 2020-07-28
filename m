Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6899FC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD7C20838
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595895597;
	bh=6o/MZ1z32u64khpK98VwBkgw43eYbDJxbrdLk66x9Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ucQUpDS5HwNj1cG1WDFB5VWew2F4PHwnvbIuCB+vRgv3fm5ol20jepSoqzGVMzPX5
	 XtXXbAc9w0VSVKOt/9mKNGb4rqtKBbX7+BNGHjBmDF6XINN3oaGRVXbddjwqJEcBm8
	 NT9VpLs31skSpJB9AYd2EfzsPCq9OyjRtqdVtBLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG1ATz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG1ATz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 20:19:55 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B889C20786;
        Tue, 28 Jul 2020 00:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595895594;
        bh=6o/MZ1z32u64khpK98VwBkgw43eYbDJxbrdLk66x9Rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJUt0jiTNItMcvuHyogiA2bKZVjg0T5jNVT2Do/aalnvH4F1MTME3XtnpNrg6IHJ4
         zlCeQvgXPTV5rAG6Fw3ewHkLA4ebXbW8ncqUmkfOSIktqHN/3X+A+xCIjVHpoG94pL
         vx2NvVjPJpi80W4CxCl+v35SXCmm1yHwKvCS3VYQ=
Date:   Mon, 27 Jul 2020 17:19:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, mhocko@kernel.org, rientjes@google.com,
        mgorman@suse.de, walken@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jianchao Guo <guojianchao@bytedance.com>
Subject: Re: [PATCH v3] mm/hugetlb: add mempolicy check in the reservation
 routine
Message-Id: <20200727171953.443afb897bb88261facf5512@linux-foundation.org>
In-Reply-To: <20200725080749.70470-1-songmuchun@bytedance.com>
References: <20200725080749.70470-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 16:07:49 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

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

This doesn't compile with CONFIG_NUMA=n - ther eis no implementation of
get_task_policy().

I think it needs more than a simple build fix - can we please rework
the patch so that its impact (mainly code size) on non-NUMA machines is
minimized?

