Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322CAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A83820724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zr+J0Puk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgHUQet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgHUQdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:33:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D21C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8uClXR16aF5e854xAvQc7WAqpjkxwvOEtTTPt3xTINQ=; b=Zr+J0Puk5W66OkhKodyulmB92/
        3FyMgESa2kPktgQLZ0Ty7hK+IbKekHaX5Laes1LHCqfZ9ysdh7R/2fVZIoLOv2CQhQlBZp1W7oF+8
        ar1lULxwFZ9T55OYxUzNYbumdYPxflUYRmyZWrz81YFuKIKjL4xwa/uMmBHhtxGLGpwndBId0F1hX
        28DiGgDX7FWoQgr7w3ym2MdPM0omvWrEvZ6qkE/DRSPPxLo0Gzx0yIiHW3O7Pdm2e9Xth6K+/s2Xw
        v2MD1fjoiyXV1HMJk+wCHYkyMSr1pRbNdPTEEDTvlY9bCvrT/gdXI9/A3iB/6JEuC6cQ+lweBgbiZ
        512JoSbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k99yU-0000pz-Ij; Fri, 21 Aug 2020 16:33:06 +0000
Date:   Fri, 21 Aug 2020 17:33:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm: Add an 'end' parameter to find_get_entries
Message-ID: <20200821163306.GW17456@casper.infradead.org>
References: <20200819150555.31669-1-willy@infradead.org>
 <20200819150555.31669-4-willy@infradead.org>
 <20200821160759.GE3432@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821160759.GE3432@quack2.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 06:07:59PM +0200, Jan Kara wrote:
> On Wed 19-08-20 16:05:51, Matthew Wilcox (Oracle) wrote:
> > This simplifies the callers and leads to a more efficient implementation
> > since the XArray has this functionality already.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> The patch looks good to me. Just I'd note that you could drop some:
> 
> 	if (index >= end)
> 		break;
> 
> checks in shmem_undo_range() as well.

Oh yes, missed a couple ;-)  Thanks, I'll add.

> In the past I was considering moving find_get_entries() to the same API as
> find_get_pages_range() has (which is essentially what you do now, but I
> also had 'start' to be a pgoff_t * so that we can return there where the
> iteration ended in the range). But in the end I've decided the churn is not
> worth the few removed lines and didn't push the patch in the end. What you
> did in this patch seems to be a reasonable middle-ground :)

I did look at that, but since we're returning the indices, we don't _need_
to update the index here.

I have some other ideas for this family of interfaces, but I'm trying
to get the THP work off my plate before getting distracted by that ;-)
