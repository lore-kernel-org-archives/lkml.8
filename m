Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EE9C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDB1206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407614AbgDNRU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:20:27 -0400
Received: from foss.arm.com ([217.140.110.172]:60396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407594AbgDNRUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:20:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C014430E;
        Tue, 14 Apr 2020 10:20:23 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38E863F6C4;
        Tue, 14 Apr 2020 10:20:22 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:20:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v2 3/6] arm64/vdso: Add time napespace page
Message-ID: <20200414172014.GA6705@C02TD0UTHF1T.local>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200225073731.465270-4-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225073731.465270-4-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:37:28PM -0800, Andrei Vagin wrote:
> Allocate the time namespace page among VVAR pages.  Provide
> __arch_get_timens_vdso_data() helper for VDSO code to get the
> code-relative position of VVARs on that special page.
> 
> If a task belongs to a time namespace then the VVAR page which contains
> the system wide VDSO data is replaced with a namespace specific page
> which has the same layout as the VVAR page. That page has vdso_data->seq
> set to 1 to enforce the slow path and vdso_data->clock_mode set to
> VCLOCK_TIMENS to enforce the time namespace handling path.
> 
> The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> update of the VDSO data is in progress, is not really affecting regular
> tasks which are not part of a time namespace as the task is spin waiting
> for the update to finish and vdso_data->seq to become even again.
> 
> If a time namespace task hits that code path, it invokes the corresponding
> time getter function which retrieves the real VVAR page, reads host time
> and then adds the offset for the requested clock which is stored in the
> special VVAR page.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  arch/arm64/include/asm/vdso.h                 |  6 ++++++
>  .../include/asm/vdso/compat_gettimeofday.h    | 11 ++++++++++
>  arch/arm64/include/asm/vdso/gettimeofday.h    |  8 ++++++++
>  arch/arm64/kernel/vdso.c                      | 20 ++++++++++++++++---
>  arch/arm64/kernel/vdso/vdso.lds.S             |  5 ++++-
>  arch/arm64/kernel/vdso32/vdso.lds.S           |  5 ++++-
>  include/vdso/datapage.h                       |  1 +
>  7 files changed, 51 insertions(+), 5 deletions(-)

> +#ifdef CONFIG_TIME_NS
> +static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
> +{
> +	const struct vdso_data *ret;
> +
> +	asm volatile("mov %0, %1" : "=r"(ret) : "r"(_timens_data));
> +
> +	return ret;
> +}
> +#endif

What is this inline assembly for? The commit message doesn't mention it,
there's no explanation here, and the native version doesn't do likewise
so it seems rather surprising.

Thanks,
Mark.

> diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
> index 5a534432aa5d..553bdc19a91f 100644
> --- a/arch/arm64/include/asm/vdso/gettimeofday.h
> +++ b/arch/arm64/include/asm/vdso/gettimeofday.h
> @@ -97,6 +97,14 @@ const struct vdso_data *__arch_get_vdso_data(void)
>  	return _vdso_data;
>  }
>  
> +#ifdef CONFIG_TIME_NS
> +static __always_inline
> +const struct vdso_data *__arch_get_timens_vdso_data(void)
> +{
> +	return _timens_data;
> +}
> +#endif
