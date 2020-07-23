Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E264C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5967D20709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595503105;
	bh=7yYsCXQZddIcngHN79CYvQZyJ/SNajKQiZIuQXTYH1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qWATA8ZIQgaeKjbz6ILXydUgpCWJgCXB/MmwP1qhRL0B4QZRgSaadVWE8CIEW/HLC
	 2sq+lfH+GrDVNvLo5NrCKx4OcKRpxcwQXLE8+Tsw6wAl+ULrHnZeVchdAEET8ol3he
	 aWD+qBSQMw24p36wH7qC4HgXWqJCTqLbAWGPuxzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgGWLSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgGWLSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:18:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18C4206F4;
        Thu, 23 Jul 2020 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595503103;
        bh=7yYsCXQZddIcngHN79CYvQZyJ/SNajKQiZIuQXTYH1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQmYhHIqSL58pJgKhwa5wstW04qTgqgJtyLDnFIVGFQ1uqTP6sYe4eOKu32wm7drq
         siQxhNZni9V6jqNnBXBOom01DACzlDbehFZHfXBN4RPkt8lTAIDi1qU/u5gOqeEqOp
         /XIMgEkqsT+7EdbyVEZjv8meITwAiwf0o7KNgpBk=
Date:   Thu, 23 Jul 2020 13:18:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: properly check all write ioctls for permissions
Message-ID: <20200723111827.GA1963557@kroah.com>
References: <20200716115346.GA1667288@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716115346.GA1667288@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 01:53:46PM +0200, Greg Kroah-Hartman wrote:
> When doing a "write" ioctl call, properly check that we have permissions
> to do so before copying anything from userspace or anything else so we
> can "fail fast".  This includes also covering the MEMWRITE ioctl which
> previously missed checking for this.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: stable <stable@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/mtd/mtdchar.c | 54 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 9 deletions(-)

Any objection to this patch getting into 5.8-final?

I can take this through one of my trees if you all give me an ack :)

thanks,

greg k-h
