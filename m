Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51125C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285B320684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579515445;
	bh=Y3DP0Hq6bbOsMQCm7DSOpzWiz+EE22/yhECKZFLXlG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TOQdxbfc38nBtOGa7YvuLfR1D8wggJ8hTDTsf3XlBi2J6igPCWDkEtOtwizDxq3PC
	 O1bqMeJ7d7XTqfU3KMUeKYijPU6xos06hxaxse0/5ztIn3XfDG1WdypvR8mvy09s9g
	 J3tyq+pG+In9uDl2LcYz5k/v7SqZr53pmo12HGhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgATKRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:17:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37836 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgATKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:17:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so28945989wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZWtKAlymkxn/gH1l7V+xHFOqcydyy10v++EHcLObYNk=;
        b=FiwqNvYYaNMOzCyeRqQypMVRRDi68lVdteTmggQjVeH5QDm/vQ3NJLymyI7xb7KFdL
         3RBK9CM+ycPa0pgjVrvRy5C1U9p3O+OQmacE2Yw5FjZ91mzE7zqSftX2w7sTtGogAoDF
         JoZh3p4QX2nmWfoeITtL9Il+4gYAl0dIMa7y6J5ytdgluZFVIhgEljREPEioScPFGXMh
         aLcej5WDsMXeo0ofbvYKb6b6eFxPXLgIVE8Jm65QyEk4uKmwFg2HLpgeoy/XSoRWhjCP
         lqewgvWsy2uO/Q/d57KvDLjS/g0ZGN6ylQYje0ptiqq1DwQ9fvpRj4b579vEs9sFCC68
         WsuQ==
X-Gm-Message-State: APjAAAUEmO0NGURWxXl9toMldy4lc1HBQnRUclta/vhofi9gAn36cgXH
        KF7YzYO+mepPspGwQB10fyc=
X-Google-Smtp-Source: APXvYqw6G6CWyw178bZoCJJYiYvmx7kmBo6dOVR6B1f6aRMKThAMiNGu8thSS9KqYzNS10oKwTjEAA==
X-Received: by 2002:adf:c746:: with SMTP id b6mr17235605wrh.298.1579515441695;
        Mon, 20 Jan 2020 02:17:21 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id q15sm46956102wrr.11.2020.01.20.02.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 02:17:20 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:17:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com
Subject: Re: [Patch v2 2/4] mm/page_alloc.c: bad_[reason|flags] is not
 necessary when PageHWPoison
Message-ID: <20200120101720.GV18451@dhcp22.suse.cz>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120030415.15925-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 11:04:13, Wei Yang wrote:
> Since function returns directly, bad_[reason|flags] is not used any
> where.
> 
> This is a following cleanup for commit e570f56cccd21 ("mm:
> check_new_page_bad() directly returns in __PG_HWPOISON case")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Acked-by: David Rientjes <rientjes@google.com>

This is a left over from loong time ago. AFAICS bad_reason and flags hav
never been used.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0cf6218aaba7..a43b9d2482f2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2051,8 +2051,6 @@ static void check_new_page_bad(struct page *page)
>  	if (unlikely(page_ref_count(page) != 0))
>  		bad_reason = "nonzero _refcount";
>  	if (unlikely(page->flags & __PG_HWPOISON)) {
> -		bad_reason = "HWPoisoned (hardware-corrupted)";
> -		bad_flags = __PG_HWPOISON;
>  		/* Don't complain about hwpoisoned pages */
>  		page_mapcount_reset(page); /* remove PageBuddy */
>  		return;
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
