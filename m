Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8ADC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4528A246A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojjKqoJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgBMPXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:23:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40878 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgBMPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so2463743plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mG5Pj3Ga2qn/6UPh/hiM2vYUP7QMzFr/lGer+oLepCc=;
        b=ojjKqoJqn3YNbRS9pIbai3sOzbP1aYkgdpr7OpIR1y2+KaxVGpme9iesoJCJU3SRhU
         HAfQ/pbQUu2k4NcORvH4RHD/TgpX9EwAE3ASjn75CwsQ6aifFHMjui0B/keNeiEfBYAm
         9VxkhZ441f/jNEys8dffVo1BnGSySP3/lfTo111fQACZ4xowTWKgUHPWcGpSloattgia
         zE46NmTrTYDxxlLpkEth0WCXUsAzom8BBeNY/XXQAwBpEzm6aNRbYbNJ8efaNmdblTej
         qEP6ATS99mxjh7IbNgoJcGNL4co6kAqB61eQiK4MdYk2h3VWemMGVBmIpbBfcQdfTTz9
         T1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mG5Pj3Ga2qn/6UPh/hiM2vYUP7QMzFr/lGer+oLepCc=;
        b=cYlR9xM3q2OqNtaJMKafQj745j/b/K+OijNwmsc8lJrJ3oAF/16EhD7MR4NJe7ciWp
         o34hpO1OOqKh+EpdRvh+6ZsnQpFLHpCL0jxGNcyDEKwTW+mB+8rPOeHoMctebV5iGnSM
         CcwUiXbFMGt/IJktvt/Uc0W5pAcJKLt6Qgufx3i51pT98zrRnXihF+hMKIQ4jcqRiFR6
         pOeWH53ntUwOVG6V5D9RF+9jpgBdMxpsnDJY7bFc3elkrnI1lW13v8hgcI/e+exjjQKN
         onAprVsLSSXscJZZ0DL1eQRoAOH9mwIYgxzHAn+CeNSwsDKSZpoaGXVFJLmABmT1hg/K
         /Kqw==
X-Gm-Message-State: APjAAAXH49vLhXM6Nt22sBbSIovjlpaHbkEJtHjFyXozDpyHyBwnQ+Ck
        SAPR/gRWqwCe0DVakZ7zQCZ7
X-Google-Smtp-Source: APXvYqyFO7tCYmZ8k+SqmOtcnU6W7tN/B4ksrngWczKUIT1JduB/3SDAP6TvrlAIs6RKKyY3gUuZ5Q==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr28645091plb.20.1581607380940;
        Thu, 13 Feb 2020 07:23:00 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id n2sm3561515pgn.71.2020.02.13.07.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 07:23:00 -0800 (PST)
Date:   Thu, 13 Feb 2020 20:52:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] bus: mhi: core: Add support for registering MHI
 controllers
Message-ID: <20200213152255.GC15010@mani>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-3-manivannan.sadhasivam@linaro.org>
 <20200206165606.GA3894455@kroah.com>
 <20200211191147.GB11908@Mani-XPS-13-9360>
 <20200211192236.GB1962867@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211192236.GB1962867@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Feb 11, 2020 at 11:22:36AM -0800, Greg KH wrote:
> On Wed, Feb 12, 2020 at 12:41:47AM +0530, Manivannan Sadhasivam wrote:
> > Hi Greg,
> > 
> > On Thu, Feb 06, 2020 at 05:56:06PM +0100, Greg KH wrote:
> > > On Fri, Jan 31, 2020 at 07:19:55PM +0530, Manivannan Sadhasivam wrote:
> > > > +static void mhi_release_device(struct device *dev)
> > > > +{
> > > > +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> > > > +
> > > > +	if (mhi_dev->ul_chan)
> > > > +		mhi_dev->ul_chan->mhi_dev = NULL;
> > > 
> > > That looks really odd.  Why didn't you just drop the reference you
> > > should have grabbed here for this pointer?  You did properly increment
> > > it when you saved it, right?  :)
> > > 
> > 
> > Well, there is no reference count (kref) exist for mhi_dev.
> 
> Then something is wrong with your model :(
> 
> You can't save pointers off to things without reference counting, that
> is going to cause you real problems.  See the coding style document for
> all the details.
> 
> > And we really needed to NULL the mhi_dev to avoid any dangling
> > reference to it.
> 
> Again, that's not how to do this correctly.
> 
> > The reason for not having kref is that, each mhi_dev will be used by
> > maximum of 2 channels only. So thought that refcounting is not needed.
> > Please correct me if I'm wrong.
> 
> Please read section 11 of Documentation/process/coding-style.rst
> 

I have fixed it and will send the next iteration soon.

Thanks,
Mani

> thanks,
> 
> greg k-h
