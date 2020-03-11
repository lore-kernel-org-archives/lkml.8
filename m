Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A858C4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EF920578
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJy9S47X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgCKTZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:25:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37527 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbgCKTZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:25:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id f16so1550102plj.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=59QKAlzCo20PiQ6XPvSINe/khVSjSi/vS+Up1F5ddTg=;
        b=tJy9S47XsErD9oAp5TQAHmEdVwCNzJg333+Gy7Dlv21uAd8nU1x7ZpuifPgBjoculb
         sGalFcr7RFjYphFG2DvQBkeG0w5ni2bDBdZ4cs9ft/rgRgtTjf+kMvomd7yGOmTvQHJa
         CqpH98qYxbnJ8HHaDo9NulzM+xrnpbYirmo2sZ/NUWSX7QzV2Rz/b/eAU5ObibbUxGsS
         AcxDHhlRrSCq2lLPMx1G5wPuV0G5hWDSdp0bQt+M3DBDsiHlTa7/yIOmJtzQR/b3584i
         kI61/xtVUcu7Cdm1DtV9kdW5t8xUKC3zz0apPNgkltrgo5dC/oECbZ8jj3Jk/+tUQ+qG
         C/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=59QKAlzCo20PiQ6XPvSINe/khVSjSi/vS+Up1F5ddTg=;
        b=EOquGaStyB29wUJ3B+rMOsmppayN/wXHyiHajTewKodMPDydjf/tTRHrgs5Jyd3FJH
         S3/hMef1Yz7/EBhlFuecSsrPMOJK3JGGLrkqwo6nhpCl/7Y1SRYeQPkM+MspjCYUx5OD
         3x0LPiCrort7JF+Lwc99304aVuaVNCu1Utw69Lqi5LUpcY2tDorNqIkKP8PZOZOw4TYZ
         dULifwCjsqQkAz//SyY96F14TvJKunLUCDnbWjlfhFsiWgxkVAGoqVTZLP7j9g1TtANB
         GKKkN2/N0vjx07IQy/Shj3rf6H4i6aV+9B98nxTTzuaAKVHc89ghXDNSu3DyY8OKW92L
         Uokg==
X-Gm-Message-State: ANhLgQ0ZqhT6KB82eR+gIdORhPQz+gD5her9EpkqXqsYk7WBjT4WSRMH
        bTgVoVP6CHW/FY0jH9XjDEro2Q==
X-Google-Smtp-Source: ADFU+vvGy/3Y8m+ciEShHUjkL41A4fyea2QqLF/s4Hpnsgky8XaD+bP70av2ha97jBPDDKorvNbFsA==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr4487286plo.195.1583954722155;
        Wed, 11 Mar 2020 12:25:22 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id s126sm29094656pfb.143.2020.03.11.12.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:25:21 -0700 (PDT)
Date:   Wed, 11 Mar 2020 12:25:20 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>,
        Neha Agarwal <nehaagarwal@google.com>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/hugetlb: remove unnecessary memory fetch in
 PageHeadHuge()
In-Reply-To: <20200311172440.6988-1-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.21.2003111223090.171292@chino.kir.corp.google.com>
References: <20200311172440.6988-1-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Vlastimil Babka wrote:

> Commit f1e61557f023 ("mm: pack compound_dtor and compound_order into one word
> in struct page") changed compound_dtor from a pointer to an array index in
> order to pack it. To check if page has the hugeltbfs compound_dtor, we can
> just compare the index directly without fetching the function pointer.
> Said commit did that with PageHuge() and we can do the same with PageHeadHuge()
> to make the code a bit smaller and faster.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Fixes: f1e61557f023 ("mm: pack compound_dtor and compound_order into one 
word in struct page")

Acked-by: David Rientjes <rientjes@google.com>

[+nehaagarwal]

We've been running with this patch for a few years and it works as 
intended.

> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dd8737a94bec..ba1ca452aa7f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1313,7 +1313,7 @@ int PageHeadHuge(struct page *page_head)
>  	if (!PageHead(page_head))
>  		return 0;
>  
> -	return get_compound_page_dtor(page_head) == free_huge_page;
> +	return page_head[1].compound_dtor == HUGETLB_PAGE_DTOR;
>  }
>  
>  pgoff_t __basepage_index(struct page *page)
