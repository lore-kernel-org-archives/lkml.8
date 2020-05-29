Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB833C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC532077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590764474;
	bh=BFvR/sBoE3bZ5MMsNgAKao6Lz/pxicRyGJ5UzgH30fE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pSzEJFeCb+t8KoVCATrBfNDYEH2N3xOQCLUjmNpfo3qSfTHm0qIOInNwCpXZAZDUb
	 O0b7q2BuwhMHH8aPXOA9kuno6iTidUKbm6pWXG6hYpEoD6PhxnJ4CPJLwuLJ/h91ya
	 0/vg68qPLATGfQHnoPthkcWTIWlwQ3W7QUzGC9UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgE2PBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgE2PBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:01:13 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2246D20776;
        Fri, 29 May 2020 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590764473;
        bh=BFvR/sBoE3bZ5MMsNgAKao6Lz/pxicRyGJ5UzgH30fE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i0XMvqn7BBr8yz6EjNmEUMRv6Yw9yQns3O8C3P0oGd6rmbv1QctYXYxyhVFCw27cw
         mUTjcDaWV+5a76FUir8DvsXjFGNJuF3JCF9Pc6CW+ONgkDKjoGUdQc/bfboHQbQV/P
         PuQcPq86T1/vWWIgwJ1caTrEUDSgsGsOtoSTib48=
Date:   Fri, 29 May 2020 17:01:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: please revert "Revert "media: staging: atomisp: Remove driver""
Message-ID: <20200529170109.4d68450f@coco.lan>
In-Reply-To: <20200529140907.GA2916@lst.de>
References: <20200529140907.GA2916@lst.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 29 May 2020 16:09:07 +0200
Christoph Hellwig <hch@lst.de> escreveu:

> Hi Mauro and Greg,
> 
> the commit mentioned in the subject (commit id ad85094b293e in
> linux-next) contains the grave offense of adding a new set_fs address
> space override in "new" code.  It also doesn't have an Ack from Greg
> despite showing up in drives/staging, which looks very suspicious.
> 
> Please don't just add crap like this back if it doesn't pass the
> most basic sanity tests.

Hi Christoph,

Thanks for the tip about set_fs().

The part of the driver which calls set_fs() is under the compat32
handler.

This code is commented-out at the commit which reverted it:

	const struct v4l2_file_operations atomisp_fops = {
	        .owner = THIS_MODULE,
	        .open = atomisp_open,
	        .release = atomisp_release,
	        .mmap = atomisp_mmap,
	        .unlocked_ioctl = video_ioctl2,
	#ifdef CONFIG_COMPAT
	        /*
	         * There are problems with this code. Disable this for now.
	        .compat_ioctl32 = atomisp_compat_ioctl32,
	         */
	#endif
	      	.poll = atomisp_poll,
	};

So, there's not risk of calling it. Also, instead of calling
an atomisp-specific compat32, the driver should, instead, use
the standard V4L2 handler for it, once we can get rid of all
those new driver-specific ioctls. Most of which can probably be
replaced by the already existing ones.

But yeah, you're right, we should get rid of the places that
have set_fs() there. I'll add an additional patch for it to
get rid of the set_fs(), adding a FIXME there. 

I'll send a patch for it in a few.

Thanks,
Mauro
