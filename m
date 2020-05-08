Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A2C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524C621473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEHPTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:19:23 -0400
Received: from muru.com ([72.249.23.125]:53598 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgEHPTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:19:23 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0CA3C806C;
        Fri,  8 May 2020 15:20:11 +0000 (UTC)
Date:   Fri, 8 May 2020 08:19:20 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: linux-next: Fixes tags need some work in the omap tree
Message-ID: <20200508151920.GY37466@atomide.com>
References: <20200508085320.58da9ffa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508085320.58da9ffa@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [200507 22:54]:
> Hi all,
> 
> In commit
> 
>   0f84d0247722 ("ARM: dts: am437x: fix networking on boards with ksz9031 phy")
> 
> Fixes tag
> 
>   Fixes: commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected
> 
> In commit
> 
>   3a78c16f67a0 ("ARM: dts: am57xx: fix networking on boards with ksz9031 phy")
> 
> Fixes tag
> 
>   Fixes: commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected

Thanks for catching these, I'll fix them.

Regards,

Tony


