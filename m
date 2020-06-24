Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFD3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA6A20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593001370;
	bh=llsEnXOBdDldUYmEyO0zoXemSr+7CRN/czVZ0wtPt98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X31lwW51DV66GwhbBcDKxJpEyt3WKHhZ+MMsIrxOmgaPwWsE5H6sdd0XsG9lLPm7J
	 NT8ifmE8duqwsJfdU68yvQALbbHUpauTnsNi6MCl1hRvhLMhXx7nOR6Sxv6K/AyFH2
	 Hr8qEoYYnTzoBbJ1EcYcOnTmuTYHr3zSB4UNNumI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390581AbgFXMWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390537AbgFXMWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:22:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78DE20707;
        Wed, 24 Jun 2020 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593001367;
        bh=llsEnXOBdDldUYmEyO0zoXemSr+7CRN/czVZ0wtPt98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vq8pa5speUnvVEor4+UxiuzoF0QDSc88FgivHmWNqRFNYftWS8EVzdyvfXRcVHSfq
         rkiU9Q0jRaitl6/pPya2DCCkV29BuUICj7LboiTxyoK1wm/VgjqmNbdeWytFFuIeeQ
         nTxkwhmLIxlrIEENeizswb7Q37sY1PE+GtYeJ8oY=
Date:   Wed, 24 Jun 2020 13:22:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: linux-next: Tree for Jun 24 [build failure on arm64]
Message-ID: <20200624122242.GA6270@willie-the-truck>
References: <20200624165323.3dffcde5@canb.auug.org.au>
 <7a7e31a8-9a7b-2428-ad83-2264f20bdc2d@hisilicon.com>
 <20200624105528.GB6134@willie-the-truck>
 <b561e663-a9aa-d600-e23b-09793199141e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b561e663-a9aa-d600-e23b-09793199141e@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:57:23PM +0100, Jon Hunter wrote:
> On 24/06/2020 11:55, Will Deacon wrote:
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > index 1e5a940532da..97d3d3632093 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -23,8 +23,9 @@ btildflags-$(CONFIG_ARM64_BTI_KERNEL) += -z force-bti
> >  # potential future proofing if we end up with internal calls to the exported
> >  # routines, as x86 does (see 6f121e548f83 ("x86, vdso: Reimplement vdso.so
> >  # preparation in build-time C")).
> > -ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
> > -               -Bsymbolic --no-eh-frame-hdr --build-id -n $(btildflags-y) -T
> > +ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv       \
> > +            -Bsymbolic $(call ld-option, --no-eh-frame-hdr) --build-id -n      \
> > +            $(btildflags-y) -T
> >  
> >  ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
> >  ccflags-y += -DDISABLE_BRANCH_PROFILING
> > 
> 
> 
> I am seeing the same build failure and the above does fix it for me.

Cheers, Jon. I'll get this into -next with your Tested-by.

Will
