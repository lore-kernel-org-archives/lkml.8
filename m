Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416BBC47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E66D2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588664739;
	bh=KabGD4ekn5YE4Pzx/iZDYkiL8RHInKLJTdo36GuGiug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j1+FwdNMjllTUNR+kbWKvzKOMsdbuF/IBOLawecjAOv7snY55fF5E+EUL3xlmcS45
	 81U4a09yVZ9AQjdR72mvDZDggSw2jVKGGOz+t3gtP4gVZKW2PoTlgugstOy2ljEk+c
	 UGMSiQ0hDT3BP1t8gIliFr8sMngly/8zZiWcFyi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgEEHpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgEEHpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:45:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404F2206CC;
        Tue,  5 May 2020 07:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588664737;
        bh=KabGD4ekn5YE4Pzx/iZDYkiL8RHInKLJTdo36GuGiug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MB5J6NxaWPPdA49yOdcc3E0eCCKZGUoGTno53CYL4PpBBM0d82eJK4gHwBkshuHOX
         acn3ntKp+HFX7GBsVFTTyEahgRy8Ldhw5p+P6HNpnUcIHFYJuN1FH+uQ/d7qKDZ6LW
         IHK/pe2cHDJg0yQK4VwxjS3h9fF3c91V442WA26o=
Date:   Tue, 5 May 2020 09:45:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk, kuba@kernel.org,
        edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH net 2/2] Revert "sockfs: switch to ->free_inode()"
Message-ID: <20200505074535.GB4054974@kroah.com>
References: <20200505072841.25365-1-sjpark@amazon.com>
 <20200505072841.25365-3-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505072841.25365-3-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 09:28:41AM +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> This reverts commit 6d7855c54e1e269275d7c504f8f62a0b7a5b3f18.
> 
> The commit 6d7855c54e1e ("sockfs: switch to ->free_inode()") made the
> deallocation of 'socket_alloc' to be done asynchronously using RCU, as
> same to 'sock.wq'.
> 
> The change made 'socket_alloc' live longer than before.  As a result,
> user programs intensively repeating allocations and deallocations of
> sockets could cause memory pressure on recent kernels.
> 
> To avoid the problem, this commit reverts the change.
> ---
>  net/socket.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Same problems here as in patch 1/2 :(
