Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501E320768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593095677;
	bh=V1/9Cp9cSTTz+XY27botGdBPhCCehM3RoZuzCXJ/j3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Eh1a58Nzh9qD4Xod/3geOu/89MSR5bDhBeYch2tKndbbDCFjiUtWU0i2dSKRTcl3N
	 DMvLV+t+EfsKSMM1cT7gh4wiLQmQrTEbLjx3fy1k7PrUfdaeJPaWjD9ATOFQaetojM
	 1qRe69j40QDq/VySIXDt56UWZFzuQHlNj7Txuz3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405381AbgFYOeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405340AbgFYOef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:34:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D80E20767;
        Thu, 25 Jun 2020 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593095674;
        bh=V1/9Cp9cSTTz+XY27botGdBPhCCehM3RoZuzCXJ/j3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yBuUsZJZbgq0vPFFBZMWiWlVLzW/Emt0078tSAKvMEZuxHSjHl1xl0IqcgYxsCx5S
         fRB5o25JFGzAc9G0vx8K51i8NwB9CJ+bbRPTMeCbelsYUD/wpOIkejwrrqJ38R+13k
         CDDbw1MULh1jhgdLpO2d0bQtPlYTUsTmtCr97pDE=
Date:   Thu, 25 Jun 2020 16:34:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devel@driverdev.osuosl.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 00/50] staging: vchiq: Getting rid of the vchi/vchiq split
Message-ID: <20200625143430.GA3898215@kroah.com>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:41:46PM +0200, Nicolas Saenz Julienne wrote:
> vchi acts as a mid layer between vchiq and its kernel services, while
> arguably providing little to no benefit: half of the functions exposed
> are a 1:1 copy of vchiq's, and the rest provide some functionality which
> can be easly integrated into vchiq without all the churn. Moreover it
> has been found in the past as a blockage to further fixes in vchiq as
> every change needed its vchi counterpart, if even possible.
> 
> Hence this series, which merges all vchi functionality into vchiq and
> provies a simpler and more concise API to services.
> 
> I'm aware that kernel's vchi API tries to mimic its userspace
> counterpart (or vice versa). Obviously this breaks the parity, but I
> don't think it's a sane goal to have. There is little sense or gain from
> it, and adds impossible constraints to upstreaming the driver.
> 
> Overall this fall short of removing 1100 lines of code, which is pretty
> neat on itself.
> 
> So far it has been tested trough bcm2835-camera, audio and vchiq-test. I
> can't do much about vc-sm-cma for now as it's only available downstream,
> but I made sure not to break anything and will provide some patches for
> the RPi devs to pick-up, so as to make their life easier.
> 
> Note that in order to keep the divergence between the downstream and
> upstream versions of this as small as possible I picked up some
> mmal-vchiq patches that might not be absolutely necessary to the goal of
> the series.

I took the first 2 patches and will wait for the rest to be resent :)

thanks,

greg k-h
