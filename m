Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E42CC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42579207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579513507;
	bh=ApmvLrELZfhcqYo85uXCVJ2jkuq9HLOrltdH6gt9VeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GZWBA6MiDortxsa/VZ7JrK7zCq09wQegks8ti3YII9RhR0fpJaoYDOTdzV7Tpx0j7
	 JMyfOVL/9UANJ1M+6ViJdPEksJRf/5iPAXCCO5Z4k23U951OBwWODCiiPW93ii4qk+
	 WDBRO0rDrI+AB253C9EbLBVWqssfRhYOzoqFHkuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgATJpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:45:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39016 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgATJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:45:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so13969588wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 01:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3iTVE2tqoMsXkoe3MYL5m+Qa1tyuzuu6FafNlWLs6fA=;
        b=Zw6dt9eK7bWLkBw8QlfTKHdcyQTs6s/Chb1CBsjyB8ZWKkzK5AOWBvequBEidcoxio
         ZeIpJd4JDZMTSiNmlyA02E00/wFvHHlSkVz64fzKgeFnDdfBx1MBTdgjVU7MTue4WPyA
         ehEHgI+sV1QUtiM0Q5IPL6KO6I8CzUVt3JVj3Zfo02otCaS0wk4PhqWZwKh4cIAADgLP
         L7OVskFlTHMpMGA2Bik5+ZCy7sAeHSk2a9XpB55rdDuQ6dYxM0EAeV0T2eqORcE7uGmJ
         kT25xDqi2H9uSJwFawyiV5TQ6wB++Ga2AH+2uajl66rFJ3csz7BgCJwwQJHj9KpQl/Cx
         R/2Q==
X-Gm-Message-State: APjAAAX0Wh/is3ZUJOt9J7LYs20iDYCgBnWQRhVta//hIzuR5BkSsOTZ
        C3PWNkUOXWr4Fws70nwghSs=
X-Google-Smtp-Source: APXvYqxc+QyDCPn3v70sKZ08DTK7X18YnCfsx7bHkx56YHq9wZ3Y9Gou5TTnbYTLpfln7vdgiZJBOw==
X-Received: by 2002:a1c:44d:: with SMTP id 74mr18530043wme.53.1579513504735;
        Mon, 20 Jan 2020 01:45:04 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id t8sm47113310wrp.69.2020.01.20.01.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 01:45:04 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:45:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 2/8] mm/migrate.c: not necessary to check start and i
Message-ID: <20200120094503.GM18451@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119030636.11899-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-01-20 11:06:30, Wei Yang wrote:
> Till here, i must no less than start. And if i equals to start,
> store_status() would always return 0.
> 
> Remove some unnecessary check to make it easy to read and prepare for
> further cleanup.

You are right. This is likely a left over from the development.
i >= start because the former is the actual iterator and start is the
first index with the cached node.

Dropping the check improves readability because one might indeed wonder
why this is the only place to do the check and the overal iteration is
complex enough to add more questions on top.

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/migrate.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ba7cf4fa43a0..c3ef70de5876 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1664,11 +1664,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		err = do_move_pages_to_node(mm, &pagelist, current_node);
>  		if (err)
>  			goto out;
> -		if (i > start) {
> -			err = store_status(status, start, current_node, i - start);
> -			if (err)
> -				goto out;
> -		}
> +		err = store_status(status, start, current_node, i - start);
> +		if (err)
> +			goto out;
>  		current_node = NUMA_NO_NODE;
>  	}
>  out_flush:
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
