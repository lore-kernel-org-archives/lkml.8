Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D710C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158B620767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598966012;
	bh=Ub1uSIZ4Qs5eDiV1KOprlSTLh6g2luT5zBCXTqED6wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sSyFx+IYNIHIH7DP72Ln1kqLBe0m6u9jUytZY9t1Z8CyQa5Mi0EMrmnaDn+eHMb2v
	 3OUnB/IchXCDIWvkHZEFh4Z+jpsB28HSN3mghfzTQsBftWJO7DQXbnOrSfqSPpNmOs
	 tXrgbQQFiRkdkw/dsiIUFZlg8+odKUySDGWDb3rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgIANNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgIANJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:09:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CAD2067C;
        Tue,  1 Sep 2020 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598965773;
        bh=Ub1uSIZ4Qs5eDiV1KOprlSTLh6g2luT5zBCXTqED6wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Va34zC5oVFNB9G9Eoxk6CaE+cVNkMAfgeX6VkSAOQkRgB8jhI6C1fQ7EZsqxGahXT
         OU/RBLleinVH67cFoWR/pkAp67wncJluU1xVmtowXauY+OebH51J7VCbZLpK6Zp31b
         DM3Jm3wE60/0oGYjU/+gun+pPFySzuypWcd3H7y8=
Date:   Tue, 1 Sep 2020 15:10:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "antoni.przybylik@wp.pl" <antoni.przybylik@wp.pl>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: Fwd: Re: [PATCH] staging: gdm724x: gdm_tty: corrected macro by
 adding brackets
Message-ID: <20200901131000.GA298818@kroah.com>
References: <e11b8f5e-1b85-fe24-36d5-c8d707ce4e66@wp.pl>
 <15764d01-0602-18c6-e2b1-089b71a2061d@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15764d01-0602-18c6-e2b1-089b71a2061d@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:06:23PM +0200, antoni.przybylik@wp.pl wrote:
> On 01.09.2020 13:08, Greg KH wrote:
> > On Tue, Sep 01, 2020 at 12:43:11PM +0200, antoniprzybylik wrote:
> > > Such macros are dangerous. Consider following example:
> > > 	#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> > > 	GDM_TTY_READY(a + b)
> > > This macro will be expanded in such a way:
> > > 	(a + b && a + b->tty_dev && a + b->port.count)
> > > And it will lead to errors.
> > This is for a pointer, no one would ever do that :)
> 
> Nobody adds a pointer to a pointer, but it's common to add to it some value
> like that:
> 
> GDM_TTY_READY(myptr + 0x1000)

In this driver?  And adding random numbers to a pointer should not be
common, when those pointers are structures, right?

> > But, if you really worry about this, turn it into an inline function,
> > that way you get the proper typedef safety, which is what something like
> > this should really be, not a macro.
> 
> How to do it? Do I need to send another patch?

If you wish to fix this up, please do, I can't take this as-is.

thanks,

greg k-h
