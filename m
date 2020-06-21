Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D448C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468FB208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592747723;
	bh=ZZHztxDAvUBWuMvdfrcMUVbI7dlbbdJrnJbEn9ncTcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xiExjvD/LnnR0Wn7CZvN9WG9p6kF1KciVxJWRiTUS9MAvL+iVu4ekCe5qe+08IYQa
	 Xrdzj61kjrDd/9ncaUOnXgVXt1a6lU9lOmeWBXWDe9cZNwQ5zPC0G1ai64Pe7VsgtM
	 SYbkFMMiFYHOnY31JCYtSXahTMIv1Mhesg4KZ3yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgFUNzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729796AbgFUNzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:55:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DF842071A;
        Sun, 21 Jun 2020 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592747721;
        bh=ZZHztxDAvUBWuMvdfrcMUVbI7dlbbdJrnJbEn9ncTcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnvGcKKYqASIrnBi927D+3Gf4q0itS0b5YI1jhAUJ01RL5xXG+5GZHjBQ4IO8CUWF
         adq2/GLpToLZEYF9BAoi0jepN6/ZCyS1nc8j61TU9mPM9WSfZxWEZfqgIeC+1QlTKg
         kfJKJCHGUQ4aaz+LwZ4TUX7TDH/JMCVkh9RXxFg0=
Date:   Sun, 21 Jun 2020 15:55:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+6bed2d543cf7e48b822b@syzkaller.appspotmail.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] media: media-request: Fix crash according to a failed
 memory allocation
Message-ID: <20200621135516.GA125094@kroah.com>
References: <b39653f6-9587-4027-35ed-53d341845cb2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b39653f6-9587-4027-35ed-53d341845cb2@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 02:45:10PM +0200, Markus Elfring wrote:
> > …, reorder media_request_alloc() such that …
> 
> Wording adjustments:
> …, reorder statements in the implementation of the function “media_request_alloc” so that …
> 
> 
> > … the last step thus
> 
> … the last step.
> Thus media_request_close() …
> 
> 
> Would you like to add the tag “Fixes” to the commit message?
> 
> 
> …
> > +++ b/drivers/media/mc/mc-request.c
> > @@ -296,9 +296,18 @@ int media_request_alloc(struct media_device *mdev, int *alloc_fd)
> >  	if (WARN_ON(!mdev->ops->req_alloc ^ !mdev->ops->req_free))
> >  		return -ENOMEM;
> >
> > +	if (mdev->ops->req_alloc)
> > +		req = mdev->ops->req_alloc(mdev);
> > +	else
> > +		req = kzalloc(sizeof(*req), GFP_KERNEL);
> 
> How do you think about to use a conditional operator?
> 
> +	req = (mdev->ops->req_alloc
> 	       ? mdev->ops->req_alloc(mdev)
> 	       : kzalloc(sizeof(*req), GFP_KERNEL));
> 
> 
> Regards,
> Markus


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
