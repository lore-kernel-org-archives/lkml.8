Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE29C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551462468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582806849;
	bh=ZSvdgyyAZrTI4ZZgTa8cz5o9//42i2OuAT24QC89tfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gKWPFoyvsXhdf2yMzYKWNCZuA35s1AX5FR0Ua1ZE4vvcq8F5SqWScik20cu6P1/JC
	 aayARs/PIlZeXRMvU4jyx53lS12vEAKCUFIrtAYpHkpyc+MoFCg0BRgyJIMuvodcNu
	 b64UHKNtUw/OecFwBUReAxzEOToh1fn3R6TuxfqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgB0MeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbgB0MeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:34:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963092468E;
        Thu, 27 Feb 2020 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582806847;
        bh=ZSvdgyyAZrTI4ZZgTa8cz5o9//42i2OuAT24QC89tfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sM4MR5or/iXdoFVY6P4lmM/QpukHyP262a8O90zsYSk55A2+QD2DPcraudRPA9NN+
         q8KsZl14+IdQThlu64zHCTHMKok4w7OA91HuP187j04ChdB09ogg0r9oVYdgB+OAOT
         nVKsLNfD9zp8NP1+xix8fqOrgaNvTyMBKEZR2cns=
Date:   Thu, 27 Feb 2020 13:34:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/21] drm: convert the drm_driver.debugfs_init() hook to
 return void.
Message-ID: <20200227123404.GA962932@kroah.com>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
 <20200227120232.19413-3-wambui.karugax@gmail.com>
 <20200227122313.GB896418@kroah.com>
 <alpine.LNX.2.21.99999.375.2002271528310.19554@wambui>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.99999.375.2002271528310.19554@wambui>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:29:46PM +0300, Wambui Karuga wrote:
> 
> 
> On Thu, 27 Feb 2020, Greg KH wrote:
> 
> > On Thu, Feb 27, 2020 at 03:02:13PM +0300, Wambui Karuga wrote:
> > > As a result of commit 987d65d01356 (drm: debugfs: make
> > > drm_debugfs_create_files() never fail) and changes to various debugfs
> > > functions in drm/core and across various drivers, there is no need for
> > > the drm_driver.debugfs_init() hook to have a return value. Therefore,
> > > declare it as void.
> > > 
> > > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > > ---
> > >  include/drm/drm_drv.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > > index 97109df5beac..c6ae888c672b 100644
> > > --- a/include/drm/drm_drv.h
> > > +++ b/include/drm/drm_drv.h
> > > @@ -323,7 +323,7 @@ struct drm_driver {
> > >  	 *
> > >  	 * Allows drivers to create driver-specific debugfs files.
> > >  	 */
> > > -	int (*debugfs_init)(struct drm_minor *minor);
> > > +	void (*debugfs_init)(struct drm_minor *minor);
> > 
> > 
> > Doesn't this patch break the build, or at least, cause lots of build
> > warnings to happen?
> > 
> > Fixing it all up later is good, but I don't think you want to break
> > things at this point in the series.
> > 
> So, should it come last in the series? All functions that use this hook have
> been converted to void in the patchset.

I recommend fixing up the functions to just always return 0 first, and
then in one last patch, change the function itself to return void along
with this.

That would make it easiest to review, and allow no build warnings at any
point in the series, right?

thanks,

greg k-h
