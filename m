Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB300C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E37C2067D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 06:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ+3uWx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgHAGrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgHAGr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 02:47:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D01C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 23:47:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so29725733wrh.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 23:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ghZyPFC3vU2L7Bh9FzpIpt3HEBdmfDTKKzPrEZq7vc4=;
        b=BJ+3uWx1pNZDTKWqdKZ6ZNbZm2uI5xSDRSoDBE07xOJdRAt+bC5d6gueCqtIgH6aJC
         dBohHuOP6NS8NHwIDgZQrj1qq9R8MupD4ShVnoMNwIaVPOwydkftym2VMVJK3Mf+zlPn
         zame2nJquED7J28iyjEWIAT3r1XiMkqM0bBBCqfGR4DsMiGbDZ60+uDfCWKpGx5PYmKD
         PhDP3S3NqvMBmwlteZ/imuqyOhwBV9/7bkbrmZdp/NRu/GpVe1tuZRBOPzF2tvHFlhbx
         l2X92AVuhKlTdNj/8rMNccqe6b2mYi3Sc4Vs6UrN8eFcD2yJvEg48VoDpkpy3KTm5upM
         ATCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ghZyPFC3vU2L7Bh9FzpIpt3HEBdmfDTKKzPrEZq7vc4=;
        b=LwIfiH2ZcHZQ/YnlrRrFOjmdva2t4UJkosdMIl71PF5yPDyU8/5gJNXwzmzULgaWew
         VDgvIZczFNtHUQFjxOrjM7DJa+0ARASBvNbWh/rZxPv9srteS6RHgys6UAWO7OYQ14Zr
         TaAUNAKvoMJ+uEZgzKpaqo92yp7vohsbPmYJ8CsY5D5I45cWXm7/UWsiQdjs2QywXwZw
         VMPV+kCZVwMwtbEjgvosjBElgd7ZOFsy8LGDqEOi1vTXGWKgB9gR7O2C60l558d0z/dp
         Rm923itqWRfarnSnxe4SpWX6gkxTj/MRqEuEeKbwk/F/jR4vP/2bnwOoItsN2L7qZBsk
         aEsg==
X-Gm-Message-State: AOAM530BKnB8b17VgTPjUkfHlaFZvMf8sFcJrzpIab/de+VFM9TnZxlv
        vhF7aE6j+6yHxFy743/xrUA=
X-Google-Smtp-Source: ABdhPJwE5jaIJdGYRWYglX+ryNHaBW4BbW+1xg/jEKK/g4bTRIn/9A0HVd6t+fAMdez/vszPQyQIQQ==
X-Received: by 2002:a5d:664e:: with SMTP id f14mr6333423wrw.6.1596264447678;
        Fri, 31 Jul 2020 23:47:27 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id 62sm16194105wrq.31.2020.07.31.23.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 23:47:26 -0700 (PDT)
Date:   Sat, 1 Aug 2020 08:47:24 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ce - Fix writel byte-order on big-endian
Message-ID: <20200801064724.GA11589@Red>
References: <202007281310.eciiVHmF%lkp@intel.com>
 <20200728060040.GA15882@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728060040.GA15882@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 04:00:40PM +1000, Herbert Xu wrote:
> On Tue, Jul 28, 2020 at 01:10:13PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   92ed301919932f777713b9172e525674157e983d
> > commit: 93c7f4d357de68f1e3a998b2fc775466d75c4c07 crypto: sun8i-ce - enable working on big endian
> > date:   8 months ago
> > config: arm64-randconfig-s031-20200728 (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.2-94-geb6779f6-dirty
> >         git checkout 93c7f4d357de68f1e3a998b2fc775466d75c4c07
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> This looks like a real bug.
> 
> ---8<---
> As writel does endianness swapping by default we need to undo
> any swapping that we have done before using it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 93c7f4d357de ("crypto: sun8i-ce - enable working on big...")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> index 138759dc8190..703a60d4e2f6 100644
> --- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> +++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
> @@ -120,7 +120,7 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
>  	/* Be sure all data is written before enabling the task */
>  	wmb();
>  
> -	v = 1 | (ce->chanlist[flow].tl->t_common_ctl & 0x7F) << 8;
> +	v = 1 | (le32_to_cpu(ce->chanlist[flow].tl->t_common_ctl) & 0x7F) << 8;
>  	writel(v, ce->base + CE_TLR);
>  	mutex_unlock(&ce->mlock);
>  
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

This is fixed in my v4 serie and the current driver is unaffected, only hashes/rng could hit a problem and v4 bring them along with the fix.
