Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E49C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334F22074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589540032;
	bh=9hU+4BjJ6xoNNsP9w8H3wKYZY9yAUHlcZJ7UwMa+r5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r9m+/udbzM65IOFd4Ya15fUk8dTdiSbIsot84TXTp107XsAungdFYS3n018/5Bx3y
	 rcu7qWhCx1KRcllAQR6p/0n+kP+zux6jde3Q4GpG68HDFT3lwMtzSwddT8aZ5GLwFW
	 13XOEn91pZAnf/FYhPe0T6tsr7wT3CRurBu9iAdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgEOKxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgEOKxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:53:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D6E420709;
        Fri, 15 May 2020 10:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589540031;
        bh=9hU+4BjJ6xoNNsP9w8H3wKYZY9yAUHlcZJ7UwMa+r5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AnvPRGNFlQ72k/NCFBbgtdO8xVxnlT7p8tUhiP3pTqCmnv04Jrt3mEvmdHXDYGqMd
         yAJDpwgglQ0ulQ7Wke7nbAp1WeyA+Jy+Ujxkqvs+2+Hi132fyWn9KkoozPsKSfh2xZ
         GscloPWMBnTTDs8HEqC4y1n9Ur4hkd/4p7oOc7qw=
Date:   Fri, 15 May 2020 12:53:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/20] usb: get rid of pointless access_ok() calls
Message-ID: <20200515105348.GB1729517@kroah.com>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-18-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509234557.1124086-18-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 12:45:55AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> in all affected cases addresses are passed only to
> copy_from()_user or copy_to_user().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/usb/core/devices.c          | 2 --
>  drivers/usb/core/devio.c            | 9 ---------
>  drivers/usb/gadget/function/f_hid.c | 6 ------
>  3 files changed, 17 deletions(-)


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
