Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23BAC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B659B207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579513011;
	bh=rU1tZr0wiA0xuDG4iu8a4GZuTec6Qu6oxMKGfYmOICU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X0dN53ezPJzH1N7lcviz29k7F47U52BYymFcq7+JjvGS7+LxlbReJ/xzTW7Yw8iq9
	 xu2RXctBIS61dcvhUy2R3viMfdmQg3ZImlU537+wYCWGOLxeLVNCuBUkeIsvIzswJb
	 mwDHKiPJofgEyeMGIGNkaRRbWfA3w6iBG2FvR7SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgATJgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:36:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33470 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:36:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so28775885wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 01:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbCOasBOEdSpgnmOMd9yAHR0ouGjEpqXs0BkDYxSv4Q=;
        b=KFvohQzspbzOVC/9mGmVDbbAwNYQQSP9KcBbaK2zbrojXILd5gsmBDR68FrRxKwnSg
         0uwuw6J3mnq46xhPxJSLkqv1XvJ7xDVS+FkIiDOalDycpoQOZe/X+vl2wq3AMun1OB7j
         uTJzVHhBZrdl5LtN+yLPsf8AxhW6D1htw5FVHZd3iIGXQzClkMYshs1wMnWz77+1ReU9
         SIFsb70oGJ8HRtueKarqK9q/sOlkDf/ucgRnqS00LumHrHV5l+t/VSQMdH66jV+P9Pfz
         YqdP0NpjeUKkOW5uDfHqgGo9uEFiZNtodomEjOp8OgCME7r/3XloATLg9+Y4t5sRtMOQ
         bGCQ==
X-Gm-Message-State: APjAAAVB9lzezpJ3kCe0pV63rHHGXJvgYPPTp1Gh8dc5qB6Fc7wPyNA4
        KX0CObFtqI9ZlbBjDbjQ4h0=
X-Google-Smtp-Source: APXvYqxGS+Q/bpi1ot1FWRFUP5CKPAmVdWKV6iQZEi3QP3a4zdKu/vqZaGcj+HkyGtNaCBXjZXORmQ==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr17108531wrm.262.1579513008584;
        Mon, 20 Jan 2020 01:36:48 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y17sm665482wma.36.2020.01.20.01.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 01:36:47 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:36:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 1/8] mm/migrate.c: skip node check if done in last round
Message-ID: <20200120093646.GL18451@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119030636.11899-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-01-20 11:06:29, Wei Yang wrote:
> Before move page to target node, we would check if the node id is valid.
> In case we would try to move pages to the same target node, it is not
> necessary to do the check each time.
> 
> This patch tries to skip the check if the node has been checked.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/migrate.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 430fdccc733e..ba7cf4fa43a0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1612,15 +1612,18 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  			goto out_flush;
>  		addr = (unsigned long)untagged_addr(p);
>  
> -		err = -ENODEV;
> -		if (node < 0 || node >= MAX_NUMNODES)
> -			goto out_flush;
> -		if (!node_state(node, N_MEMORY))
> -			goto out_flush;
> +		/* Check node if it is not checked. */
> +		if (current_node == NUMA_NO_NODE || node != current_node) {
> +			err = -ENODEV;
> +			if (node < 0 || node >= MAX_NUMNODES)
> +				goto out_flush;
> +			if (!node_state(node, N_MEMORY))
> +				goto out_flush;

This makes the code harder to read IMHO. The original code checks the
valid node first and it doesn't conflate that with the node caching
logic which your change does.

>  
> -		err = -EACCES;
> -		if (!node_isset(node, task_nodes))
> -			goto out_flush;
> +			err = -EACCES;
> +			if (!node_isset(node, task_nodes))
> +				goto out_flush;
> +		}
>  
>  		if (current_node == NUMA_NO_NODE) {
>  			current_node = node;
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
