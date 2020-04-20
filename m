Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18853C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A6720735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgDTLQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:16:29 -0400
Received: from foss.arm.com ([217.140.110.172]:46636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTLQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:16:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47D001FB;
        Mon, 20 Apr 2020 04:16:28 -0700 (PDT)
Received: from [10.37.8.239] (unknown [10.37.8.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012443F237;
        Mon, 20 Apr 2020 04:16:26 -0700 (PDT)
Subject: Re: [PATCH] vdso/datapage: use correct clock mode name in comment
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
References: <20200420100615.1549804-1-christian.brauner@ubuntu.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <240095f3-a6f8-5815-1b5d-2c0a639b3525@arm.com>
Date:   Mon, 20 Apr 2020 12:17:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420100615.1549804-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 11:06 AM, Christian Brauner wrote:
> While the explanation for time namespace <-> vdso interactions is very
> helpful it uses the wrong name in the comment when describing the clock
> mode making grepping a bit annoying.
> 
> This seems like an accidental oversight when moving from VCLOCK_TIMENS
> to VDSO_CLOCKMODE_TIMENS. It seems that
> 660fd04f9317 ("lib/vdso: Prepare for time namespace support") misspelled
> VCLOCK_TIMENS as VLOCK_TIMENS which explains why it got missed when
> VCLOCK_TIMENS became VDSO_CLOCKMODE_TIMENS in
> 2d6b01bd88cc ("lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes").
> 
> Update the commit to use VDSO_CLOCKMODE_TIMENS.
>

Probably you want to add that this patch adds no functional changes, just to
make it explicit.
Otherwise:

Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Fixes: 660fd04f9317 ("lib/vdso: Prepare for time namespace support")
> Fixes: 2d6b01bd88cc ("lib/vdso: Move VCLOCK_TIMENS to vdso_clock_modes")
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  include/vdso/datapage.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index 5cbc9fcbfd45..7955c56d6b3c 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -73,8 +73,8 @@ struct vdso_timestamp {
>   *
>   * @offset is used by the special time namespace VVAR pages which are
>   * installed instead of the real VVAR page. These namespace pages must set
> - * @seq to 1 and @clock_mode to VLOCK_TIMENS to force the code into the
> - * time namespace slow path. The namespace aware functions retrieve the
> + * @seq to 1 and @clock_mode to VDSO_CLOCKMODE_TIMENS to force the code into
> + * the time namespace slow path. The namespace aware functions retrieve the
>   * real system wide VVAR page, read host time and add the per clock offset.
>   * For clocks which are not affected by time namespace adjustment the
>   * offset must be zero.
> 
> base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
> 

-- 
Regards,
Vincenzo
