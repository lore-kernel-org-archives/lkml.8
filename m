Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A197C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BA32074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589540018;
	bh=YO9ieZ2XSjlr8youhAVFeJv8Lk8F4t/qapdPY41IiYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sPc86UMiYcsEa/klY9uWiEIHEZypYQS+m3iDK2neBlSDKx2ZbTQdW1lI7ZTkkNKGY
	 VY8QvWA1zzjpmPcfmVd1cj3ZFi8rC11SWsrFawfi21jn+aKhtDe3Yvs2FtYQnQezcH
	 7AB+Q3FEKXru2vLFgMRCVMJ1IEp3IeuhJAe8wtHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEOKxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgEOKxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:53:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C643C20709;
        Fri, 15 May 2020 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589540015;
        bh=YO9ieZ2XSjlr8youhAVFeJv8Lk8F4t/qapdPY41IiYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2cMsIbs15Sft892IdErIDqutExzauM4P+weAaPQtXM5RewFP8HC0paIsj/hi45MGl
         hqf0SuwQ57cdQpv33YwqDC5luP1CpbuayLhx3nA+NQUldkJw9Gr1QHnDH12Cs/vVi3
         JvaU5KTqidvcLpoQwvFDgKXkrCoo8Q03OsFNkim8=
Date:   Fri, 15 May 2020 12:53:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/20] n_hdlc_tty_read(): remove pointless access_ok()
Message-ID: <20200515105333.GA1729517@kroah.com>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-6-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509234557.1124086-6-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 12:45:43AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> only copy_to_user() is done to the address in question
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/tty/n_hdlc.c | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
