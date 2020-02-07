Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA9DC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DA1217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581063011;
	bh=fRQnC1TQ7Xgxxby5fZyeHggtdHJhVDOJjGRTYTQn7yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ecOgRUsq9ufda3lAR+d/V8W4rR6dCAo/18Ro1+3sRi+T+shEEzucb7oYTPgqRVmzA
	 bp+VMRz9DfIGPoVnOrYdc5fHiAUsI2QPy01KkYBjq1mKe0gEhR7aBpZcLvDp3lXRT1
	 k7p+1F5qnRK2BzQpOmhWqf4T0vqPNYDMXjy+sqI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGIKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:10:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgBGIKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:10:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC2C021741;
        Fri,  7 Feb 2020 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581063008;
        bh=fRQnC1TQ7Xgxxby5fZyeHggtdHJhVDOJjGRTYTQn7yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCHGQzj6Ev2I9SM5Z+7iz5VaayAKcEoIoIj/DfLEMUki7FVzTTvSJ2Hmw8G071WUf
         7pm1C7zgz0QBTTTyUaRgscjYOMExLEQCf4XqdAFroF0MCSAvgAb1XhGgnUsRUcH0VO
         NcPa3xMMHWmOfF91MxTqKDsitAO9FRx3VhbE60U0=
Date:   Fri, 7 Feb 2020 09:10:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shen Kai <shenkai8@huawei.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] add lock proctect to __handle_sysrq in
 write_sysrq_trigger
Message-ID: <20200207081006.GB309560@kroah.com>
References: <1581062166-27284-1-git-send-email-shenkai8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581062166-27284-1-git-send-email-shenkai8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 07:56:06AM +0000, Shen Kai wrote:
> From: Feilong Lin <linfeilong@huawei.com>
> 
> Add lock protect to __handle_sysrq to avoid race condition.
> __handle_sysrq will change console_loglevel without lock protect
> which can lead to console_loglevel to be set as an unexpected value.
> 
> Problem may occur when "echo t > /proc/sysrq-trigger" is called on 
> multiple cpus concurrently.
> 
> In this case in __handle_sysrq, console_loglevel is set to 7 to print
> some head info to the console then restore it. But without lock protect
> in parallel execution situation, restoring may go wrong. The new 
> loglevel may be taken as the previous loglevel incorrectly.
> Console_loglevel can be 7 at last, which causes the terminal to output
> info in most log levels.
> 
> This bug was found on linux 4.19
> 
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> Reported-by: Kai Shen <shenkai8@huawei.com>
> ---
>  drivers/tty/sysrq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index f724962..cbb48a9 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -1087,6 +1087,8 @@ EXPORT_SYMBOL(unregister_sysrq_key);
>  /*
>   * writing 'C' to /proc/sysrq-trigger is like sysrq-C
>   */
> +static DEFINE_MUTEX(sysrq_mutex);
> +
>  static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
>  				   size_t count, loff_t *ppos)
>  {
> @@ -1095,7 +1097,9 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
>  
>  		if (get_user(c, buf))
>  			return -EFAULT;
> +		mutex_lock(&sysrq_mutex);
>  		__handle_sysrq(c, false);
> +		mutex_unlock(&sysrq_mutex);

What exactly are you protecting here?  What other task is doing this at
the same exact time?

You mention different tasks hitting this sysrq-trigger at the same time,
but really, "just do not do that" should be the real answer, as even
with this lock, you don't know what the end result will be as the "last"
one in will have the last word, right?

thanks,

greg k-h
