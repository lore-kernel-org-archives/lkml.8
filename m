Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84816C33CB8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5747720684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579514473;
	bh=OO9HfJOqOkLZ4+13PKRs0SRcpQaNaN/ageKFiF7TTo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k4wbJwab5FbXQWvXZMr0ne+0cGtvJtTvgX1Dn2bAf/X+602BjqHYUP2w6tIm/0TMx
	 F3irLcRghI6W/p6e9B/hg/dOfp0GI65904irBc7Iz7dRgJHR31nDt1eZ+4IAmI0Bi/
	 f/y7bh5prLQlOfx0ntgXu30Ei7Jx9lrLOVtOI+6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgATKBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:01:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39915 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:01:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so14024429wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jxk5yp1oVvwf0kXhOVENyg67VI0xjVmnjfrfkil0lfs=;
        b=lkw0/Pc/OUnP/nDF9ObLFEISqGVrz7LHMJL2KikmIaIbUxdGbMFYtJ4dhkE4ZUyIMl
         CmoBhxZFlWNO2Qv2/FWm5JWxqFNJueI6OQBiGaLBDfX0w6Ru86dVxm/uBq3kWRcC9Pvl
         a3CNF3aqeNKqpspBb1/S8Vg5nTXFo42PFz6HZx0iyaQ+IovC/m99C/Js7lipIQSR7dLo
         a9vsywDoucq3a8Uk7SydyNFj77Lz9NYVpzLY9umcCdZ7K4GBL1riWuEHPf1dEx1yw/Su
         P5Hq8GPmU52t9tEJxOxF/cdQwyHAF8XjjbyALg3rUXgCc0iOVrbDzF6iACJ5Srr4jtAy
         QQMA==
X-Gm-Message-State: APjAAAWTTNYM58pZv7d/698UrMwznH3B3zSYpED/9v2Qke6LICn0L1wx
        luC310PpIxgaW1iayUkRWDCdS7GV
X-Google-Smtp-Source: APXvYqxYBuIQmfBusK7EhcIIuQra7HOCCwsHpk+12XqToXyw5GLSis2BrXeymZqh4TW0/qsUevxd+Q==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr17772687wma.84.1579514470363;
        Mon, 20 Jan 2020 02:01:10 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id z21sm22219218wml.5.2020.01.20.02.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 02:01:09 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:01:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 6/8] mm/migrate.c: handle same node and add failure in
 the same way
Message-ID: <20200120100108.GQ18451@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-7-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119030636.11899-7-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-01-20 11:06:34, Wei Yang wrote:
> When page is not queued for migration, there are two possible cases:
> 
>   * page already on the target node
>   * failed to add to migration queue
> 
> Current code handle them differently, this leads to a behavior
> inconsistency.
> 
> Usually for each page's status, we just do store for once. While for the
> page already on the target node, we might store the node information for
> twice:
> 
>   * once when we found the page is on the target node
>   * second when moving the pages to target node successfully after above
>     action
> 
> The reason is even we don't add the page to pagelist, but store_status()
> does store in a range which still contains the page.
> 
> This patch handles these two cases in the same way to reduce this
> inconsistency and also make the code a little easier to read.

Yeah, the improvement is really marginal. I do not feel strongly one way
or another.

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/migrate.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 46a5697b7fc6..aee5aeb082c4 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1657,18 +1657,18 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		err = add_page_for_migration(mm, addr, current_node,
>  				&pagelist, flags & MPOL_MF_MOVE_ALL);
>  
> -		if (!err) {
> -			/* The page is already on the target node */
> -			err = store_status(status, i, current_node, 1);
> -			if (err)
> -				goto out_flush;
> -			continue;
> -		} else if (err > 0) {
> +		if (err > 0) {
>  			/* The page is successfully queued for migration */
>  			continue;
>  		}
>  
> -		err = store_status(status, i, err, 1);
> +		/*
> +		 * Two possible cases for err here:
> +		 * == 0: page is already on the target node, then store
> +		 *       current_node to status
> +		 * <  0: failed to add page to list, then store err to status
> +		 */
> +		err = store_status(status, i, err ? : current_node, 1);
>  		if (err)
>  			goto out_flush;
>  
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
