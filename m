Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6A6C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC522075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 05:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lm4Tu30h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgD0Fw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 01:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgD0Fw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:52:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D63C061A0F;
        Sun, 26 Apr 2020 22:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LQVtzGaomYtG7V/jX0MqKImKPB9VkLmtjmhmXgAH0Xc=; b=Lm4Tu30hpSl+D6HEWWAScRDmtt
        jEUap9jlU3mOipiBhzFXsGaa0TyCihkJXduNfgNxTU2yikcSbjuO3C4cIv4/T11IisHHZto5q8uGh
        sKJ6gECuN90WXQKLegzyzObDogzxAEQ9Gpi1co4E8SVbc4VbwrhnKfFg4B+a3szinI8z/eh3/mcXt
        gfK34E4urHi205PEvNFymGPB6mQ/MaCRwFZ4yrb6ga62i397JNSdkPDnMjtReS1ytuDrBSH8EDF/c
        TYWbj5yjm5MUJTtj2/7APAB2btVxovtErHyhdesBTGK3Mt+n14gARrO3Zy8fREzDu8qD3e515MWIK
        tjryPzJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSwhL-0004dg-5C; Mon, 27 Apr 2020 05:52:55 +0000
Date:   Sun, 26 Apr 2020 22:52:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH 1/9] include/linux/pagemap.h: introduce
 set/clear_fs_page_private
Message-ID: <20200427055255.GA16709@infradead.org>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-2-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426214925.10970-2-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why not attach_page_private and clear_page_private as that conveys
the use case a little better?

> +static inline void *set_fs_page_private(struct page *page, void *data)
> +{
> +	get_page(page);
> +	set_page_private(page, (unsigned long)data);
> +	SetPagePrivate(page);
> +
> +	return data;
> +}
> +
> +static inline void *clear_fs_page_private(struct page *page)
> +{
> +	void *data = (void *)page_private(page);
> +
> +	if (!PagePrivate(page))
> +		return NULL;
> +	ClearPagePrivate(page);
> +	set_page_private(page, 0);
> +	put_page(page);
> +
> +	return data;
> +}

Can you add kerneldoc comments describing them, including why we
take the refernces?  Also what is the point of the return value
of set_fs_page_private?
