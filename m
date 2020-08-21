Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14CD20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgHUKyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:54:22 -0400
Received: from foss.arm.com ([217.140.110.172]:57554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgHUKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:54:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C45E1063;
        Fri, 21 Aug 2020 03:53:51 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6B203F6CF;
        Fri, 21 Aug 2020 03:53:50 -0700 (PDT)
Subject: Re: [PATCH] ARM64: vdso32: Install vdso32 from vdso_install
To:     Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200818014950.42492-1-swboyd@chromium.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9f2a9b2b-bcb6-a719-1861-83ea8617eea6@arm.com>
Date:   Fri, 21 Aug 2020 11:56:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818014950.42492-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/20 2:49 AM, Stephen Boyd wrote:
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
>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 55bc8546d9c7..b45f0124cc16 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -165,6 +165,7 @@ zinstall install:
>  PHONY += vdso_install
>  vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
> +	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 $@
>  
>  # We use MRPROPER_FILES and CLEAN_FILES now
>  archclean:
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 5139a5f19256..d6adb4677c25 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -208,7 +208,7 @@ quiet_cmd_vdsosym = VDSOSYM $@
>        cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
>  
>  # Install commands for the unstripped file
> -quiet_cmd_vdso_install = INSTALL $@
> +quiet_cmd_vdso_install = INSTALL32 $@
>        cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/vdso32.so
>  
>  vdso.so: $(obj)/vdso.so.dbg
> 
> base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
> 

-- 
Regards,
Vincenzo
