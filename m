Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C64C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010EB2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587812077;
	bh=XU8fusLrSTHmIUAeVbGFgNvIoVqbEQlw1d7OY9tTAvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZZlTAMba4h7YdmQPETeNWTBglIpgyRP6xXW4JmmkTUlx6rBWJI0cR0xF2faaBjnhO
	 mdl4CGgyTndGqPSMS11LDTao9bAWO//fIAigoBQCtt9TRmnAtNk/edeb9fpx/9Uezl
	 Cw/IY2I6e7Zdl+gYoKcqYb4Yb2kwUNVn4MP/q1Ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgDYKyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYKyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:54:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CB520714;
        Sat, 25 Apr 2020 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587812075;
        bh=XU8fusLrSTHmIUAeVbGFgNvIoVqbEQlw1d7OY9tTAvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCa3PyZVCeUVlmy+czbQUoSbGWp5TY6eCGW9a9RqrhOEd4i8Da8iIGz2KhysHPVIv
         /ArdsHI4hsE15umyFtYnPbtienLTyQBZhgquwoskmWLZBcqdJyO4EOZglxlWSoonq0
         QKUsISQlJRMJwIRfIZ/ZGzWrhMdHdoMDp2XX0Ww8=
Date:   Sat, 25 Apr 2020 12:54:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suraj Upadhyay <usuraj35@gmail.com>
Cc:     jerome.pouiller@silabs.com, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200425105432.GA2068247@kroah.com>
References: <20200424134834.GA19700@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424134834.GA19700@blackclown>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 07:18:34PM +0530, Suraj Upadhyay wrote:
> Break lines with length over 80 characters to conform
> to the linux coding style and refactor wherever necessary.
> 
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
> 
> Changes in v3:
> 	- Changed the temporary variable name for the memzcmp statement
> 	  to is_used. (as suggested).
> 	- Added a temporary ieee80211_supported_band variable to address
> 	  the problem in wfx_get_hw_rate() more efficiently. (not
> 	  suggested, but still).
> 
> Changes in v2:
>         - Introduced a temporary variable for the memzcmp statement.
>         - Addressed the checkpatch problem with wfx_get_hw_rate().
>         - Restored the function definition of wfx_tx_get_tx_parms
>           as suggested by the reviewer.
>         - Added suggested changes for req->packet_id statement.
> 
>  drivers/staging/wfx/data_tx.c | 40 +++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
> index 9c1a91207dd8..717155975345 100644
> --- a/drivers/staging/wfx/data_tx.c
> +++ b/drivers/staging/wfx/data_tx.c
> @@ -20,6 +20,8 @@
>  static int wfx_get_hw_rate(struct wfx_dev *wdev,
>  			   const struct ieee80211_tx_rate *rate)
>  {
> +
> +	struct ieee80211_supported_band *band;
>  	if (rate->idx < 0)

checkpatch did not complain about this change?

It should have...

Please fix that up.

thanks,

greg k-h
