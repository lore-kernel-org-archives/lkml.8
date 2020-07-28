Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67A12074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595951599;
	bh=OuxCoUV/Gm9xGmt005BF7ghh+V5TDaF/FvZpjT7+Pn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p6pAMXdbodxY90d/FK7MBgL+/b4BVps8ZNuLju1H8pjTACOrDP+wXT+Fb+nH2iYfp
	 ZePPOlpy5nfZQZgcq9RM3sG0HfyKbgqew7MFuwW1Jey6MxypcdiW1LVQRMNcFxaPUR
	 gy9rR/Ac2/H4v/m6YP5CJZbaSYVTgieRdbR6hOYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgG1PxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731004AbgG1PxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:53:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F882065C;
        Tue, 28 Jul 2020 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595951598;
        bh=OuxCoUV/Gm9xGmt005BF7ghh+V5TDaF/FvZpjT7+Pn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SaWxadHSweB5pY8xDgYABO2l9O5HRBSD+QJqCdZcxCi8HKaoS+5z8El+0pznGlsOL
         oPYnRsC0p1aJQyCuzQ/C868Y+JrjTyFND5q1SQ0EfJ+kfp0+/t8ddf5PwONqR+s4Jo
         FRx4UkDHL8TNF4TC0GFFpUZv1eA+KpaESL4W3ZxI=
Date:   Tue, 28 Jul 2020 17:53:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
Cc:     devel@driverdev.osuosl.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        stern@rowland.harvard.edu, jrdr.linux@gmail.com,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] media: usbvision: fixed coding style
Message-ID: <20200728155311.GA4178776@kroah.com>
References: <20200728143004.3228-1-dhiraj.sharma0024@gmail.com>
 <20200728145419.GA3537020@kroah.com>
 <CAPRy4h1Xs1JpQinnWm04dOi07Ch0RLL0U4Z5DDCKHmombXE0sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPRy4h1Xs1JpQinnWm04dOi07Ch0RLL0U4Z5DDCKHmombXE0sA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 09:14:24PM +0530, Dhiraj Sharma wrote:
> Sorry, I didn't realize that I committed a mistake by not replying to
> all. It was an accidental mistake which will not be committed in
> future now.
> 
> >
> > That is not needed in a changelog text.
> >
> 
> Alright Sir.
> 
> > Neither is this, please be specific about what you have fixed.  My bot
> > should kick in soon with more specifics...
> 
> Sir there were checkpatch.pl styling issues and I fixed them all
> together, so should I write a proper changelog as what all I fixed i.e
> errors and warnings thrown by checkpatch.pl

As the bot said, only do one type of thing per patch, and "fix all
checkpatch errors/warnings" is not one type of thing.
