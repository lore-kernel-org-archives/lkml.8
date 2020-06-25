Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D009B20773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593104843;
	bh=EMzGjcfL2NohlkRbBIHJ19RakYEx5lPHd+BKbAjeI5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lgRg7F9X1bGVr0Vby/My/YJaCKXovGYf5LnqnXMVsSDn5c6OJpj9ivJ8teDenTRGQ
	 DxleIQZQuyyLGmQg74USOAKbHdusgOUoButuQxTpD4pAo/vPepeqddQ2wN2z3h5NSl
	 BCWyx84fSgncvVeMqt+nYsSSkRxgH5VClDImeYiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406642AbgFYRHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404317AbgFYRHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:07:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB7F520707;
        Thu, 25 Jun 2020 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593104841;
        bh=EMzGjcfL2NohlkRbBIHJ19RakYEx5lPHd+BKbAjeI5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbpICURGfnxUpz3FOfLxcaobtHhnuAs+U27iSH3NkjvVkdck+A139uzKARjt+GXe9
         W6lJifOYsPEZMTsWcUEX7izn3CCztcytSJsV6YHlFjOHpVoLBmPjn4KeuiwOlEQWmv
         EFN4QxkHU3xBgwNsGNezVmW7ltDLPjj7w6iM6g4s=
Date:   Thu, 25 Jun 2020 19:07:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: media: soc_camera: Adding parentheses to
 macro defination at line 241, Clearing alignment issues at lines 410 and
 1270, fixing return values at EPOLLERR
Message-ID: <20200625170717.GA3962702@kroah.com>
References: <20200625153516.fibpfsodnogrimlh@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625153516.fibpfsodnogrimlh@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:35:17AM -0400, B K Karthik wrote:
> staging: media: soc_camera: soc_camera.c: Clearing coding-style problem
> "Macros with complex values should be enclosed in parentheses" in line 241 by adding parentheses.
> staging: media: soc_camera: soc_camera.c: Clearing coding-style problem
> "Alignment should match open parenthesis" by adding tab spaces in line 410.
> staging: media: soc_camera: soc_camera.c: Clearing coding-style problem
> "return of an errno should typically be negative" by adding a "-" in front of EPOLLER in line 812.
> staging: media: soc_camera: soc_camera.c: Clearing coding-style problem
> "Alignment should match open parenthesis" by adding tab spaces in line 1270.
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/media/soc_camera/soc_camera.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

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
