Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE04206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591387676;
	bh=PH0ao3GdQEwOlFgdOXqP5G6s5H3/uRzNMIZyS6oNI4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rhbiBqN80+Tgyxqv21CP4E+Ju56y7U8XwPkqJb9KvzDez7daT/9LP/tT6IT0/reMR
	 ZPltEbDZER10dlwLBI2GiKjH8aEheQ2muT6515XZ5d2i7lIVVn/w2FxLRbp43+kFPu
	 rL0nA8zRvQnO0njixTPuEHRaef3pslPnRL5LuOQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgFEUH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:07:56 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34603 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgFEUHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:07:55 -0400
Received: by mail-ua1-f67.google.com with SMTP id r9so3730943ual.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FlJgMKQQXIjXwSqXj5h10emSVIeCQTIajZGC2MB8JjA=;
        b=g5aWvFme5A75cFwkvVN1ArHw1nWSoDfouTGtZSwIDl9mF/lqUFxAJgpr7yhdrwWmyk
         FKAIv7NYhAjHWjiI1iirQCiwPnKNbTuOcM8rKaPb3M5YsI4Ita1hyvZQewBWdRrTKDvg
         POu8FRLqABUXJ1qBTjEKRL0WFOy2P8fzdC+pV5/D8G9uJBQQUWmI/XD9lHXLm6JZPzgk
         0ZS/M9Sxik8OBEZMRuHw+KW6ysqcA+OSPn3XW6U4ccO4nBfSzqOJqrCHGEzP/Z0VGG0l
         7eVWP9FIrTCR4LGN24c9wgwYgdgzjJcAzhcH9DoUm7oPJGKFP3kuQ1z4JEYbLbZlmwSr
         mYWg==
X-Gm-Message-State: AOAM532P4l7PU6Qo/lF9LGKtMLQoK/KlMKLMA0bVuc2dgDFhJ1BOeWaN
        pS3WrZallkw64t3WGT2V6w0=
X-Google-Smtp-Source: ABdhPJw2l/VjBLOkpzld267CPB7R0he7pKlOB8RlXtO+VYr1sXSYV3JTe1BH+5DnadIphpFZAvMLHA==
X-Received: by 2002:ab0:300c:: with SMTP id f12mr8511736ual.76.1591387674083;
        Fri, 05 Jun 2020 13:07:54 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id i18sm956312vsp.22.2020.06.05.13.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 13:07:53 -0700 (PDT)
Date:   Fri, 5 Jun 2020 20:07:51 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] kselftests: cgroup: add perpcu memory accounting
 test
Message-ID: <20200605200751.GE224745@google.com>
References: <20200528232508.1132382-1-guro@fb.com>
 <20200528232508.1132382-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528232508.1132382-6-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:25:08PM -0700, Roman Gushchin wrote:
> Add a simple test to check the percpu memory accounting.
> The test creates a cgroup tree with 1000 child cgroups
> and checks values of memory.current and memory.stat::percpu.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  tools/testing/selftests/cgroup/test_kmem.c | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> index 5224dae216e5..a0d4f1a3137d 100644
> --- a/tools/testing/selftests/cgroup/test_kmem.c
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -331,6 +331,64 @@ static int test_kmem_dead_cgroups(const char *root)
>  	return ret;
>  }
>  
> +/*
> + * This test creates a sub-tree with 1000 memory cgroups.
> + * Then it checks that the memory.current on the parent level
> + * is greater than 0 and approximates matches the percpu value
> + * from memory.stat.
> + */
> +static int test_percpu_basic(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *parent, *child;
> +	long current, percpu;
> +	int i;
> +
> +	parent = cg_name(root, "percpu_basic_test");
> +	if (!parent)
> +		goto cleanup;
> +
> +	if (cg_create(parent))
> +		goto cleanup;
> +
> +	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
> +		goto cleanup;
> +
> +	for (i = 0; i < 1000; i++) {
> +		child = cg_name_indexed(parent, "child", i);
> +		if (!child)
> +			return -1;
> +
> +		if (cg_create(child))
> +			goto cleanup_children;
> +
> +		free(child);
> +	}
> +
> +	current = cg_read_long(parent, "memory.current");
> +	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
> +
> +	if (current > 0 && percpu > 0 && abs(current - percpu) <
> +	    4096 * 32 * get_nprocs())

So this is checking that we've allocated less than 32 pages per cpu over
1000 child cgroups that's not percpu memory? Is there a more definitive
measurement or at least a comment we can leave saying why this limit was
chosen.

> +		ret = KSFT_PASS;
> +	else
> +		printf("memory.current %ld\npercpu %ld\n",
> +		       current, percpu);
> +
> +cleanup_children:
> +	for (i = 0; i < 1000; i++) {
> +		child = cg_name_indexed(parent, "child", i);
> +		cg_destroy(child);
> +		free(child);
> +	}
> +
> +cleanup:
> +	cg_destroy(parent);
> +	free(parent);
> +
> +	return ret;
> +}
> +
>  #define T(x) { x, #x }
>  struct kmem_test {
>  	int (*fn)(const char *root);
> @@ -341,6 +399,7 @@ struct kmem_test {
>  	T(test_kmem_proc_kpagecgroup),
>  	T(test_kmem_kernel_stacks),
>  	T(test_kmem_dead_cgroups),
> +	T(test_percpu_basic),
>  };
>  #undef T
>  
> -- 
> 2.25.4
> 
> 
