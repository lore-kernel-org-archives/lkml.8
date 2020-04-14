Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB94C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119E42075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 00:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vxw15Ml3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390671AbgDNAyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390662AbgDNAyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 20:54:53 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE17C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 17:54:53 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t11so3306439pgg.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 17:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8NSR3d9X4rRyGO0LrVyOkKAqA+19b8b7FLQelt1aJ7k=;
        b=Vxw15Ml3H2fFG3deBOcL46hkDLLvhbsQQPLTfESiNdR4yYhX5GFZefHuFSpUFJQXxP
         BaXE5s2EjRgKyv4RDU8pGgvcAMAnmWBeOK+H4wtnVZbEeTs2pvENv0oszGbsk8dTwvfd
         VYPfHLjjW/eX+y8gR7zTO/opHEpqmnFCUSQGyPBtiEQbunOiSTLDBt12FIUOjMwxx+WS
         oJPTRhxZO+BSl6sOdDdZ+M+4tiGhK8rGUwUGhD8U3ZN5iBMBdgCyN5rVJw7Iq0sGRFmm
         3m8YtPcxSrvEYKHmYge98/OmIUHbTQi8orXhrRyarMAZEg6KKYAa6vculuSHxjqeyMuL
         wmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8NSR3d9X4rRyGO0LrVyOkKAqA+19b8b7FLQelt1aJ7k=;
        b=gNkH1G+g+Bdqt8VIhNp2gJMtvJ57MFdafSH4F7Pvafq219Jj+THoz62Kc7xZehm53o
         p4P1fHgnaz7mE3EQQU1nsI+1/qJd1PI5vAN3drYJlkXi3FuTRW5Ef1BehsP7gGfzEuSd
         eLdGefO1CP11/TGH4zVPZYQ9fASq9Oi3SGavqMsvTzt824t8J1gTjxBP4TVTLI2KCuOG
         svfNzmmuwMP3Ni+dRsl3D02QF2AFdYZb9GzCH4edoFbwaIqJUEagPTZXXROpkk74gjFT
         TL4xCPBXZ11DSMKzI5j1Zq25sAQYVleXB4NPFPEVn54R3VGtfdJlbPew5ulfeR7keIWW
         +j9A==
X-Gm-Message-State: AGi0PuY1VeEFbNB9iJc3epL9gpJhXchZl7kf+o3jNPeoutBq9S4DaSb2
        pqXefaoREHlxxAhhbpbTvVwJfw==
X-Google-Smtp-Source: APiQypKhIa0nf7HpIrSVf79vJpY5Jcfz9pzzaxdfxLA/3kzdYXAX++X4s6nSdJ5GCeOpC+obUnScWg==
X-Received: by 2002:a65:4107:: with SMTP id w7mr18587933pgp.438.1586825692675;
        Mon, 13 Apr 2020 17:54:52 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k24sm9522657pfk.164.2020.04.13.17.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 17:54:51 -0700 (PDT)
Date:   Mon, 13 Apr 2020 17:55:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>, ohad@wizery.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] remoteproc: Split firmware name allocation from
 rproc_alloc()
Message-ID: <20200414005506.GG20625@builder.lan>
References: <20200413193401.27234-1-mathieu.poirier@linaro.org>
 <20200413193401.27234-3-mathieu.poirier@linaro.org>
 <bd8cc8d5-94c1-5767-d089-535731fc1055@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd8cc8d5-94c1-5767-d089-535731fc1055@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13 Apr 13:56 PDT 2020, Alex Elder wrote:

> On 4/13/20 2:33 PM, Mathieu Poirier wrote:
> > Make the firmware name allocation a function on its own in order to
> > introduce more flexibility to function rproc_alloc().
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> I didn't look at the larger context (MCU series); I'm only looking
> at this (and the others in this series) in isolation.  I like
> that you're encapsulating this stuff into functions but doing so
> doesn't really add any flexibility.
> 
> Two small suggestions for you to consider but they're truly
> more about style so it's entirely up to you.  Outside of that
> this looks straightforward to me, and the result of the series
> is an improvement.
> 
> I'll let you comment on my suggestions before offering my
> "reviewed-by" indication.
> 
> 					-Alex
> 
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++------------
> >  1 file changed, 39 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 80056513ae71..4dee63f319ba 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1979,6 +1979,33 @@ static const struct device_type rproc_type = {
> >  	.release	= rproc_type_release,
> >  };
> >  
> > +static int rproc_alloc_firmware(struct rproc *rproc,
> > +				const char *name, const char *firmware)
> > +{
> > +	char *p, *template = "rproc-%s-fw";
> > +	int name_len;
> 
> Not a big deal (and maybe it's not consistent with other nearby
> style) but template and name_len could be defined inside the
> "if (!firmware)" block.
> 

I prefer variables declared in the beginning of the function, so I'm
happy with this.

> > +	if (!firmware) {
> > +		/*
> > +		 * If the caller didn't pass in a firmware name then
> > +		 * construct a default name.
> > +		 */
> > +		name_len = strlen(name) + strlen(template) - 2 + 1;
> > +		p = kmalloc(name_len, GFP_KERNEL);
> 
> 
> I don't know if it would be an improvement, but you could
> check for a null p value below for both cases.  I.e.:
> 
> 		if (p)
> 			snprintf(p, ...);
> 

Moving the common NULL check and return out seems nice, but given that
we then have to have this positive conditional I think the end result is
more complex.

That said, if we're not just doing a verbatim copy from rproc_alloc() I
think we should make this function:

	if (!firmware)
		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
	else
		p = kstrdup_const(firmware, GFP_KERNEL);

	rproc->firmware = p;

	return p ? 0 : -ENOMEM;

Regards,
Bjorn

> (more below)
> 
> > +		if (!p)
> > +			return -ENOMEM;
> > +		snprintf(p, name_len, template, name);
> > +	} else {
> > +		p = kstrdup(firmware, GFP_KERNEL);
> > +		if (!p)
> > +			return -ENOMEM;
> > +	}
> > +
> 
> 	if (!p)
> 		return -ENOMEM;
> 	
> > +	rproc->firmware = p;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * rproc_alloc() - allocate a remote processor handle
> >   * @dev: the underlying device
> > @@ -2007,42 +2034,21 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >  			  const char *firmware, int len)
> >  {
> >  	struct rproc *rproc;
> > -	char *p, *template = "rproc-%s-fw";
> > -	int name_len;
> >  
> >  	if (!dev || !name || !ops)
> >  		return NULL;
> >  
> > -	if (!firmware) {
> > -		/*
> > -		 * If the caller didn't pass in a firmware name then
> > -		 * construct a default name.
> > -		 */
> > -		name_len = strlen(name) + strlen(template) - 2 + 1;
> > -		p = kmalloc(name_len, GFP_KERNEL);
> > -		if (!p)
> > -			return NULL;
> > -		snprintf(p, name_len, template, name);
> > -	} else {
> > -		p = kstrdup(firmware, GFP_KERNEL);
> > -		if (!p)
> > -			return NULL;
> > -	}
> > -
> >  	rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
> > -	if (!rproc) {
> > -		kfree(p);
> > +	if (!rproc)
> >  		return NULL;
> > -	}
> > +
> > +	if (rproc_alloc_firmware(rproc, name, firmware))
> > +		goto free_rproc;
> >  
> >  	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> > -	if (!rproc->ops) {
> > -		kfree(p);
> > -		kfree(rproc);
> > -		return NULL;
> > -	}
> > +	if (!rproc->ops)
> > +		goto free_firmware;
> >  
> > -	rproc->firmware = p;
> >  	rproc->name = name;
> >  	rproc->priv = &rproc[1];
> >  	rproc->auto_boot = true;
> > @@ -2091,6 +2097,12 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >  	rproc->state = RPROC_OFFLINE;
> >  
> >  	return rproc;
> > +
> > +free_firmware:
> > +	kfree(rproc->firmware);
> > +free_rproc:
> > +	kfree(rproc);
> > +	return NULL;
> >  }
> >  EXPORT_SYMBOL(rproc_alloc);
> >  
> > 
> 
