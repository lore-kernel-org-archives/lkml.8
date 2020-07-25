Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D909C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A81E2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595684077;
	bh=1xJLgPKo17XB2bbhytRqI3o6mCjroafyaZ1pK+RLnc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UdvDRhYPUt8dPqrNw0ev46uoYcV75jrjyoAyrCOZ5hQRyk/wY/LjXRGnMlHhpcVjY
	 bFTspuBNtEMbJP2xQ96NQ1ilrljswOdmwAsRiBbloRoCka7/j1zi9hrsCOmrwqNRbU
	 rr67gHPzoTonBhCe5kaYVNYt537QoOCMyNbgX4hA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGYNeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 09:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbgGYNef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 09:34:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 779672070C;
        Sat, 25 Jul 2020 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595684075;
        bh=1xJLgPKo17XB2bbhytRqI3o6mCjroafyaZ1pK+RLnc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OC5t1ZjACNZQsWL+I/n74e85vGj+lQ1sL8xg4rlOZWOYRZYHCYZg+gZ/CQW4Whnhy
         xiRqz3F9JtbmyYp39GaTg+414zoU7fSgQEOtLH9ivhf/PO/gh9058YU22a93NGYmKj
         +yk7kZO1cPMHD14yk8zfkQ6XK4MqSVE8+ClDhDMU=
Date:   Sat, 25 Jul 2020 15:34:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com
Subject: Re: [PATCH V2] Subject: [PATCH] staging: rtl8723bs: core: Using
 comparison to true is error prone
Message-ID: <20200725133434.GA1143075@kroah.com>
References: <20200725132806.15019-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725132806.15019-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 02:28:06PM +0100, John Oldman wrote:
> clear below issues reported by checkpatch.pl:
> 
> CHECK: Using comparison to true is error prone

Your subject line is very odd :(

> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> ---
> v1: Initial attempt.
> v2: Removed unneccessary parentheses around 'pregistrypriv->ht_enable'
> Also considered clearing 'CHECK: Logical continuations should be on the previous line' report
> but this results in exceeding line length guideline.
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index ca98274ae390..7aacbe1b763e 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -363,8 +363,9 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
>  	}
> 
>  	/* HT Cap. */
> -	if (((pregistrypriv->wireless_mode&WIRELESS_11_5N) || (pregistrypriv->wireless_mode&WIRELESS_11_24N))
> -		&& (pregistrypriv->ht_enable == true)) {
> +	if (((pregistrypriv->wireless_mode & WIRELESS_11_5N)
> +	      || (pregistrypriv->wireless_mode & WIRELESS_11_24N))
> +	      && pregistrypriv->ht_enable) {

 || and && go on the end of the line, not the front.

But you also changed other things that were not needed here, and you did
not say that in your changelog text :(

thanks,

greg k-h
