Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB55C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3958520733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581353297;
	bh=E2ozvacKCjmDCHg1sN2gC/qMaTMQKL6FnDLyHYTdN4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dFnOYzX//dabLDzkblNeJ2xoVq++r6aiLvHRwoy4NWZ8Ayg/ph4kiWQ7Jd2gfJBfc
	 tNdg7PDVufaoz4Nns8//8zn6pMkmRqeSiwudK3lqW6ZuPau+1l1Q/E4Ey/jNVHusLA
	 oFViIYYtA17C8Y5i8PAs09cwXjq3OY899JQTOy1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBJQsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbgBJQsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:48:16 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80EF620733;
        Mon, 10 Feb 2020 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581353295;
        bh=E2ozvacKCjmDCHg1sN2gC/qMaTMQKL6FnDLyHYTdN4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkBfFofpXhkpoVFyomRIzCFkhv9TX19muKluBtbdPklRvYiGQBzmIh+hlOGFYGAkZ
         N3eVS5x9n4C1qBFOo0Xmn3uz1cfwjzp17dWSZ7YCe4NXK/d4/BVq/SoXYatsfh1rg4
         oWuFvY9fXG7+axHoKekAKmAJbIkO0V2Knv49bXpo=
Date:   Mon, 10 Feb 2020 08:48:15 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jerry Lin <wahahab11@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: rename some variables and clean up code
Message-ID: <20200210164815.GA967528@kroah.com>
References: <20200205024821.GA32262@compute1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205024821.GA32262@compute1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:48:21AM +0800, Jerry Lin wrote:
> Rename some variables to be more understandable and module-related
> and remove some redundant code to make it more easy-to-read.
> 
> Signed-off-by: Jerry Lin <wahahab11@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc2000_i2c.c | 118 +++++++++++++---------------------
>  1 file changed, 44 insertions(+), 74 deletions(-)


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
