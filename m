Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC8C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F032072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588076688;
	bh=v3DgtmSId2rTIqTuXLUCM4ll+1xF/+qucisJtHmJLms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LjnEI1CwUPaHeGCOmlHUjkbvYH3alg1eTEVxF8AvkT7be3xMTkQomRBim+4Zicios
	 OFckFnKUIw+Gz/gqGuI8qWGgnamTvkxJq31EOgiOdsrRNdidhuQbA6E2/Pf7t6fdWy
	 cmV6pJUe35At225YZ9yPLWx8CQJTBJsJgRcCBqeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgD1MYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgD1MYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:24:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FEE2206A1;
        Tue, 28 Apr 2020 12:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588076687;
        bh=v3DgtmSId2rTIqTuXLUCM4ll+1xF/+qucisJtHmJLms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjRjCj3EJ+e4zbnwYzOHx2FWHVrfmyqtxQjIAUTjAWlE3B80++82vUEyFofkur8+5
         r1LJp2BO3Os377GlnhwKOzatZoHHhLEe9guFj+TTmTbbbSA5EBDm7fPo+7IUrKbYA6
         mQyZWunYErUrZzvOzBeVSLavPU/OULpsNbkjuwAM=
Date:   Tue, 28 Apr 2020 14:24:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: change prefix to qlge_*
Message-ID: <20200428122444.GA1244536@kroah.com>
References: <20200426084120.28295-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426084120.28295-1-realwakka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 05:41:20PM +0900, Sidong Yang wrote:
> In terms of namespace, The driver uses either qlge_, ql_ or nothing.
> also there is macro using QL_. This can make crash with other qlogic
> drivers. Rename everything to use the qlge_ or QLGE_ prefix.

How can it crash anything?

I can see changing global functions to a common namespace like this, but
you are changing a _lot_ of things here:

> ---
>  drivers/staging/qlge/qlge.h         |  488 +++++------
>  drivers/staging/qlge/qlge_dbg.c     |  638 +++++++-------
>  drivers/staging/qlge/qlge_ethtool.c |  484 +++++------
>  drivers/staging/qlge/qlge_main.c    | 1200 +++++++++++++--------------
>  drivers/staging/qlge/qlge_mpi.c     |  386 ++++-----
>  5 files changed, 1598 insertions(+), 1598 deletions(-)
> 
> diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
> index fc8c5ca8935d..a8da06c978ff 100644
> --- a/drivers/staging/qlge/qlge.h
> +++ b/drivers/staging/qlge/qlge.h
> @@ -955,7 +955,7 @@ enum {
>  	MB_CMD_GET_PORT_CFG = 0x00000123,
>  	MB_CMD_GET_LINK_STS = 0x00000124,
>  	MB_CMD_SET_LED_CFG = 0x00000125, /* Set LED Configuration Register */
> -		QL_LED_BLINK = 0x03e803e8,
> +		QLGE_LED_BLINK = 0x03e803e8,
>  	MB_CMD_GET_LED_CFG = 0x00000126, /* Get LED Configuration Register */
>  	MB_CMD_SET_MGMNT_TFK_CTL = 0x00000160, /* Set Mgmnt Traffic Control */
>  	MB_SET_MPI_TFK_STOP = (1 << 0),
> @@ -986,14 +986,14 @@ enum {
>  	MB_CMD_STS_PARAM_ERR = 0x00004006,	/* Parameter Error. */
>  };
>  
> -struct mbox_params {
> +struct qlge_mbox_params {
>  	u32 mbox_in[MAILBOX_COUNT];
>  	u32 mbox_out[MAILBOX_COUNT];
>  	int in_count;
>  	int out_count;
>  };

Why change local structure names that are local to the specific driver?
That "namespace" can not escape out of the driver, so lots of these
changes are unneeded.

I will gladly take a patch that fixes up the global symbols, but that's
all that needs to be done here, right?

thanks,

greg k-h
