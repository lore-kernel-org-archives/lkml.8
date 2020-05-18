Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C03207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589781217;
	bh=m/pEmnnHQNzFD4ohbvLcO3u8FKFWYBLKdSWWaqCTpL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HxQl54VJsb8bsQWdB/lZQVTjAsFuq6GPmcDi/M/vGACslDNg83e0zOnk12g72kdfZ
	 8LdsuxUe7A63ggwhsVdA33lky6Z5i/YAKMpL57C49x51nOO42/D67byo+a+t9RnFwd
	 5dXnfwU5NjcdQm45aF+ABqJVB3Y9Qn3K80NaP5L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgERFxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgERFxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:53:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F05220787;
        Mon, 18 May 2020 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589781215;
        bh=m/pEmnnHQNzFD4ohbvLcO3u8FKFWYBLKdSWWaqCTpL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUeL+bduHx4Obp0B4yUCsnjsTcsxlQRgzfA45+FLMAZ5/a6x6P1PPYwn19RbJnbyZ
         YysnE5/UjscItAX3AeIiIfKe3XL3YsmF4VkoJo1FtKfGgZk03eLck98gDcjGVrKC5p
         fqOZh4YjI9qbXtJMgIpeNJ1Aaf8QnDeWhGagNns4=
Date:   Mon, 18 May 2020 07:53:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mohamed Dawod <mhm.dawod@gmail.com>
Cc:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wfx: Typo fix
Message-ID: <20200518055333.GA2826732@kroah.com>
References: <20200518054729.GA12362@dinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518054729.GA12362@dinux>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 07:47:29AM +0200, Mohamed Dawod wrote:
> Fixing some typo errors in traces.h file
> 
> Signed-off-by: Mohamed Dawod <mhm.dawod@gmail.com>
> ---
>  drivers/staging/wfx/traces.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

What changed from v1?  Always put that below the --- line.

Please fix that up and send v3.

thanks,

greg k-h
