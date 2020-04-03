Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D5E20787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lglM60dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390349AbgDCA1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:27:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbgDCA1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fjcWiaQ4VURRnXwyak7wpsiJ0QlywrYLsor4d7ICZUg=; b=lglM60dpQtXKHl3m6dND98BC9r
        CnDWkjWD2HiLEBXizIprkqKRtbKHHsu+/ip8hEiNrST6v5FcPw7W8+J8MAII9R/QqjIO7xP0/U0sH
        EmDbus1zVCBLhN8k6sCYuQpGySi1XruYohUlFvBttvUjEuEtYGIxj37yOuTTiyC2nAIRlgX0QY/ml
        WrLmEgJV6pvRnDFH1IRyzDn2J7mTOW/4gU8IVEph9NaOV7QQ43rcCtj/3v+WrCKmFlVH51vIUlMbK
        Z0/S7dz2acsE5svO2Y2LjZSJNYsnaXe+jtxtY1KXygniurqDZv8OpTOJ5Q8hss8kFJGLWwsmsRJSN
        ubqz4VXQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKAAr-000170-3v; Fri, 03 Apr 2020 00:27:05 +0000
Date:   Thu, 2 Apr 2020 17:27:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Aslan Bakirov <aslan@fb.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com, riel@surriel.com,
        guro@fb.com, mhocko@kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v3] mm: cma: NUMA node interface
Message-ID: <20200403002705.GP21484@bombadil.infradead.org>
References: <20200402232236.2218713-1-aslan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402232236.2218713-1-aslan@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 04:22:37PM -0700, Aslan Bakirov wrote:
> +static inline int __init cma_declare_contiguous(phys_addr_t base,
> +			phys_addr_t size, phys_addr_t limit,
> +			phys_addr_t alignment, unsigned int order_per_bit,
> +			bool fixed, const char *name, struct cma **res_cma)
> +			{

This { should be in the first column.

> -			addr = memblock_phys_alloc_range(size, alignment,
> -							 highmem_start, limit);
> +			addr = memblock_alloc_range_nid(size, alignment,
> +				 highmem_start, limit, nid, false);

Two extra tabs, not one.

