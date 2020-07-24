Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57872C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362C820714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 01:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595552900;
	bh=6h79p/EBOO3Jy0O+wNOK5EBNEFcadFue56VbMpxqAfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QdvjdOO4C+CnArb3Bxz5IWZV+ydDRLpLEoLKesba8Eofnn1OW/3DfQDccYmHvSnma
	 DveDY2XUwnZfCDw6F8iWbI+mDOuBHSq7hXA0eP/7ps++NjATOhCXbKBuCqz+imw6ny
	 UEk7BdtnMNpWsXVAg5AmIaKOGdCtNQnJFZddBNAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgGXBIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 21:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgGXBIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 21:08:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D75206E3;
        Fri, 24 Jul 2020 01:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595552895;
        bh=6h79p/EBOO3Jy0O+wNOK5EBNEFcadFue56VbMpxqAfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U6qUgPZWAddKYwPy75j0iJwMI0u7S1FZpM6Htu3VLY43Bakop2yGaOQ9zNk4AziSP
         53D1qwpryq4oHD4AiwkI+gotw+lxwjvctrEhhPyUC0n+Mq/lNkChZh851He3nbqrnb
         kyBgjWWAPAHtSzqP28cKb+eLLNplXpnk9987gJsU=
Date:   Thu, 23 Jul 2020 18:08:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     js1304@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: fix memalloc_nocma_{save/restore}
 APIs
Message-Id: <20200723180814.acde28b92ce6adc785a79120@linux-foundation.org>
In-Reply-To: <1595468942-29687-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595468942-29687-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 10:49:02 +0900 js1304@gmail.com wrote:

> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Currently, memalloc_nocma_{save/restore} API that prevents CMA area
> in page allocation is implemented by using current_gfp_context(). However,
> there are two problems of this implementation.
> 
> First, this doesn't work for allocation fastpath. In the fastpath,
> original gfp_mask is used since current_gfp_context() is introduced in
> order to control reclaim and it is on slowpath. So, CMA area can be
> allocated through the allocation fastpath even if
> memalloc_nocma_{save/restore} APIs are used.

Whoops.

> Currently, there is just
> one user for these APIs and it has a fallback method to prevent actual
> problem.

Shouldn't the patch remove the fallback method?

> Second, clearing __GFP_MOVABLE in current_gfp_context() has a side effect
> to exclude the memory on the ZONE_MOVABLE for allocation target.

More whoops.

Could we please have a description of the end-user-visible effects of
this change?  Very much needed when proposing a -stable backport, I think.

d7fefcc8de9147c is over a year old.  Why did we only just discover
this?  This makes one wonder how serious those end-user-visible effects
are?

> To fix these problems, this patch changes the implementation to exclude
> CMA area in page allocation. Main point of this change is using the
> alloc_flags. alloc_flags is mainly used to control allocation so it fits
> for excluding CMA area in allocation.
> 

