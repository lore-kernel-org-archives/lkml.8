Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CDFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8869120663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgG0MMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:12:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:35594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgG0MMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:12:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E049AED9;
        Mon, 27 Jul 2020 12:13:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 997321E12C5; Mon, 27 Jul 2020 14:12:50 +0200 (CEST)
Date:   Mon, 27 Jul 2020 14:12:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] udf: use common error code for unclean filesystem
Message-ID: <20200727121250.GN23179@quack2.suse.cz>
References: <20200726075828.GA26460@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726075828.GA26460@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 26-07-20 09:58:28, Pavel Machek wrote:
> 
> Use common error code for unclean filesystem, and warn when
> incosistency is detected.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

So this is going in the right direction but there are *much* more places
that would need a similar treatment (furthermore I'd prefer to use the
EFSCORRUPTED redefine of EUCLEAN as other filesystems do). Any reason why
you converted this particular place?

								Honza

> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index adaba8e8b326..8e74c7b5b8d0 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1395,7 +1395,10 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
>  	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_SHORT &&
>  	    iinfo->i_alloc_type != ICBTAG_FLAG_AD_LONG &&
>  	    iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
> -		ret = -EIO;
> +		ret = -EUCLEAN;
> +		udf_err(inode->i_sb, "invalid allocation type: %u\n",
> +			iinfo->i_alloc_type);
> +
>  		goto out;
>  	}
>  	iinfo->i_unique = 0;
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
