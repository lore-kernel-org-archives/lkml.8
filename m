Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10680C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D720C206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584047730;
	bh=ccRwF32HhslBrkGGDOXUK8qvOUyLzLxr8tzfObRY5mc=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=GN+P4by33ydTAmKpihhJkKF0raOauw2jE4qkCiOGC7bScsOxED8CoZ0SqsfL3JAiC
	 iX8pZTvlTRkjYB8npWgqGCjcBfPPIIHrulwAY/nFVoCJXh8QrJ1ZnsYC8B2TqZcB7L
	 SCtK/B2TBij2UIe+947CbBNctnyhFCKO6P1hNS04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCLVP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgCLVP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:15:29 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C4F1206B7;
        Thu, 12 Mar 2020 21:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584047728;
        bh=ccRwF32HhslBrkGGDOXUK8qvOUyLzLxr8tzfObRY5mc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=pVZohXdY8ZM//YXY0/tKkWezoBiKOpsXJWqkU6Jm7b+hHfquUcMVyG1FIadSzhVxO
         lAGiLX7orcIq/1o9OyW8AVrtsm+/kY4VEr3RuGLMCz9pcW7opFaTCbCIlLk6y7Z/NO
         gIr42rHmixMkKKg7Ie7gaxn2VL/7RtP95b1U+vLQ=
Received: by pali.im (Postfix)
        id 7DC70896; Thu, 12 Mar 2020 22:15:26 +0100 (CET)
Date:   Thu, 12 Mar 2020 22:15:26 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change email address for Pali =?utf-8?B?Um9ow6Fy?=
Message-ID: <20200312211526.oahg6mdbvkxlkezi@pali>
References: <20200307104237.8199-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200307104237.8199-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 March 2020 11:42:37 Pali Rohár wrote:
> For security reasons I stopped using gmail account and kernel address is
> now up-to-date alias to my personal address.
> 
> People periodically send me emails to address which they found in source
> code of drivers, so this change reflects state where people can contact me.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---

Greg, could you or someone else help me where to (re)send this patch?
MAINTAINERS file does not specify who is maintainer of MAINTAINERS file
itself and scripts/get_maintainer.pl did not help me too. Main entry is
LKML list.

As this change is across more subsystems I do not know who can take such
patch and I do not thing it make sense to split such change into more
patches (one for each subsystem).

>  .../ABI/testing/sysfs-platform-dell-laptop       |  8 ++++----
>  MAINTAINERS                                      | 16 ++++++++--------
>  arch/arm/mach-omap2/omap-secure.c                |  2 +-
>  arch/arm/mach-omap2/omap-secure.h                |  2 +-
>  arch/arm/mach-omap2/omap-smc.S                   |  2 +-
>  drivers/char/hw_random/omap3-rom-rng.c           |  4 ++--
>  drivers/hwmon/dell-smm-hwmon.c                   |  4 ++--
>  drivers/platform/x86/dell-laptop.c               |  4 ++--
>  drivers/platform/x86/dell-rbtn.c                 |  4 ++--
>  drivers/platform/x86/dell-rbtn.h                 |  2 +-
>  drivers/platform/x86/dell-smbios-base.c          |  4 ++--
>  drivers/platform/x86/dell-smbios-smm.c           |  2 +-
>  drivers/platform/x86/dell-smbios.h               |  2 +-
>  drivers/platform/x86/dell-smo8800.c              |  2 +-
>  drivers/platform/x86/dell-wmi.c                  |  4 ++--
>  drivers/power/supply/bq2415x_charger.c           |  4 ++--
>  drivers/power/supply/bq27xxx_battery.c           |  2 +-
>  drivers/power/supply/isp1704_charger.c           |  2 +-
>  drivers/power/supply/rx51_battery.c              |  4 ++--
>  fs/udf/ecma_167.h                                |  2 +-
>  fs/udf/osta_udf.h                                |  2 +-
>  include/linux/power/bq2415x_charger.h            |  2 +-
>  tools/laptop/freefall/freefall.c                 |  2 +-
>  23 files changed, 41 insertions(+), 41 deletions(-)
