Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FB1C352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64F6218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LK3W4xgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgBFUjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:39:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgBFUjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xG8lrNJrYMqb4GvRMFcP1M+jqGxfiqnS6HqIrpyki6Q=; b=LK3W4xgy/df9FCXI4xtAKy9CmO
        U8K080IP8Tu4enkhPr+fe9U2Bc4T+kBMG8PtMhmq0AhQoDuKiPwJNI5z8xKUem5/6PhrZ/dwr4aTC
        rTHmmuS/hlAiZ/Nu9Rgkk2o5IfVyrhhKQdnfbv21TBEEhAZtzCUPQ/zlmzxFbO8AD0WJVO7ILAWpz
        ZdBU2aLlggRfEMXgEBgMCnhiOPUJgpiW5JBS2tsxYGIhao4ovo3YJ4ltIWIgYA4MOtkkPqH8kViPa
        xVgsNB13HrR/+zqjX2GTlGVCGBCbnPrflLkdRJqwNlbKpO53UXgh7fA1xDgalkrSrhH7rBQ3/eU63
        vVoAG7cg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iznw9-0004Fy-Gq; Thu, 06 Feb 2020 20:39:45 +0000
Date:   Thu, 6 Feb 2020 12:39:45 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: always consider THP when adjusting min_free_kbytes
Message-ID: <20200206203945.GZ8731@bombadil.infradead.org>
References: <20200204194156.61672-1-mike.kravetz@oracle.com>
 <alpine.DEB.2.21.2002041218580.58724@chino.kir.corp.google.com>
 <8cc18928-0b52-7c2e-fbc6-5952eb9b06ab@oracle.com>
 <20200204215319.GO8731@bombadil.infradead.org>
 <b6979214-3f0e-6c12-ed63-681b40c6e16c@oracle.com>
 <2ba63021-d05c-a648-f280-6c751e01adf6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ba63021-d05c-a648-f280-6c751e01adf6@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 05:36:44PM -0800, Mike Kravetz wrote:
> The value of min_free_kbytes is calculated in two routines:
> 1) init_per_zone_wmark_min based on available memory
> 2) set_recommended_min_free_kbytes may reserve extra space for
>    THP allocations
> 
> In both of these routines, a user defined min_free_kbytes value will
> be overwritten if the value calculated in the code is larger. No message
> is logged if the user value is overwritten.
> 
> Change code to never overwrite user defined value.  However, do log a
> message (once per value) showing the value calculated in code.

But what if the user set min_free_kbytes to, say, half of system memory,
and then hot-unplugs three quarters of their memory?  I think the kernel
should protect itself against such foolishness.

