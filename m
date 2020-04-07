Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A00C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC21B206F5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586243016;
	bh=LytVc/o3dJSC/P8WRBr9Oe46Yn+qbrEACTCuLCGSB+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NP2pFsSdKEZsfvXKIisl+GdHYBCACqEBVYtrEOwShYLX7c29l/ESritoqvuVrfLdL
	 CFRSPhJsBYCAqd8pzVm3sxC4KeVBgOrDsmvDhf8bwsN8HCgSzvxZt+0zTFsM4Lcs5X
	 PWplw2O/OW6/VjkIHGRzlgHTVYXZPzYzpvgen1dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgDGHDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:03:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53084 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGHDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:03:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id t203so616926wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 00:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXO3P9SmStpo/qxz2PlNziez/h+6PQpILt/U0iNyx7w=;
        b=if5o+P/eEHZnwg6OHQr0lZImsOyRyL1yoVAagZHqHjDGmQA3Q5i9LisLqenU5Fkcd2
         +1GQEk1Q7ubq+3wLFgTpRG/SNPNw9uuCiDqPrnkoVoRJq8PHPlz5XBx+MdZLzX+VBMmv
         c/P32XkoCcOkOldc30ixZ/L4LWI45ZcyFbAIXf/vliKalmUnG5SbzeWVGC9soiSOkEyd
         kdnmd7y3nmdf8eXVEbGCZFJkY9Oez8pLJJsgRdmq3uQ/jyYafJMrUeNyDJTxdEtC3C8l
         Vp1Z1O5+KZKI7Q203yjNtJypOMPC7aWMKZvDP1HrJat4Z0dPv5R1PtPlYGwRjAPs9VtQ
         aOFg==
X-Gm-Message-State: AGi0PuaMH2q4J0keGCcnh0dpDe2kbzqOC/YCtozPp6/FP4TQxvK/brEn
        o1dya98PeJAYfHZB2YsPnHI=
X-Google-Smtp-Source: APiQypIvWYvXcCO8B7oHzW2wCt/2xQtAcNDAE7MpAMH+wT+BsthaG01xH/FqqV+DFX7O1EjzK917Ew==
X-Received: by 2002:a1c:3589:: with SMTP id c131mr848071wma.116.1586243013199;
        Tue, 07 Apr 2020 00:03:33 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id q19sm25494273wra.38.2020.04.07.00.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 00:03:32 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:03:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Aslan Bakirov <aslan@fb.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH v4 2/2] mm: hugetlb: optionally allocate gigantic
 hugepages using cma
Message-ID: <20200407070331.GD18914@dhcp22.suse.cz>
References: <20200407010431.1286488-1-guro@fb.com>
 <20200407010431.1286488-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010431.1286488-3-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-04-20 18:04:31, Roman Gushchin wrote:
[...]
My ack still applies but I have only noticed two minor things now.

[...]
> @@ -1281,8 +1308,14 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
>  	set_page_refcounted(page);
>  	if (hstate_is_gigantic(h)) {
> +		/*
> +		 * Temporarily drop the hugetlb_lock, because
> +		 * we might block in free_gigantic_page().
> +		 */
> +		spin_unlock(&hugetlb_lock);
>  		destroy_compound_gigantic_page(page, huge_page_order(h));
>  		free_gigantic_page(page, huge_page_order(h));
> +		spin_lock(&hugetlb_lock);

This is OK with the current code because existing paths do not have to
revalidate the state AFAICS but it is a bit subtle. I have checked the
cma_free path and it can only sleep on the cma->lock unless I am missing
something. This lock is only used for cma bitmap manipulation and the
mutex sounds like an overkill there and it can be replaced by a
spinlock.

Sounds like a follow up patch material to me.

[...]
> +	for_each_node_state(nid, N_ONLINE) {
> +		int res;
> +
> +		size = min(per_node, hugetlb_cma_size - reserved);
> +		size = round_up(size, PAGE_SIZE << order);
> +
> +		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
> +						 0, false, "hugetlb",
> +						 &hugetlb_cma[nid], nid);
> +		if (res) {
> +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
> +				res, nid);
> +			break;

Do we really have to break out after a single node failure? There might
be other nodes that can satisfy the allocation. You are not cleaning up
previous allocations so there is a partial state and then it would make
more sense to me to simply s@break@continue@ here.

> +		}
> +
> +		reserved += size;
> +		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
> +			size / SZ_1M, nid);
> +
> +		if (reserved >= hugetlb_cma_size)
> +			break;
> +	}
> +}
-- 
Michal Hocko
SUSE Labs
