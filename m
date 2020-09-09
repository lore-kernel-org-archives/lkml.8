Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4B0C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DDEA21532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599672071;
	bh=Ucg/VGBbh9jVN1vdrF37GPG3g7nBAbka0slS9uXk/vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CPZmt4aobKYzNX7o5uIsNZoAvxCoUD4EQfeMppcFYVFYmhqt9LJfJ64KrFqkMe0Tl
	 Yb1mScAgd0o+vL1A/yBgEu/ocx0N+LmFi2oThtUpM3Pv4VnL8ETVLCQIMBYub/qBr9
	 tteKyBQJ4aLzGSAko+MDtuSkn236Ce5A/ISwmQJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgIIPZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgIIPYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:24:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A03321941;
        Wed,  9 Sep 2020 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599664938;
        bh=Ucg/VGBbh9jVN1vdrF37GPG3g7nBAbka0slS9uXk/vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiGIWoUn3rIWwcR41W9+pP3V3CcF4KmVOL+XP8KZQoiVkzIZ5XGGbniZz28510v3B
         B3WRU3zxaFuEDN2h8/+d9LO/blRBV1zdNL8eISdUBKThQ2uHz5VYdFUaIjtG7t9+Z0
         sexPSntTstShuAERv9SiklWxV3YDnxQ1ls5yHEFw=
Date:   Wed, 9 Sep 2020 17:22:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Igor Russkikh <irusskikh@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH 0/5 REBASED to v5.9-rc4] Qlogic drivers: Convert to
 SPDX license identifiers
Message-ID: <20200909152228.GD691964@kroah.com>
References: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
 <e5688d4c-f512-6705-6bb1-db832828fb35@marvell.com>
 <DM6PR18MB305266178BB9982CBDF05319AF260@DM6PR18MB3052.namprd18.prod.outlook.com>
 <alpine.DEB.2.21.2009091126290.5622@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2009091126290.5622@felia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 11:36:44AM +0200, Lukas Bulwahn wrote:
> 
> 
> On Wed, 9 Sep 2020, Nilesh Javali wrote:
> 
> > Lukas,
> > 
> > I have Acked for the storage drivers and opt for option B below for spdx maintainers to pick.
> >
> 
> Thomas, Greg,
> 
> We got everything straightened out with Igor and Nilesh.
> 
> Can you pick this patchset with Igor's and Nilesh's Acked-bys into the 
> spdx tree and forward it to Linus?

Yes, I will do so, thanks.

greg k-h
