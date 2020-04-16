Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6892C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF515208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633052AbgDPLa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:30:59 -0400
Received: from foss.arm.com ([217.140.110.172]:58956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506191AbgDPLJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:09:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB356C14;
        Thu, 16 Apr 2020 03:45:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D08083F73D;
        Thu, 16 Apr 2020 03:45:29 -0700 (PDT)
Date:   Thu, 16 Apr 2020 11:45:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 3/6] arm64/vdso: Add time napespace page
Message-ID: <20200416104527.GD4987@lakrids.cambridge.arm.com>
References: <20200416052618.804515-1-avagin@gmail.com>
 <20200416052618.804515-4-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416052618.804515-4-avagin@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On Wed, Apr 15, 2020 at 10:26:15PM -0700, Andrei Vagin wrote:
> diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> index 07468428fd29..351c145d3808 100644
> --- a/arch/arm64/include/asm/vdso.h
> +++ b/arch/arm64/include/asm/vdso.h
> @@ -12,6 +12,12 @@
>   */
>  #define VDSO_LBASE	0x0
>  
> +#ifdef CONFIG_TIME_NS
> +#define __VVAR_PAGES    2
> +#else
> +#define __VVAR_PAGES    1
> +#endif
> +
>  #ifndef __ASSEMBLY__
  
> +#ifdef CONFIG_TIME_NS
> +static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
> +{
> +	const struct vdso_data *ret;
> +
> +	ret = _timens_data;
> +	OPTIMIZER_HIDE_VAR(ret);
> +
> +	return ret;
> +}
> +#endif

Sorry for the confusion here, but please either:

* Add a preparatory patch making __arch_get_vdso_data() use
  OPTIMIZER_HIDE_VAR(), and use OPTIMIZER_HIDE_VAR() here.

* Use the same assembly as __arch_get_vdso_data() currently does.

... and either way add a comment here:

	/* See __arch_get_vdso_data() */

... so taht the rationale is obvious.

[...]

> +enum vvar_pages {
> +	VVAR_DATA_PAGE_OFFSET = 0,
> +#ifdef CONFIG_TIME_NS
> +	VVAR_TIMENS_PAGE_OFFSET = 1,
> +#endif /* CONFIG_TIME_NS */
> +	VVAR_NR_PAGES = __VVAR_PAGES,
> +};

Pet peeve, but we don't need the initializers here, as enums start from
zero. The last element shouldn't have a trailing comma as we don't
expect to add elements after it in future.

Rather than assigning to VVAR_NR_PAGES, it'd be better to use a
BUILD_BUG_ON() to verify that it is the number we expect:

enum vvar_pages {
	VVAR_DATA_PAGE,
#ifdef CONFIG_TIME_NS
	VVAR_TIMENS_PAGE,
#endif
	VVAR_NR_PAGES
};

BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);

Thanks,
Mark.
