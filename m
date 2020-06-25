Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD82BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B4220773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593105852;
	bh=ERYgcYUp0xp8dcvgh/Kv/HPBnf41UK731QAjGSqQBp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BIgE+r0BJoakRPixkhkE3mMTdFBdZelI8ufr0ia6Gh6cwPJuWs8oJOc/e8Sv3W/1W
	 xECdfemGd7+BF/h0ep78bNB/2kIwaF0jdOinexUrGTvx8Mfx8Entb/ldFZp8fd6F0q
	 upsmaW3nJkXB9xGY9CfV4iM/ZFrHMrunPQs4fizk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406750AbgFYRYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404342AbgFYRYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:24:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D735F20773;
        Thu, 25 Jun 2020 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593105849;
        bh=ERYgcYUp0xp8dcvgh/Kv/HPBnf41UK731QAjGSqQBp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geSBgMNE3dvqSAP8s354iMk3AMtHB96CoB3rnE+tJuj/99rX4k7k00Zm9A56vR/Rp
         vl6XxHYznexewuyKGA0fuAiJoLKxaKfOiRGbxPZ8b5ypRnvCR0tkgpN3rJpnqiHjYd
         ZPw7kaPi1XNk1TLqjAU1d7maABn+Qt4jkjTvphLA=
Date:   Thu, 25 Jun 2020 19:24:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        "supporter:QLOGIC QLGE 10Gb ETHERNET DRIVER" 
        <GR-Linux-NIC-Dev@marvell.com>,
        open list <linux-kernel@vger.kernel.org>,
        Manish Chopra <manishc@marvell.com>,
        "open list:QLOGIC QLGE 10Gb ETHERNET DRIVER" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] fix trailing */ in block comment
Message-ID: <20200625172405.GB3965841@kroah.com>
References: <20200625153614.63912-1-coiby.xu@gmail.com>
 <20200625153614.63912-2-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625153614.63912-2-coiby.xu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:36:13PM +0800, Coiby Xu wrote:
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  drivers/staging/qlge/qlge_main.c |  3 ++-
>  drivers/staging/qlge/qlge_mpi.c  | 10 ++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 

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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
