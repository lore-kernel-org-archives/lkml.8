Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEFAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBC32070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596092930;
	bh=is7ibpZH5c70+mTBOL4OZ9tChpg2BoECoi0RvbkELCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RvHzQGfE9PVyFMGV1WpJucOTaUfybc36ZiXlBHV0mwNL+n852++UMr6Q5MyuHivmH
	 UvVeW7I4WHuL/Ss789KoEwf8e6qNYgjyOUoPgi6fhAJdTk5li2g8MnjL3RvACkIkkl
	 2Sf0bXhGl5tysSIi3JDnZJ9ZTvdVG/xPWXSxOB2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgG3HIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3HIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:08:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77BD22070B;
        Thu, 30 Jul 2020 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596092927;
        bh=is7ibpZH5c70+mTBOL4OZ9tChpg2BoECoi0RvbkELCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3bI5Qr8nSWppsBGUyYc1IHmaJVLyUGRCyfBHjVt9vBRMD3uOFGyNhAR1/sCOa32/
         uyHFHa5S/MXa1WZ5JvTOYiUfALz9KH9txWxxBmYHLmF7o6ULmCZN7MMRACEhtkKQ4B
         ZgmtTV0uZP00mZRuvrSCxGhM9FsnlO1cD7be/oqU=
Date:   Thu, 30 Jul 2020 09:08:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v9 0/4] driver core: add probe error check helper
Message-ID: <20200730070832.GA4045592@kroah.com>
References: <CGME20200713144331eucas1p25911c4ffa9315f632d8f6dd833588981@eucas1p2.samsung.com>
 <20200713144324.23654-1-a.hajda@samsung.com>
 <e55a23bf-59bb-43c6-f7d7-467c282b8648@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55a23bf-59bb-43c6-f7d7-467c282b8648@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 05:05:03PM +0200, Andrzej Hajda wrote:
> Hi Greg,
> 
> Apparently the patchset has no more comments.
> 
> Could you take the patches to your tree? At least 1st and 2nd.

All now queued up, thanks!

greg k-h
