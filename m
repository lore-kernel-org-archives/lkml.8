Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4938FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AAB2073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595150546;
	bh=sGfO3y4kT4xic/3N5k1tpNgoebDdYB4aq+e8LiCLE+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FLNXB+Bjfv23HlxH4y1Z01uNoC3dD47fCxtipcMf7YtAGT52pFZVVFlyczPVZhsQc
	 kXw9yuV0yWzFbfyvkbABH+cBFA9tyZVWOX6JThkwS9wr8QPXD52ttXfLXkaT6B0xLA
	 4T0HtDanjHDeBTVmP3iB/gaJvm3zEVK8tZUyhkq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgGSJWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 05:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgGSJWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 05:22:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1674B20734;
        Sun, 19 Jul 2020 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595150543;
        bh=sGfO3y4kT4xic/3N5k1tpNgoebDdYB4aq+e8LiCLE+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmwWn5LvDIrQ1l/0Y7B7O5H4Upn+Xskt8j6BQqgS+NJ+clQ1XB11cZxjbIgN/UBm6
         XQVU523jmAGrycjmEJnbqyWpp2kcbkXMAZwH0VYjC9P/KgrIGPEqIeca2cCRpJZwqm
         46crhI2soNfzVJbM9sCHnnlbQu8lEwYDEjNm23So=
Date:   Sun, 19 Jul 2020 11:22:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Darshan D V <darshandv10@gmail.com>
Cc:     yuehaibing@huawei.com, ardb@kernel.org, contact@christina-quast.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fixed the space and indentation
 coding styles
Message-ID: <20200719092236.GB171181@kroah.com>
References: <20200717150451.13735-1-darshandv10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717150451.13735-1-darshandv10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 08:34:51PM +0530, Darshan D V wrote:
> rtllib_crypt_ccmp.c: Fixed the error - space required before the
> open parenthesis '(' on line #281.
> 
> rtllib_crypt_ccmp.c: Fixed the warning - suspect code indent for
> conditional statements on line #338
> 
> Signed-off-by: Darshan D V <darshandv10@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> index 0cbf4a1a326b..b60e2a109ce4 100644
> --- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
> @@ -278,7 +278,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>  		int aad_len, ret;
>  
>  		req = aead_request_alloc(key->tfm, GFP_ATOMIC);
> -		if(!req)
> +		if (!req)
>  			return -ENOMEM;
>  
>  		aad_len = ccmp_init_iv_and_aad(hdr, pn, iv, aad);
> @@ -337,7 +337,7 @@ static int rtllib_ccmp_set_key(void *key, int len, u8 *seq, void *priv)
>  		}
>  		if (crypto_aead_setauthsize(data->tfm, CCMP_MIC_LEN) ||
>  			crypto_aead_setkey(data->tfm, data->key, CCMP_TK_LEN))
> -				return -1;
> +			return -1;
>  	} else if (len == 0) {
>  		data->key_set = 0;
>  	} else {
> -- 
> 2.17.1


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
