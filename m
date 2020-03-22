Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5292C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F19A20714
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584876377;
	bh=OiEurEKKZLz5Mz/S8byIrRQLkbRiNo+3AQ/w5bAcbtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YxKa9ve9IK6wE3b/ECWwTS4/0STdC/xwXJcYgG/+CIHNhOj2Cv2/LoWLVPmUQY0af
	 E7CncPQe56/YbqBsa2HhOMaOETJIrkyqeAXJKXwBxxhg9rMy78b7iNFG91sZkkchTA
	 VRd179lZt9CBNI/BJ74cDP3zUhY0ErNd2aE3rKg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCVL0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgCVL0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:26:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D5B20714;
        Sun, 22 Mar 2020 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584876374;
        bh=OiEurEKKZLz5Mz/S8byIrRQLkbRiNo+3AQ/w5bAcbtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tw1uBt6AVm9fR0Xz7qaVF5w0nKkfyu1KIAtPS2JdW9IsDUdJb3E9L3+SzE4mvVqeq
         t9WBALmeuagUxTf8sL7Ooa3/rwIqa2VtVRONMjEhNAHhw8ut6LINCWsqzoduin2/rH
         m7NuJdJ2b+D3JvG2RRxYywWxTR0EonV6Tw59cXY8=
Date:   Sun, 22 Mar 2020 12:26:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@inria.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Colin Ian King <colin.king@canonical.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: remove unneeded variable: ret
Message-ID: <20200322112611.GB75383@kroah.com>
References: <20200322092303.2518033-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322092303.2518033-1-jbwyatt4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 02:23:03AM -0700, John B. Wyatt IV wrote:
> Remove unneeded variable ret; replace with 0 for the return value.
> 
> Update function documentation (comment) on the return status as
> suggested by Julia Lawall <julia.lawall@inria.fr>.
> 
> Issue reported by coccinelle (coccicheck).
> 
> Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> ---
>  drivers/staging/vt6656/card.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
> index dc3ab10eb630..05b57a2489a0 100644
> --- a/drivers/staging/vt6656/card.c
> +++ b/drivers/staging/vt6656/card.c
> @@ -716,13 +716,11 @@ int vnt_radio_power_off(struct vnt_private *priv)
>   *  Out:
>   *      none
>   *
> - * Return Value: true if success; otherwise false
> + * Return Value: 0

If this always returns something, why have it return anything at all?

Why not make this a patch series, doing this, and then fixing up the
callers and the function to not return anything.

thanks,

greg k-h
