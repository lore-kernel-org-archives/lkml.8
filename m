Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C03820788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585063115;
	bh=0oO4R6Fq55pS68Lzl3lvAUhpi/VkW0U9z/riyIu9OD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FRp7XFSpD6IlSxOXMIsJfrSAwAWYOj6wc1Mr1Fe7FHqI8M7+oZrOff2E712k6yAO7
	 dDNGKud9hwsuQC9C5yhnoMSLiGH9tAgOfJwnuRLyVSyDQW44LOXwCmS/sJCSm9CUDR
	 omlX9/+SDjDo2Wnr5yjpNc25Av1YGEN/iLZgU9uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgCXPSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgCXPSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:18:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B202076F;
        Tue, 24 Mar 2020 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585063113;
        bh=0oO4R6Fq55pS68Lzl3lvAUhpi/VkW0U9z/riyIu9OD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIQUsxffWxV+ZptxFl4tdp0yoU+K2wKOyGp3Wy7pPzEtWprI5ziuSFpGGSvDtKUmz
         M/FqAgZj3S4JTIHlniRlPfNvIf8ggk8WZ807KjvMzcMDSTTLHlH209rtwBWp+mIjtA
         9ASVSJcvc4/LLcpgp+pEGEpENRxYf8ISCWExKh4Q=
Date:   Tue, 24 Mar 2020 16:18:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] nvmem: Add support for write-only instances
Message-ID: <20200324151831.GA2510993@kroah.com>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-6-srinivas.kandagatla@linaro.org>
 <20200323190505.GB632476@kroah.com>
 <4820047d-9a99-749c-491d-dbb91a2f5447@linaro.org>
 <20200324122939.GA2348009@kroah.com>
 <300e8095-3af4-15a2-069f-87ac7cbb83bb@linaro.org>
 <PSXP216MB04387C07F1E4C827245DE98380F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04387C07F1E4C827245DE98380F10@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:24:21PM +0000, Nicholas Johnson wrote:
> On Tue, Mar 24, 2020 at 01:25:46PM +0000, Srinivas Kandagatla wrote:
> > 
> > 
> > On 24/03/2020 12:29, Greg KH wrote:
> > > > But the Idea here is :
> > > > We ended up with providing different options like read-only,root-only to
> > > > nvmem providers combined with read/write callbacks.
> > > > With that, there are some cases which are totally invalid, existing code
> > > > does very minimal check to ensure that before populating with correct
> > > > attributes to sysfs file. One of such case is with thunderbolt provider
> > > > which supports only write callback.
> > > > 
> > > > With this new checks in place these flags and callbacks are correctly
> > > > validated, would result in correct file attributes.
> > > Why this crazy set of different groups?  You can set the mode of a sysfs
> > > file in the callback for when the file is about to be created, that's so
> > > much simpler and is what it is for.  This feels really hacky and almost
> > > impossible to follow:(
> > Thanks for the inputs, That definitely sounds much simpler to deal with.
> > 
> > Am guessing you are referring to is_bin_visible callback?
> > 
> > I will try to clean this up!
> I am still onboard and willing do the work, but we may need to discuss
> to be on the same page with new plans. How do you wish to do this?
> 
> Does this new approach still allow us to abort if we receive an invalid
> configuration? Or do we still need to have something in nvmem_register()
> to abort in invalid case?
> 
> The documentation of is_bin_visible says only read/write permissions are 
> accepted. Does this mean that it will not take read-only or write-only? 
> That is one way of interpreting it.

That's a funny way of interpreting it :)

Please be sane, you pass back the permissions of the file, look at all
of the places in the kernel is it used for examples...

thanks,

greg k-h
