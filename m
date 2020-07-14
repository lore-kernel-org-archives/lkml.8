Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE21C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C5622365
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGNNnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:43:42 -0400
Received: from foss.arm.com ([217.140.110.172]:57406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgGNNnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:43:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F0761FB;
        Tue, 14 Jul 2020 06:43:41 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.2.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F35C33F68F;
        Tue, 14 Jul 2020 06:43:39 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:43:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>, will@kernel.org
Cc:     maz@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: arch_timer: Replace HTTP links with HTTPS ones
Message-ID: <20200714134337.GB67386@C02TD0UTHF1T.local>
References: <20200713100359.33063-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713100359.33063-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 12:03:59PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.

[...]

> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 9f0ec21d6327..c395b17eead4 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -172,7 +172,7 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
>   * This insanity brought to you by speculative system register reads,
>   * out-of-order memory accesses, sequence locks and Thomas Gleixner.
>   *
> - * http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/631195.html
> + * https://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/631195.html

This link is dead, and I'd rather replace it with a (HTTPS)
lore.kernel.org link.

IIUC that's:

https://lore.kernel.org/r/alpine.DEB.2.21.1902081950260.1662@nanos.tec.linutronix.de

... later referred to in the sub-thread:

https://lore.kernel.org/linux-arm-kernel/20190213170413.GE6346@brain-police/

Will, does that look right to you?

Mark.
