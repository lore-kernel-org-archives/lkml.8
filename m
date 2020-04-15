Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F9EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CEA206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408323AbgDOJKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:10:24 -0400
Received: from foss.arm.com ([217.140.110.172]:40314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408295AbgDOJKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:10:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E5B91063;
        Wed, 15 Apr 2020 02:10:12 -0700 (PDT)
Received: from [192.168.1.172] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04533F68F;
        Wed, 15 Apr 2020 02:10:09 -0700 (PDT)
Subject: Re: [PATCH 04/15] tools headers: Update linux/vdso.h and grab a copy
 of vdso/const.h
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20200414164854.26026-1-acme@kernel.org>
 <20200414164854.26026-5-acme@kernel.org>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <56641c66-3fce-6fcc-1436-454e83c9c959@arm.com>
Date:   Wed, 15 Apr 2020 10:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200414164854.26026-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/20 5:48 PM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get in line with:
> 
>   8165b57bca21 ("linux/const.h: Extract common header for vDSO")
> 
> And silence this tools/perf/ build warning:
> 
>   Warning: Kernel ABI header at 'tools/include/linux/const.h' differs from latest version at 'include/linux/const.h'
>   diff -u tools/include/linux/const.h include/linux/const.h
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  tools/include/linux/const.h |  5 +----
>  tools/include/vdso/const.h  | 10 ++++++++++
>  tools/perf/check-headers.sh |  1 +
>  3 files changed, 12 insertions(+), 4 deletions(-)
>  create mode 100644 tools/include/vdso/const.h
> 
> diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
> index 7b55a55f5911..81b8aae5a855 100644
> --- a/tools/include/linux/const.h
> +++ b/tools/include/linux/const.h
> @@ -1,9 +1,6 @@
>  #ifndef _LINUX_CONST_H
>  #define _LINUX_CONST_H
>  
> -#include <uapi/linux/const.h>
> -
> -#define UL(x)		(_UL(x))
> -#define ULL(x)		(_ULL(x))
> +#include <vdso/const.h>
>  
>  #endif /* _LINUX_CONST_H */
> diff --git a/tools/include/vdso/const.h b/tools/include/vdso/const.h
> new file mode 100644
> index 000000000000..94b385ad438d
> --- /dev/null
> +++ b/tools/include/vdso/const.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __VDSO_CONST_H
> +#define __VDSO_CONST_H
> +
> +#include <uapi/linux/const.h>
> +
> +#define UL(x)		(_UL(x))
> +#define ULL(x)		(_ULL(x))
> +
> +#endif /* __VDSO_CONST_H */
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index bfb21d049e6c..c905c683606a 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -23,6 +23,7 @@ include/uapi/linux/vhost.h
>  include/uapi/sound/asound.h
>  include/linux/bits.h
>  include/linux/const.h
> +include/vdso/const.h
>  include/linux/hash.h
>  include/uapi/linux/hw_breakpoint.h
>  arch/x86/include/asm/disabled-features.h
> 

-- 
Regards,
Vincenzo
