Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60B8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C94120775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgFZEpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZEpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:45:54 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5225AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:45:54 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPTX1xB3z9sT6; Fri, 26 Jun 2020 14:45:51 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     benh@kernel.crashing.org, paulus@samba.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200611224220.25066-1-chris.packham@alliedtelesis.co.nz>
References: <20200611224220.25066-1-chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v3 0/2] powerpc: CMDLINE config cleanup
Message-Id: <159314672616.1150869.14723126983856405829.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:45:51 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 10:42:18 +1200, Chris Packham wrote:
> This series cleans up the config options related to the boot command line.
> 
> Chris Packham (2):
>   powerpc: Remove inaccessible CMDLINE default
>   powerpc: configs: remove CMDLINE_BOOL
> 
>  arch/powerpc/Kconfig                           | 6 +-----
>  arch/powerpc/configs/44x/akebono_defconfig     | 2 --
>  arch/powerpc/configs/44x/arches_defconfig      | 2 --
>  arch/powerpc/configs/44x/bamboo_defconfig      | 2 --
>  arch/powerpc/configs/44x/bluestone_defconfig   | 2 --
>  arch/powerpc/configs/44x/canyonlands_defconfig | 2 --
>  arch/powerpc/configs/44x/currituck_defconfig   | 2 --
>  arch/powerpc/configs/44x/eiger_defconfig       | 2 --
>  arch/powerpc/configs/44x/fsp2_defconfig        | 1 -
>  arch/powerpc/configs/44x/icon_defconfig        | 2 --
>  arch/powerpc/configs/44x/iss476-smp_defconfig  | 1 -
>  arch/powerpc/configs/44x/katmai_defconfig      | 2 --
>  arch/powerpc/configs/44x/rainier_defconfig     | 2 --
>  arch/powerpc/configs/44x/redwood_defconfig     | 2 --
>  arch/powerpc/configs/44x/sam440ep_defconfig    | 2 --
>  arch/powerpc/configs/44x/sequoia_defconfig     | 2 --
>  arch/powerpc/configs/44x/taishan_defconfig     | 2 --
>  arch/powerpc/configs/44x/warp_defconfig        | 1 -
>  arch/powerpc/configs/holly_defconfig           | 1 -
>  arch/powerpc/configs/mvme5100_defconfig        | 3 +--
>  arch/powerpc/configs/ps3_defconfig             | 2 --
>  arch/powerpc/configs/skiroot_defconfig         | 1 -
>  arch/powerpc/configs/storcenter_defconfig      | 1 -
>  23 files changed, 2 insertions(+), 43 deletions(-)

Applied to powerpc/next.

[1/2] powerpc: Remove inaccessible CMDLINE default
      https://git.kernel.org/powerpc/c/f134a7cef1d7de45fab028a945b7f34c615718e1
[2/2] powerpc/configs: Remove CMDLINE_BOOL
      https://git.kernel.org/powerpc/c/0488d32530ecff973c40f2592a6eab2907d0a5cc

cheers
