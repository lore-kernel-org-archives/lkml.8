Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D79C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1910208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588853838;
	bh=3mNT4dfpXECmxxzbHr8WQ8lTxsoviUkLflEkHRPjUm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dun9+bwD7wl7gbogV3eWAeu4kwuSGbJSCPnWuQBEp3LWGcbPtBEWnWVY8/XcMEp+T
	 W4WkgCgAoKjLdOU48Wl0cHgJrCMCPmq+pPz6EUSGAY++a5z7vaSbSOEnrLdWwR3+/Z
	 YE+ZMLWEorG/z89FBkmDE4tUeTDo2/ZbY72nHbi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEGMRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:17:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40098 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgEGMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:17:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id u16so6550987wmc.5;
        Thu, 07 May 2020 05:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8vf8a0RtXwF+U6/vuiecNbW1tvIfw6NFoZKkZipDlw=;
        b=bPWVlL9aHkhaZ+kLsbsXd/zFfEUJLsngHlgT1SKrqk3pHFIQwDQ3LwNuE1++anSMFa
         R4YUDhLna7lSqOQG1wHo9Hu93JeHzwrCf74IiSZQZ+Qgz8wrKcErskkS3IcX8LFk6R+1
         wEUh0KQ1VxKPNssJ8n2XWoifyAd14jn2WAhy0Pt9G9m9AY+dPd/bgicWvT7I4892EPPA
         piUbMTo/58ESft6C8uy7XY0/czv/tGFkFO6vgsded0GsrDN/j9lrMORX74Yak65FvHvq
         6a1WB/6/+TVPa3rHNy/M44JpqtGCcu4IzRM3/MfTe+bHG2D2O2Ff3/DNSv9I4TXK/10W
         pz8g==
X-Gm-Message-State: AGi0PuYj9AZ/zBeeSaee9DVeXYvcDnYLSxdEQKzy/Eizq/pGYygYgOrh
        K4UntEbSQ2zaBme3wF4sCkw=
X-Google-Smtp-Source: APiQypKAPCLf4pCrnsBJUWeKWU+a+SQ5cBDiIeIBdVGmTlKz6Y0Zs9Mh9ciJ98+3WJd/ZQnDMsMwsw==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr10274637wmj.86.1588853835178;
        Thu, 07 May 2020 05:17:15 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id a13sm7854976wrv.67.2020.05.07.05.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 05:17:14 -0700 (PDT)
Date:   Thu, 7 May 2020 14:17:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [PATCH] Documentation: update numastat explanation
Message-ID: <20200507121712.GJ6345@dhcp22.suse.cz>
References: <20200507120217.12313-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507120217.12313-1-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-05-20 14:02:17, Vlastimil Babka wrote:
> During recent patch discussion [1] it became apparent that the "other_node"
> definition in the numastat documentation has always been different from actual
> implementation. It was also noted that the stats can be innacurate on systems
> with memoryless nodes.
> 
> This patch corrects the other_node definition (with minor tweaks to two more
> definitions), adds a note about memoryless nodes and also two introductory
> paragraphs to the numastat documentation.
> 
> [1] https://lore.kernel.org/linux-mm/20200504070304.127361-1-sandipan@linux.ibm.com/T/#u
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  Documentation/admin-guide/numastat.rst | 31 +++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/numastat.rst b/Documentation/admin-guide/numastat.rst
> index aaf1667489f8..08ec2c2bdce3 100644
> --- a/Documentation/admin-guide/numastat.rst
> +++ b/Documentation/admin-guide/numastat.rst
> @@ -6,6 +6,21 @@ Numa policy hit/miss statistics
>  
>  All units are pages. Hugepages have separate counters.
>  
> +The numa_hit, numa_miss and numa_foreign counters reflect how well processes
> +are able to allocate memory from nodes they prefer. If they succeed, numa_hit
> +is incremented on the preferred node, otherwise numa_foreign is incremented on
> +the preferred node and numa_miss on the node where allocation succeeded.
> +
> +Usually preferred node is the one local to the CPU where the process executes,
> +but restrictions such as mempolicies can change that, so there are also two
> +counters based on CPU local node. local_node is similar to numa_hit and is
> +incremented on allocation from a node by CPU on the same node. other_node is
> +similar to numa_miss and is incremented on the node where allocation succeeds
> +from a CPU from a different node. Note there is no counter analogical to
> +numa_foreign.
> +
> +In more detail:
> +
>  =============== ============================================================
>  numa_hit	A process wanted to allocate memory from this node,
>  		and succeeded.
> @@ -14,11 +29,13 @@ numa_miss	A process wanted to allocate memory from another node,
>  		but ended up with memory from this node.
>  
>  numa_foreign	A process wanted to allocate on this node,
> -		but ended up with memory from another one.
> +		but ended up with memory from another node.
>  
> -local_node	A process ran on this node and got memory from it.
> +local_node	A process ran on this node's CPU,
> +		and got memory from this node.
>  
> -other_node	A process ran on this node and got memory from another node.
> +other_node	A process ran on a different node's CPU
> +		and got memory from this node.
>  
>  interleave_hit 	Interleaving wanted to allocate from this node
>  		and succeeded.
> @@ -28,3 +45,11 @@ For easier reading you can use the numastat utility from the numactl package
>  (http://oss.sgi.com/projects/libnuma/). Note that it only works
>  well right now on machines with a small number of CPUs.
>  
> +Note that on systems with memoryless nodes (where a node has CPUs but no
> +memory) the numa_hit, numa_miss and numa_foreign statistics can be skewed
> +heavily. In the current kernel implementation, if a process prefers a
> +memoryless node (i.e.  because it is running on one of its local CPU), the
> +implementation actually treats one of the nearest nodes with memory as the
> +preferred node. As a result, such allocation will not increase the numa_foreign
> +counter on the memoryless node, and will skew the numa_hit, numa_miss and
> +numa_foreign statistics of the nearest node.
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
