Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBEBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2302072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U09EBhDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392082AbgDNXRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392077AbgDNXQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:16:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CE5C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:16:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so668185pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fVpe83X72mXEcgVl/x0abZuBvG+NYvz1+3O7LHGqMys=;
        b=U09EBhDk0jVTSgHgT7E5Nqa5eqCQ/b+FRztd1fifz/V4J6V5vMuoALHYu5gqIBPb51
         5b5VEVUMtn0/snBbsAn3jvlphxK9w2DjxQWf7twaKlrtOjuW6hNDHde/y9XuqQ66rfFG
         G8x5+wPr238FUh50jWcOPWnlPNIU0ax6H3BSkJFoVlz1V1AOeDxmmel+u8e8vTRJ/2YS
         RX6E6q7yLuu8MwoM2QCAeDQ7EL6kYpkSL6YICKcQaOb+CJi4QduxA0dLRXrTepNsqKPQ
         Kvqf3LwPM5PvXA/WzdBaB033ViN4L39TIfTiBPmI7bSd0oE1dWIciJHnZ40Q4JJIi+lp
         5Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fVpe83X72mXEcgVl/x0abZuBvG+NYvz1+3O7LHGqMys=;
        b=lXu1NRk5Dd0RZt7sFcwpNJ4cY7VZgEDzhOVVdULdZa5jTcrCgP3K6aN9b/fHOrwLSb
         WvhZ9cZu3xBSNZyNyf8sKVMG6T/aeYCiecQ2o876fAGs2/nl7qlZhT8f10RNdeCZSxml
         CR9KcVrn5LR7aMz95w67z9q5vm0G9jhxTkmJgwB8EOAw/a2zgjrmCn2JBif+2/QikQxq
         yv5xihaIiuWLyyZMLmmjyNTCk4SLSpLis/o0AInz4hh7Ta1wHq2i8Xpk/QHm0rxJmaoy
         MLU8jEoCH5yhb0N0a+Xc830SnDzIZVNKxiE12KB+Xz7rdL3PwBcZ/Pxbtnm2lBKzj+4v
         CDHA==
X-Gm-Message-State: AGi0PubOU0ZntVxhI45GcViyZVU0dRPn8i3SUhS4B+TgyZIrq/rEKRz1
        VL4WHyKWUUyRWeb8uiSHwlbvow==
X-Google-Smtp-Source: APiQypIZqG4UPA4ogPQqh0O1FJv33YnNmBwtNFONQBkXMuSgXNHgL3qQ4xCtvY6sy7BW5urSgF/NUA==
X-Received: by 2002:a65:58c4:: with SMTP id e4mr13671577pgu.61.1586906164468;
        Tue, 14 Apr 2020 16:16:04 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u24sm8942736pgo.65.2020.04.14.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:16:03 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:16:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Alex Elder <elder@linaro.org>, ohad@wizery.com, s-anna@ti.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] remoteproc: Split firmware name allocation from
 rproc_alloc()
Message-ID: <20200414231601.GI892431@yoga>
References: <20200413193401.27234-1-mathieu.poirier@linaro.org>
 <20200413193401.27234-3-mathieu.poirier@linaro.org>
 <bd8cc8d5-94c1-5767-d089-535731fc1055@linaro.org>
 <20200414005506.GG20625@builder.lan>
 <20200414194441.GA25931@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414194441.GA25931@xps15>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14 Apr 12:44 PDT 2020, Mathieu Poirier wrote:

> Hey Bjorn,
> 
> On Mon, Apr 13, 2020 at 05:55:06PM -0700, Bjorn Andersson wrote:
> > On Mon 13 Apr 13:56 PDT 2020, Alex Elder wrote:
> > 
> > > On 4/13/20 2:33 PM, Mathieu Poirier wrote:
> > > > Make the firmware name allocation a function on its own in order to
> > > > introduce more flexibility to function rproc_alloc().
> > > > 
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > 
> > > I didn't look at the larger context (MCU series); I'm only looking
> > > at this (and the others in this series) in isolation.  I like
> > > that you're encapsulating this stuff into functions but doing so
> > > doesn't really add any flexibility.
> > > 
> > > Two small suggestions for you to consider but they're truly
> > > more about style so it's entirely up to you.  Outside of that
> > > this looks straightforward to me, and the result of the series
> > > is an improvement.
> > > 
> > > I'll let you comment on my suggestions before offering my
> > > "reviewed-by" indication.
> > > 
> > > 					-Alex
> > > 
> > > > ---
> > > >  drivers/remoteproc/remoteproc_core.c | 66 ++++++++++++++++------------
> > > >  1 file changed, 39 insertions(+), 27 deletions(-)
> > > > 
> > > > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > > > index 80056513ae71..4dee63f319ba 100644
> > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > @@ -1979,6 +1979,33 @@ static const struct device_type rproc_type = {
> > > >  	.release	= rproc_type_release,
> > > >  };
> > > >  
> > > > +static int rproc_alloc_firmware(struct rproc *rproc,
> > > > +				const char *name, const char *firmware)
> > > > +{
> > > > +	char *p, *template = "rproc-%s-fw";
> > > > +	int name_len;
> > > 
> > > Not a big deal (and maybe it's not consistent with other nearby
> > > style) but template and name_len could be defined inside the
> > > "if (!firmware)" block.
> > > 
> > 
> > I prefer variables declared in the beginning of the function, so I'm
> > happy with this.
> > 
> > > > +	if (!firmware) {
> > > > +		/*
> > > > +		 * If the caller didn't pass in a firmware name then
> > > > +		 * construct a default name.
> > > > +		 */
> > > > +		name_len = strlen(name) + strlen(template) - 2 + 1;
> > > > +		p = kmalloc(name_len, GFP_KERNEL);
> > > 
> > > 
> > > I don't know if it would be an improvement, but you could
> > > check for a null p value below for both cases.  I.e.:
> > > 
> > > 		if (p)
> > > 			snprintf(p, ...);
> > > 
> > 
> > Moving the common NULL check and return out seems nice, but given that
> > we then have to have this positive conditional I think the end result is
> > more complex.
> > 
> > That said, if we're not just doing a verbatim copy from rproc_alloc() I
> > think we should make this function:
> > 
> > 	if (!firmware)
> > 		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
> > 	else
> > 		p = kstrdup_const(firmware, GFP_KERNEL);
> 
> If you really want to use kstrdup_const() the return value has to be casted to a
> "char *".  Variable 'p' can't be declared const "char *" because rproc->firmware is not
> a "const".  Simply put somewhere the "const" will need to be dropped or casted out.
> 

The firmware parameter to rproc_alloc() is const char * and there's a
couple of places where a really const string is passed, so by using
kstrdup_const() we don't end up duplicating const data on the heap.

And afaict we can make both p and rproc->firmware const char * to allow
this, or am I missing something?

Regards,
Bjorn
