Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF06BC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B963C221E7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIKP2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgIKPZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:25:30 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6128A22268;
        Fri, 11 Sep 2020 14:06:07 +0000 (UTC)
Date:   Fri, 11 Sep 2020 15:06:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/hotplug: Improve memory offline event notifier
Message-ID: <20200911140603.GB12835@gaia>
References: <1598241869-28416-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598241869-28416-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Mon, Aug 24, 2020 at 09:34:29AM +0530, Anshuman Khandual wrote:
> This brings about three different changes to the sole memory event notifier
> for arm64 platform and improves it's robustness while also enhancing debug
> capabilities during potential memory offlining error conditions.
> 
> This moves the memory notifier registration bit earlier in the boot process
> from device_initcall() to setup_arch() which will help in guarding against
> potential early boot memory offline requests.
> 
> This enables MEM_OFFLINE memory event handling. It will help intercept any
> possible error condition such as if boot memory some how still got offlined
> even after an expilicit notifier failure, potentially by a future change in
> generic hotplug framework. This would help detect such scenarious and help
> debug further.
> 
> It also adds a validation function which scans entire boot memory and makes
> sure that early memory sections are online. This check is essential for the
> memory notifier to work properly as it cannot prevent boot memory offlining
> if they are not online to begin with. But this additional sanity check is
> enabled only with DEBUG_VM.

Could you please split this in separate patches rather than having a
single one doing three somewhat related things?

> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -376,6 +376,14 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  			"This indicates a broken bootloader or old kernel\n",
>  			boot_args[1], boot_args[2], boot_args[3]);
>  	}
> +
> +	/*
> +	 * Register the memory notifier which will prevent boot
> +	 * memory offlining requests - early enough. But there
> +	 * should not be any actual offlinig request till memory
> +	 * block devices are initialized with memory_dev_init().
> +	 */
> +	memory_hotremove_notifier();

Why can this not be an early_initcall()? As you said, memory_dev_init()
is called much later, after the SMP was initialised.

You could even combine this with validate_bootmem_online_state() in a
single early_initcall() which, after checking, registers the notifier.

-- 
Catalin
