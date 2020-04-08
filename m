Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA68C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F042A20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XoxkBf1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgDHUYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:24:42 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33390 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgDHUYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FCin5CxUiqOa42dOBAJeAv8hLhn4PzxcsTEw9e4NZJY=; b=XoxkBf1bGxRc+ttmmvia5OvZE
        oitOH2Yx9geESlq3nazl+qwL1Zcf4HXXYRApOnK0i4z8MNlEFJt2LTp+u/ERpFq03tgqzs7llZQap
        cVk83dH1h6HRrumDZSkAtJgvPqQO66fXqOIcB5Q68w3pPPEHI5k5ZEcghDm8DVCHT54DCGxe1o8cq
        jhfarDU/C7T60Vf4T11sKFZNZK7YgjCb1UE/pU1wXm2MVZAQfHzfqTjeRG0bPOtHHOVKntwYNr9Ol
        qAA9d4r8PbrRWrO7nUwQQpmj1vzZlPyOv45WxEnHXV7WODgTgGxs3J/xXOsefCD0EU2J8SlMI7rnw
        DLBHbG05g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47442)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jMHFO-0008KP-0G; Wed, 08 Apr 2020 21:24:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jMHFF-00027f-Jb; Wed, 08 Apr 2020 21:24:21 +0100
Date:   Wed, 8 Apr 2020 21:24:21 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Roy Pledge <Roy.Pledge@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: fsl: dpio: avoid stack usage warning
Message-ID: <20200408202421.GU25745@shell.armlinux.org.uk>
References: <20200408185834.434784-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408185834.434784-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 08:58:16PM +0200, Arnd Bergmann wrote:
> A 1024 byte variable on the stack will warn on any 32-bit architecture
> during compile-testing, and is generally a bad idea anyway:
> 
> fsl/dpio/dpio-service.c: In function 'dpaa2_io_service_enqueue_multiple_desc_fq':
> fsl/dpio/dpio-service.c:495:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> There are currently no callers of this function, so I cannot tell whether
> dynamic memory allocation is allowed once callers are added. Change
> it to kcalloc for now, if anyone gets a warning about calling this in
> atomic context after they start using it, they can fix it later.
> 
> Fixes: 9d98809711ae ("soc: fsl: dpio: Adding QMAN multiple enqueue interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/soc/fsl/dpio/dpio-service.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index cd4f6410e8c2..ff0ef8cbdbff 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -478,12 +478,17 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
>  				const struct dpaa2_fd *fd,
>  				int nb)
>  {
> -	int i;
> -	struct qbman_eq_desc ed[32];
> +	struct qbman_eq_desc *ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);

I think you need to rearrange this to be more compliant with the coding
style.

> +	int i, ret;
> +
> +	if (!ed)
> +		return -ENOMEM;
>  
>  	d = service_select(d);
> -	if (!d)
> -		return -ENODEV;
> +	if (!d) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
>  
>  	for (i = 0; i < nb; i++) {
>  		qbman_eq_desc_clear(&ed[i]);
> @@ -491,7 +496,10 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
>  		qbman_eq_desc_set_fq(&ed[i], fqid[i]);
>  	}
>  
> -	return qbman_swp_enqueue_multiple_desc(d->swp, &ed[0], fd, nb);
> +	ret = qbman_swp_enqueue_multiple_desc(d->swp, &ed[0], fd, nb);
> +out:
> +	kfree(ed);
> +	return ret;
>  }
>  EXPORT_SYMBOL(dpaa2_io_service_enqueue_multiple_desc_fq);
>  
> -- 
> 2.26.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
