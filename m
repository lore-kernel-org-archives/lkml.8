Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78204C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B112082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uu6sySxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbgFXLNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgFXLNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:13:13 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3501DC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o+wrDuDEOBRD8xp7VlW4WFiVlPd+yRCvyexu2cGK4ug=; b=uu6sySxgKDDgJoBHjuKpYnDFAk
        wN1sRUtDSglgsjM9dH3HJQY2ht+gocnxs5fhwqVMQGAoSxpqRg7RLJfv2nRzPCS5Ff1FpO2FUuSd/
        qov/JJCwkeBAD7uR7wzz1IbVsZmg8OxSIxpckpafKijTLjzwEUcWEBWvngmfL07YqIld10vXxeKDk
        6nD46lnLCecuY/LMaH71FiMAMXwyzTcH9hMLhGEieuw/q5Zh6InPKVuJRW42p8ia/ICsyIvnm91PN
        pVWKARuUQTm7I6AxHamRvcbmrh+/UmrgLMcViXKSXocoAHlLbNqwhJ2niGopF1lz6ye4+hQSt3Urw
        bRg5UoDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo3Kp-0008Jh-8M; Wed, 24 Jun 2020 11:12:55 +0000
Date:   Wed, 24 Jun 2020 12:12:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_alloc: fix documentation error and remove magic
 numbers
Message-ID: <20200624111255.GL21350@casper.infradead.org>
References: <20200624032712.23263-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624032712.23263-1-jsavitz@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:27:12PM -0400, Joel Savitz wrote:
> In addition, this patch replaces the magic number bounds with symbolic
> constants to clarify the logic.

Why do people think this kind of thing makes the code easier to read?
It actually makes it harder.  Unless the constants are used in more
than one place, just leave the numbers where they are.

> @@ -7852,6 +7852,9 @@ void setup_per_zone_wmarks(void)
>   * 8192MB:	11584k
>   * 16384MB:	16384k
>   */
> +static const int MIN_FREE_KBYTES_LOWER_BOUND = 1 << 7;
> +static const int MIN_FREE_KBYTES_UPPER_BOUND = 1 << 18;
> +
>  int __meminit init_per_zone_wmark_min(void)
>  {
>  	unsigned long lowmem_kbytes;
> @@ -7862,10 +7865,10 @@ int __meminit init_per_zone_wmark_min(void)
>  
>  	if (new_min_free_kbytes > user_min_free_kbytes) {
>  		min_free_kbytes = new_min_free_kbytes;
> -		if (min_free_kbytes < 128)
> -			min_free_kbytes = 128;
> -		if (min_free_kbytes > 262144)
> -			min_free_kbytes = 262144;
> +		if (min_free_kbytes < MIN_FREE_KBYTES_LOWER_BOUND)
> +			min_free_kbytes = MIN_FREE_KBYTES_LOWER_BOUND;
> +		if (min_free_kbytes > MIN_FREE_KBYTES_UPPER_BOUND)
> +			min_free_kbytes = MIN_FREE_KBYTES_UPPER_BOUND;

The only thing I'd consider changing there is replacing 262144 with 256
* 1024.  1 << 18 is not clearer!
