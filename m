Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24867207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgE0LhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:37:07 -0400
Received: from foss.arm.com ([217.140.110.172]:36518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgE0LhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:37:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F4BE55D;
        Wed, 27 May 2020 04:37:06 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F6CD3F305;
        Wed, 27 May 2020 04:37:05 -0700 (PDT)
Date:   Wed, 27 May 2020 12:37:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        mark.rutland@arm.com, suzuki.poulose@arm.com,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
Message-ID: <20200527113703.GD28101@gaia>
References: <1590573876-19120-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590573876-19120-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:34:36PM +0530, Anshuman Khandual wrote:
> +/*
> + * get_arm64_ftr_reg - Looks up a feature register entry using
> + * its sys_reg() encoding. This calls get_arm64_ftr_reg_nowarn().
> + *
> + * returns - Upon success,  matching ftr_reg entry for id.
> + *         - NULL on failure but with an WARN_ON().
> + */
> +static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
> +{
> +	struct arm64_ftr_reg *reg;
> +
> +	reg = get_arm64_ftr_reg_nowarn(sys_id);
> +
> +	/*
> +	 * Can not really proceed when the search fails here.
> +	 * Requesting for a non existent register search will
> +	 * be an error. Warn but let it continue for now.
> +	 */
> +	WARN_ON(!reg);
> +	return reg;

I find the comment here slightly confusing: cannot proceed but continue.
Maybe something like:

	/*
	 * Requesting a non-existent register search is an error. Warn
	 * and let the caller handle it.
	 */

Otherwise it looks fine:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
