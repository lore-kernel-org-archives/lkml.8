Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F0C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F742206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD0C1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 22:27:16 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:44773 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbgD0C1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:27:16 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B80CF82167F;
        Mon, 27 Apr 2020 12:27:10 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jStUD-0001QJ-Af; Mon, 27 Apr 2020 12:27:09 +1000
Date:   Mon, 27 Apr 2020 12:27:09 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: Re: [RFC PATCH 8/9] orangefs: use set/clear_fs_page_private
Message-ID: <20200427022709.GC2005@dread.disaster.area>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-9-guoqing.jiang@cloud.ionos.com>
 <20200426222455.GB2005@dread.disaster.area>
 <20200427001234.GB29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427001234.GB29705@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=7-415B0cAAAA:8
        a=_ZLPnNw1jSjQLjkGmAoA:9 a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 05:12:34PM -0700, Matthew Wilcox wrote:
> On Mon, Apr 27, 2020 at 08:24:55AM +1000, Dave Chinner wrote:
> > > @@ -460,17 +456,13 @@ static void orangefs_invalidatepage(struct page *page,
> > >  
> > >  	if (offset == 0 && length == PAGE_SIZE) {
> > >  		kfree((struct orangefs_write_range *)page_private(page));
> > > -		set_page_private(page, 0);
> > > -		ClearPagePrivate(page);
> > > -		put_page(page);
> > > +		clear_fs_page_private(page);
> > 
> > Ditto:
> > 		wr = clear_fs_page_private(page);
> > 		kfree(wr);
> 
> You don't want to be as succinct as the btrfs change you suggested?
> 
> 		kfree(clear_fs_page_private(page));

That could be done, yes. I was really just trying to point out the
use after free that was occurring here rather than write compact
code...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
