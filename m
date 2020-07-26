Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588B9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358BD206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595752002;
	bh=+uk7MIIMPHgiZ/Vvk6Ik8YDGvxAcPrqQ5e2EgEoj2w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gd7z/NA2TeNntGDsPaW63U07F1qzD8lXbqWPEKhWIJr8Uxm425KW7RlVJDSZMJzJG
	 IYFHkCX6su5YfCci9hHfEjt6mlOE6eBdpcS0ZLethLrNJvxsKuLYTnXVglqB5UVy1N
	 4fcGa+1CHQ8HoY6807zmVGc3+5iq1D+ezLb6BXUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGZI0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgGZI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:26:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F29E206F6;
        Sun, 26 Jul 2020 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595751998;
        bh=+uk7MIIMPHgiZ/Vvk6Ik8YDGvxAcPrqQ5e2EgEoj2w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DlkvWHEm2ut0XyRhMxCTFTHz9gNwFUG/DlNUO5f5kYbij/7FmUpn5WRyl5HM7Ecb1
         EVUbSCbn6cweIcTxCAqhvV3d2Ba6DM5HJkdUM4Hdj7rDE+q77gpqQlPzh5FhJ2WtZr
         n90JshAE4sA1aPKtXYBr9qnwLR6YaQS3kt2GBW+k=
Date:   Sun, 26 Jul 2020 10:26:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Cc:     devel@driverdev.osuosl.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: rtl8723bs: include: Fix coding style errors
Message-ID: <20200726082636.GA447282@kroah.com>
References: <20200726080215.41501-1-aditya.jainadityajain.jain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726080215.41501-1-aditya.jainadityajain.jain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 01:32:15PM +0530, Aditya Jain wrote:
> Fixing ERROR: "foo *	bar" should be "foo *bar" in hal_phy_cfg.h
> as reported by checkpatch.pl
> 
> Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
> ---
>  .../staging/rtl8723bs/include/hal_phy_cfg.h    | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> index 419ddb0733aa..fd5f377bad4f 100644
> --- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> +++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
> @@ -42,7 +42,7 @@ u32 	Data
>  
>  u32
>  PHY_QueryRFReg_8723B(
> -struct adapter *		Adapter,
> +struct adapter 		*Adapter,
>  u8 		eRFPath,
>  u32 			RegAddr,
>  u32 			BitMask

Ick, these are all horrid.  How about just making these all on a single
line like most functions have them instead of this one cleanup?

Same for the other changes you made in this file.

thanks,

greg k-h
