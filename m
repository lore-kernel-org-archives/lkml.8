Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D34DC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16031221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIKQmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgIKPKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:10:04 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D4522266;
        Fri, 11 Sep 2020 14:40:34 +0000 (UTC)
Date:   Fri, 11 Sep 2020 15:40:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     will@kernel.org, sudeep.holla@arm.com, morten.rasmussen@arm.com,
        valentin.schneider@arm.com, souvik.chakravarty@arm.com,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: implement CPPC FFH support using AMUs
Message-ID: <20200911144032.GC12835@gaia>
References: <20200826130309.28027-1-ionela.voinescu@arm.com>
 <20200826130309.28027-5-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826130309.28027-5-ionela.voinescu@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 02:03:09PM +0100, Ionela Voinescu wrote:
> +/*
> + * Refer to drivers/acpi/cppc_acpi.c for the description of the functions
> + * below.
> + */
> +bool cpc_ffh_supported(void)
> +{
> +	const struct cpumask *cnt_cpu_mask = cpus_with_amu_counters();
> +	int cpu = nr_cpu_ids;
> +
> +	if (cnt_cpu_mask)
> +		cpu = cpumask_any_and(cnt_cpu_mask, cpu_present_mask);
> +
> +	if ((cpu >= nr_cpu_ids) || !freq_counters_valid(cpu))
> +		return false;
> +
> +	return true;
> +}

IIUC, the only need for the cpumask is this function, the others would
have worked just fine with the existing cpu_has_amu_feat(). So you have
a lot more !cnt_cpu_mask checks now.

I wonder whether instead you could add a new function near
cpu_has_amu_feat(), something like get_cpu_with_amu_feat() and do the
cpumask_any_and() in there.

-- 
Catalin
