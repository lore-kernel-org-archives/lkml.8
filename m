Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89B7C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C434020735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588695655;
	bh=0cAfX6WAuzHeQRYxpczQiT++Fzbit2iwi8QK7XTC5TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=daCE2lK4yM+0BZPsnShEfi0JWsM5X4HWV4Bl99LA0lX9MbAtN8IHwyeCUY4XUGGm8
	 Ga9Q9x3SoSjfDB4rdSrjwsyJSWQE5A5T8WdPheBO2Sw3hzWkxgx0v5EW6IQ1vDk1d8
	 bJ7ULMik0UgwGQ2e+7M7HZwD10VVNhp4RhAFuzjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgEEQUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgEEQUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:20:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F2E5206B9;
        Tue,  5 May 2020 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588695654;
        bh=0cAfX6WAuzHeQRYxpczQiT++Fzbit2iwi8QK7XTC5TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9CCkizEL0lBpe1KWV+w47OsscV8cueE55ygq0Ywj2NxIph5+eabCVMEQk836jWCL
         ZStezxZkpcSlEcUnp/g7sQ/SyNn8N8+5dGnOa2CvCxK9ecpr9ieyZnbnsPK8oSG9OX
         b5ER6U+oRcelUpsKYP9XXAobt9R49asLpvM0zrSI=
Date:   Tue, 5 May 2020 17:20:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
Subject: Re: [PATCH v2 5/5] arm/arm64: smccc: Add ARCH_SOC_ID support
Message-ID: <20200505162049.GG24239@willie-the-truck>
References: <20200504092905.10580-1-sudeep.holla@arm.com>
 <20200504092905.10580-6-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504092905.10580-6-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 10:29:05AM +0100, Sudeep Holla wrote:
> diff --git a/drivers/firmware/psci/soc_id.c b/drivers/firmware/psci/soc_id.c
> new file mode 100644
> index 000000000000..b45f2d78e12e
> --- /dev/null
> +++ b/drivers/firmware/psci/soc_id.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2020 Arm Limited
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +#define SMCCC_SOC_ID_JEP106_BANK_IDX_MASK	GENMASK(30, 24)
> +/*
> + * As per the spec bits[23:16] are JEP-106 identification code with parity bit
> + * for the SiP. We can drop the parity bit.
> + */

Which spec? Could you link to the doc and section here, please?

Will
