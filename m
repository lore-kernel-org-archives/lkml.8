Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C162C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 049EC2192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589044040;
	bh=WvWUoFR5RjANxd1qiacraQ/PkwG98wt/odgEnXsQW5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dT32QdQm1KgGkhVXDZ/nIvJqwTuZkQNEwPewTZLcNoKHxm8HdCql+dXPwdlvhUQyo
	 6WnNEqJEmIvi1rtstgDMm1MKk+0tX3psO7MeLma50fS2Vlc5H7aGJmJM+g6iJiATfG
	 PPlNdQ/JVY5oT0f5R2CCU8V6Xq9gI0TB2rXtWjbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgEIRHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 13:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgEIRHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:07:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99832184D;
        Sat,  9 May 2020 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589044036;
        bh=WvWUoFR5RjANxd1qiacraQ/PkwG98wt/odgEnXsQW5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQKV7mHmq9gT1QqVjvt3oc3CUGzez8CokyYeKbs5VYNWKZvZXSz0iFxtw8QMvp/7d
         bokWfV/jImMT/a3UDiOFNUNHC5XhZFZPjBHuynqPUJeZs0z7IicHjdeBGOl278koGS
         FwEfTeFtRqL04t2ID8siOrIIF6+hI+jdHIVuyxTs=
Date:   Sat, 9 May 2020 19:07:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matej Dujava <mdujava@kocurkovo.cz>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: vt6655: clean Makefiles
Message-ID: <20200509170714.GC2482887@kroah.com>
References: <1589015247-738-1-git-send-email-mdujava@kocurkovo.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589015247-738-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 11:07:27AM +0200, Matej Dujava wrote:
> This patch is removing CFLAGS that are defining flags that are not used.

You are also modifying the indentation and moving lines around for no
reason :(

Please only do one thing for a patch, and always describe everything you
do in the changelog text.

Can you fix this up and send a v2?

thanks,

greg k-h
