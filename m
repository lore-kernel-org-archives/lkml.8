Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44ECC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7A020678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bGSSp+1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbgDNQcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391601AbgDNQcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:32:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4CFC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:32:36 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b62so13926007qkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QBdKhl12xvvYi9lcxj1S9EA5zV6NRqJ0DNsgwZaL5f0=;
        b=bGSSp+1WA5PYJleV9ifx6NNnf93E6ao5JcRqKpwnklWFlxyK7FUkcisjZaCRvqQIDY
         XjVzONiep1xbXRC+TQ8OrlINiYy/Z0j7ng22kRs4pG6i7dN4zHeRSmNW5Fq2rsindx9Z
         es8/FlpOaZT4RzmV4YFvcD9/9HR9ySqyzfqtxPxRBNfG5N1eyihCeuzOjfqWBrP7DQyU
         sX6zjLXg1/mYyvzXinc0g9Xg9V7QUFPyD5tjcE6aX9P5wWzAUr3po/BJ4aanhAtyPjN1
         8uTX7UEbD8b6klDvQ8o6lzbJFrXbS+P8ooinQ5r/7/hCxaVslUfBje7vcFcvPzpB21pG
         0nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBdKhl12xvvYi9lcxj1S9EA5zV6NRqJ0DNsgwZaL5f0=;
        b=siFCEkl1L9kuVGdtzTMSKMGMvcXpInoS6R+5RMB77l+4ATUHBA2MJDRnZBBPByZbg7
         zzdXgZsj1FZzXTf8yPzdU6SxSPTilNKum/xdnSDePqvC8ie6PpvvbtkhuFf1YmRMXDPX
         s54UwSI7VxYetEWvE95LVhmajkI6EVcbrdmcKy6qZQug5+GrtPgX2kCW1JyNYN6nO/5n
         wWm47tB+LVM2M805FJ77tLK9ULzJ0/aWNLU4SINR7L2BKzXv04EEktn0VhsbgVAHvDHW
         OwqXw5+D4L9EgW4xhhAl2R7Jk2P8SzQ6wMzEPJORbHQDfIM3TtK8CUPkSJ6AU/wUgC70
         +4Wg==
X-Gm-Message-State: AGi0Pub9NGM8ZKMYjgF5TfZbSrNnUCGg7Tz2Tp2xpDa7Lq0+gnLgRghW
        iX/JTy3Cae9jFleZdTDMI29pcg==
X-Google-Smtp-Source: APiQypL35bvylggzZE0yMT8vcGrCFxCjV/OJPpuQpN3/dXZvvHERYdDgIWBReT0U8zOAMVy0imoEUw==
X-Received: by 2002:a37:6393:: with SMTP id x141mr3886719qkb.179.1586881955711;
        Tue, 14 Apr 2020 09:32:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m1sm11597515qtm.22.2020.04.14.09.32.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 09:32:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOOUE-0006Ly-OX; Tue, 14 Apr 2020 13:32:34 -0300
Date:   Tue, 14 Apr 2020 13:32:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/gup: dereference page table entry using helper
Message-ID: <20200414163234.GG5100@ziepe.ca>
References: <1586877001-19138-1-git-send-email-agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586877001-19138-1-git-send-email-agordeev@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:10:01PM +0200, Alexander Gordeev wrote:
> Commit 0005d20 ("mm/gup: Move page table entry dereference
> into helper function") wrapped access to page table entries
> larger than sizeof(long) into a race-aware accessor. One of
> the two dereferences in gup_fast path was however overlooked.
> 
> CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> CC: linux-mm@kvack.org
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index d53f7dd..eceb98b 100644
> +++ b/mm/gup.c
> @@ -2208,7 +2208,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		if (!head)
>  			goto pte_unmap;
>  
> -		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> +		if (unlikely(pte_val(pte) != pte_val(gup_get_pte(ptep)))) {

It doesn't seem like this needs the special helper as it is just
checking that the pte hasn't changed, it doesn't need to be read
exactly.

But it probably should technically still be a READ_ONCE. Although I
think the atomic inside try_grab_compound_head prevents any real
problems.

Jason
