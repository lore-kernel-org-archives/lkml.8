Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD4AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0E820656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598007120;
	bh=1k7U4PSUM4yAUm0/6DoU641DVnINw25wkhL4AAswegs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ym+XkWJcReMajhqKMdlrQfIDAIxKKM/br0dC2ExI41zFx3PRmbBw6dDT2Uj+Th/wl
	 D8Uqux6ngW+b632ZMdtuEZmNVIV7oWaLWZYkkQBXVq4KdlGoWMrsghPS2d3B1qjAgz
	 wSCHymu963I2wZuu1TY6bgzS7fVwmWDfJ7pSjG3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgHUKv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgHUKvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:51:49 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DAD520656;
        Fri, 21 Aug 2020 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598007107;
        bh=1k7U4PSUM4yAUm0/6DoU641DVnINw25wkhL4AAswegs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prhbb35myOvkZwCCf8yDkGRFADHWY/m9+JW8VonHKEhgn5l1mTzsd+O2PIHaqjXq/
         5xnJ/ah7z8Pj8wuXz58f46GPqGOemmHb4VRj+ZkOj/b4p/GoeOB73IadUVpq9fFfBk
         WP8lltJ8pdoBbdrmW4PHkbnnQffGC/Y+uXurTs4I=
Date:   Fri, 21 Aug 2020 11:51:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH] ARM64: vdso32: Install vdso32 from vdso_install
Message-ID: <20200821105142.GA20455@willie-the-truck>
References: <20200818014950.42492-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818014950.42492-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 06:49:50PM -0700, Stephen Boyd wrote:
> Add the 32-bit vdso Makefile to the vdso_install rule so that 'make
> vdso_install' installs the 32-bit compat vdso when it is compiled.
> 
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Fixes: a7f71a2c8903 ("arm64: compat: Add vDSO")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/Makefile               | 1 +
>  arch/arm64/kernel/vdso32/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Will
