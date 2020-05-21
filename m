Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5E120814
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ORbURK7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgEUXjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgEUXjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:39:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B56DC061A0E;
        Thu, 21 May 2020 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UhLgnVlQuCtNJDc9NwdUyny7kdhWTv6DaiOdM5pHUZ4=; b=ORbURK7h2ssoNG+c2uiKhjOqu0
        ReLVRHrpbCzC5dXiE+6exvk2urZCF/e8KCDWaKlpmxJz0AZ+v2Z2IzIZmFfu8kt4GVjSH7c/dR8qn
        yXyQbAzULuzFjgbMWoYWR4LLXi9CFge/wTX4jWOUqcBAE4EJMX4XFvXT1YFqWCldVexWaQzKEQAs/
        +NCeiiPKpKIhd8hF6QB0pbMBU+hPWeyAkpYETkMsE9aR81LMdV8NJYq5bSCPTuUKXGUA8p7US7Oig
        1gz8UDqaN2iWRTSRlaTigwytxDa6laPKc53kCzg4N3CsBqdISnBv3BSDMaGW2jTgLVPC7Nm2Wz65Q
        OkngE/Xw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbumq-00051H-A0; Thu, 21 May 2020 23:39:40 +0000
Date:   Thu, 21 May 2020 16:39:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/36] iomap: Support large pages in
 iomap_adjust_read_range
Message-ID: <20200521233940.GH28818@bombadil.infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-15-willy@infradead.org>
 <20200521222438.GT2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521222438.GT2005@dread.disaster.area>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 08:24:38AM +1000, Dave Chinner wrote:
> > @@ -571,7 +572,6 @@ static int
> >  __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> >  		struct page *page, struct iomap *srcmap)
> >  {
> > -	struct iomap_page *iop = iomap_page_create(inode, page);
> >  	loff_t block_size = i_blocksize(inode);
> >  	loff_t block_start = pos & ~(block_size - 1);
> >  	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
> > @@ -580,9 +580,10 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> >  
> >  	if (PageUptodate(page))
> >  		return 0;
> > +	iomap_page_create(inode, page);
> 
> What problem does this fix? i.e. if we can get here with an
> uninitialised page, why isn't this a separate bug fix. I don't see
> anything in this patch that actually changes behaviour, and there's
> nothing in the commit description to tell me why this is here,
> so... ???

I'm not fixing anything ... just moving the call to iomap_page_create()
from the opening stanza to down here because we no longer need a struct
iomap_page pointer in this function.
