Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A42C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8F12078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bbk5s4ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgH3KSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgH3KSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 06:18:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F799C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/GAo2Idg5PG00N2nZbQoR5pf/FedffQ77BrAr0UiKvs=; b=Bbk5s4uxphj3K3Tda8l/eN8Bum
        bblVL1iDpSHXsmgyPg0qacB6asEZ8I1i/SC2O7ZLjumo0DpEUUc+jHnnoL/oloRCmxiyZL8OVnHKS
        g9FJvAWXSuvwikupzUwUdmjWZBC3NgX4xdCf4UOTIO64EwmIhUO512u7rQ8BQB9wijYnIMqagPT4k
        BHhV82fQpssRTZOnsGC7kZuG1/n8HMgCorkvYJpqFo1E6eGbt6bjfO0GnaWyeF2ipdP9DdTcTumcT
        na53+jQ/FN44RfRQ9d/92tduh3G+O8O9c4gYEuWjn3uvaDmVUEtlRI0BDvZqsNtjdT0Cc9dqJntAj
        JTM8Y5Cw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCKPn-0006ZT-9V; Sun, 30 Aug 2020 10:18:23 +0000
Date:   Sun, 30 Aug 2020 11:18:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
Message-ID: <20200830101823.GY14765@casper.infradead.org>
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <8ec2a4b0-9e51-abf9-fa7a-29989d3f1fac@arm.com>
 <01c846d4-2fe4-eeef-6c79-e71fda1f9a39@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c846d4-2fe4-eeef-6c79-e71fda1f9a39@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 06:14:33PM +0800, Alex Shi wrote:
> +++ b/mm/page_alloc.c
> @@ -532,9 +536,18 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>  	mask <<= bitidx;
>  	flags <<= bitidx;
>  
> +#ifdef	CONFIG_CPU_V6
> +	byte = (unsigned long)READ_ONCE(bitmap[byte_bitidx]);
> +#else
>  	byte = READ_ONCE(bitmap[byte_bitidx]);
> +#endif
>  	for (;;) {
> +#ifdef	CONFIG_CPU_V6
> +		/* arm v6 has no cmpxchgb function, so still false sharing long word */
> +		old_byte = cmpxchg((unsigned long*)&bitmap[byte_bitidx], byte, (byte & ~mask) | flags);
> +#else
>  		old_byte = cmpxchg(&bitmap[byte_bitidx], byte, (byte & ~mask) | flags);
> +#endif

Good grief, no.  Either come up with an appropriate abstraction or
abandon this patch.  We can't possibly put this kind of ifdef in the
memory allocator!

