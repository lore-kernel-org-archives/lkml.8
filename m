Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3327EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03601207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgETMBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:01:15 -0400
Received: from foss.arm.com ([217.140.110.172]:54448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgETMBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:01:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1560730E;
        Wed, 20 May 2020 05:01:14 -0700 (PDT)
Received: from [10.37.8.50] (unknown [10.37.8.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F8003F52E;
        Wed, 20 May 2020 05:01:12 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] arm64: add the time namespace support
To:     Andrei Vagin <avagin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
References: <20200416052618.804515-1-avagin@gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <08e3ee73-8048-b84e-61b3-e87f3500e022@arm.com>
Date:   Wed, 20 May 2020 13:02:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416052618.804515-1-avagin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrei,

On 4/16/20 6:26 AM, Andrei Vagin wrote:
> Allocate the time namespace page among VVAR pages and add the logic
> to handle faults on VVAR properly.
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
> v2: Code cleanups suggested by Vincenzo.
> v3: use OPTIMIZER_HIDE_VAR() instead of inline assembly in
>     __arch_get_timens_vdso_data.
> 

Nit: If you re-post, I would remove the OPTIMIZER_HIDE_VAR() reference because
it does not reflect the current status of the patches.

I tested it again with your latest change in the test code and it works for me
(thank you for sending a patch for the test as well).

With this:

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dmitry Safonov <dima@arista.com>
> 
> v3 on github (if someone prefers `git pull` to `git am`):
> https://github.com/avagin/linux-task-diag/tree/arm64/timens-v3
> 
> Andrei Vagin (6):
>   arm64/vdso: use the fault callback to map vvar pages
>   arm64/vdso: Zap vvar pages when switching to a time namespace
>   arm64/vdso: Add time napespace page
>   arm64/vdso: Handle faults on timens page
>   arm64/vdso: Restrict splitting VVAR VMA
>   arm64: enable time namespace support
> 
>  arch/arm64/Kconfig                            |   1 +
>  .../include/asm/vdso/compat_gettimeofday.h    |  11 ++
>  arch/arm64/include/asm/vdso/gettimeofday.h    |   8 ++
>  arch/arm64/kernel/vdso.c                      | 134 ++++++++++++++++--
>  arch/arm64/kernel/vdso/vdso.lds.S             |   3 +-
>  arch/arm64/kernel/vdso32/vdso.lds.S           |   3 +-
>  include/vdso/datapage.h                       |   1 +
>  7 files changed, 147 insertions(+), 14 deletions(-)
> 

-- 
Regards,
Vincenzo
