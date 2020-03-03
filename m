Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB002C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EA624673
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJ7XVeuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCCBWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:22:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCCBWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NojBDjb7TlQCImuRBu0tY2yEVynAhDwavypt4k6px3k=; b=HJ7XVeuy87U2yFbalZXh8bGzml
        n7bPovrmrBC5k/yQhrSJRZq8DTVrBLSBQs6+tGIBqV8DGk6mQub2r8dnOoFfVOZGMCMEFW6JpaG2z
        sP8brbDrsxfC7wjYi7cZb94NnyAiA+sYSxqF5tmsQXKtiS0KRf+HkFSPmtOqtok9xzUJQL2ps2V4/
        9YzbumGLYEHF13izP2eZP0RGTDGTfnrZhxwi/BsC48MPhAjAxHOkjissbxfYc3lldz4pZm8mdIJoc
        gwzLkpULOB3tE8BtICZyosSucGMgTmOZuOV2ZB6HD9D5jgC3dI0v7YBDKG0NDBZn7y2YqNteTP1KG
        j97AEomg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8wG3-0006dp-MG; Tue, 03 Mar 2020 01:22:03 +0000
Date:   Mon, 2 Mar 2020 17:22:03 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] mm: fix long time stall from mm_populate
Message-ID: <20200303012203.GR29971@bombadil.infradead.org>
References: <20200303002638.206421-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303002638.206421-1-minchan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 04:26:38PM -0800, Minchan Kim wrote:
> @@ -1196,6 +1196,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  	struct vm_area_struct *vma = NULL;
>  	int locked = 0;
>  	long ret = 0;
> +	bool tried = false;

How about ...

	int *lockedp = &locked;

>  
>  	end = start + len;
>  
> @@ -1226,14 +1227,18 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  		 * double checks the vma flags, so that it won't mlock pages
>  		 * if the vma was already munlocked.
>  		 */
> -		ret = populate_vma_page_range(vma, nstart, nend, &locked);
> +		ret = populate_vma_page_range(vma, nstart, nend,
> +						tried ? NULL : &locked);

		ret = populate_vma_page_range(vma, nstart, nend, lockedp);

>  		if (ret < 0) {
>  			if (ignore_errors) {
>  				ret = 0;
>  				continue;	/* continue at next VMA */
>  			}
>  			break;
> -		}
> +		} else if (ret == 0)
> +			tried = true;
> +		else
> +			tried = false;

		} else if (ret == 0)
			lockedp = NULL;

Maybe there's a better name than lockedp.
