Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C1C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAB02184D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwYKQExG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEHTh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHTh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:37:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E8C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 12:37:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so1173002plt.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MM+EfAjkHc8LoqfMvtzvccHII1WH38gRuXMGYiBBnFE=;
        b=WwYKQExGgTsrssSscMFy2ZBRu0gm/Ws61srkCzbPrdobD6SIqhjBoo9/qTYuJmsrSd
         mzp77tIMnN9Y4WcLsFL1cGbN3P/qcSC58VVgYrhsZMI16iyUVJfP/cH7l30NpcsNt4Aj
         Yj6AN4YQBscNlDxlEEO/OuUdkQUyXSV7mRPaVaK9PY5iHNMBELaz8lWHDvxbr0/5wO7+
         cQjYwqhhRuB6P8Q3bJTgkqGhQEKiBcRWN/ip7offgtTJBRrCuMv34z0K/JDztIhsFqmS
         5qXsvrIg7mHwVghYDxZIPyKWmc/bZ63YwLd1R54Hjc8f7ZsVaijK9hUa7P7yufVdpLEV
         WV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MM+EfAjkHc8LoqfMvtzvccHII1WH38gRuXMGYiBBnFE=;
        b=Uyna81hxzMzIUGKpB99oTbl/Nw5gVO0WPas1oHks+Tq1dru24vM3zQySVe1P6XLbBe
         D+6RBnoHj/UgLcAARJ2n5nIS76C0Qf8klUv2Y4jcEOOLS6+RD+YLMjw8eqBEhMvm+5L8
         9cjHPOwLCUggzVDof5H+6YFEQ4R7HLoJajJS6NvckyW7SuiDKgO/b5ehmzluVxhhSaLD
         x28749s6cYLXaI89eGxcVXi312TxcLLI8ykckaVODA5LeQIxKYQY+2lTAy8opc6pdQiC
         L76kOzZ73EMl6NA52bIDBbLEvhfiNJnhrR77HANFL4H4Rf5HjR5T3HO1R67abI1mDlJ+
         Om9g==
X-Gm-Message-State: AGi0PuZDII7WJtzApbop7GJj/CDZiIgArkzipdsD5PLMVKClK3B1eewz
        44z5bJJqy0aiseo78wCuxfBFNg0uiKo=
X-Google-Smtp-Source: APiQypJ/pPShgC/v2Z2yC+NlljFPbzhnP6tzi/R7vtfhvEgY5MefS6gGP8gHf6NSz2hIbbZOuEEIhA==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4mr3594492pls.275.1588966646505;
        Fri, 08 May 2020 12:37:26 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c84sm2640455pfb.153.2020.05.08.12.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 12:37:25 -0700 (PDT)
Date:   Fri, 8 May 2020 13:37:23 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, loic.pallardy@st.com, arnaud.pouliquen@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/14] remoteproc: Introduce function
 rproc_alloc_internals()
Message-ID: <20200508193723.GB4526@xps15>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-3-mathieu.poirier@linaro.org>
 <20200505223158.GB2329931@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505223158.GB2329931@builder.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:31:58PM -0700, Bjorn Andersson wrote:
> On Fri 24 Apr 13:01 PDT 2020, Mathieu Poirier wrote:
> 
> > In scenarios where the remote processor's lifecycle is entirely
> > managed by another entity there is no point in allocating memory for
> > a firmware name since it will never be used.  The same goes for a core
> > set of operations.
> > 
> > As such introduce function rproc_alloc_internals() to decide if the
> > allocation of a firmware name and the core operations need to be done.
> > That way rproc_alloc() can be kept as clean as possible.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 31 +++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 448262470fc7..1b4756909584 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -2076,6 +2076,30 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
> >  	return 0;
> >  }
> >  
> > +static int rproc_alloc_internals(struct rproc *rproc,
> > +				 const struct rproc_ops *ops,
> > +				 const char *name, const char *firmware)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * In scenarios where the remote processor's lifecycle is entirely
> > +	 * managed by another entity there is no point in carrying a set
> > +	 * of operations that will never be used.
> > +	 *
> > +	 * And since no firmware will ever be loaded, there is no point in
> > +	 * allocating memory for it either.
> 
> While this is true, I would expect that there are cases where the
> remoteproc has ops but no firmware.
> 

That is a scenario I did not envisioned, but I agree, the remote processor could
be fetching from a private ROM memory and still required handling from the
remoteproc core.

> How about splitting this decision already now; i.e. moving the if(!ops)
> to rproc_alloc_ops() and perhaps only allocate firmware if ops->load is
> specified?
> 

Or just add "if (ops->load)" before calling rproc_alloc_firmware()...  Otherwise
we need to change the calling order of rproc_alloc_firmware() and
rproc_alloc_ops() in order to make sure 'ops' is valid when calling the former.
Either way I'll add a comment with the rationale you have detailed above.


> Regards,
> Bjorn
> 
> > +	 */
> > +	if (!ops)
> > +		return 0;
> > +
> > +	ret = rproc_alloc_firmware(rproc, name, firmware);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return rproc_alloc_ops(rproc, ops);
> > +}
> > +
> >  /**
> >   * rproc_alloc() - allocate a remote processor handle
> >   * @dev: the underlying device
> > @@ -2105,7 +2129,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >  {
> >  	struct rproc *rproc;
> >  
> > -	if (!dev || !name || !ops)
> > +	if (!dev || !name)
> >  		return NULL;
> >  
> >  	rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
> > @@ -2128,10 +2152,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >  	if (!rproc->name)
> >  		goto put_device;
> >  
> > -	if (rproc_alloc_firmware(rproc, name, firmware))
> > -		goto put_device;
> > -
> > -	if (rproc_alloc_ops(rproc, ops))
> > +	if (rproc_alloc_internals(rproc, ops, name, firmware))
> >  		goto put_device;
> >  
> >  	/* Assign a unique device index and name */
> > -- 
> > 2.20.1
> > 
