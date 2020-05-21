Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBDEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5448E207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590070549;
	bh=I+ppeGpRJmwBqRsyqpZd6h5unEhCpnis2mJI09ZkU7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mCjsx30dvSAhI1MY6k0wuy++gnlNXiJOiicqt3FVRwgAKYs144uNfEYmlwJdw8qS5
	 Ub3qCNd+MfmpyR30jIw5XJ8S1nwdKfCUkCkyPdXrXV+hL/M6ZZhR29ms0xPuriaH92
	 luirf3ngPqPkFedvF8ZEQO6ixDz33Btja4L0C5jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgEUOPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgEUOPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:15:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBE220721;
        Thu, 21 May 2020 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590070547;
        bh=I+ppeGpRJmwBqRsyqpZd6h5unEhCpnis2mJI09ZkU7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSM1tGENz5jfJftUm03PtVI9V3CCBxNJlwh+F8YeZYHb0WHhLJXzkezQF0EXWKQ4v
         NpX68Xtbp0lnsIX0CgsCHnVqU217Wz9zyiZ8BFInusHs5ih5pUHIE1HByV3gAxPFFz
         0V7A2QR8VbdFtY/JivIrvJlgdqcPe6hnhb9u+JZo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 738EE40AFD; Thu, 21 May 2020 11:15:45 -0300 (-03)
Date:   Thu, 21 May 2020 11:15:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
Subject: Re: [PATCH 2/4] perf svghelper: Fix memory leak in
 svg_build_topology_map
Message-ID: <20200521141545.GC3898@kernel.org>
References: <20200521133218.30150-1-liwei391@huawei.com>
 <20200521133218.30150-3-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521133218.30150-3-liwei391@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 21, 2020 at 09:32:16PM +0800, Wei Li escreveu:
> From: Li Bin <huawei.libin@huawei.com>
> 
> Fix leak of memory pointed to by t.sib_thr and t.sib_core in
> svg_build_topology_map.
> 
> Signed-off-by: Li Bin <huawei.libin@huawei.com>
> ---
>  tools/perf/util/svghelper.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index 96f941e01681..e2b3b0e2fafe 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -754,6 +754,7 @@ int svg_build_topology_map(struct perf_env *env)
>  	int i, nr_cpus;
>  	struct topology t;
>  	char *sib_core, *sib_thr;
> +	int ret;

Please set ret to -1 here

	int ret = -1;
	
So that you don't have to add all those lines below...

>  
>  	nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
>  
> @@ -767,12 +768,14 @@ int svg_build_topology_map(struct perf_env *env)
>  
>  	if (!t.sib_core || !t.sib_thr) {
>  		fprintf(stderr, "topology: no memory\n");
> +		ret = -1;
>  		goto exit;
>  	}
>  
>  	for (i = 0; i < env->nr_sibling_cores; i++) {
>  		if (str_to_bitmap(sib_core, &t.sib_core[i], nr_cpus)) {
>  			fprintf(stderr, "topology: can't parse siblings map\n");
> +			ret = -1;
>  			goto exit;
>  		}
>  
> @@ -782,6 +785,7 @@ int svg_build_topology_map(struct perf_env *env)
>  	for (i = 0; i < env->nr_sibling_threads; i++) {
>  		if (str_to_bitmap(sib_thr, &t.sib_thr[i], nr_cpus)) {
>  			fprintf(stderr, "topology: can't parse siblings map\n");
> +			ret = -1;
>  			goto exit;
>  		}
>  
> @@ -791,6 +795,7 @@ int svg_build_topology_map(struct perf_env *env)
>  	topology_map = malloc(sizeof(int) * nr_cpus);
>  	if (!topology_map) {
>  		fprintf(stderr, "topology: no memory\n");
> +		ret = -1;
>  		goto exit;
>  	}
>  
> @@ -798,12 +803,11 @@ int svg_build_topology_map(struct perf_env *env)
>  		topology_map[i] = -1;
>  
>  	scan_core_topology(topology_map, &t, nr_cpus);
> -
> -	return 0;

... as you'll set it to zero here :-)

> +	ret = 0;
>  
>  exit:
>  	zfree(&t.sib_core);
>  	zfree(&t.sib_thr);
>  
> -	return -1;
> +	return ret;
>  }
> -- 
> 2.17.1
> 

-- 

- Arnaldo
