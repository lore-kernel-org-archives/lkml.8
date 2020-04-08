Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4738AC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237BE20730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgDHPnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:43:06 -0400
Received: from verein.lst.de ([213.95.11.211]:42937 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbgDHPnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:43:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2262D68C4E; Wed,  8 Apr 2020 17:43:04 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:43:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/28] mm: remove the prot argument from vm_map_ram
Message-ID: <20200408154303.GB28676@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408135240.6528-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408135240.6528-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 09:52:40PM +0800, Hillf Danton wrote:
> 
> On Wed,  8 Apr 2020 13:59:15 +0200 Christoph Hellwig wrote:
> > 
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -474,7 +474,7 @@ _xfs_buf_map_pages(
> >  		nofs_flag = memalloc_nofs_save();
> >  		do {
> >  			bp->b_addr = vm_map_ram(bp->b_pages, bp->b_page_count,
> > -						-1, PAGE_KERNEL);
> > +						-1);
> s/-1/NUMA_NO_NODE/

Not really relevant to this series, but otherwise agreed.
