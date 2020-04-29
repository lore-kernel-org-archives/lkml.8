Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D380C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDB620BED
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588195581;
	bh=MaCkXnxZeesUHYpyP7Lu3SfMr1AsQhB6Xpct+XkQlHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MaaA0LdOE+0RPwziuEWebhdfFKIVHj4XcGqbOmK92srcyS3dfhR5GXm5PXNMzf15p
	 LFRZ/Xee+RF7lEBhz/Ya4xWFP4XYQJH2Oktn6H9uqudG8JE2nWxZnO1jslyki2qvso
	 XNoEQroBcTm+lWpCjnvTHVejfCRKyczZ7BsRp/FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgD2V0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgD2V0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:26:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308092073E;
        Wed, 29 Apr 2020 21:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588195579;
        bh=MaCkXnxZeesUHYpyP7Lu3SfMr1AsQhB6Xpct+XkQlHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wg6NBLr2LtkWbzxJYrDsfKqukVBwgLUfEJKVdEL0kjfpwdZ+k4QFReJsRr4NSLlOw
         nUQQq0i8zZ4EMboEDkYuWrzMT30K1TAanS76Bu+dqqte5yH4qxZqvKzwFeP7TN13BG
         3x6WHb1IJb6kCS3Nlc97pghn74qI1UnoR9H8TleE=
Date:   Wed, 29 Apr 2020 22:26:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, maz@kernel.org, suzuki.poulose@arm.com,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/16] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1,
 ID_MMFR5 and other changes
Message-ID: <20200429212614.GD8604@willie-the-truck>
References: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
 <6749304e-8a4d-f4b9-eb40-91f0dd13166e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6749304e-8a4d-f4b9-eb40-91f0dd13166e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Wed, Apr 29, 2020 at 03:07:15PM +0530, Anshuman Khandual wrote:
> On 04/14/2020 03:18 PM, Anshuman Khandual wrote:
> > This series is primarily motivated from an adhoc list from Mark Rutland
> > during our previous ID_ISAR6 discussion [1]. The current proposal also
> > accommodates some more suggestions from Will and Suzuki.
> > 
> > This series adds missing 32 bit system registers (ID_PFR2, ID_DFR1 and
> > ID_MMFR5), adds missing features bits on all existing system registers
> > (32 and 64 bit) and some other miscellaneous changes. While here it also
> > includes a patch which does macro replacement for various open bits shift
> > encodings for various CPU ID registers. There is a slight re-order of the
> > patches here as compared to the previous version (V1).
> > 
> > This series is based on v5.7-rc1. All feature bits enabled here can be
> > referred in ARM DDI 0487F.a specification. Though I have tried to select
> > appropriate values for each new feature being added here, there might be
> > some inconsistencies (or mistakes). In which case, please do let me know
> > if anything needs to change. Thank you.
> > 
> > [1] https://patchwork.kernel.org/patch/11287805/
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com> 
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: kvmarm@lists.cs.columbia.edu
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Changes in V2:
> > 
> > - Added Suggested-by tag from Mark Rutland for all changes he had proposed
> > - Added comment for SpecSEI feature on why it is HIGHER_SAFE per Suzuki
> > - Added a patch which makes ID_AA64DFR0_DOUBLELOCK a signed feature per Suzuki
> > - Added ID_DFR1 and ID_MMFR5 system register definitions per Will
> > - Added remaining features bits for relevant 64 bit system registers per Will
> > - Changed commit message on [PATCH 5/7] regarding TraceFilt feature per Suzuki
> > - Changed ID_PFR2.CSV3 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will
> > - Changed ID_PFR0.CSV2 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will 
> > - Changed some commit messages
>
> Just a gentle ping. I am wondering if you had a chance to glance
> through this updated series.

Please can you resend based on for-next/cpufeature?

Will
