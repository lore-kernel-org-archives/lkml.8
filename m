Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51167C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0DF2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x15EKl3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbgFWTie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbgFWTid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:38:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD94C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:38:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so1911667pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLUdK2O+Oo0igXjG1Jlq/+/VUzxX/d3DK9ShPndvY8g=;
        b=x15EKl3F5E8SKPmuVouUwJC4Riv2JoQmDBUPRWtKf8Jr0OI8g2BtI0CnP+ac30/DqZ
         kjZrwvi6LPTZZN4xd7/CyibC0GGEmUMKOBJr55vWJAmvJRgNRBK13e6fxsqWGhPkaqo+
         GxE0pI8rnfai2y18sx45ejhGEeIGJTng3MF0VIATw3F+CereOWE0BkdaiVQ6n+Ot2jpE
         ZvcvNe/J5XM/WZ/qD2+I6DNMf1/qkFw+z8hHzFAdDw07CqERzhsRRm3MSgP59y+L44Rw
         o06rVZ7/BvxjNnkBXkwNXiwtR+UsFSNDvvtkKcPrXt4veiJV+3PkFaSypFr3m7qOGzvi
         0t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLUdK2O+Oo0igXjG1Jlq/+/VUzxX/d3DK9ShPndvY8g=;
        b=NhhmpkdcQt+FUOtfM8TVdbEZA/0HIc+ZPuH3cuxSafHAbr3i9eKJ0nADdmQOqbZLEu
         lAEmbqap5jP3n7oD3iTpWEtosMt+NAij72bFZi6LcKkBhDu49E5ZOfFI4NtGtpwnbnEG
         AwqZv+5QloeeG2/7wt5GNXW38IV50uq5sbTwOedguZnzy5JMjavD/MhuinKsPnuV23gn
         uV8xH+Yq1MalXmES86ZkZXh2HozMVYVpa6OBna7ANqwkBgUJ85MLZJe3CIRK+jvSf0PS
         xQ1DKD9gWIY5LDH8DTgeMkdYMfE2u2cTZ+3zgWtQxCR1eZC3CKABUJqnlekeewP55B/D
         XIZQ==
X-Gm-Message-State: AOAM533zOg8EudwbbgfA3RUs6B3wQeqcq9Hth4HJnweTUcS0X19ktEdF
        HSrl4Md5mMPpzUEzV+c3VvBLUQ==
X-Google-Smtp-Source: ABdhPJwuj4j82sIFTCrbLbdcgs9pvm/7pHq7I60LicHHsHHDcyTcH4VpyR4UXwx5Lpk2bWYwjo6Hbg==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr24719824pln.153.1592941112375;
        Tue, 23 Jun 2020 12:38:32 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r77sm155749pfc.87.2020.06.23.12.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 12:38:31 -0700 (PDT)
Date:   Tue, 23 Jun 2020 13:38:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, s-anna@ti.com
Subject: Re: [PATCH v4 5/9] remoteproc: Introducing function rproc_validate()
Message-ID: <20200623193830.GB1908098@xps15>
References: <20200601175139.22097-1-mathieu.poirier@linaro.org>
 <20200601175139.22097-6-mathieu.poirier@linaro.org>
 <20200622072502.GG149351@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622072502.GG149351@builder.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:25:02AM -0700, Bjorn Andersson wrote:
> On Mon 01 Jun 10:51 PDT 2020, Mathieu Poirier wrote:
> 
> > Add a new function to assert the general health of the remote
> > processor before handing it to the remoteproc core.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 45 ++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index c70fa0372d07..0be8343dd851 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -2060,6 +2060,47 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
> >  #endif
> >  EXPORT_SYMBOL(rproc_get_by_phandle);
> >  
> > +static int rproc_validate(struct rproc *rproc)
> > +{
> > +	/*
> > +	 * When adding a remote processor, the state of the device
> > +	 * can be offline or detached, nothing else.
> > +	 */
> > +	if (rproc->state != RPROC_OFFLINE &&
> > +	    rproc->state != RPROC_DETACHED)
> > +		goto inval;
> 
> I would prefer that you just return -EINVAL; directly.
> 
> Overall I think this would be better represented as a switch on
> rproc->state though.
> 

Sure thing.

> 
> I think the logic is sound though.
> 
> Regards,
> Bjorn
> 
> > +
> > +	if (rproc->state == RPROC_OFFLINE) {
> > +		/*
> > +		 * An offline processor without a start()
> > +		 * function makes no sense.
> > +		 */
> > +		if (!rproc->ops->start)
> > +			goto inval;
> > +	}
> > +
> > +	if (rproc->state == RPROC_DETACHED) {
> > +		/*
> > +		 * A remote processor in a detached state without an
> > +		 * attach() function makes not sense.
> > +		 */
> > +		if (!rproc->ops->attach)
> > +			goto inval;
> > +		/*
> > +		 * When attaching to a remote processor the device memory
> > +		 * is already available and as such there is no need to have a
> > +		 * cached table.
> > +		 */
> > +		if (rproc->cached_table)
> > +			goto inval;
> > +	}
> > +
> > +	return 0;
> > +
> > +inval:
> > +	return -EINVAL;
> > +}
> > +
> >  /**
> >   * rproc_add() - register a remote processor
> >   * @rproc: the remote processor handle to register
> > @@ -2089,6 +2130,10 @@ int rproc_add(struct rproc *rproc)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	ret = rproc_validate(rproc);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	dev_info(dev, "%s is available\n", rproc->name);
> >  
> >  	/* create debugfs entries */
> > -- 
> > 2.20.1
> > 
