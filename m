Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2928BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014992070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594883066;
	bh=DV5zKc/ZWVUvHklF0tyr4PwKp6kaVLmlesNhot2hFgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q9OacycV9JlLqdqZacCss3yTC37vrUOr9TE07mYSyZyPRyE36Oeevd5g2cln/CcyM
	 OdbCiZ189QLxbgTPSLaNIGmqL4PkDrDZesujsILFkOIDb5Q+2Ya9XyqPvBw6z/uwhu
	 4bmIxIwq7xoKneW4WFtyHLa7kA8W8WBMIszlH2m8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgGPHEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgGPHEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:04:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BAE1206F4;
        Thu, 16 Jul 2020 07:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594883062;
        bh=DV5zKc/ZWVUvHklF0tyr4PwKp6kaVLmlesNhot2hFgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYFVjxV5k9yB/i4gwIJF2lqTwXuMDkamt5mmUDgF5kgsQRDjjU3yMQGzeUIGSVp3d
         AROD9O1qtZ/4/oZiB9e4eceD/516OtCK1qKO2K7qxcnAFaWslYY6Aqzezaa5ugTxFo
         hfbofGjOPkH6OW6NCLuoHfmH4ERtGfWAYZ9242J8=
Date:   Thu, 16 Jul 2020 09:04:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qiu Wenbo <qiuwenbo@phytium.com.cn>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Linux Driver Project Developer List 
        <driverdev-devel@linuxdriverproject.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Villegas <git@marvil07.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fixes coding style in several headers
Message-ID: <20200716070416.GA962748@kroah.com>
References: <20200716064118.61243-1-qiuwenbo@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716064118.61243-1-qiuwenbo@phytium.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 02:41:12PM +0800, Qiu Wenbo wrote:
> This patch fixes warnings in several headers found by the checkpatch.pl tool.

What warnings specifically?

Please only fix one type of warning per patch.

> 
> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
> ---
>  drivers/staging/rtl8712/rtl871x_event.h   | 15 ++++++++++-----
>  drivers/staging/rtl8712/rtl871x_io.h      |  3 ++-
>  drivers/staging/rtl8712/rtl871x_pwrctrl.h | 15 ++++++++++-----
>  drivers/staging/rtl8712/rtl871x_xmit.h    | 15 ++++++++++-----
>  4 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
> index d9a5476d2426..0e59d0ee6aae 100644
> --- a/drivers/staging/rtl8712/rtl871x_event.h
> +++ b/drivers/staging/rtl8712/rtl871x_event.h
> @@ -78,13 +78,16 @@ struct event_node {
>  	unsigned char *node;
>  	unsigned char evt_code;
>  	unsigned short evt_sz;
> -	/*volatile*/ int *caller_ff_tail;
> +	/*volatile*/
> +	int *caller_ff_tail;

Why did you change this?  It's fine as is, and a hint something needs to
be fixed.

>  	int	caller_ff_sz;
>  };
>  
>  struct c2hevent_queue {
> -	/*volatile*/ int	head;
> -	/*volatile*/ int	tail;
> +	/*volatile*/
> +	int	head;
> +	/*volatile*/
> +	int	tail;

Same for these.



>  	struct	event_node	nodes[C2HEVENT_SZ];
>  	unsigned char	seq;
>  };
> @@ -92,8 +95,10 @@ struct c2hevent_queue {
>  #define NETWORK_QUEUE_SZ	4
>  
>  struct network_queue {
> -	/*volatile*/ int	head;
> -	/*volatile*/ int	tail;
> +	/*volatile*/
> +	int	head;
> +	/*volatile*/
> +	int	tail;
>  	struct wlan_bssid_ex networks[NETWORK_QUEUE_SZ];
>  };
>  
> diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
> index c20dd5a6bbd1..2e269b71072c 100644
> --- a/drivers/staging/rtl8712/rtl871x_io.h
> +++ b/drivers/staging/rtl8712/rtl871x_io.h
> @@ -101,7 +101,8 @@ struct	_io_ops {
>  struct io_req {
>  	struct list_head list;
>  	u32	addr;
> -	/*volatile*/ u32	val;
> +	/*volatile*/
> +	u32	val;
>  	u32	command;
>  	u32	status;
>  	u8	*pbuf;
> diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
> index dd5a79f90b1a..e6b740c09120 100644
> --- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
> +++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
> @@ -77,14 +77,19 @@ struct reportpwrstate_parm {
>  
>  struct	pwrctrl_priv {
>  	struct mutex mutex_lock;
> -	/*volatile*/ u8 rpwm; /* requested power state for fw */
> +	/*volatile*/
> +	u8 rpwm; /* requested power state for fw */
>  	/* fw current power state. updated when 1. read from HCPWM or
>  	 * 2. driver lowers power level
>  	 */
> -	/*volatile*/ u8 cpwm;
> -	/*volatile*/ u8 tog; /* toggling */
> -	/*volatile*/ u8 cpwm_tog; /* toggling */
> -	/*volatile*/ u8 tgt_rpwm; /* wanted power state */
> +	/*volatile*/
> +	u8 cpwm;
> +	/*volatile*/
> +	u8 tog; /* toggling */
> +	/*volatile*/
> +	u8 cpwm_tog; /* toggling */
> +	/*volatile*/
> +	u8 tgt_rpwm; /* wanted power state */
>  	uint pwr_mode;
>  	uint smart_ps;
>  	uint alives;
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
> index f227828094bf..6d2e12b35670 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.h
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.h
> @@ -182,11 +182,16 @@ struct sta_xmit_priv {
>  };
>  
>  struct	hw_txqueue {
> -	/*volatile*/ sint	head;
> -	/*volatile*/ sint	tail;
> -	/*volatile*/ sint	free_sz;	/*in units of 64 bytes*/
> -	/*volatile*/ sint      free_cmdsz;
> -	/*volatile*/ sint	 txsz[8];
> +	/*volatile*/
> +	sint	head;
> +	/*volatile*/
> +	sint	tail;
> +	/*volatile*/
> +	sint	free_sz;	/*in units of 64 bytes*/
> +	/*volatile*/
> +	sint      free_cmdsz;
> +	/*volatile*/
> +	sint	 txsz[8];
>  	uint	ff_hwaddr;
>  	uint	cmd_hwaddr;
>  	sint	ac_tag;
> -- 
> 2.27.0
> 

Actually same for all of these, the code is fine as-is.

thanks,

greg k-h
