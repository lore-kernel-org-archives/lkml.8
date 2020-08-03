Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BC5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2401F20781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596455678;
	bh=5A1oCPWgnKkZFBnhgIH4zbdWjtzCqsJZ8eSK6EddM5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HnEiwRSHEPggtXUg8n3OLJQmvxB+pzZOF6NMUW18Wo4VzLwvIabmH6wVLfO5gryPy
	 ODBNYRuHbSPBd/HPkO6Evsv2pEf8N70j0tWY/jqliqj+GylT3EMEoiQq3rtXazLaTL
	 LdUBsoXYh3fV8tkdacGViOh/1akymjTqdrcmwO3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgHCLyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgHCLyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:54:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72E92076C;
        Mon,  3 Aug 2020 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596455624;
        bh=5A1oCPWgnKkZFBnhgIH4zbdWjtzCqsJZ8eSK6EddM5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2OXXZz6L8TwDyNZXlLmZqydukYYfMfQYoZFCePUAzM+ZD246LX1U0Oz2zH3/vCFNz
         n8uyUL5FTO+PZQl7z9mtnFkszBAEY9qjNsHAT3d7+ruCdlndM3EfNLZ9dYaRTTnNip
         H0GMlrreLx2/YcO2gKlu9WAtib0gcqrDe0knmAMs=
Date:   Mon, 3 Aug 2020 13:53:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] drivers: char: applicom.c: Add lock for protecting
 DeviceErrorCount
Message-ID: <20200803115328.GA955269@kroah.com>
References: <20200803105049.11089-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803105049.11089-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:20:49PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> The variable DeviceErrorCount is used to keep track of the number of
> errors in read, write and interrupt routines, however it was not
> protected by proper locking.
> Therefore, this patch adds a spinlock: error_lock to protect the
> variable.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> ---
>  drivers/char/applicom.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
> index 14b2d8034c51..6df7450b8b99 100644
> --- a/drivers/char/applicom.c
> +++ b/drivers/char/applicom.c
> @@ -106,6 +106,7 @@ static DECLARE_WAIT_QUEUE_HEAD(FlagSleepRec);
>  static unsigned int WriteErrorCount;	/* number of write error      */
>  static unsigned int ReadErrorCount;	/* number of read error       */
>  static unsigned int DeviceErrorCount;	/* number of device error     */
> +DEFINE_SPINLOCK(error_lock);		/* lock to protect error count variables */

That's a horrible global name, shouldn't it be static?

>  
>  static ssize_t ac_read (struct file *, char __user *, size_t, loff_t *);
>  static ssize_t ac_write (struct file *, const char __user *, size_t, loff_t *);
> @@ -428,7 +429,9 @@ static ssize_t ac_write(struct file *file, const char __user *buf, size_t count,
>  		spin_unlock_irqrestore(&apbs[IndexCard].mutex, flags);
>  		printk(KERN_WARNING "APPLICOM driver write error board %d, DataFromPcReady = %d\n",
>  		       IndexCard,(int)readb(apbs[IndexCard].RamIO + DATA_FROM_PC_READY));
> +		spin_lock_irqsave(&error_lock, flags);

Why all of these irqsave?

>  		DeviceErrorCount++;

Does this really matter?  Who cares if we drop one of these, or any
other of these debugging-only values?

thanks,

greg k-h
