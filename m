Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2996C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9705E2078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RzbSKO81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgH3To1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3To0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:44:26 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48B7C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 12:44:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v54so1929908qtj.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QoYBG+NdvSoV67EJFnNPS8VrfY8dUEpoMzW4ry+0U34=;
        b=RzbSKO81qmP1eLps/rkRqQzVUa1f7zqzafevh0NnckQcDGIThq6UIy3hOzQd/NlGWc
         sEeGZdDbmA8fs71t6MlRUb1P+s+IviJ5f8C6iIncHe9y7vkK84U3pZvR6jO22VEDUdOc
         f44u3RVjghATDMih631DsjlkArTbkzIZbVOorQ/mo5FrUUiL+YL/0Jck3lZcZmzv0/7H
         96fBi9FqdwN+/QhbFSL3z7li3XLRQvgiE3C0O3ZpQEGIiHjcf06SBfxSylprnz6m8POF
         jqzUr2dyJLgjNp5r2WqHRUWAX7P3iUplFBsRh2ce1YKxN5l2nqYNITcdPCkCHA66NhRt
         3QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QoYBG+NdvSoV67EJFnNPS8VrfY8dUEpoMzW4ry+0U34=;
        b=NPv7LNG0nO09rapwH8vqfyBf+uI+NxFPOJedCQUriQjvhluPZn1HnAyH76qVimUi4K
         hxoEwJhT+VPCX9zW7H7wT0HXC4SQX0R5OIwqShAZ3hYbYKo7LB9me9lw43dGPI9m7PPq
         iv3BC9qWnwtubSFJp1aLT3sPAZl8t3I4kbmf+ssxUO+MWOE48pAXujZUjQr0iNlmaifz
         0xQHC3rxWnlzLOH2BboJv1im4Iqss9df1gcX8sIlWOw5wQqA7e/MxWZGEPRume3trwIo
         m/vneFP92Ml6CV+DpVVS1PtBiHAduTS/gvxjVFKgrNOswJnQRx5NmTQNNljz7Sq/KWH8
         OK6A==
X-Gm-Message-State: AOAM533Y6i3qc8qevyVp4YTy7L+eQCqxJ3TEeszhsVbELCxpOx69J434
        lcDbvz8Uyp+TeLCBjGEAw6RPuY8HRVXf7w==
X-Google-Smtp-Source: ABdhPJzIg+NxRrWFIHRyJ4fldNEtjunYm4joab7Mtjszsd8aqaUoA6nVgieTxVtPiQFxdvVm3Yn9tQ==
X-Received: by 2002:ac8:4e49:: with SMTP id e9mr9749096qtw.91.1598816664976;
        Sun, 30 Aug 2020 12:44:24 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k63sm6647539qkf.33.2020.08.30.12.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 12:44:24 -0700 (PDT)
Date:   Sun, 30 Aug 2020 15:44:18 -0400
From:   Qian Cai <cai@lca.pw>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: Fix return wrong value when isolate
 page fail
Message-ID: <20200830194417.GA4039@lca.pw>
References: <20200830081053.64981-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830081053.64981-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 04:10:53PM +0800, Muchun Song wrote:
> When we isolate page fail, we should not return 0, because we do not
> set page HWPoison on any page.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This seems solve the problem for me that madvise(MADV_SOFT_OFFLINE) will run
into ENOMEM eventually:

https://lore.kernel.org/lkml/20200811220643.GB39857@lca.pw/

Reviewed-by: Qian Cai <cai@lca.pw>

> ---
>  mm/memory-failure.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 696505f56910..4eb3c42ffe35 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1850,6 +1850,7 @@ static int __soft_offline_page(struct page *page)
>  	} else {
>  		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
>  			pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
> +		ret = -EBUSY;
>  	}
>  	return ret;
>  }
> -- 
> 2.11.0
> 
> 
