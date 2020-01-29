Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E744C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1D820720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580291725;
	bh=Qp4z6BxxO4jNfVLAjf+Lq7T3fqN2XTFayWA+61yLH38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r9Suz/8aNQGqEkoA7bFk/6LHRrM2q5dW/xy0D7GaB8rzGY4w6VsiU/gWqkpfHgaM1
	 4awxxcZ7YwUqQuCg/2vN7riByA+Xj8/Uovs5koqhs1GQx/pST+n6uNjM/q/X0LDgj7
	 9T7CmlkzqMdJwOhRKoA4oUZfSyt5SLJzkDu+RHH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgA2JzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgA2JzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:55:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A2D20708;
        Wed, 29 Jan 2020 09:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580291723;
        bh=Qp4z6BxxO4jNfVLAjf+Lq7T3fqN2XTFayWA+61yLH38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkOB7FKkcx+naNcyRr3OAxOQvWFZoxDP8uwopMNvffxqcN/4+/72QEtDdMw7vN+oU
         z2yjQZ9IwJgBzC8ga2/OLi9BJy8dganyc06dntY252aIlBKRoiBpUuNSGwW5g+sNnJ
         DnYQqQrxCfDxbEQb8Y1uSzinYTl6SMy0Vm724cvM=
Date:   Wed, 29 Jan 2020 10:55:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andreas Schneider <asn@cryptomilk.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.4.y] ALSA: pcm: Add missing copy ops check before
 clearing buffer
Message-ID: <20200129095521.GA3852676@kroah.com>
References: <20200129094041.12272-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129094041.12272-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:40:41AM +0100, Takashi Iwai wrote:
> [ this is a fix specific to 4.4.y and 4.9.y stable trees;
>   4.14.y and older already contain the right fix ]
> 
> The stable 4.4.y and 4.9.y backports of the upstream commit
> add9d56d7b37 ("ALSA: pcm: Avoid possible info leaks from PCM stream
> buffers") dropped the check of substream->ops->copy_user as copy_user
> is a new member that isn't present in the older kernels.
> Although upstream drivers should work without this NULL check, it may
> cause a regression with a downstream driver that sets some
> inaccessible address to runtime->dma_area, leading to a crash at
> worst.
> 
> Since such drivers must have ops->copy member on older kernels instead
> of ops->copy_user, this patch adds the missing check of ops->copy for
> fixing the regression.
> 
> Reported-and-tested-by: Andreas Schneider <asn@cryptomilk.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks for the fix!

greg k-h
