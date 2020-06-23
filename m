Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C62CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68674207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cqkg6S/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbgFWThb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbgFWTh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:37:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A2BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:37:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z63so10571508pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8tcoG/srDe41M/d7sumygMyJ7BaeM73/Bo5ylqI3GKA=;
        b=Cqkg6S/8/9qXa9Wew7R7+tLH85WimVGdrzM9LUVwPd7s+V25vQHgnxXWWCiQReHRFx
         8fZONY8wJi90pYuiLeHlN6TWAUD9Dcss/PS8ZBlTuLPAoSCR26ewDjmztbjO4Ux2++3z
         W3gK/vzRiNCET6NC8a8lBWp4A63GFYjRoxFWSMnrPKlXOXrtasIlbTNDfUIKTdR4xgX2
         Stokz60sbrxxGWsqbpSN+m6WLFdG0B5IvYd6JwYzPEa51FZBlN6/QdgphAyDBiaK2qne
         UGUAMTb9k5QtNzdGADHtHgJu6JAMMyW//r/acCrmE7jEuEuW7cpGQ89hzklUXgEURUjr
         ZmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8tcoG/srDe41M/d7sumygMyJ7BaeM73/Bo5ylqI3GKA=;
        b=I1XIE6UAG4tIBvkxJ1OVxFok/UgepWflKiRMwvAxuYcHrYj7QR4ld2J3R/Vj5Fx9UC
         XUn0bsw4YLkRH1gHt/Q66t76cu9YXrdNP3lmM8lSnic8D1LCQg5SYqKiGcqAVJd8fGZs
         I9caOe6s8sYVtZmHas/pWTLRDs18XTm3wAYCqWFP5xnDCRq0kUZNT5EX0jQR5hC4hNP4
         +ZZ2isO//HUvgwyz8F0SZftE5/a/zAczKZzl/ZJm38gv105YdOrpKYlAH0Zso/bCSzrd
         mXmwihdE+rw24ORO8cMh7KGxTR+4Sf0jSQp+z6/g6GBvXTLZ1xHrO0MM4SZWPrN1uSR0
         73Mw==
X-Gm-Message-State: AOAM532XFz3z6qp48pu/+MFDKBbm3m6+pTEgg4Y2HhElZp9AmaLyVviS
        3G6naYXVPs70fm9iUQRxyu4M6w==
X-Google-Smtp-Source: ABdhPJwvNKBozLgfp5hKqsOZhbe46vtp3p6HtncuBeoDlDod08/cwAB4QukHgS6v6XWRiKlpEFblfg==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr13015187pgh.255.1592941047943;
        Tue, 23 Jun 2020 12:37:27 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n4sm18301557pfq.9.2020.06.23.12.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 12:37:27 -0700 (PDT)
Date:   Tue, 23 Jun 2020 13:37:25 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, s-anna@ti.com
Subject: Re: [PATCH v4 3/9] remoteproc: Introducing function rproc_attach()
Message-ID: <20200623193725.GA1908098@xps15>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
 <20200601175139.22097-4-mathieu.poirier@linaro.org>
 <20200622070727.GD149351@builder.lan>
 <20200622071804.GE149351@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622071804.GE149351@builder.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 22, 2020 at 12:18:04AM -0700, Bjorn Andersson wrote:
> On Mon 22 Jun 00:07 PDT 2020, Bjorn Andersson wrote:
> 
> > On Mon 01 Jun 10:51 PDT 2020, Mathieu Poirier wrote:
> > 
> > > Introducing function rproc_attach() to enact the same actions as
> > > rproc_start(), but without the steps related to the handling of
> > > a firmware image.  That way we can properly deal with scenarios
> > > where the remoteproc core needs to attach with a remote processsor
> > > that has been booted by another entity.
> > > 
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 42 ++++++++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > > 
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index 9f04c30c4aaf..0b323f6b554b 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -1370,6 +1370,48 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
> > >  	return ret;
> > >  }
> > >  
> > > +static int __maybe_unused rproc_attach(struct rproc *rproc)
> > > +{
> > > +	struct device *dev = &rproc->dev;
> > > +	int ret;
> > > +
> > 
> > For the case where we're going DETACHED -> RUNNING - > OFFLINE we
> > need to consider the pm_runtime (and prepare/unprepare) state of the
> > device as well...
> > 
> 
> Missed that you do indeed pm_runtime_get() in the calling function, so I
> think we're good on that part. Still need how to actually implement
> that (and the prepare/unprepare), in particular if we're moving into
> detaching a remoteproc.

I had planned to look at the interaction between the PM runtime and prepare/unprepare
callbacks later today.  Depending on what I find I may end up modifying this
patch... 

> 
> > 
> > Apart from that I think this looks good.
> > 
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn
> 
> > Regards,
> > Bjorn
> > 
> > > +	ret = rproc_prepare_subdevices(rproc);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
> > > +			rproc->name, ret);
> > > +		goto out;
> > > +	}
> > > +
> > > +	/* Attach to the remote processor */
> > > +	ret = rproc_attach_device(rproc);
> > > +	if (ret) {
> > > +		dev_err(dev, "can't attach to rproc %s: %d\n",
> > > +			rproc->name, ret);
> > > +		goto unprepare_subdevices;
> > > +	}
> > > +
> > > +	/* Start any subdevices for the remote processor */
> > > +	ret = rproc_start_subdevices(rproc);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to probe subdevices for %s: %d\n",
> > > +			rproc->name, ret);
> > > +		goto stop_rproc;
> > > +	}
> > > +
> > > +	rproc->state = RPROC_RUNNING;
> > > +
> > > +	dev_info(dev, "remote processor %s is now attached\n", rproc->name);
> > > +
> > > +	return 0;
> > > +
> > > +stop_rproc:
> > > +	rproc->ops->stop(rproc);
> > > +unprepare_subdevices:
> > > +	rproc_unprepare_subdevices(rproc);
> > > +out:
> > > +	return ret;
> > > +}
> > > +
> > >  /*
> > >   * take a firmware and boot a remote processor with it.
> > >   */
> > > -- 
> > > 2.20.1
> > > 
