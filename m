Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C48C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4442070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588758535;
	bh=ZW1E79xPaZKAydY429DVMLY0e+c/wC5VYXN8YIirzjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m/Qo4jfWLmahwbX1amnUZRKFy604Rl6B/gStmYS6vjHk0GFObHE0x+pTXJAic9Yn9
	 Eyry+U141X3wyxBPUrFE2zpZAzNPoSaC0UjsrRwWWSuCRlP9/NIews0YY6Rpa+s4zV
	 Lis8laVDGAZ0fMuYZx3X2pCoMuqNRPWGyeT9feXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgEFJsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgEFJsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:48:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7934F206DD;
        Wed,  6 May 2020 09:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588758533;
        bh=ZW1E79xPaZKAydY429DVMLY0e+c/wC5VYXN8YIirzjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwtFY++fxs2YNcNbbN+ZfgD+/9YnoIpehM4RYf+bS6ZuKVQf6QPag8gWpA0OrecEp
         G2ZCTCXXR3/YDgChIyUNUbIvPOKmS0Lf6irGRLNNWe1EfCOEz7QJ2p038mRUue0uSK
         cjs/cy+YpVrIdfXvi40mz6x60zA0GR0vRbom8Bb4=
Date:   Wed, 6 May 2020 11:48:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc:     jslaby@suse.com, andrew@daynix.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: Fix data abort due to race in hvc_open
Message-ID: <20200506094851.GA2787548@kroah.com>
References: <20200428032601.22127-1-rananta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428032601.22127-1-rananta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:26:01PM -0700, Raghavendra Rao Ananta wrote:
> Potentially, hvc_open() can be called in parallel when two tasks calls
> open() on /dev/hvcX. In such a scenario, if the hp->ops->notifier_add()
> callback in the function fails, where it sets the tty->driver_data to
> NULL, the parallel hvc_open() can see this NULL and cause a memory abort.
> Hence, serialize hvc_open and check if tty->private_data is NULL before
> proceeding ahead.
> 
> The issue can be easily reproduced by launching two tasks simultaneously
> that does nothing but open() and close() on /dev/hvcX.
> For example:
> $ ./simple_open_close /dev/hvc0 & ./simple_open_close /dev/hvc0 &
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
> ---
>  drivers/tty/hvc/hvc_console.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index 436cc51c92c3..ebe26fe5ac09 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -75,6 +75,8 @@ static LIST_HEAD(hvc_structs);
>   */
>  static DEFINE_MUTEX(hvc_structs_mutex);
>  
> +/* Mutex to serialize hvc_open */
> +static DEFINE_MUTEX(hvc_open_mutex);
>  /*
>   * This value is used to assign a tty->index value to a hvc_struct based
>   * upon order of exposure via hvc_probe(), when we can not match it to
> @@ -346,16 +348,24 @@ static int hvc_install(struct tty_driver *driver, struct tty_struct *tty)
>   */
>  static int hvc_open(struct tty_struct *tty, struct file * filp)
>  {
> -	struct hvc_struct *hp = tty->driver_data;
> +	struct hvc_struct *hp;
>  	unsigned long flags;
>  	int rc = 0;
>  
> +	mutex_lock(&hvc_open_mutex);
> +
> +	hp = tty->driver_data;
> +	if (!hp) {
> +		rc = -EIO;
> +		goto out;
> +	}
> +
>  	spin_lock_irqsave(&hp->port.lock, flags);
>  	/* Check and then increment for fast path open. */
>  	if (hp->port.count++ > 0) {
>  		spin_unlock_irqrestore(&hp->port.lock, flags);
>  		hvc_kick();
> -		return 0;
> +		goto out;
>  	} /* else count == 0 */
>  	spin_unlock_irqrestore(&hp->port.lock, flags);

Wait, why isn't this driver just calling tty_port_open() instead of
trying to open-code all of this?

Keeping a single mutext for open will not protect it from close, it will
just slow things down a bit.  There should already be a tty lock held by
the tty core for open() to keep it from racing things, right?

Try just removing all of this logic and replacing it with a call to
tty_port_open() and see if that fixes this issue.

As "proof" of this, I don't see other serial drivers needing a single
mutex for their open calls, do you?

thanks,

greg k-h
