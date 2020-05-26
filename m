Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3ABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A996C207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgEZPYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:24:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgEZPYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:24:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 589E8B158;
        Tue, 26 May 2020 15:24:49 +0000 (UTC)
Subject: Re: [PATCH v3 18/19] kselftests: cgroup: add kernel memory accounting
 tests
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-19-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d980935c-fecc-9682-7dab-bdcf33c12a9c@suse.cz>
Date:   Tue, 26 May 2020 17:24:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-19-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:47 PM, Roman Gushchin wrote:
> Add some tests to cover the kernel memory accounting functionality.
> These are covering some issues (and changes) we had recently.
> 
> 1) A test which allocates a lot of negative dentries, checks memcg
> slab statistics, creates memory pressure by setting memory.max
> to some low value and checks that some number of slabs was reclaimed.
> 
> 2) A test which covers side effects of memcg destruction: it creates
> and destroys a large number of sub-cgroups, each containing a
> multi-threaded workload which allocates and releases some kernel
> memory. Then it checks that the charge ans memory.stats do add up
> on the parent level.
> 
> 3) A test which reads /proc/kpagecgroup and implicitly checks that it
> doesn't crash the system.
> 
> 4) A test which spawns a large number of threads and checks that
> the kernel stacks accounting works as expected.
> 
> 5) A test which checks that living charged slab objects are not
> preventing the memory cgroup from being released after being deleted
> by a user.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  tools/testing/selftests/cgroup/.gitignore  |   1 +
>  tools/testing/selftests/cgroup/Makefile    |   2 +
>  tools/testing/selftests/cgroup/test_kmem.c | 382 +++++++++++++++++++++
>  3 files changed, 385 insertions(+)
>  create mode 100644 tools/testing/selftests/cgroup/test_kmem.c
> 
> diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
> index aa6de65b0838..84cfcabea838 100644
> --- a/tools/testing/selftests/cgroup/.gitignore
> +++ b/tools/testing/selftests/cgroup/.gitignore
> @@ -2,3 +2,4 @@
>  test_memcontrol
>  test_core
>  test_freezer
> +test_kmem
> \ No newline at end of file
> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
> index 967f268fde74..4794844a228e 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -6,11 +6,13 @@ all:
>  TEST_FILES     := with_stress.sh
>  TEST_PROGS     := test_stress.sh
>  TEST_GEN_PROGS = test_memcontrol
> +TEST_GEN_PROGS = test_kmem

Should be +=

>  TEST_GEN_PROGS += test_core
>  TEST_GEN_PROGS += test_freezer
>  
>  include ../lib.mk
>  
>  $(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
> +$(OUTPUT)/test_kmem: cgroup_util.c ../clone3/clone3_selftests.h
>  $(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
>  $(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> new file mode 100644
> index 000000000000..5bc1132fec6b
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -0,0 +1,382 @@
...
> +/*
> + * This test allocates 100000 of negative dentries with long names.
> + * Then it checks that "slab" in memory.stat is larger than 1M.
> + * Then it sets memory.high to 1M and checks that at least 1/2
> + * of slab memory has been reclaimed.
> + */
> +static int test_kmem_basic(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *cg = NULL;
> +	long slab0, slab1, current;
> +
> +	cg = cg_name(root, "kmem_basic_test");
> +	if (!cg)
> +		goto cleanup;
> +
> +	if (cg_create(cg))
> +		goto cleanup;
> +
> +	if (cg_run(cg, alloc_dcache, (void *)100000))
> +		goto cleanup;
> +
> +	slab0 = cg_read_key_long(cg, "memory.stat", "slab ");
> +	if (slab0 < (1 >> 20))

1 << 20 ?

Anyway I was getting this:
not ok 1 test_kmem_basic
ok 2 test_kmem_memcg_deletion
ok 3 test_kmem_proc_kpagecgroup
not ok 4 test_kmem_kernel_stacks
ok 5 test_kmem_dead_cgroups

Adding some debugging into kmem_basic I found I get memory.stat == 0 at this
point thus it fails the fixed test (otherwise it was failing the <= 0 test after
writing to memory.high). But it's just a VM spinned by virtme which has a very
simple init, so perhaps things are not as initialized as expected.
