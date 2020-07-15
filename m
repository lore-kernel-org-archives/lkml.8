Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8357C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D36D2065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594826665;
	bh=Zg2rsnakyWUd1tUcfsHqVlLsINCebZ+cnfEZe1dPnyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MYVW5soFBCiMi5gruf0Z6TpFSG7c8lg1YvRjibPKcASc5tzH9ivXXeq5Oi2VTVI0g
	 jK+SMNmhVf1dM4hQDi8ftjhTmN8DnmB2zB6ED6PsUxweqGMBXw2Y+GlAgIrNyWqtQ/
	 XQ1wkOUCZaCEnYxztCJPiQiQk4MT+zfK3GG0M1iA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgGOPYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgGOPYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:24:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 454B02065E;
        Wed, 15 Jul 2020 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594826663;
        bh=Zg2rsnakyWUd1tUcfsHqVlLsINCebZ+cnfEZe1dPnyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjWt89mWYRAOFc5aZxrigdFKbYJwSTW+d/sOrMpL7lOONrQ/KndCbp+/9LXFOyXWK
         oRxrY9jbv2Vo/MZfbIBJDgO+xKiZn/BrD/qoqonvG4zpTNaUnphJ5K4XqfNSV2TMiQ
         pPv7FEh97ZVV32ertwjbIP0wOjSXjZqdwTFFCeZE=
Date:   Wed, 15 Jul 2020 17:24:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Larry.Finger@lwfinger.net, puranjay12@gmail.com,
        yepeilin.cs@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8188eu: core: fix coding style issues
Message-ID: <20200715152419.GA722895@kroah.com>
References: <20200715142710.76205-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715142710.76205-1-98.arpi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:57:10PM +0530, Arpitha Raghunandan wrote:
> Fixing WARNING: Prefer using '"%s...", __func__' to using 'function_name'
> in a string in rtw_ioctl_set.c
> 
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

What changed from v1?

Always put that information below the --- line in the patch like the
documentation asks.

Can you fix this up and send v3?

thanks,

greg k-h
