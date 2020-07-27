Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE676C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BB92075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595843722;
	bh=urwdv9j9aZxm9yC48fvVH4Ln/hMjaLnoAMYUax2VmtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y+g9CGZ5FGeewiGjpKaSjZPvC4vyzGWZNfXNEHmfTW5tF7ji2B9bXwNRK23hp7cFy
	 VUIdggOouh14lZgyqRq7SEzbKUDpaDHm7IkYWX7RA7mb7ntyrMhRYvsfdoE2pkrfvI
	 g/K+ys2I0fROeVXNMt+eEX8pAKTakjsmxgxyKG0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgG0JzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0JzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:55:20 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9B92075D;
        Mon, 27 Jul 2020 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595843719;
        bh=urwdv9j9aZxm9yC48fvVH4Ln/hMjaLnoAMYUax2VmtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bt4R+NfqantUvxsvkWwOMaIhWn7H98Y6a08+SzJ/sgme2YPVupE+YVDeGrmVY1Y0G
         u2Ryj+JqH6OcdTo2Ba8mgDj8Zngak384PTmh5O7CfBV3DH7Y7JM6u/QHLM7MKv6827
         j37Cp+Cw1y7KSEBat1scAfFISX1iRVTTEfWenVK4=
Date:   Mon, 27 Jul 2020 15:25:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Swapnil Jakhade <sjakhade@cadence.com>, kishon@ti.com,
        linux-kernel@vger.kernel.org, maxime@cerno.tech,
        mparab@cadence.com, yamonkar@cadence.com, tomi.valkeinen@ti.com,
        jsarha@ti.com, praneeth@ti.com
Subject: Re: [PATCH v4 0/2] Add new PHY APIs to framework to get/set PHY
 attributes
Message-ID: <20200727095515.GX12965@vkoul-mobl>
References: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
 <f1f2cdca-99a1-2bcc-6fe2-9ce95553a7cd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f2cdca-99a1-2bcc-6fe2-9ce95553a7cd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sekhar,

On 26-07-20, 01:24, Sekhar Nori wrote:
> Hi Vinod,
> 
> On 7/17/20 12:20 PM, Swapnil Jakhade wrote:
> > This patch series adds a new pair of PHY APIs that can be used to get/set
> > all the PHY attributes. It also adds a new PHY attribute max_link_rate.
> > 
> > It includes following patches:
> > 
> > 1. v4-0001-phy-Add-new-PHY-attribute-max_link_rate-and-APIs-.patch
> > This patch adds max_link_rate as a new PHY attribute along with a pair of
> > APIs that allow using the generic PHY subsystem to get/set PHY attributes
> > supported by the PHY.
> > 
> > 2. v4-0002-phy-cadence-torrent-Use-kernel-PHY-API-to-set-PHY.patch
> > This patch uses PHY API phy_set_attrs() to set corresponding PHY properties
> > in Cadence Torrent PHY driver. This will enable drivers using this PHY to
> > read these properties using PHY framework.
> > 
> > The phy_get_attrs() API will be used in the DRM bridge driver [1] which is
> > in the process of upstreaming.
> 
> Is it possible to queue these for v5.9 also? I did notice that phy
> updates for v5.9-rc1 are posted already. But these APIs are needed for
> the DisplayPort driver thats getting ready for merge too. Having these
> queued now will make managing dependencies much easier.

I would prefer if we defer core change to post rc1. For your display, we
can provide a signed tag for you/drm folks to fetch.

Would that be okay?

Thanks
-- 
~Vinod
