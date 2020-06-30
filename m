Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E814C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8618206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGZjrssa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgF3JKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgF3JKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:10:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C9EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:10:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so19336285wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qw+g1jLxSkKavfMbFGU6iuXSgClnm8neHGPQpEb1Hmc=;
        b=DGZjrssaQWi8uYoqx2PT+vh8VkTkMaIbqx5nH+ZfB5u8Xpa7XLIr9EDpmliTqmZFg+
         7DcuSDiwYO3dqO97ZJzf243XyLki7Msw2L1RRQQXeneYaG9OjPJf6mzF0T+BbWyAFFgR
         b8sy0aMzEOLLEM8+OOvz4+yhBuPWi7Mr32BNRZFlLiBwH7v6QLM1NB9RL49pgHJWKGLo
         mwbkx1dqSi/EeblRZtorv25vYrD/gjmD9DLpwMcj6AdvvF9oeJRYvFB8AtaKxr6fpoK0
         fWbL5GDZr3QdNTRkRgxMFGSQfr8NFFVHXvv+D8OXXUYiBVJ+3G1aim4N972AddRYT2fT
         5rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qw+g1jLxSkKavfMbFGU6iuXSgClnm8neHGPQpEb1Hmc=;
        b=DeDOASRe0zNftL/0wK7t8e58eBwFRRVxb5IQx8cN3g9/RiI2sVrEGiSvCMVt20vHk0
         na52FbPcPyhFnUizmwD+gY+CthwB68h3qeFztowm6I4syAng1YD80xetLyyibQ7Vccd4
         v/C79TFFFRrTL4eT/ahPe8bX3BjyNiZZzmEtiDbnBipNY1g+eJHdqIUxPkzneSAK8zad
         e/XJdPJqb5MRHNewJdbLtCYStv+7VbeImcSVPUgQkQhoR/bV4UdrHm2NNAlmfNw/TucZ
         /mPgHZP4y22/lm87iQzNidTSouQ1GrhxUQu2Rp1FFRIx4Xy1QcEMdwGpiqPaMfgVjyZi
         UqOA==
X-Gm-Message-State: AOAM531NMCa1L/z1Xvtii68dMpypqa4AIcoeYJUw+oAYIZ+QtVN8+ZGG
        8ffzmpB+qcPQu+mZ4Y+VzuvoNg==
X-Google-Smtp-Source: ABdhPJxgqjKPF7nbSn/auL0wj5H0DWf+4ftxxPtYiwQsFQWStOssSU9Pwl5Wt4o7o9I8jDQgnqg/Ww==
X-Received: by 2002:adf:f104:: with SMTP id r4mr21796791wro.90.1593508222607;
        Tue, 30 Jun 2020 02:10:22 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id v18sm3013117wrv.49.2020.06.30.02.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 02:10:22 -0700 (PDT)
Date:   Tue, 30 Jun 2020 10:10:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     haver <haver@linux.vnet.ibm.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: Re: [PATCH 17/20] misc: genwqe: card_base: Do not pass unused
 argument 'fatal_err'
Message-ID: <20200630091020.GJ1179328@dell>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
 <20200629140442.1043957-18-lee.jones@linaro.org>
 <016718c7218cf811897cc32cf9476222@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <016718c7218cf811897cc32cf9476222@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, haver wrote:

> On 2020-06-29 16:04, Lee Jones wrote:
> > 'fatal_err' is taken as an argument to a static function which is only
> > invoked once.  During this invocation 'fatal_err' is not set.  There
> > doesn't appear to be a good reason to keep it around.
> > 
> > Also fixes the following W=1 kernel build warning:
> > 
> >  drivers/misc/genwqe/card_base.c:588: warning: Function parameter or
> > member 'fatal_err' not described in 'genwqe_recover_card'
> > 
> > Cc: Michael Jung <mijung@gmx.net>
> > Cc: Michael Ruettger <michael@ibmra.de>
> > Cc: Frank Haverkamp <haver@linux.ibm.com>
> > Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/misc/genwqe/card_base.c | 18 +++---------------
> >  1 file changed, 3 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/misc/genwqe/card_base.c
> > b/drivers/misc/genwqe/card_base.c
> > index bceebf49de2d5..809a6f46f6de3 100644
> > --- a/drivers/misc/genwqe/card_base.c
> > +++ b/drivers/misc/genwqe/card_base.c
> > @@ -569,30 +569,18 @@ static int genwqe_stop(struct genwqe_dev *cd)
> > 
> >  /**
> >   * genwqe_recover_card() - Try to recover the card if it is possible
> > - *
> > - * If fatal_err is set no register access is possible anymore. It is
> > - * likely that genwqe_start fails in that situation. Proper error
> > - * handling is required in this case.
> > + * @cd: GenWQE device information
> >   *
> >   * genwqe_bus_reset() will cause the pci code to call genwqe_remove()
> >   * and later genwqe_probe() for all virtual functions.
> >   */
> > -static int genwqe_recover_card(struct genwqe_dev *cd, int fatal_err)
> > +static int genwqe_recover_card(struct genwqe_dev *cd)
> >  {
> >  	int rc;
> >  	struct pci_dev *pci_dev = cd->pci_dev;
> > 
> >  	genwqe_stop(cd);
> > 
> > -	/*
> > -	 * Make sure chip is not reloaded to maintain FFDC. Write SLU
> > -	 * Reset Register, CPLDReset field to 0.
> > -	 */
> > -	if (!fatal_err) {
> > -		cd->softreset = 0x70ull;
> > -		__genwqe_writeq(cd, IO_SLC_CFGREG_SOFTRESET, cd->softreset);
> > -	}
> > -
> >  	rc = genwqe_bus_reset(cd);
> >  	if (rc != 0) {
> >  		dev_err(&pci_dev->dev,
> > @@ -958,7 +946,7 @@ static int genwqe_health_thread(void *data)
> > 
> >  			cd->card_state = GENWQE_CARD_FATAL_ERROR;
> > 
> > -			rc = genwqe_recover_card(cd, 0);
> > +			rc = genwqe_recover_card(cd);
> >  			if (rc < 0) {
> >  				/* FIXME Card is unusable and needs unbind! */
> >  				goto fatal_error;
> 
> I think this one I want to keep. Since fatal_err is 0, !fatal_error is 1 and
> the register write is actually executed.

Ah yes, good catch.

What if we *always* did instead then?

> I also want to keep the parameter even though it is only used with 0. The
> register bit causes a less drastic recovery, but if we would discover that
> that is not working ok, we rather discard the debug data we get in this case
> instead of letting the recovery fail. I think it does not hurt to keep it.

I'm not 100% against it, but it is dead code.

> Maybe you can add a comment?

If you really want to keep it, I can just update the kerneldoc
instead.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
