Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD2C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BAD2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgH1K3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:29:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgH1K3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:29:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2727B1A0;
        Fri, 28 Aug 2020 10:30:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 74D101E12C0; Fri, 28 Aug 2020 12:29:35 +0200 (CEST)
Date:   Fri, 28 Aug 2020 12:29:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Denis Efremov <efremov@linux.com>, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] udf: Use kvzalloc() in udf_sb_alloc_bitmap()
Message-ID: <20200828102935.GC5098@quack2.suse.cz>
References: <20200827151923.40067-1-efremov@linux.com>
 <20200827221652.64660-1-efremov@linux.com>
 <e8048e6a-0880-3646-3caf-78de513207ee@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8048e6a-0880-3646-3caf-78de513207ee@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-08-20 17:29:25, Gustavo A. R. Silva wrote:
> 
> 
> On 8/27/20 17:16, Denis Efremov wrote:
> > Use kvzalloc() in udf_sb_alloc_bitmap() instead of open-coding it.
> > Size computation wrapped in struct_size() macro to prevent potential
> > integer overflows.
> > 
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Looks good. :)
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thank you both. I've added the patch to my tree.

								Honza

> 
> Thanks
> --
> Gustavo
> 
> > ---
> > Changes in v2:
> >  - size computation wrapped in struct_size()
> > Changes in v3:
> >  - int size dropped
> > 
> >  fs/udf/super.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > index 1c42f544096d..d9eabbe368ff 100644
> > --- a/fs/udf/super.c
> > +++ b/fs/udf/super.c
> > @@ -1006,18 +1006,10 @@ int udf_compute_nr_groups(struct super_block *sb, u32 partition)
> >  static struct udf_bitmap *udf_sb_alloc_bitmap(struct super_block *sb, u32 index)
> >  {
> >  	struct udf_bitmap *bitmap;
> > -	int nr_groups;
> > -	int size;
> > -
> > -	nr_groups = udf_compute_nr_groups(sb, index);
> > -	size = sizeof(struct udf_bitmap) +
> > -		(sizeof(struct buffer_head *) * nr_groups);
> > -
> > -	if (size <= PAGE_SIZE)
> > -		bitmap = kzalloc(size, GFP_KERNEL);
> > -	else
> > -		bitmap = vzalloc(size); /* TODO: get rid of vzalloc */
> > +	int nr_groups = udf_compute_nr_groups(sb, index);
> >  
> > +	bitmap = kvzalloc(struct_size(bitmap, s_block_bitmap, nr_groups),
> > +			  GFP_KERNEL);
> >  	if (!bitmap)
> >  		return NULL;
> >  
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
