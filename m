Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF04C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A83207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590581347;
	bh=QQD+MRgE+NZNCZ1eRvLYNsmu3HPx3aINjpU48jwRlJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bsLU/Tnxl0/daMvIVOKIzHs7/rIhbsXnHEUnBLDQ0ql8WPv1rvCeDd7gTyFWkNKN/
	 KfPnFcD50YEt8LfarWJIlwIVrAQbdBnapje5B6q8IlsD5A4qtlj46T5QOJl6Ggfftx
	 M5Rs7d10jF4pcN2m9mVlhHdScSyNWFQN2QcNU25w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbgE0MJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387935AbgE0MI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:08:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1643E207D8;
        Wed, 27 May 2020 12:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590581338;
        bh=QQD+MRgE+NZNCZ1eRvLYNsmu3HPx3aINjpU48jwRlJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppw1YZ13U3GlFvOUOKJHjPS6spIo3N1LnVyxUGcYWXLlt024/UzwJ/j8caj9QRbTT
         aStNnpVrgk/9GGow9w2VyKFQ6ePWmKMXiHP945Qbwoml51r0Kleg1cpF40zR8TI9kv
         Tv3jem1MlMHO38AXGJOvAA8k+fHHZha6t1JWxNVs=
Date:   Wed, 27 May 2020 14:08:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com
Subject: Re: [RFC 00/50] staging: vchiq: Getting rid of the vchi/vchiq split
Message-ID: <20200527120855.GA429709@kroah.com>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:53:05PM +0200, Nicolas Saenz Julienne wrote:
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
> Overall the series falls short of removing 1500 lines of code, which is
> pretty neat on itself.
> 
> So far it has been tested trough bcm2835-camera, audio and vchiq-test. I
> can't do much about vc-sm-cma for now, but the changes are done in a way
> that shouldn't affect its behaviour.
> 
> Note that the series builds up on RPi/Laurent's camera support series[1]
> and can't yet be merged. We'd have to coordinate here. We could either
> wait for the vc_sm_cma rework (if it's not going to take months and
> months to finish), or factor out all the vc-sm-cma stuff, merge that into
> the downstream kernel and take the rest of the series on top of
> Laurent's mmal-vchiq changes.

These look great, but due to the dependancy, I can't take them all.

But I can take the first 10, so I did that, they are now queued up,
thanks!

greg k-h
