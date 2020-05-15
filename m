Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCFB20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589540050;
	bh=Mjq71EcqjRqFc7HquDipPJiGp+F3LaonhLAil3VBgMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xys5Ef6Yg2oAl4i8RH471OZNlAszMYRWfWlWyJUCqmJ8CRoOb8bBvOwhb8xv4a9qT
	 jQWNRONy60nMNlwH60gSDIPxOYq5Be9VbX2YdtE+26EQJhxxjn31igLAeBZGnwRUPh
	 tmsfp/L0NbCYh+qV5/p6LH0E4gZggh8+8sdmin9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgEOKyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgEOKyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:54:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B7DC2074D;
        Fri, 15 May 2020 10:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589540049;
        bh=Mjq71EcqjRqFc7HquDipPJiGp+F3LaonhLAil3VBgMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyMNmXTHqkQmPhwON3CEZX0wi7dnL71VxyFae9KZyjKL/UbnlxbYkOgBiPZbhx/S6
         OC88ugg5qywwQ5YPfxcjPaHVCuZiaY1g4e2nd1cnYWhjlZLNMHL5H8sdKMZ7ezM1UL
         zex41jjpmtFuWO/53o9vHF3kkyHhmxkKx/M70Rwo=
Date:   Fri, 15 May 2020 12:54:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/20] nvram: drop useless access_ok()
Message-ID: <20200515105406.GD1729517@kroah.com>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <20200509234557.1124086-7-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509234557.1124086-7-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 12:45:44AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> we are using copy_to_user()/memdup_user() anyway
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/char/nvram.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
