Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C592920675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585571253;
	bh=ajDQwbsNxsLl0J0u0qBd4KKnlR4p1TibQ00sEsLk0ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h14rl4YPloMQBxzuIyTFon4ANd4V06xbbSRVHrOqunyAczskmdY2esI1/R0jL5tat
	 Hfy5aFL6zhS+StMyLl1HPQjwz8t9Mk5PFrgdCLMvWHBW3ymyzBrTQ16CylQnGR3adl
	 PgbFqKwicq5tZJdvSHV4E2P1ksRXQ/eWXJhHOCn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgC3M1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbgC3M1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:27:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC43420675;
        Mon, 30 Mar 2020 12:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585571250;
        bh=ajDQwbsNxsLl0J0u0qBd4KKnlR4p1TibQ00sEsLk0ZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXKBEWPy8pX6UU765tRl+nSECxxo98TqKBu3GDeQaN796sPI4b3gosPySJ1XV+Q3+
         do9zcGocwKrkGXHHB8IGm1OVNxAQ8Kva+pCCW1lc03exbElWvqTBFK+uEIzWDdlobe
         CeNw5eVMeInzTK5Fz/ukY5rzchWd84IYGwWcU6yU=
Date:   Mon, 30 Mar 2020 14:27:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: vt6656: Define EnCFG_BBType_MASK as OR between
 previous defines
Message-ID: <20200330122714.GA113453@kroah.com>
References: <20200327165802.8445-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165802.8445-1-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 05:58:02PM +0100, Oscar Carter wrote:
> Define the EnCFG_BBType_MASK bit as an OR operation between two previous
> defines instead of using the OR between two new BIT macros. Thus, the
> code is more clear.
> 
> Fixes: a74081b44291 ("staging: vt6656: Use BIT() macro instead of hex value")
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/staging/vt6656/mac.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
> index c532b27de37f..b01d9ee8677e 100644
> --- a/drivers/staging/vt6656/mac.h
> +++ b/drivers/staging/vt6656/mac.h
> @@ -177,7 +177,7 @@
>  #define EnCFG_BBType_a		0x00
>  #define EnCFG_BBType_b		BIT(0)
>  #define EnCFG_BBType_g		BIT(1)
> -#define EnCFG_BBType_MASK	(BIT(0) | BIT(1))
> +#define EnCFG_BBType_MASK	(EnCFG_BBType_b | EnCFG_BBType_g)

This does not "fix" anything, like your "Fixes:" tag implies.  It just
cleans up the code some more.  Only use Fixes: if it actually fixes a
problem introduced by a previous patch.

Can you remove that line and resend?

thanks.

greg k-h
