Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87A02070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgG3HJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:09:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40739 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3HJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:09:52 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k12hK-0006D2-4S; Thu, 30 Jul 2020 07:09:50 +0000
Date:   Thu, 30 Jul 2020 09:09:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: bpfilter logging write errors in dmesg
Message-ID: <20200730070948.ysjruvwl4vjobwus@wittgenstein>
References: <20200727104636.nuz3u4xb7ba7ue5a@wittgenstein>
 <20200727132855.GA28165@lst.de>
 <20200727141337.liwdfjxq4cwvt5if@wittgenstein>
 <20200727145013.GA2154@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727145013.GA2154@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 04:50:13PM +0200, Christoph Hellwig wrote:
> Strange.  Can you add this additional debugging patch:

Sorry Christoph,

didn't mean to leave you waiting. I got pulled into other stuff.

Christian

> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 4fb797822567a6..d0a8ada1efd954 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -369,8 +369,10 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
>  	int retval = -EINVAL;
>  
>  	inode = file_inode(file);
> -	if (unlikely((ssize_t) count < 0))
> +	if (unlikely((ssize_t) count < 0)) {
> +		printk("count invalid: %zd\n", count);
>  		return retval;
> +	}
>  
>  	/*
>  	 * ranged mandatory locking does not apply to streams - it makes sense
> @@ -380,25 +382,35 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
>  		loff_t pos = *ppos;
>  
>  		if (unlikely(pos < 0)) {
> -			if (!unsigned_offsets(file))
> +			if (!unsigned_offsets(file)) {
> +				printk("pos invalid: %lld\n", pos);
>  				return retval;
> +			}
>  			if (count >= -pos) /* both values are in 0..LLONG_MAX */
>  				return -EOVERFLOW;
>  		} else if (unlikely((loff_t) (pos + count) < 0)) {
> -			if (!unsigned_offsets(file))
> +			if (!unsigned_offsets(file)) {
> +				printk("pos+count invalid: %lld, %zd\n", pos, count);
>  				return retval;
> +			}
>  		}
>  
>  		if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
>  			retval = locks_mandatory_area(inode, file, pos, pos + count - 1,
>  					read_write == READ ? F_RDLCK : F_WRLCK);
> -			if (retval < 0)
> +			if (retval < 0) {
> +				if (retval == -EINVAL)
> +					printk("locks_mandatory_area\n");
>  				return retval;
> +			}
>  		}
>  	}
>  
> -	return security_file_permission(file,
> +	retval = security_file_permission(file,
>  				read_write == READ ? MAY_READ : MAY_WRITE);
> +	if (retval == -EINVAL)
> +		printk("security_file_permission\n");
> +	return retval;
>  }
>  
>  static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
