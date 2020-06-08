Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57085C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D602076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591618525;
	bh=xt2dfXDYvKQ+mK/taWv4/T9nWcs8mHsbCaH3tuw/rKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y0Xd9R4WL8J7vj1wTR0UjbcL6A++AMy3pFNn2eHssS6KRIFQ8G8hENWM46nKMewRS
	 lkEL5vIkLXIhsIgauLtlgagUpkE50mwNhMQcNjeu6+WR5/0OrvemXeHaE9V8WMjCY0
	 r6tqBhTIVKLjXRcTyZGeWWy+YfhA1KZDXXcJpcpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgFHMPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgFHMPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:15:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238B7206C3;
        Mon,  8 Jun 2020 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591618522;
        bh=xt2dfXDYvKQ+mK/taWv4/T9nWcs8mHsbCaH3tuw/rKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4/dAPrFBtt8TlGtfodkTeGQBFlrU4Gf9SF51xlpAwYPrfj9ZbmDbeHu1bP8KuHJP
         O0veAt7/Zab0n2v/lPigwOQ/07Kd+NaI1X6M+R7DgoUprXRYKqhMWu4bLXrfmgs0mt
         fNXXaDBLMdfvXYSBztqqKmPkCxjVvNiITLpF7+Mk=
Date:   Mon, 8 Jun 2020 14:15:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     matthias.bgg@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, gene.chen.richtek@gmail.com,
        lee.jones@linaro.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] drivers: base: Warn if driver name is not present
Message-ID: <20200608121519.GA306451@kroah.com>
References: <20200608095217.21162-1-matthias.bgg@kernel.org>
 <20200608105756.GB295073@kroah.com>
 <b8affc8c-3f38-3488-76dd-1b02fcdda329@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8affc8c-3f38-3488-76dd-1b02fcdda329@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 01:48:28PM +0200, Matthias Brugger wrote:
> 
> 
> On 08/06/2020 12:57, Greg KH wrote:
> > On Mon, Jun 08, 2020 at 11:52:16AM +0200, matthias.bgg@kernel.org wrote:
> >> From: Matthias Brugger <mbrugger@suse.com>
> >>
> >> If we pass a driver without a name, we end up in a NULL pointer
> >> derefernce.
> > 
> > That's a very good reason not to have a driver without a name :)
> > 
> > What in-kernel driver does this?
> > 
> >> Check for the name before trying to register the driver.
> >> As we don't have a driver name to point to in the error message, we dump
> >> the call stack to make it easier to detect the buggy driver.
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> ---
> >>  drivers/base/driver.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> >> index 57c68769e157..40fba959c140 100644
> >> --- a/drivers/base/driver.c
> >> +++ b/drivers/base/driver.c
> >> @@ -149,6 +149,12 @@ int driver_register(struct device_driver *drv)
> >>  	int ret;
> >>  	struct device_driver *other;
> >>  
> >> +	if (!drv->name) {
> >> +		pr_err("Driver has no name.\n");
> >> +		dump_stack();
> >> +		return -EINVAL;
> > 
> > Ick, no, an oops-traceback for doing something dumb like this should be
> > all that we need, right?
> > 
> > How "hardened" do we need to make internal apis anyway?  What's the odds
> > that if this does trigger, the driver author would even notice it?
> > 
> 
> We just had the case that a driver got accepted in a maintainer repository
> without a name. Which got later found by the kernel test robot.

That driver had obviously never actually been run before :(

> I agree with you that it probably doesn't make much sense to check for this kind
> of bugs, as it should be discoverable if you test your code, before you submit.
> 
> I propose to ignore this patch.

Thanks, now dropped!

greg k-h
