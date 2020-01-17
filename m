Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E38C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DC821582
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579302592;
	bh=J8G75prBE7ZkmVbsmyXdLc5j/bL81Kr7XW7AZi8Mk+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rN2uRRzihdgVe81IyqYuSKIb4OQJ8bICALpdKX/ph2B9jF1bxjvPcUii7x1eAmlzo
	 5Rn3rQKoZk9Ir2IzcS/9ooPGXC4dGfSlXhSxaZGoyd7DsJW3HnfJoa3whe5vA8TZqp
	 JotaVp3V02nDYUHDyGUdQ93ORLNsYWE913rKqqFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgAQXJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:09:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgAQXJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:09:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F143621D7D;
        Fri, 17 Jan 2020 23:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579302590;
        bh=J8G75prBE7ZkmVbsmyXdLc5j/bL81Kr7XW7AZi8Mk+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R09VTqjNYytCeyZv0hELOmpgk5udpnn7S4Dzp4SW5fm0RSgavfxNjyIfRfZ3Ipdkn
         Z0b94OtbLPAjoOFEV/gJQMJ57wOs+czLQ3OaO/r/Gt1KOuox+m4vB/YT5mohVTqn6z
         CvGTiBILqb6mguCR4jUG+aaRoelunT1Ov7QrbUlU=
Date:   Sat, 18 Jan 2020 00:09:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Hongbo Yao <yaohongbo@huawei.com>
Subject: Re: [PATCH] phy: ti: j721e-wiz: Fix build error without
 CONFIG_OF_ADDRESS
Message-ID: <20200117230948.GA2124963@kroah.com>
References: <20200117212310.2864-1-kishon@ti.com>
 <20200117230102.GB2093057@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117230102.GB2093057@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 12:01:02AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Jan 18, 2020 at 02:53:10AM +0530, Kishon Vijay Abraham I wrote:
> > From: Hongbo Yao <yaohongbo@huawei.com>
> > 
> > If CONFIG_OF_ADDRESS is not set and COMPILE_TEST=y, the following
> > error is seen while building phy-j721e-wiz.c
> > 
> > drivers/phy/ti/phy-j721e-wiz.o: In function `wiz_remove':
> > phy-j721e-wiz.c:(.text+0x1a): undefined reference to
> > `of_platform_device_destroy'
> > 
> > Fix the config dependency for PHY_J721E_WIZ here.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
> > Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  drivers/phy/ti/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Want me to just take this directly in my tree so the build error goes
> away?

Nevermind, I did :)
