Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D39C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D5A207D8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fmGWyJlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgFET6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgFET6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:58:52 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FFDC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 12:58:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c14so10986268qka.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgzDVTZwme/KA/wq7BoOxreHRs0A8AWUEwZnRHhNBHk=;
        b=fmGWyJlttqUpc/2hHZ58g5DtXi3bE0riIRvjTtX8mmQUfarEOKkujUK50cyZluGohZ
         vdw1TjIxlPXAjfDwBXr13MtcaLV5Cu4D1/7m2Tr8Xi72u68YETQW5m+k4iffnXKCg6Df
         9ZwsXbZ7FzycF3HlyMEzqGPCqEmvkzR6IN2bdwBntAy4Ax4y0DgJa03Qm0Ro3cVxSKAX
         zC0c+nwnK9n7m6V5WcukdlIsUAjDsC1yMvppQFTJ/mfgFJ+dvskROEAxdmA5EI4gAU6E
         WeK1ydWr5sj9ivTbqeqgxJanI6kNPZi2o1hS0oo008yH/c6VznfyzluIA23cRcD4FoTg
         Uksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgzDVTZwme/KA/wq7BoOxreHRs0A8AWUEwZnRHhNBHk=;
        b=cBtzbwnOuZk9/IcDdiRpvcSvMFqeEVgAlfg9ca6t15Ydc9EGCdKa8JWD5pT2zSi5vW
         gVL0CXg0ueE1NDFjmOMxZ900SmB7K4tkJH+lBULjOWpKMv3m0VM2Dw356AzjGkjLLavb
         kjyVz3I6Nu/tMpRf5hdveA458d2fa/Ie8jVAC19MQ34Hdnttp5FeQDQf+PCefsBl3qjt
         +Ri9ET/T2oCs06IUa8UxFRN1G/8Y3mNNFjz/mhpJXUgcRi8WjxsqhmimqqcqnBgSzeoY
         9sD8CD82DGd1oDdtZV7JW5OLkffJ06BZn7jnqN9E7i4rU4F25Ct8LTliZo356uwpAkQk
         nLAA==
X-Gm-Message-State: AOAM530K11GNrXd/p7j9W0aBLfgQjH661pLO2pMGJKXuYJ3NvVJB+g3m
        ZgYljT3RWl6VydP42D0Kgs5PGQDXjUwaYA==
X-Google-Smtp-Source: ABdhPJx8LUVTacTIB+DgOKgb+9pKMpWqqOfTenp8TMp0cCJl6ShSLdrxzQAHVUcRaPtO+Ot0LktvyQ==
X-Received: by 2002:a37:a981:: with SMTP id s123mr11649117qke.106.1591387130987;
        Fri, 05 Jun 2020 12:58:50 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 126sm672989qkj.89.2020.06.05.12.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 12:58:50 -0700 (PDT)
Date:   Fri, 5 Jun 2020 15:58:48 -0400
From:   Qian Cai <cai@lca.pw>
To:     linux-kernel@vger.kernel.org
Cc:     dave@stgolabs.net, manfred@colorfullife.com,
        mm-commits@vger.kernel.org, willy@infradead.org,
        akpm@linux-foundation.org
Subject: Re: + ipc-convert-ipcs_idr-to-xarray-update.patch added to -mm tree
Message-ID: <20200605195848.GB5393@lca.pw>
References: <20200420181310.c18b3c0aa4dc5b3e5ec1be10@linux-foundation.org>
 <20200424014753.DfBuzjmzo%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424014753.DfBuzjmzo%akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 06:47:53PM -0700, Andrew Morton wrote:
> ------------------------------------------------------
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Subject: ipc-convert-ipcs_idr-to-xarray-update
> 
> implemant change suggested by Manfred
> 
> Link: http://lkml.kernel.org/r/20200421183342.GQ5820@bombadil.infradead.org
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  include/linux/xarray.h |    1 
>  ipc/util.c             |   52 +++++++++++++++------------------------
>  lib/xarray.c           |    2 -
>  3 files changed, 21 insertions(+), 34 deletions(-)
> 
[]
> --- a/ipc/util.c~ipc-convert-ipcs_idr-to-xarray-update
> +++ a/ipc/util.c
> @@ -210,52 +210,40 @@ static inline int ipc_id_alloc(struct ip
>  	int err;
>  
>  	if (get_restore_id(ids) < 0) {
> -		XA_STATE(xas, &ids->ipcs, 0);
> -		int min_idx, max_idx;
> +		int max_idx;
>  
>  		max_idx = max(ids->in_use*3/2, ipc_min_cycle);
>  		max_idx = min(max_idx, ipc_mni) - 1;
>  
> -		xas_lock(&xas);
> +		xa_lock(&ids->ipcs);
>  
> -		min_idx = ids->next_idx;
> -		new->seq = ids->seq;
> +		err = __xa_alloc_cyclic(&ids->ipcs, &idx, NULL,
> +				XA_LIMIT(0, max_idx), &ids->next_idx,
> +				GFP_KERNEL);

This will trigger,

[ 8853.759549] LTP: starting semget05
[ 8867.257088] BUG: sleeping function called from invalid context at mm/slab.h:567
[ 8867.270259] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 22556, name: semget05
[ 8867.270309] 2 locks held by semget05/22556:
[ 8867.270345]  #0: 00000000512de7e0 (&ids->rwsem){++++}-{3:3}, at: ipcget+0x4e/0x230
[ 8867.270426]  #1: 00000000552b9018 (&new->lock){+.+.}-{2:2}, at: ipc_addid+0xf4/0xf50
[ 8867.270495] CPU: 0 PID: 22556 Comm: semget05 Not tainted 5.7.0-next-20200605 #4
[ 8867.270531] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
[ 8867.270565] Call Trace:
[ 8867.270606]  [<000000004ff1ee2a>] show_stack+0x11a/0x1c8
[ 8867.270649]  [<00000000505a751c>] dump_stack+0x134/0x180
[ 8867.270692]  [<000000004ffba20e>] ___might_sleep+0x3d6/0x400
[ 8867.270732]  [<0000000050332ad8>] kmem_cache_alloc+0x2b0/0x560
[ 8867.270772]  [<00000000505c6efa>] __xas_nomem+0x10a/0x278
[ 8867.270810]  [<00000000505cc408>] __xa_alloc+0x168/0x220
[ 8867.270848]  [<00000000505cc5b0>] __xa_alloc_cyclic+0xf0/0x208
__xa_alloc_cyclic at lib/xarray.c:1698
[ 8867.270885]  [<00000000504d9b9a>] ipc_addid+0x412/0xf50
ipc_id_alloc at ipc/util.c: 293
[ 8867.272003]  [<00000000504e1cf6>] newary+0x246/0x3a0
newary at ipc/sem.c:570
[ 8867.272041]  [<00000000504dc030>] ipcget+0x68/0x230
ipcget_new at ipc/util.c:347
(inlined by) ipcget at ipc/util.c:646
[ 8867.272079]  [<00000000504e6308>] ksys_semget+0xf8/0x118
[ 8867.273237]  [<00000000504eb5bc>] ksys_ipc+0x134/0x310
[ 8867.273276]  [<000000004ff08f64>] __s390x_sys_s390_ipc+0x3c/0x50
[ 8867.273321]  [<00000000509063c4>] system_call+0xdc/0x29c
[ 8867.273355] 2 locks held by semget05/22556:
[ 8867.273387]  #0: 00000000512de7e0 (&ids->rwsem){++++}-{3:3}, at: ipcget+0x4e/0x230
[ 8867.275205]  #1: 00000000552b9018 (&new->lock){+.+.}-{2:2}, at: ipc_addid+0xf4/0xf50

