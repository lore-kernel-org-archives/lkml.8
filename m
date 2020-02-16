Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B50FC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 16:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BB020857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581871101;
	bh=VWG8pxZ0l2Q+50IdYiHS//nBhQMz4rD87ECHqgUJ+9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T1w0s5AnjfCgzBOo78FDVMXkWBnGbQlpDsSQtIKg1JlHGsuVBHo1z9a7hz1AFu25J
	 HsuZjrvTykeZ/eFZwDtrt8n/GxJL0lQxplW29AY2amKQRt2+HUqnYHUQA/Sk76mEQQ
	 wENY8o3DPk5IdqJDNacIbiGiSUE5nFevIyfJVU2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgBPQiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 11:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgBPQiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 11:38:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7860120857;
        Sun, 16 Feb 2020 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581871094;
        bh=VWG8pxZ0l2Q+50IdYiHS//nBhQMz4rD87ECHqgUJ+9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmiVP36zahpvKZBCZ5Yn+Q+1QtNy3qviQIH7XfHpFL5LfVWfFRM2LI+BXCBifPImH
         c4fGCCqdprgjrGVBtqcpYNx3x3tO78XuibTE2Ns7j3xYLfuctQQI+2onMoljgeb1rB
         Ly7Gztv4Y3689DMsL2bbFIm8eJuar5H+Y34Qp+0s=
Date:   Sun, 16 Feb 2020 17:38:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sunnypranay <mpranay2017@gmail.com>
Cc:     hsweeten@visionengravers.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: DMA-API-HOWTO.txt: fixed grammer issues
 Fixed some of the grammer issues in DMA-API-HOWTO.txt using the software
 grammerly.
Message-ID: <20200216163809.GB48157@kroah.com>
References: <20200216141658.734-1-mpranay2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216141658.734-1-mpranay2017@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 07:46:58PM +0530, sunnypranay wrote:
> From: mpranay <mpranay2017@gmail.com>
> 
> ---
>  Documentation/DMA-API-HOWTO.txt  | 628 +++++++++++++++----------------
>  drivers/staging/comedi/drivers.c |   2 +-
>  2 files changed, 311 insertions(+), 319 deletions(-)


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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
