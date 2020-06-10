Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66EFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807052072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591775924;
	bh=l5Pz+5+fBVqy4h+8oU7TpZbl8q3eqsgxiHk9A3UrlTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vbEzdEsMaZ3fqxEe9zcHUgiYXbwLVrXDLEjx4VhYPA9UGI1VcDdmmFy0ImW2MpG9d
	 hB/0F8ifnelZwhvXwCQ/hiPCQAgErcTgkJe9t1aUthPzFhPm/RRIfK7ECICqsCRG1O
	 WgIsI1wyi2mDNCHn1tXgExywqohvVeCiThplmej0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgFJH6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJH6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:58:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0220206C3;
        Wed, 10 Jun 2020 07:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591775921;
        bh=l5Pz+5+fBVqy4h+8oU7TpZbl8q3eqsgxiHk9A3UrlTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPcl4BZDzRuBHdNBgmoqY7NjYWKLVer39Rf1Q/S9Zmna+ay/ew2xJ1+/lS2IYp0no
         LfBPo/LwfalSfF9i/iT6u3TnyEb2cGvnOxLjzZhAR3YYEgmCvI4x+OgJGX2M2MxT2a
         2JFFJ/DFhLIRnce+HXSm99tY7ru2QY3Sjvtw3mOE=
Date:   Wed, 10 Jun 2020 08:58:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] efi/libstub/arm64: link stub lib.a conditionally
Message-ID: <20200610075837.GD15939@willie-the-truck>
References: <20200604022031.164207-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604022031.164207-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:20:30AM +0900, Masahiro Yamada wrote:
> Since commit 799c43415442 ("kbuild: thin archives make default for
> all archs"), core-y is passed to the linker with --whole-archive.
> Hence, the whole of stub library is linked to vmlinux.
> 
> Use libs-y so that lib.a is passed after --no-whole-archive for
> conditional linking.
> 
> The unused drivers/firmware/efi/libstub/relocate.o will be dropped
> for ARCH=arm64.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> This patch touches under arch/arm64/, but
> this is more related to efi.
> I am sending this to Ard.

Ok, I'll ignore this then. Ard -- please yell if you want me to do anything
else with it.

Will


> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 650e1185c190..48a6afa774fc 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -145,7 +145,7 @@ export	TEXT_OFFSET
>  
>  core-y		+= arch/arm64/
>  libs-y		:= arch/arm64/lib/ $(libs-y)
> -core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
> +libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  
>  # Default target when executing plain make
>  boot		:= arch/arm64/boot
> -- 
> 2.25.1
> 
