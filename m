Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136ED2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHYOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:52:05 -0400
Received: from foss.arm.com ([217.140.110.172]:60504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgHYOvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:51:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3125130E;
        Tue, 25 Aug 2020 07:51:54 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60CCC3F71F;
        Tue, 25 Aug 2020 07:51:53 -0700 (PDT)
Subject: Re: [PATCH] arm64: traps: clean up arm64_ras_serror_get_severity()
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200812110918.18575-1-zhangliguang@linux.alibaba.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f5d171fd-8fc6-cd39-1467-45ce29517f47@arm.com>
Date:   Tue, 25 Aug 2020 15:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812110918.18575-1-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

On 12/08/2020 12:09, Liguang Zhang wrote:
> Function arm64_is_fatal_ras_serror() is always called after
> arm64_is_ras_serror(), so we should remove some needless
> arm64_is_ras_serror() call in function arm64_ras_serror_get_severity().

> diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> index cee5928e1b7d..287b4d64dc67 100644
> --- a/arch/arm64/include/asm/traps.h
> +++ b/arch/arm64/include/asm/traps.h
> @@ -79,13 +79,6 @@ static inline bool arm64_is_ras_serror(u32 esr)
>   */
>  static inline u32 arm64_ras_serror_get_severity(u32 esr)
>  {
> -	u32 aet = esr & ESR_ELx_AET;
> -
> -	if (!arm64_is_ras_serror(esr)) {
> -		/* Not a RAS error, we can't interpret the ESR. */
> -		return ESR_ELx_AET_UC;
> -	}

I agree this can go, it looks like I had it here as a sanity check while the KVM bits were
sorted out.

Please also remove the comment that says it does this:
| * Non-RAS SError's are reported as Uncontained/Uncategorized.

This becomes the callers problem.


>  	/*
>  	 * AET is RES0 if 'the value returned in the DFSC field is not
>  	 * [ESR_ELx_FSC_SERROR]'

> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 13ebd5ca2070..635d4cca0a4b 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -913,7 +913,7 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
>  	case ESR_ELx_AET_UC:	/* Uncontainable or Uncategorized error */
>  	default:
>  		/* Error has been silently propagated */
> -		arm64_serror_panic(regs, esr);
> +		return true;

KVM depends on this, please don't remove it.

What does 'fatal' mean?
To the arch code it means panic(), as we don't (yet) have the information to fix the
error. But to KVM 'fatal' means kill-the-guest. KVM does this as without user-space's
involvement, there is very little else it can do.

KVM can only do this if the error is contained. As it must have been contained by stage2,
so the host can keep running. But if the error was reported as uncontained, KVM would need
to panic() the host.

(An example of an Uncontained error is a store that went to the wrong address due to
corruption that wasn't caught in time. We can't trust any value in memory once we've seen
one of these.)


I agree it looks funny, but it was simpler for the arch code helper to do this, instead of
having an 'arm64_is_uncontained_ras_serror(), as now you'd always have to check three things.


>  	}
>  }


Thanks,

James
