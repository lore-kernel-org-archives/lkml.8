Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F55FC35247
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668E52168B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 09:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580117806;
	bh=tNG7JQBJuo7xmIstT57a7SplYqcXx9rISKLRqNDpUXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LpNFwKyFy81Kkw1eqoi8KdpLntoWz3Fwfn3f8t+xC3+g6vixmrUQzIYYUlnzoboze
	 3QAKr88Sot9y3+CZ4IKnzf++NsNQuuq7xdQcHTk5fBc/wImhgvc+51v/K/TfiMSuIc
	 fldkgvheMla3PRJu7yI3d1oCMiJgafnFL9Qn0EC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgA0Jgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 04:36:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33068 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgA0Jgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:36:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so8162588wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 01:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=roaLqSgfifGJecXUxqExqg9D+N1Onbxp/Fi3I5fIEaA=;
        b=kjCyjXcFJYTfH3dCZhVOMTGXpnN+asyJYi8J5+buwivC0/bEXJFP7TgWD3+l4BE7Wp
         IxHpE9nO+TZMzxsOFxwg1RWcLWwc+X+rOIM8vf1+uRKHDv7NKgbXdTI0L8qpDEz+kJh9
         Oo97ZpyQcvGV1EaUSiPlfVhBHHbJG7OXjzK99NNsy36Qm2B2jOTm7NZ8vjEWiwdd3w0N
         E12oNocAkeyutuk2nC06DWXWUKTubo5BrQPfLNHWXsM0eDfMv6wz18WAhkDT0Ya7srqv
         U8rTv3mG3rWRqoqeJ31Pj/4b3SwDqRdmESLPzo0nGWoG0FazcAeursymXDgeLDccxUQ7
         Q8NA==
X-Gm-Message-State: APjAAAUEfkmk4Ia+EfKCviG9Su76g4ZvvR0Zf6MgSi5jFhOfS3zpb5Ik
        9X20tld5cGG1eNInJ64qZHGmoJVM
X-Google-Smtp-Source: APXvYqyCSkoSqviTOB9m5+1RyOePsliXdw7B+S2zPPzWCj4fnNv5Q7mZh8Ou0Fkk4d7TXGszmcMZNA==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr12429547wme.53.1580117803298;
        Mon, 27 Jan 2020 01:36:43 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id t10sm8734812wmi.40.2020.01.27.01.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 01:36:42 -0800 (PST)
Date:   Mon, 27 Jan 2020 10:36:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 2/4] mm/migrate.c: wrap do_move_pages_to_node() and
 store_status()
Message-ID: <20200127093642.GC1183@dhcp22.suse.cz>
References: <20200126102623.9616-1-richardw.yang@linux.intel.com>
 <20200126102623.9616-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126102623.9616-3-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 26-01-20 18:26:21, Wei Yang wrote:
> Usually do_move_pages_to_node() and store_status() is a pair. There are
> three places call this pair of functions with almost the same form.
> 
> This patch just wrap it to make it friendly to audience and also
> consolidate the move and store action into one place.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

I believe I have already acked this one. Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/migrate.c | 61 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ae3db45c6a42..e816c8990296 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1583,6 +1583,29 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  	return err;
>  }
>  
> +static int move_pages_and_store_status(struct mm_struct *mm, int node,
> +		struct list_head *pagelist, int __user *status,
> +		unsigned long nr_pages, int start, int i)
> +{
> +	int err;
> +
> +	err = do_move_pages_to_node(mm, pagelist, node);
> +	if (err) {
> +		/*
> +		 * Positive err means the number of failed
> +		 * pages to migrate.  Since we are going to
> +		 * abort and return the number of non-migrated
> +		 * pages, so need incude the rest of the
> +		 * nr_pages that have not attempted as well.
> +		 */
> +		if (err > 0)
> +			err += nr_pages - i - 1;
> +		return err;
> +	}
> +	err = store_status(status, start, node, i - start);
> +	return err;
> +}
> +
>  /*
>   * Migrate an array of page address onto an array of nodes and fill
>   * the corresponding array of status.
> @@ -1626,20 +1649,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  			current_node = node;
>  			start = i;
>  		} else if (node != current_node) {
> -			err = do_move_pages_to_node(mm, &pagelist, current_node);
> -			if (err) {
> -				/*
> -				 * Positive err means the number of failed
> -				 * pages to migrate.  Since we are going to
> -				 * abort and return the number of non-migrated
> -				 * pages, so need incude the rest of the
> -				 * nr_pages that have not attempted as well.
> -				 */
> -				if (err > 0)
> -					err += nr_pages - i - 1;
> -				goto out;
> -			}
> -			err = store_status(status, start, current_node, i - start);
> +			err = move_pages_and_store_status(mm, current_node,
> +					&pagelist, status, nr_pages,
> +					start, i);
>  			if (err)
>  				goto out;
>  			start = i;
> @@ -1668,13 +1680,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		if (err)
>  			goto out_flush;
>  
> -		err = do_move_pages_to_node(mm, &pagelist, current_node);
> -		if (err) {
> -			if (err > 0)
> -				err += nr_pages - i - 1;
> -			goto out;
> -		}
> -		err = store_status(status, start, current_node, i - start);
> +		err = move_pages_and_store_status(mm, current_node, &pagelist,
> +				status, nr_pages, start, i);
>  		if (err)
>  			goto out;
>  		current_node = NUMA_NO_NODE;
> @@ -1684,16 +1691,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		return err;
>  
>  	/* Make sure we do not overwrite the existing error */
> -	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
> -	/*
> -	 * Don't have to report non-attempted pages here since:
> -	 *     - If the above loop is done gracefully there is not non-attempted
> -	 *       page.
> -	 *     - If the above loop is aborted to it means more fatal error
> -	 *       happened, should return err.
> -	 */
> -	if (!err1)
> -		err1 = store_status(status, start, current_node, i - start);
> +	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
> +			status, nr_pages, start, i);
>  	if (err >= 0)
>  		err = err1;
>  out:
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
