Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB25C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C671E2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586440044;
	bh=qb0zEt9oZjXwhGut9OGCMasSdPJZIafUHazH89S648o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G2VWJeNKJfb3E7uJU79n1LZIWM3tAn8CgsmOm/hwtNaV51v+zXwyR3JjCYn2UWj2m
	 namNH8ZDaBx7YDi51CGJmAJvCCiIvRMYT3MYH42Vu/+OASjBKI+qsSVFiRrROCc/Ha
	 5iTeqMa4FUfTPah+3ZG97imQRdApEPYIpuruFTmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgDINrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgDINrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:47:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80E022083E;
        Thu,  9 Apr 2020 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586440042;
        bh=qb0zEt9oZjXwhGut9OGCMasSdPJZIafUHazH89S648o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuzJZmyzOkjXYOGh8vDBL9dHWEU80N2DEtFKZexMz0v6eM79kJgkniryfWaidu2wD
         MT8PhAao2sv9XOSkYFdPCB3D3awBw4ZGRz8593TPA4mOyFXMyatUsqKUhyuywo73Fh
         tzjo/HViO/9QdWkv3O28bnocc8vOnKm6icwL2Ovw=
Date:   Thu, 9 Apr 2020 15:47:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] phy: tegra: fix USB dependencies
Message-ID: <20200409134718.GB1546731@kroah.com>
References: <20200408200828.124139-1-arnd@arndb.de>
 <20200409132435.GA3263479@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409132435.GA3263479@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 03:24:35PM +0200, Thierry Reding wrote:
> On Wed, Apr 08, 2020 at 10:08:14PM +0200, Arnd Bergmann wrote:
> > Without CONFIG_USB_SUPPORT, we can get a couple of warnings for
> > missing dependencies:
> > 
> > WARNING: unmet direct dependencies detected for USB_PHY
> >   Depends on [n]: USB_SUPPORT [=n]
> >   Selected by [m]:
> >   - PHY_TEGRA_XUSB [=m] && ARCH_TEGRA [=y]
> > 
> > WARNING: unmet direct dependencies detected for USB_CONN_GPIO
> >   Depends on [n]: USB_SUPPORT [=n] && GPIOLIB [=y]
> >   Selected by [m]:
> >   - PHY_TEGRA_XUSB [=m] && ARCH_TEGRA [=y]
> > 
> > Fixes: 6835bdc99580 ("phy: tegra: Select USB_PHY")
> > Fixes: f67213cee2b3 ("phy: tegra: xusb: Add usb-role-switch support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/phy/tegra/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I sent a similar patch a couple of days ago:
> 
> 	http://patchwork.ozlabs.org/patch/1263865/
> 
> This should be applied by Greg on top of the PR that I sent for USB. I
> did get the semi-automated "we're in the merge window" reply from Greg,
> but I was under the impression that he still applied fixes during the
> merge window. It seems like he didn't pick this up yet, though.
> 
> Greg, anything I should've done differently for you to notice this?

I try not to apply anything during the merge window...

