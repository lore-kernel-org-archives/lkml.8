Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6FCC47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A50206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588676300;
	bh=kGKEaMOGdWDAoVnU3rzjWdKoL2we/jTZgg/mglaLMyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HDoebcn1G0tYvMbNqQ7oV5ygf7qGrC/f2Wb3FZPfQXOSdQHfIjZjuYT2yAGN0L2Sg
	 v8PLF2Jl1bNmGqZWKbOiQSKwj85DkHv9lpDwakNioFWAd/Vjcjquj7WV23dJZ36ukG
	 QVNUMf0t9HdKjb62w0zt5XiDXGFd7jX2ahVUtmVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgEEK6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEEK6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:58:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEDCC206A5;
        Tue,  5 May 2020 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588676298;
        bh=kGKEaMOGdWDAoVnU3rzjWdKoL2we/jTZgg/mglaLMyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=io0hVQK3c32p7zo87nJ8WEyOmN8PemqN6FZgT184MWEXddcmIC016k5WG8coHZygZ
         HnNb/gQoffmsmIVjR3DtHjQK10llOSRu3CQIKj00o0vKxbgaZlsMibJ2jN2sDRJP4s
         Uug8qmab9BvwkBuiO1MKuzZaxwfIlnN4BeguisBs=
Date:   Tue, 5 May 2020 11:58:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: Sort vendor-specific errata
Message-ID: <20200505105811.GD19710@willie-the-truck>
References: <20200416115658.20406-1-geert+renesas@glider.be>
 <20200416115658.20406-2-geert+renesas@glider.be>
 <CAK8P3a14Vk1JKRYZkkAhC9fAV4CMQzvux_FWdNkn39OwsYn4mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a14Vk1JKRYZkkAhC9fAV4CMQzvux_FWdNkn39OwsYn4mA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 03:06:55PM +0200, Arnd Bergmann wrote:
> On Thu, Apr 16, 2020 at 1:57 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > Sort configuration options for vendor-specific errata by vendor, to
> > increase uniformity.
> > Move ARM64_WORKAROUND_REPEAT_TLBI up, as it is also selected by
> > ARM64_ERRATUM_1286807.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Looks fine to me, though I wonder if we should move the errata
> menu to a separate Kconfig file, given that it's already longer than the
> Kconfig.platforms and Kconfig.debug files at 500 lines.
> 
> Maybe a Kconfig.cpu with both the "ARMv8.x architectural features" and
> errata menus?
> 
> Either way,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de

I've queued this patch as-is on for-next/kconfig [1]. Happy to take a
follow-up moving things out into Kconfig.cpu.

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/kconfig

