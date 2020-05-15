Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B51C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4147A2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589540042;
	bh=Yr4GyxkQ3bMgTFMGAu8B7Z6m/55KjgMcK7oJClfDsBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rdQaFbuID3UO4J+eRB+VwE8puUxm3iur4xzouJOe8HAUR2nBHWu+mLwTPFHP4PTCl
	 MM7ZZ5nHgG3tlvFFXZH1jbFcftD0J1WFQfbgmDDcCcnicodyQPJQYDOrMNZspwltKL
	 pJTfa5+kFdfg4vIL1O6qWOaQrTsSNJ6eQjvxadD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEOKyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:32864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgEOKyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:54:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4418D20709;
        Fri, 15 May 2020 10:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589540040;
        bh=Yr4GyxkQ3bMgTFMGAu8B7Z6m/55KjgMcK7oJClfDsBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwe1r3QjepS23apalhmvm6DEPSLao+P1T5STBIT6FtSyynldFWQWpGL9askYzriXf
         ngEialcvK7UWBNzpipTbj0a25bvACTQC1WURolBkWuCyF30Vnc0dt430PEwqvllSbp
         M1qrVyCEL7ywEC4gnc8B1L4LiIg/V+KxhdV+QZMg=
Date:   Fri, 15 May 2020 12:53:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] vmci_host: get rid of pointless access_ok()
Message-ID: <20200515105358.GC1729517@kroah.com>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-20-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509234557.1124086-20-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 12:45:57AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> get_user_pages_fast() doesn't need the caller to check that.
> NB: reachable only from ioctl(2) and only under USER_DS
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/misc/vmw_vmci/vmci_host.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
