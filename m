Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469B8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E2520774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgHKQDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:03:49 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37653 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728797AbgHKQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:03:49 -0400
Received: (qmail 337967 invoked by uid 1000); 11 Aug 2020 12:03:48 -0400
Date:   Tue, 11 Aug 2020 12:03:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     trix@redhat.com
Cc:     gregkh@linuxfoundation.org, acozzette@cs.hmc.edu,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: realtek_cr: fix return check for dma functions
Message-ID: <20200811160348.GD335280@rowland.harvard.edu>
References: <20200811151505.12222-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811151505.12222-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:15:05AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this representative problem
> 
> realtek_cr.c:639:3: warning: The left expression of the compound
>   assignment is an uninitialized value. The computed value will
>   also be garbage
>     SET_BIT(value, 2);
>     ^~~~~~~~~~~~~~~~~
> 
> value is set by a successful call to rts51x_read_mem()
> 
> 	retval = rts51x_read_mem(us, 0xFE77, &value, 1);
> 	if (retval < 0)
> 		return -EIO;
> 
> A successful call to rts51x_read_mem returns 0, failure can
> return positive and negative values.  This check is wrong
> for a number of functions.  Fix the retval check.
> 
> Fixes: 065e60964e29 ("ums_realtek: do not use stack memory for DMA")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/storage/realtek_cr.c | 36 ++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index 3789698d9d3c..b983753e2368 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -481,16 +481,16 @@ static int enable_oscillator(struct us_data *us)
>  	u8 value;
>  
>  	retval = rts51x_read_mem(us, 0xFE77, &value, 1);
> -	if (retval < 0)
> +	if (retval != STATUS_SUCCESS)
>  		return -EIO;

Instead of changing all these call sites, wouldn't it be a lot easier 
just to change rts51x_read_mem() to make it always return a negative 
value (such as -EIO) when there's an error?

Alan Stern
