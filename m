Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EA0C07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B115921D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599761468;
	bh=c2tztsNpwyNu1D1MBTKVqE3luU/B7LUoBEm+xm+5A7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kjS+aInoZjiA7y5C2Ar+Ctw5NL8gY5518oIRUi/It8Ae1KL7+Uvm/Jo3EiBXxoJzH
	 QQCdeRXXf1QL7PN5dFYNLaVgpvX9gpSVwxUIAehh7y1gI+4Y8v0BsKJJGLRE8wibI1
	 c4iab+VVzUgnWxxba5pTr9DA8xYNLt/obQntwJ08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgIJSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgIJR7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:59:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0AE20BED;
        Thu, 10 Sep 2020 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599760755;
        bh=c2tztsNpwyNu1D1MBTKVqE3luU/B7LUoBEm+xm+5A7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2E2+d3GeM49R0VN2KDJsfGVusvUohciSPnXQmvjkUOoKiwaFB8uKEqtoGErfm+O9B
         tBeKn1rsXMX98zLwnXboGz9QXAMKfhuCRKONJIBRyHxoGpM1ZjggFrq0aht8xTr54w
         1nOpQiWLxk4ryGTluyrIM2Mhee4w1PgJ0RZb4igI=
Date:   Thu, 10 Sep 2020 19:59:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v2 0/3] Expose recovery/coredump configuration from sysfs
Message-ID: <20200910175923.GB3076593@kroah.com>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
 <20200901220542.GA121362@xps15>
 <20200903235944.GC3715@yoga>
 <20200904220213.GA404035@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904220213.GA404035@xps15>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:02:13PM -0600, Mathieu Poirier wrote:
> On Thu, Sep 03, 2020 at 06:59:44PM -0500, Bjorn Andersson wrote:
> > On Tue 01 Sep 17:05 CDT 2020, Mathieu Poirier wrote:
> > 
> > > Hi Rishabh,
> > > 
> > > On Thu, Aug 27, 2020 at 12:48:48PM -0700, Rishabh Bhatnagar wrote:
> > > > From Android R onwards Google has restricted access to debugfs in user
> > > > and user-debug builds. This restricts access to most of the features
> > > > exposed through debugfs. This patch series adds a configurable option
> > > > to move the recovery/coredump interfaces to sysfs. If the feature
> > > > flag is selected it would move these interfaces to sysfs and remove
> > > > the equivalent debugfs interface.
> > > 
> > > What I meant wast to move the coredump entry from debugfs to sysfs and from
> > > there make it available to user space using a kernel config.
> > 
> > Why would we not always make this available in sysfs?
> 
> At this time the options are in debugfs and vendors can decide to make that
> available on products if they want to.  The idea behind using a kernel
> configuration once moved to sysfs was to give the same kind of options.
> 
> > 
> > > But thinking further on this it may be better to simply provide an API
> > > to set the coredump mode from the platform driver, the same way
> > > rproc_coredump_set_elf_info() works.
> > 
> > Being able to invoke these from the platform drivers sounds like a new
> > feature. What would trigger the platform drivers to call this? Or are
> > you perhaps asking for the means of the drivers to be able to select the
> > default mode?
> 
> My ultimate goal is to avoid needlessly stuffing things in sysfs.  My hope in
> suggesting a new API was that platform drivers could recognise the kind of
> build/environment they operate in and setup the coredump mode accordingly.  That
> would have allowed us to leave debugfs options alone.
> 
> > 
> > Regarding the default mode, I think it would make sense to make the
> > default "disabled", because this is the most sensible configuration in a
> > "production" environment. And the sysfs means we have a convenient
> > mechanism to configure it, even on production environments.
> >
> 
> I am weary of changing something that hasn't been requested.  
>  
> > > That will prevent breaking a fair amount of user space code...
> > > 
> > 
> > We typically don't guarantee that the debugfs interfaces are stable and
> > if I understand the beginning of you reply you still want to move it
> > from debugfs to sysfs - which I presume would break such scripts in the
> > first place?
> 
> Correct - I am sure that moving coredump and recovery options to sysfs will
> break user space scripts.  Even if debugfs is not part of the ABI it would be
> nice to avoid disrupting people as much as possible.

Don't move the files, keep them in both places.  Lots of systems
restrict debugfs, so moving "stable" stuff like this into sysfs makes
sense.

thanks,

greg k-h
