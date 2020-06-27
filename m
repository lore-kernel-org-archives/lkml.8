Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD658C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982232081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593234744;
	bh=ZR9R+1G9C/s3y+kFJcl3xJbnyXzaVO/+UpaRU8BkKL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bMeYKRCw2AJJ2HoxDw6P1uCQ4y2Cw/FUzJxXhsW0JO3b87TOfqD+MWpejEViKCj6f
	 iLc2yMYDX+JOQiZXDvewcALAULmeRSn8QrkzBSnqt97qOZUqyEs+AZ6/mRxilacd7m
	 JIVlHuBjSn953m1PBT7UEoUldNtXLS9hsvjwrOKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgF0FMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 01:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgF0FMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 01:12:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9878120720;
        Sat, 27 Jun 2020 05:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593234742;
        bh=ZR9R+1G9C/s3y+kFJcl3xJbnyXzaVO/+UpaRU8BkKL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmxiMz01I5d2q6UtYiC3un2KWDm3gZP0T884E/9vsR8y7/WwDalZVOGL/7L8SuvWd
         P+F1eVAhFlSNb58cs/8j+dHP4NbIjEQZ61pp07uQpv+itFxWKxLb3x4opmp6jDVxVE
         Jui35tKrx9pf/pGT4bBaGtVQEhkIzTQJTJf/SlIk=
Date:   Sat, 27 Jun 2020 07:12:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbtft-bus.c:
Message-ID: <20200627051219.GA233327@kroah.com>
References: <20200627045004.a46jbqtbiintu2nt@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627045004.a46jbqtbiintu2nt@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 12:50:04AM -0400, B K Karthik wrote:
> fbtft-bus.c:
> 
> fixing ERROR: space prohibited before that close parenthesis ')' by removing that space and ',' in line 65 and 67.
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


Your subject line is really odd :(

Please read the following text from my patch-bot:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

And fix up both the subject lines, and the changelog body text so that
it looks correct.  Look at the other patches for this code that have
been accepted as examples of what to do.

thanks,

greg k-h
