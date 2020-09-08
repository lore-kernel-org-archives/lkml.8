Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E047DC2BBD0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5A9206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 11:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgIHLgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:36:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgIHLbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:31:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CD6DAB0E;
        Tue,  8 Sep 2020 11:31:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 492231E1325; Tue,  8 Sep 2020 13:31:10 +0200 (CEST)
Date:   Tue, 8 Sep 2020 13:31:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: adjust dirtytime_interval_handler definition to
 match prototype
Message-ID: <20200908113110.GB2956@quack2.suse.cz>
References: <20200907093140.13434-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907093140.13434-1-tklauser@distanz.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-09-20 11:31:40, Tobias Klauser wrote:
> Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
> changed ctl_table.proc_handler to take a kernel pointer. Adjust the
> definition of dirtytime_interval_handler to match its prototype in
> linux/writeback.h which fixes the following sparse error/warning:
> 
> fs/fs-writeback.c:2189:50: warning: incorrect type in argument 3 (different address spaces)
> fs/fs-writeback.c:2189:50:    expected void *
> fs/fs-writeback.c:2189:50:    got void [noderef] __user *buffer
> fs/fs-writeback.c:2184:5: error: symbol 'dirtytime_interval_handler' redeclared with different type (incompatible argument 3 (different address spaces)):
> fs/fs-writeback.c:2184:5:    int extern [addressable] [signed] [toplevel] dirtytime_interval_handler( ... )
> fs/fs-writeback.c: note: in included file:
> ./include/linux/writeback.h:374:5: note: previously declared as:
> ./include/linux/writeback.h:374:5:    int extern [addressable] [signed] [toplevel] dirtytime_interval_handler( ... )
> 
> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 149227160ff0..58b27e4070a3 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2184,7 +2184,7 @@ static int __init start_dirtytime_writeback(void)
>  __initcall(start_dirtytime_writeback);
>  
>  int dirtytime_interval_handler(struct ctl_table *table, int write,
> -			       void __user *buffer, size_t *lenp, loff_t *ppos)
> +			       void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int ret;
>  
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
