Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE76C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6962072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HaEXaxSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbgHQTvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgHQPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:18:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6036C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hCefh1Pahxh4o69rSCAzBH1nyvhBAQVuzTSUa//BjSc=; b=HaEXaxSUJfaZR9PXaX/Iw51Eee
        elL+G4+Z0IVSwtAc6bT/0YEsJEkalKG5vrOMm5/rtjyWrJd3/fg02hrWL0dJeG6cbT8loU6hksGb7
        IISbwMJ8MRVgs9dkHtyKR1EH5ZWCgzQsUQ3/JLE69pmR+OX39TcneUy0WjQEk8TlgpZWVRyWf5Uaa
        G83hpf7YzODX1DoI0omB7nDAXvtsUukDyCpl/EqUIAoVF/399K4rPTRF5AS9S3gybD7t+O1FR/O9y
        AEKY3MEBNrz181r9nD8GThs5H4bBcLCR47AFsL6TGRlBHTSe3gs8YPHiSKNYY39mOLAVbPDwuM98R
        VLzGYg2w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7guR-0008L3-Fu; Mon, 17 Aug 2020 15:18:51 +0000
Date:   Mon, 17 Aug 2020 16:18:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH] mm: change prev_offset type to unsigned long
Message-ID: <20200817151851.GK17456@casper.infradead.org>
References: <20200817150637.4244-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817150637.4244-1-huobean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:06:37PM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>

There's no description.  Please explain why this patch is needed.

> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index cf4bdf7803b6..d736c7a4b826 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2025,7 +2025,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  	pgoff_t last_index;
>  	pgoff_t prev_index;
>  	unsigned long offset;      /* offset into pagecache page */
> -	unsigned int prev_offset;
> +	unsigned long prev_offset;
>  	int error = 0;
>  
>  	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
> -- 
> 2.17.1
> 
> 
