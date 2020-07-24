Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43063C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2113F206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595577499;
	bh=MrwCiCK2poXyalIQcTVioocFhr5gBVdyQlm3J3yoT6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yLxT3CT+1ELMkrEAow9vGvuS5o8K7Cr5LlBCzxbEtH0zIoMhDIhTbkPKqgqGtRwce
	 Vqsca5TZCr+vFJCrDROF5XyGh5CHPxr8t1h76jXr05WRpJauMx1LWyq491kiIlchol
	 cs5evWigISS0ULPxUce8S9H9DWUZz/wRB4EguDDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgGXH6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgGXH6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:58:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89C52068F;
        Fri, 24 Jul 2020 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595577497;
        bh=MrwCiCK2poXyalIQcTVioocFhr5gBVdyQlm3J3yoT6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZ5SE4UEtBCEwHakT4CT424khXj0IXDrQsmyhCYSmXsOe/zJUUwFQzzeS25E9bTrf
         EXegxWvE0nG3QyGlvBO1BrM1L9HyK8V8JdCtkY+b/KffvBEIMcHQU68w2uMzpfWhQn
         T2p09xeGgeOXqQOm0BCOWV6Hnrg+Yr1G7lkqzEpc=
Date:   Fri, 24 Jul 2020 09:58:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] newport_con: vc_color is now in state
Message-ID: <20200724075819.GA3955149@kroah.com>
References: <202007241318.wXYkumEO%lkp@intel.com>
 <20200724062735.18229-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724062735.18229-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 08:27:35AM +0200, Jiri Slaby wrote:
> Since commit 28bc24fc46f9 (vc: separate state), vc->vc_color is known as
> vc->state.color. Somehow both me and 0-day bot missed this driver during
> the conversion.
> 
> So fix the driver now.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> ---
>  drivers/video/console/newport_con.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

You forgot the "Reported-by:" line :(

I'll go add it, thanks for the fix.

greg k-h
