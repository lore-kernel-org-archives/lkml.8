Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F576C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7247C206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlpBrxf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDTFQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgDTFQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:16:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CE3C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:16:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o15so3928191pgi.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AJCXY9N/izbz1GpMZ9BIBOPXdMTUjKbB5QCZIkMawR0=;
        b=WlpBrxf6Q6+UQa+nWUXh7v/c7EvpDM1QXLugT7PBHl4ohoXSJvwteyoAvIf24aj/5P
         cSHcrpzoKjnEvoFMt5eBLGjwoVG5bh9DkHg97L9g84/HItucU4P0+dIXGbK2ExTLEXyt
         6OXcAIlkVLPKIotTttRO1twIsFFFeDniNxerHcBYr9zP7USN0N2LcsMtPYseH6H4T3sS
         Vt0vxisUBlJLYxc6hhVf6W7lkc7YY4sfktE1B0pJqe/RBTe5qMzlGcNHO8ZXOjWi5r2/
         tNuq9N7dbLf3Vj/Otq//kBQtfruE3y9oqQNBE8j5VU9AcnKGlgVhbQjyO4LNrahmZ7up
         M2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AJCXY9N/izbz1GpMZ9BIBOPXdMTUjKbB5QCZIkMawR0=;
        b=q2qmTKnkuqTOeP3g+7KXPtQ/wIwI4tKxDNEtNMf/vfPu4HGZg+qv9O1uViQuy0DGtH
         Yul0QKH6EOsFzeqrnQ7qcyvMAE4r2H/Cf8ASvPiBeqDAi3/O2az2BRDWw29BJLfzQudY
         q9zJZLanTgBkTSNYysgDQyX6bKXARRaecZgqjVJMDWE/EVcyg5hiboqjR6XplCFgdoqV
         Yct+2Lxlqy5+/0qfgnK70xaqE2AQv2Ylhlbqz/nHVMrBrsJLidME47VTxkikDIWw25pc
         2SLQTHMePEogEDj7o+KHUeYtf6cccuPTAMntm+FKbx9BYpNzkbSOi5AIhLgCY7JdGMG3
         m57w==
X-Gm-Message-State: AGi0PubugclCRUNFIant/wnFz49ROa5YbSWtPpspxch/Kxfkt4neWvHy
        o6ZOrYuFBTCkhibC+3XWyfgEBmUrlT8=
X-Google-Smtp-Source: APiQypJ9Kw0k4hwPdm/c+M80nAY2on5zgW6KIBIQc+6/mRw2Jl4tfvE9w6Mr93cnsAHPENmr3AITOg==
X-Received: by 2002:aa7:9251:: with SMTP id 17mr11236988pfp.315.1587359818287;
        Sun, 19 Apr 2020 22:16:58 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a7sm11848075pfg.157.2020.04.19.22.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 22:16:57 -0700 (PDT)
Date:   Sun, 19 Apr 2020 22:17:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>, ohad@wizery.com,
        s-anna@ti.com, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] remoteproc: Restructure firmware name allocation
Message-ID: <20200420051720.GE1516868@builder.lan>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-6-mathieu.poirier@linaro.org>
 <9a4b6342-750e-284a-2343-8151b478589b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4b6342-750e-284a-2343-8151b478589b@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15 Apr 14:23 PDT 2020, Alex Elder wrote:

> On 4/15/20 3:48 PM, Mathieu Poirier wrote:
> > Improve the readability of function rproc_alloc_firmware() by using
> > a non-negated condition.
> > 
> > Suggested-by: Alex Elder <elder@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> If it were me, I'd move the comment above the if statement and
> perhaps reword it a little bit to describe what's happening.
> But no matter, this looks good.
> 

This would also avoid the fact that we have a multiline block without
braces (which isn't needed, but looks odd to me). So that sounds like a
good idea.

Regards,
Bjorn

> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index ebaff496ef81..0bfa6998705d 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1984,14 +1984,14 @@ static int rproc_alloc_firmware(struct rproc *rproc,
> >  {
> >  	const char *p;
> >  
> > -	if (!firmware)
> > +	if (firmware)
> > +		p = kstrdup_const(firmware, GFP_KERNEL);
> > +	else
> >  		/*
> >  		 * If the caller didn't pass in a firmware name then
> >  		 * construct a default name.
> >  		 */
> >  		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
> > -	else
> > -		p = kstrdup_const(firmware, GFP_KERNEL);
> >  
> >  	if (!p)
> >  		return -ENOMEM;
> > 
> 
