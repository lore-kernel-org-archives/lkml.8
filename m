Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D21C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485C92087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579514613;
	bh=PaW4jANCzmziwx1lY3lO8sFPbhBSMCzhtzus4/NBbZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=idPt+hYG944Tm1clMEJ463J1daC3UD+BCRUaH8jvn7B26ouZ9jgZkb3gC2TFoR135
	 vXijhQOzUZXrPMibm2xZfBiISqxoiGAe7m381FpxRsTvk6FhlU41aypvfrI78vxTTp
	 SqG/2kQrUQxAwKOENUZEikwe1/tLept3Xb/DNW+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgATKDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:03:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38354 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgATKDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:03:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so28857957wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cu8cSR4Bnec+tkaO+g7MgIEFj+2elstBE2vN31ryndg=;
        b=KVHbWX5I2uqpT86h/6qJKXhIyYJ+hkf9G4AeUCgdMgKl23qWKIdjrdzIC938CfRxDK
         MmLKKvYt4MJCiybaYrkPbsWvDY25Aq5bscYd6Fq9sMnrwU+pyar6COLIDPjS/htt+W5B
         ByPM7yn48BIhWQkewnqWTZBWUKGb50GtnMj+EYeQh9yyueg1A0l0kri5xAtofIW+pVBE
         i53Kv0nAukYcGvGzlPBiK27alEd05jWXSIobYNeaV3r9BnTtjM4BhKn6FfHzKdeQSMyL
         P3SHT1hRjbGq2QKTuf2xWUR/Iq1yIxIPWvm5Mz0uD7wRBltutXsAuf784I6ebmCgmsgb
         h9AA==
X-Gm-Message-State: APjAAAXW8N2b3b0/VmKJul/cIUOSkwOKxuDDnO81M3nLHc9YK++SRcGp
        qv5eIcR+rttMtFZ4fr27j0KYvhEI
X-Google-Smtp-Source: APXvYqyeM74K8SE2MiQArXPNtrR2i6KIc9h5W4nRAi55aZJhvwJKkUh14I86FL6zXu60sfokmBKNUg==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr17068286wru.318.1579514609772;
        Mon, 20 Jan 2020 02:03:29 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i11sm48193424wrs.10.2020.01.20.02.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 02:03:29 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:03:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 8/8] mm/migrate.c: use break instead of goto out_flush
Message-ID: <20200120100328.GS18451@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-9-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119030636.11899-9-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-01-20 11:06:36, Wei Yang wrote:
> Label out_flush is just outside the loop, so break the loop is enough.

I find the explicit label easier to follow than breaking out of the
loop. Especially when there is another break out of the loop with a
different label.

While the patch is correct I find the resulting code worse readable.

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/migrate.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 2a857fec65b6..59bfae11b9d6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1621,22 +1621,22 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  
>  		err = -EFAULT;
>  		if (get_user(p, pages + i))
> -			goto out_flush;
> +			break;
>  		if (get_user(node, nodes + i))
> -			goto out_flush;
> +			break;
>  		addr = (unsigned long)untagged_addr(p);
>  
>  		/* Check node if it is not checked. */
>  		if (current_node == NUMA_NO_NODE || node != current_node) {
>  			err = -ENODEV;
>  			if (node < 0 || node >= MAX_NUMNODES)
> -				goto out_flush;
> +				break;
>  			if (!node_state(node, N_MEMORY))
> -				goto out_flush;
> +				break;
>  
>  			err = -EACCES;
>  			if (!node_isset(node, task_nodes))
> -				goto out_flush;
> +				break;
>  		}
>  
>  		if (current_node == NUMA_NO_NODE) {
> @@ -1676,9 +1676,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		 */
>  		err = store_status(status, i, err ? : current_node, 1);
>  		if (err)
> -			goto out_flush;
> +			break;
>  	}
> -out_flush:
> +
>  	/* Make sure we do not overwrite the existing error */
>  	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
>  				status, start, i - start - need_move);
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
