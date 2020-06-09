Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D3EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6923F204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgFIUfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:35:13 -0400
Received: from foss.arm.com ([217.140.110.172]:48678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgFIUfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:35:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 821121F1;
        Tue,  9 Jun 2020 13:35:07 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C8163F73D;
        Tue,  9 Jun 2020 13:35:05 -0700 (PDT)
Date:   Tue, 9 Jun 2020 21:35:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>, Stephen Boyd <swboyd@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] arm64: vdso32: add CONFIG_THUMB2_COMPAT_VDSO
Message-ID: <20200609203502.GA21214@gaia>
References: <20200528072031.GA22156@willie-the-truck>
 <20200608205711.109418-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608205711.109418-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 01:57:08PM -0700, Nick Desaulniers wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7f9d38444d6d..fe9e6b231cac 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1299,6 +1299,14 @@ config COMPAT_VDSO
>  	  You must have a 32-bit build of glibc 2.22 or later for programs
>  	  to seamlessly take advantage of this.
>  
> +config THUMB2_COMPAT_VDSO
> +	bool "Compile the vDSO in THUMB2 mode"
> +	depends on COMPAT_VDSO
> +	default y
> +	help
> +	  Compile the compat vDSO with -mthumb -fomit-frame-pointer if y, otherwise
> +	  as -marm.

Now that we understood the issue (I think), do we actually need this
choice? Why not going for -mthumb -fomit-frame-pointer always for the
compat vdso?

-- 
Catalin
