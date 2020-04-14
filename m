Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C6CC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651CF206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olJdbZJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505168AbgDNTpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505157AbgDNTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:44:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A258C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:44:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z9so5651052pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y8n+fCXbMWC1iI3wANy/sDKv9uXTY3yXiMXRA/S7MQo=;
        b=olJdbZJQB+gw4nBNzS0uf5tHqL6Rp1Vmc82avBY4KcDI+pB6WRolI9q33KwGrjkBhc
         d+4tXdgzDt3QLaFZEoYdncx8iH8pCiE8txFdp751P59XTi0j+2k8e5LDpCK0fTyCEjxK
         VVJnXXeeY2tHvYPdWeaiggBzIRv71hR4nYaqdGNi9vrmYBNZuTLY47Skgj0leooZLBli
         ZBUbmjvSMTg8UyGwY7iB/te7DsjdSv3gaHsoadexI7yXoAhhrf+QEZoBAhMqAswUWurZ
         08wavDsYCdHA6/MwRmPwjEHx15x2earJUCIhCWQVh9G5U+effwNtOjRJqoM1mCRrMD1s
         HXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y8n+fCXbMWC1iI3wANy/sDKv9uXTY3yXiMXRA/S7MQo=;
        b=hi7tseVj1SwsPb4o1GDGs4JTdEt/COjrMKWDwSh+MvprKxZc7kt0Ib86BsD5mrPgKf
         J5gNLzPDjQd0wGRxEv/9duiQ0Pdf6y16bUz+cIWNbT6Q0ODmwh04Y2r2k7qtdhCeKWoO
         pJ7vJgRf/Ew+Vb5GfsigFrlkqyitUD0XvCoOX8tJZPTNHSObouZKb3JBgqcOnnTORphU
         saGhJMGCJveVQmbbWQs1bWMnKbqAbCElkUdgdsk6OAU7nEw8TcYT14/PehG7c1OT8CTP
         MNVeSnER8BCtR1ITatYRAlibjJQx9GdP3DKqhKmg9mSTpXdizP5Y+HgpzC2pgZPaCnWC
         /kpw==
X-Gm-Message-State: AGi0Publx6sLTMKhkxXux/tiONM7TaA+iOihZP6Z05C65M0jfwixNHvb
        LGyXlFNa15LKb3Px6l13/hfyqA==
X-Google-Smtp-Source: APiQypKwVO3YYKnkeKBmDcieDhffhfreynXiumXxdiwadgN/nIlVyTtU0cUoHi5CZGca7Q5NeKJ0hA==
X-Received: by 2002:a17:902:7897:: with SMTP id q23mr1482603pll.312.1586893483817;
        Tue, 14 Apr 2020 12:44:43 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 198sm12041371pfa.87.2020.04.14.12.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:44:43 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:44:41 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Alex Elder <elder@linaro.org>, ohad@wizery.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] remoteproc: Split firmware name allocation from
 rproc_alloc()
Message-ID: <20200414194441.GA25931@xps15>
References: <20200413193401.27234-1-mathieu.poirier@linaro.org>
 <20200413193401.27234-3-mathieu.poirier@linaro.org>
 <bd8cc8d5-94c1-5767-d089-535731fc1055@linaro.org>
 <20200414005506.GG20625@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414005506.GG20625@builder.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn,

On Mon, Apr 13, 2020 at 05:55:06PM -0700, Bjorn Andersson wrote:
> On Mon 13 Apr 13:56 PDT 2020, Alex Elder wrote:
> 
> > On 4/13/20 2:33 PM, Mathieu Poirier wrote:
> > > Make the firmware name allocation a function on its own in order to
> > > introduce more flexibility to function rproc_alloc().
> > > 
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > I didn't look at the larger context (MCU series); I'm only looking
> > at this (and the others in this series) in isolation.  I like
> > that you're encapsulating this stuff into functions but doing so
> > doesn't really add any flexibility.
> > 
> > Two small suggestions for you to consider but they're truly
> > more about style so it's entirely up to you.  Outside of that
> > this looks straightforward to me, and the result of the series
> > is an improvement.
> > 
> > I'll let you comment on my suggestions before offering my
> > "reviewed-by" indication.
> > 
> > 					-Alex
> > 
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++------------
> > >  1 file changed, 39 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > index 80056513ae71..4dee63f319ba 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -1979,6 +1979,33 @@ static const struct device_type rproc_type = {
> > >  	.release	= rproc_type_release,
> > >  };
> > >  
> > > +static int rproc_alloc_firmware(struct rproc *rproc,
> > > +				const char *name, const char *firmware)
> > > +{
> > > +	char *p, *template = "rproc-%s-fw";
> > > +	int name_len;
> > 
> > Not a big deal (and maybe it's not consistent with other nearby
> > style) but template and name_len could be defined inside the
> > "if (!firmware)" block.
> > 
> 
> I prefer variables declared in the beginning of the function, so I'm
> happy with this.
> 
> > > +	if (!firmware) {
> > > +		/*
> > > +		 * If the caller didn't pass in a firmware name then
> > > +		 * construct a default name.
> > > +		 */
> > > +		name_len = strlen(name) + strlen(template) - 2 + 1;
> > > +		p = kmalloc(name_len, GFP_KERNEL);
> > 
> > 
> > I don't know if it would be an improvement, but you could
> > check for a null p value below for both cases.  I.e.:
> > 
> > 		if (p)
> > 			snprintf(p, ...);
> > 
> 
> Moving the common NULL check and return out seems nice, but given that
> we then have to have this positive conditional I think the end result is
> more complex.
> 
> That said, if we're not just doing a verbatim copy from rproc_alloc() I
> think we should make this function:
> 
> 	if (!firmware)
> 		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
> 	else
> 		p = kstrdup_const(firmware, GFP_KERNEL);

If you really want to use kstrdup_const() the return value has to be casted to a
"char *".  Variable 'p' can't be declared const "char *" because rproc->firmware is not
a "const".  Simply put somewhere the "const" will need to be dropped or casted out.

Mathieu

> 
> 	rproc->firmware = p;
> 
> 	return p ? 0 : -ENOMEM;
> 
> Regards,
> Bjorn
> 
> > (more below)
> > 
> > > +		if (!p)
> > > +			return -ENOMEM;
> > > +		snprintf(p, name_len, template, name);
> > > +	} else {
> > > +		p = kstrdup(firmware, GFP_KERNEL);
> > > +		if (!p)
> > > +			return -ENOMEM;
> > > +	}
> > > +
> > 
> > 	if (!p)
> > 		return -ENOMEM;
> > 	
> > > +	rproc->firmware = p;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  /**
> > >   * rproc_alloc() - allocate a remote processor handle
> > >   * @dev: the underlying device
> > > @@ -2007,42 +2034,21 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> > >  			  const char *firmware, int len)
> > >  {
> > >  	struct rproc *rproc;
> > > -	char *p, *template = "rproc-%s-fw";
> > > -	int name_len;
> > >  
> > >  	if (!dev || !name || !ops)
> > >  		return NULL;
> > >  
> > > -	if (!firmware) {
> > > -		/*
> > > -		 * If the caller didn't pass in a firmware name then
> > > -		 * construct a default name.
> > > -		 */
> > > -		name_len = strlen(name) + strlen(template) - 2 + 1;
> > > -		p = kmalloc(name_len, GFP_KERNEL);
> > > -		if (!p)
> > > -			return NULL;
> > > -		snprintf(p, name_len, template, name);
> > > -	} else {
> > > -		p = kstrdup(firmware, GFP_KERNEL);
> > > -		if (!p)
> > > -			return NULL;
> > > -	}
> > > -
> > >  	rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
> > > -	if (!rproc) {
> > > -		kfree(p);
> > > +	if (!rproc)
> > >  		return NULL;
> > > -	}
> > > +
> > > +	if (rproc_alloc_firmware(rproc, name, firmware))
> > > +		goto free_rproc;
> > >  
> > >  	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> > > -	if (!rproc->ops) {
> > > -		kfree(p);
> > > -		kfree(rproc);
> > > -		return NULL;
> > > -	}
> > > +	if (!rproc->ops)
> > > +		goto free_firmware;
> > >  
> > > -	rproc->firmware = p;
> > >  	rproc->name = name;
> > >  	rproc->priv = &rproc[1];
> > >  	rproc->auto_boot = true;
> > > @@ -2091,6 +2097,12 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> > >  	rproc->state = RPROC_OFFLINE;
> > >  
> > >  	return rproc;
> > > +
> > > +free_firmware:
> > > +	kfree(rproc->firmware);
> > > +free_rproc:
> > > +	kfree(rproc);
> > > +	return NULL;
> > >  }
> > >  EXPORT_SYMBOL(rproc_alloc);
> > >  
> > > 
> > 
