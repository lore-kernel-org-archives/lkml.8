Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95415C54E49
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724192173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLu8LUoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgEHTJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgEHTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:09:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA67C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 12:09:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x2so1420967pfx.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZrRyPpzm1Wr0bdkc0wF86Fld8NZLrNeACvycZ1kw4os=;
        b=OLu8LUoFVM4oyCO5AtdtrepqMY8xQbLSJpJJcQlFFZNX9jHCjTCYsLjYxZcFFHRw1h
         jnxD+/nCldbnNrvNS2uXXQ9cf1cy/nnZzmPmiVZqBrW7i0WAqkI2OZsshLDogZMFwNZw
         QTkG7bLpXZVdUAg7aEXHdJRvhLTqkKcKg4GbCeXt9QP/uQbXNz8VWBWvJFOksrqfmg1U
         SisWOlad75CG2Vlm0b2CibuOOnvPDF23pQTQdJkCcI7nLBMu1/hXtYoPYkhkKkCZhLL2
         +3sn/BMyYSNDPBPu6y15ZJELAa5l5fFG0j48OtT/ZmvHXn5fo98ji78NTABy74yI3TPD
         ugcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZrRyPpzm1Wr0bdkc0wF86Fld8NZLrNeACvycZ1kw4os=;
        b=ekMskgvt7TIeBdEZKD4qsfzXrPHigffNDbVzA8AirJRpm431Z8ZLaTVxcCEzH4jWA0
         kEcFHWFdsI43yLazHijzJSEm+Sw03OMofBdb5GkwSnQ8jGf8FGopnF5bOPptum26Cdqt
         /fhpqBdTzz0aurMyGKXQkWgMFXzdNXuTOxhGooGJeko6uT8HM9tm1KSP/0ZOus6vd6co
         O9xgPRZDQit+TdNr57SG487XZ4kyiuOpj/ez0cN6SPgvRKksrLJfGZCMkfB6kDZIfxPt
         Ka7HCQxCuBfYJGd8cECwmGefxZuaHPWo+Do1JtKzgA/TbCZYXJ/a4yD7LJLqCuWrCj4S
         Avzw==
X-Gm-Message-State: AGi0PuZhA43yQ4dVmEl9gU4o6cs42Y75L0bLWXLdMP4fkfJhlokJdlYq
        z6rF7P8pbQK9WPWnlqW1AZQaxQ==
X-Google-Smtp-Source: APiQypK300/hKC35oHTBAMQmgp/mTdcuz3tlQk4JcQD3R2+iSFiayTznCchz0upseoQJpTyBhNQ2vQ==
X-Received: by 2002:a63:dd11:: with SMTP id t17mr2785704pgg.348.1588964954846;
        Fri, 08 May 2020 12:09:14 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h11sm2407257pfo.120.2020.05.08.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 12:09:13 -0700 (PDT)
Date:   Fri, 8 May 2020 13:09:11 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ohad@wizery.com, loic.pallardy@st.com, arnaud.pouliquen@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/14] remoteproc: Make core operations optional
Message-ID: <20200508190911.GA4526@xps15>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-2-mathieu.poirier@linaro.org>
 <20200505221608.GA2329931@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505221608.GA2329931@builder.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Tue, May 05, 2020 at 03:16:08PM -0700, Bjorn Andersson wrote:
> On Fri 24 Apr 13:01 PDT 2020, Mathieu Poirier wrote:
> 
> > When synchronizing with a remote processor, it is entirely possible that
> > the remoteproc core is not the life cycle manager.  In such a case core
> > operations don't exist and should not be called.
> > 
> 
> Why would the core call these functions if it knows the remote is in a
> state where it doesn't need these?

This is the reasoning that came out of a conversation Arnaud and I had.  We are
all on the same page.

> 
> Regards,
> Bjorn
> 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_internal.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index b389dc79da81..59fc871743c7 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -67,7 +67,7 @@ rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
> >  static inline
> >  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
> >  {
> > -	if (rproc->ops->sanity_check)
> > +	if (rproc->ops && rproc->ops->sanity_check)
> >  		return rproc->ops->sanity_check(rproc, fw);
> >  
> >  	return 0;
> > @@ -76,7 +76,7 @@ int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
> >  static inline
> >  u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
> >  {
> > -	if (rproc->ops->get_boot_addr)
> > +	if (rproc->ops && rproc->ops->get_boot_addr)
> >  		return rproc->ops->get_boot_addr(rproc, fw);
> >  
> >  	return 0;
> > @@ -85,7 +85,7 @@ u64 rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
> >  static inline
> >  int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
> >  {
> > -	if (rproc->ops->load)
> > +	if (rproc->ops && rproc->ops->load)
> >  		return rproc->ops->load(rproc, fw);
> >  
> >  	return -EINVAL;
> > @@ -93,7 +93,7 @@ int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
> >  
> >  static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> >  {
> > -	if (rproc->ops->parse_fw)
> > +	if (rproc->ops && rproc->ops->parse_fw)
> >  		return rproc->ops->parse_fw(rproc, fw);
> >  
> >  	return 0;
> > @@ -103,7 +103,7 @@ static inline
> >  int rproc_handle_rsc(struct rproc *rproc, u32 rsc_type, void *rsc, int offset,
> >  		     int avail)
> >  {
> > -	if (rproc->ops->handle_rsc)
> > +	if (rproc->ops && rproc->ops->handle_rsc)
> >  		return rproc->ops->handle_rsc(rproc, rsc_type, rsc, offset,
> >  					      avail);
> >  
> > @@ -114,7 +114,7 @@ static inline
> >  struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
> >  						   const struct firmware *fw)
> >  {
> > -	if (rproc->ops->find_loaded_rsc_table)
> > +	if (rproc->ops && rproc->ops->find_loaded_rsc_table)
> >  		return rproc->ops->find_loaded_rsc_table(rproc, fw);
> >  
> >  	return NULL;
> > -- 
> > 2.20.1
> > 
