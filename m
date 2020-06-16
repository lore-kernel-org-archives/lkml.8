Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89654C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FFF208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="acRvEnLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbgFPUS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbgFPUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:18:57 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6A2C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:18:57 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g5so16990894otg.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5OcMZK0pIGG+xHLzfApAVvfMiSRe3c77ecNoi1ZxYsc=;
        b=acRvEnLAKUl45yhbSb5Acwnee3bW4VJQVY1BLJ2hsepfm6/dj+FoLtbkSd4s+dJnhB
         jpAs08a6XpEPDpdSekXGPRNJ0uNyM+wFVUwEasiIdzcG5hp01rqI/aq4Irorf2QqwI7u
         wemXPg7vMZvPip+snIpyPE/zinPNWeh18ch96GYLSaVxD4MzcM3oCnQVEy4Eil2mpqxQ
         WgZSNnS0kd0HzZnPTt5svSXHbOFyjW1M41wT+dRee2fI9dtx71rduUQB00Q0VRQ2udZG
         PeECt8Bw+dfaxAJmAXRclNQVSalnP5Lkb3H3DtBEDIezd8jOdg2T72b6uGYLdxSEAC07
         FBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5OcMZK0pIGG+xHLzfApAVvfMiSRe3c77ecNoi1ZxYsc=;
        b=PTZdxN+BpONkvNGUewjUTNlTUrOkOZFiVpiss5ZwaEmiEMrWyAbotbEUOD53HF6Yoo
         5ZlTxGVFHnnSN1TuWEyuRQJz80E5rAphGMvaYPk1aPTkF/7ChY1OLI/QanWWN0LJPQeQ
         9G3YIdUN/jgyKKtu8aFauyXh7ZUPh38uBcnB9fRH0GrlymKpJVYh3vYylSvDyQHwAuqH
         W67TPRd6wKdZXZ6GwW8JF6+D8j3y4Q5kduvMXGpeohPo3+s/ScwW+KbONfX5Iia07jO0
         zHvkAd2Uc8CCZHYM3VbpwsSJoSXluZ2C4w7wFAIKsW4MffXDGTcAR3urMWejfXqnSrYN
         W/zA==
X-Gm-Message-State: AOAM531L9OQwu7ioDncvkvnr2D91+aFkvHD2Nk11KVnqq0udWQWSgSKk
        zDASZDI+ud8sq8Wi0ni+GW/e2A==
X-Google-Smtp-Source: ABdhPJzSqLU4z7tKM4zTa37oGY9FKrc/afCUXskGLirSHGMztvd7XlkWk5gSy8MKJ5BKXnpv1OIqgQ==
X-Received: by 2002:a05:6830:4a2:: with SMTP id l2mr3812104otd.10.1592338735936;
        Tue, 16 Jun 2020 13:18:55 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 94sm4268169otb.47.2020.06.16.13.18.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2020 13:18:54 -0700 (PDT)
Date:   Tue, 16 Jun 2020 13:18:40 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        liwang@redhat.com, mgorman@techsingularity.net,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, compaction: make capture control handling safe
 wrt interrupts
In-Reply-To: <20200616082649.27173-1-vbabka@suse.cz>
Message-ID: <alpine.LSU.2.11.2006161316230.1119@eggly.anvils>
References: <b17acf5b-5e8a-3edf-5a64-603bf6177312@suse.cz> <20200616082649.27173-1-vbabka@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, Vlastimil Babka wrote:

> Hugh reports:
> 
> =====
> While stressing compaction, one run oopsed on NULL capc->cc in
> __free_one_page()'s task_capc(zone): compact_zone_order() had been
> interrupted, and a page was being freed in the return from interrupt.
> 
> Though you would not expect it from the source, both gccs I was using
> (a 4.8.1 and a 7.5.0) had chosen to compile compact_zone_order() with
> the ".cc = &cc" implemented by mov %rbx,-0xb0(%rbp) immediately before
> callq compact_zone - long after the "current->capture_control = &capc".
> An interrupt in between those finds capc->cc NULL (zeroed by an earlier
> rep stos).
> 
> This could presumably be fixed by a barrier() before setting
> current->capture_control in compact_zone_order(); but would also need
> more care on return from compact_zone(), in order not to risk leaking
> a page captured by interrupt just before capture_control is reset.
> 
> Maybe that is the preferable fix, but I felt safer for task_capc() to
> exclude the rather surprising possibility of capture at interrupt time.
> =====
> 
> I have checked that gcc10 also behaves the same.
> 
> The advantage of fix in compact_zone_order() is that we don't add another
> test in the page freeing hot path, and that it might prevent future problems
> if we stop exposing pointers to unitialized structures in current task.
> 
> So this patch implements the suggestion for compact_zone_order() with barrier()
> (and WRITE_ONCE() to prevent store tearing) for setting
> current->capture_control, and prevents page leaking with WRITE_ONCE/READ_ONCE
> in the proper order.
> 
> Fixes: 5e1f0f098b46 ("mm, compaction: capture a page under direct compaction")
> Cc: stable@vger.kernel.org # 5.1+
> Reported-by: Hugh Dickins <hughd@google.com>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/compaction.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index fd988b7e5f2b..86375605faa9 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2316,15 +2316,26 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
>  		.page = NULL,
>  	};
>  
> -	current->capture_control = &capc;
> +	/*
> +	 * Make sure the structs are really initialized before we expose the
> +	 * capture control, in case we are interrupted and the interrupt handler
> +	 * frees a page.
> +	 */
> +	barrier();
> +	WRITE_ONCE(current->capture_control, &capc);
>  
>  	ret = compact_zone(&cc, &capc);
>  
>  	VM_BUG_ON(!list_empty(&cc.freepages));
>  	VM_BUG_ON(!list_empty(&cc.migratepages));
>  
> -	*capture = capc.page;
> -	current->capture_control = NULL;
> +	/*
> +	 * Make sure we hide capture control first before we read the captured
> +	 * page pointer, otherwise an interrupt could free and capture a page
> +	 * and we would leak it.
> +	 */
> +	WRITE_ONCE(current->capture_control, NULL);
> +	*capture = READ_ONCE(capc.page);
>  
>  	return ret;
>  }
> -- 
> 2.27.0
