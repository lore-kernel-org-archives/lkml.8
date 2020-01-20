Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41066C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154EA207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579513794;
	bh=nYqMncCIpghnrUZvl3uMKKWHSmIGLB8woiWpgN/zCtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O9ix1Hq+GWIJMhU1Les0XlYgNoIk1+0gpPXt/rcMB/RChDbvROr2VoMfTyczLd71A
	 uQ6NuBcEESVMEf+MKqUuTxV86x8lF5N2QxA1Ggx6bCWimKqQkKBMwVQgQI+UnZgp88
	 dEL4AmL0FLXUVT1HQIelz4qxv++fF4SNtz4t96s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgATJtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:49:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40807 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:49:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so28775657wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 01:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=96Yk+QoVaIwO+HNATcLRzJaQ7QQbxKQlungEeYBl4+M=;
        b=HgH1hssnBEx9nhKlL6Cnu1r0qsGwHX62YLs1RQZIBZjKbgI/bvshaeSYYC4xs6DO+K
         m2X101z6AWV1Kpymu+vBmFEGYpny0rgXwsZERIiifKCHgyP0OrwIpnFFoKCejVnZBy8N
         11RPzBqwPkrkJe9rgU3Yf268U7gVXz/A4fuEd7nHqcg0wVtRypCIh/JWkmB5RZBeDr/I
         yUWhBuo6za1D5RmlUM/Nu8HrZ9Ebpzc7bGXQBqevtPtRg9PLzELSUUDO2WZpj+Tp7w+W
         4aHn6qTVLFwgNCO2dEpmqKymcMoQy9Nb9LVpFGvDMZ+yw7Z4JQuOussr5mU3EknYIqpe
         ZCLw==
X-Gm-Message-State: APjAAAW6/7JCZWahUTBUR2SFs+xsvU+b6jMymDqceDp3W8dKq0ZtlzSM
        SCHNUrNAt1bpXr+aSOm/JJ8=
X-Google-Smtp-Source: APXvYqzbw5Za9L5kGrGJOgeUCwtft8uNLTozwyqXlPcbUsvotfIBnuXbs5z4lnwBX8OydnoENyHQig==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr17698671wru.296.1579513791059;
        Mon, 20 Jan 2020 01:49:51 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s8sm45542497wrt.57.2020.01.20.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 01:49:50 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:49:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 4/8] mm/migrate.c: wrap do_move_pages_to_node() and
 store_status()
Message-ID: <20200120094949.GO18451@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-5-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119030636.11899-5-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-01-20 11:06:32, Wei Yang wrote:
> Usually do_move_pages_to_node() and store_status() is a pair. There are
> three places call this pair of functions with almost the same form.
> 
> This patch just wrap it to make it friendly to audience and also
> consolidate the move and store action into one place. Also mentioned by
> Yang Shi, the handling of do_move_pages_to_node()'s return value is not
> proper. Now we can fix it in one place.

The helper helps here indeed. Thanks this makes the code easier to read.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/migrate.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4a63fb8fbb6d..dec147d3a4dd 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1583,6 +1583,19 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  	return err;
>  }
>  
> +static int move_pages_and_store_status(struct mm_struct *mm, int node,
> +		struct list_head *pagelist, int __user *status,
> +		int start, int nr)
> +{
> +	int err;
> +
> +	err = do_move_pages_to_node(mm, pagelist, node);
> +	if (err)
> +		return err;
> +	err = store_status(status, start, node, nr);
> +	return err;
> +}
> +
>  /*
>   * Migrate an array of page address onto an array of nodes and fill
>   * the corresponding array of status.
> @@ -1629,10 +1642,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  			current_node = node;
>  			start = i;
>  		} else if (node != current_node) {
> -			err = do_move_pages_to_node(mm, &pagelist, current_node);
> -			if (err)
> -				goto out;
> -			err = store_status(status, start, current_node, i - start);
> +			err = move_pages_and_store_status(mm, current_node,
> +					&pagelist, status, start, i - start);
>  			if (err)
>  				goto out;
>  			start = i;
> @@ -1661,10 +1672,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		if (err)
>  			goto out_flush;
>  
> -		err = do_move_pages_to_node(mm, &pagelist, current_node);
> -		if (err)
> -			goto out;
> -		err = store_status(status, start, current_node, i - start);
> +		err = move_pages_and_store_status(mm, current_node, &pagelist,
> +				status, start, i - start);
>  		if (err)
>  			goto out;
>  		current_node = NUMA_NO_NODE;
> @@ -1674,13 +1683,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		return err;
>  
>  	/* Make sure we do not overwrite the existing error */
> -	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
> -	if (err1) {
> -		if (err >= 0)
> -			err = err1;
> -		goto out;
> -	}
> -	err1 = store_status(status, start, current_node, i - start);
> +	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
> +				status, start, i - start);
>  	if (err >= 0)
>  		err = err1;
>  out:
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
