Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EA1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8962070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dgQcgB/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgETP4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgETP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:56:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA5DC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:56:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z72so3447197wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3DUjkUudWUma8eVVc+3k66CY1qVHbplZFH3HiAs22PM=;
        b=dgQcgB/jsiNL+KTJ/ognXuY5PS6xaSXJ6xPP9stTlAR++RzPLcjVHzhAVN/2ltCUzD
         t4b7oqaM9641nFZxnSRPCkivd2m1eMcd5ncdX+bGVQJ/OLNxTLByGFk/Vxap6V0N1j+e
         u7xSS4UAzqpY2FZPT5Yt4V+dT5DJGYxINnhA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3DUjkUudWUma8eVVc+3k66CY1qVHbplZFH3HiAs22PM=;
        b=E0GntelzIYPwkVolfzNueBw+5gzlA9eq+WF3haJmmXdGsZwxqm4YCO1y1/YwpVTN+X
         onuv4Y5hQavRNT1Tb6GyCKQyL8LYIikuF78DtEtAyj0pL+guAhWn/pnbJJYFqbKKaXpJ
         /Rau1UXaXUbDDix52o7BMP9VAj4aUsHe+hQFuOjwAHkyqYhW6bOkcknc/vm+QlNDSaaW
         C8a5CJ+hxeWIYAhsgM8YgSZ56EvDUlzMJMuZb898C+HjrRRqzecDjk43NAQ+Sh2jqveI
         cu30q9/WRvYX4LAGYhKza1YOEtUYQl2ft1Faq+VkSjTslr2BrGlgn5W+Ank50Iv+WfuN
         z8FQ==
X-Gm-Message-State: AOAM53221jVTEmRXoCm3cRIqe4EGfsbN1d/4SzslZIbAWBE2vPN/z5lB
        vqXX1ioGFTQwqZADS95XX4xscQ==
X-Google-Smtp-Source: ABdhPJwlB3wdEB+iw8FeHqykqYSYcAPQ7TELIxhBm9FKron7pIEHkpVCJsFtj1zdPaHRLKc5n9zc2w==
X-Received: by 2002:a05:600c:2c07:: with SMTP id q7mr5007786wmg.131.1589990193205;
        Wed, 20 May 2020 08:56:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k13sm3323046wmj.40.2020.05.20.08.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:56:32 -0700 (PDT)
Date:   Wed, 20 May 2020 17:56:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Olof Johansson <olof.johansson@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wufan@codeaurora.org, pratanan@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/8] Qualcomm Cloud AI 100 driver
Message-ID: <20200520155630.GA206103@phenom.ffwll.local>
Mail-Followup-To: Jeffrey Hugo <jhugo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Olof Johansson <olof.johansson@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Dave Airlie <airlied@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, wufan@codeaurora.org,
        pratanan@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAKMK7uG-oP-tcOcNz-ZzTmGondEo-17BCN1kpFBPwb7F8QcM5w@mail.gmail.com>
 <20200520051536.GA2141566@kroah.com>
 <CAKMK7uEbwTK68sxhf452fPHzAreQqRbRc7=RLGX-9SesXnJnLQ@mail.gmail.com>
 <5701b299-7800-1584-4b3a-6147e7ad3fca@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5701b299-7800-1584-4b3a-6147e7ad3fca@codeaurora.org>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:48:13AM -0600, Jeffrey Hugo wrote:
> On 5/20/2020 2:34 AM, Daniel Vetter wrote:
> > On Wed, May 20, 2020 at 7:15 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > On Tue, May 19, 2020 at 10:41:15PM +0200, Daniel Vetter wrote:
> > > > On Tue, May 19, 2020 at 07:41:20PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Tue, May 19, 2020 at 08:57:38AM -0600, Jeffrey Hugo wrote:
> > > > > > On 5/18/2020 11:08 PM, Dave Airlie wrote:
> > > > > > > On Fri, 15 May 2020 at 00:12, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> > > > > > > > 
> > > > > > > > Introduction:
> > > > > > > > Qualcomm Cloud AI 100 is a PCIe adapter card which contains a dedicated
> > > > > > > > SoC ASIC for the purpose of efficently running Deep Learning inference
> > > > > > > > workloads in a data center environment.
> > > > > > > > 
> > > > > > > > The offical press release can be found at -
> > > > > > > > https://www.qualcomm.com/news/releases/2019/04/09/qualcomm-brings-power-efficient-artificial-intelligence-inference
> > > > > > > > 
> > > > > > > > The offical product website is -
> > > > > > > > https://www.qualcomm.com/products/datacenter-artificial-intelligence
> > > > > > > > 
> > > > > > > > At the time of the offical press release, numerious technology news sites
> > > > > > > > also covered the product.  Doing a search of your favorite site is likely
> > > > > > > > to find their coverage of it.
> > > > > > > > 
> > > > > > > > It is our goal to have the kernel driver for the product fully upstream.
> > > > > > > > The purpose of this RFC is to start that process.  We are still doing
> > > > > > > > development (see below), and thus not quite looking to gain acceptance quite
> > > > > > > > yet, but now that we have a working driver we beleive we are at the stage
> > > > > > > > where meaningful conversation with the community can occur.
> > > > > > > 
> > > > > > > 
> > > > > > > Hi Jeffery,
> > > > > > > 
> > > > > > > Just wondering what the userspace/testing plans for this driver.
> > > > > > > 
> > > > > > > This introduces a new user facing API for a device without pointers to
> > > > > > > users or tests for that API.
> > > > > > 
> > > > > > We have daily internal testing, although I don't expect you to take my word
> > > > > > for that.
> > > > > > 
> > > > > > I would like to get one of these devices into the hands of Linaro, so that
> > > > > > it can be put into KernelCI.  Similar to other Qualcomm products. I'm trying
> > > > > > to convince the powers that be to make this happen.
> > > > > > 
> > > > > > Regarding what the community could do on its own, everything but the Linux
> > > > > > driver is considered proprietary - that includes the on device firmware and
> > > > > > the entire userspace stack.  This is a decision above my pay grade.
> > > > > 
> > > > > Ok, that's a decision you are going to have to push upward on, as we
> > > > > really can't take this without a working, open, userspace.
> > > > 
> > > > Uh wut.
> > > > 
> > > > So the merge criteria for drivers/accel (atm still drivers/misc but I
> > > > thought that was interim until more drivers showed up) isn't actually
> > > > "totally-not-a-gpu accel driver without open source userspace".
> > > > 
> > > > Instead it's "totally-not-a-gpu accel driver without open source
> > > > userspace" _and_ you have to be best buddies with Greg. Or at least
> > > > not be on the naughty company list. Since for habanalabs all you
> > > > wanted is a few test cases to exercise the ioctls. Not the entire
> > > > userspace.
> > > 
> > > Also, to be fair, I have changed my mind after seeing the mess of
> > > complexity that these "ioctls for everyone!" type of pass-through
> > > these kinds of drivers are creating.  You were right, we need open
> > > userspace code in order to be able to properly evaluate and figure out
> > > what they are doing is right or not and be able to maintain things over
> > > time correctly.
> > > 
> > > So I was wrong, and you were right, my apologies for my previous
> > > stubbornness.
> > 
> > Awesome and don't worry, I'm pretty sure we've all been stubborn
> > occasionally :-)
> > 
> >  From a drivers/gpu pov I think still not quite there since we also
> > want to see the compiler for these programmable accelerator thingies.
> > But just having a fairly good consensus that "userspace library with
> > all the runtime stuff excluding compiler must be open" is a huge step
> > forward. Next step may be that we (kernel overall, drivers/gpu will
> > still ask for the full thing) have ISA docs for these programmable
> > things, so that we can also evaluate that aspect and gauge how many
> > security issues there might be. Plus have a fighting chance to fix up
> > the security leaks when (post smeltdown I don't really want to
> > consider this an if) someone finds a hole in the hw security wall. At
> > least in drivers/gpu we historically have a ton of drivers with
> > command checkers to validate what userspace wants to run on the
> > accelerator thingie. Both in cases where the hw was accidentally too
> > strict, and not strict enough.
> 
> I think this provides a pretty clear guidance on what you/the community are
> looking for, both now and possibly in the future.
> 
> Thank you.
> 
> From my perspective, it would be really nice if there was something like
> Mesa that was a/the standard for these sorts of accelerators.  Its somewhat
> the wild west, and we've struggled with it.

Yeah there's currently 0 standard api for ML accelerators that aren't
gpus. So not only don't we have mesa, we don't even have an api.

I do personally think that for anything that's somewhat programmable and
not just fixed-function matrix multiply accelerator for neural networks, a
slimmed down mesa vk or compute driver might be the most reasonable
starting point for an open source ecosystem for these things. Still a ton
of work, and if you're unlucky you might have bet on the wrong standard to
adapt for ML needs, atm no one can predict whether it's going to be vk, or
opencl or maybe something else entirely that will serve as the low-level
driver fabric underneath stuff like tenserflow and other ML libraries.

> I don't work on the compiler end of things, but based on what I've seen in
> my project, I think the vendors are going to be highly resistant to opening
> that up.  There is more than just the raw instruction set that goes on in
> the device, and its viewed as "secret sauce" even though I agree with your
> previous statements on that viewpoint.

Well it's the same with gpus. Sometimes you can get companies to open up
their runtimes. Almost never their compiler. A big problem seems to be
licensing troubles that prevent them from opening up the compiler - it's
often much cheaper and easier to just write a new open compiler than
trying to get the legal review for the existing one done. I don't think
there's a single case where a company succeeded in opening a gpu/accel
compiler that didn't start out with at least open source as an eventual
goal.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
