Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB955C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08DE20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583865198;
	bh=3SvcEl4PgZQLccLFPomo2nsihCMkUCtFc+sCwvGbkdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rp+56wOyDcu1wy6Q9EddTb2xJiXzkfVmNRfEh9c4ZRNt3PaqL3siJoHu0OuErtH5+
	 hWvvajA9i9493/XDc6juxzPcSoADnTEcjFu8JDP7T/Hq3AK6u7+VQWsAg265wj+HOz
	 yLgM38ofDcE9pPdK+zaF5wtUir/UxTQflU6A16Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgCJSdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCJSdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:33:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A0C720727;
        Tue, 10 Mar 2020 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583865196;
        bh=3SvcEl4PgZQLccLFPomo2nsihCMkUCtFc+sCwvGbkdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBO32IVf81r9mxHRvvoia2vHB0lQceqNZkDVRc1rD6+emc8p8tvhEBDB9japaOFvb
         dq9JEckmfJzUiOpqb8SZcEsITvWlpm2QTwZp4SMb3PzQmo8jLafqNhFSmOB+VIW4n5
         OsOzibvX9UxW5v3Ze8D5OQLc8R0sT8xApN2QwtAc=
Date:   Tue, 10 Mar 2020 19:33:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sladyn Nunes <sladynlinuxkernel@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] drivers: base: platform.c: Fix coding style issue.
Message-ID: <20200310183313.GB3485635@kroah.com>
References: <20200310181712.884-1-sladynlinuxkernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310181712.884-1-sladynlinuxkernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:47:12PM +0530, Sladyn Nunes wrote:
> Fixed whitespace and coding style issues in the
> document.
> 
> Signed-off-by: Sladyn Nunes <sladynlinuxkernel@gmail.com>
> ---
>  drivers/base/platform.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Also, please start with coding style issues in drivers/staging/ not
anywhere else in the kernel, you will have a much easier time there.

thanks,

greg k-h
