Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E169C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C983207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589821205;
	bh=mvonww6L/AfIRw6SI8Ticp2hXIALdNie5RN5GGRhRME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u+A9XxkugXi8x8m0tdtXg2oSG8Qojvhv+dMluYIjv8JmSaBIKHJHSIjkoy2C7WDTl
	 TekGExtnae4vwJm6AWHDBE3FQ7SzHGWdDSUxfZI2aZl5GOL+gaDM8VvVn/29fukiUq
	 uIVjm0UDZf62iDV+GQgLo33VAWI5gmkr/6+cPy68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgERRAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERRAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:00:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6448720758;
        Mon, 18 May 2020 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589821203;
        bh=mvonww6L/AfIRw6SI8Ticp2hXIALdNie5RN5GGRhRME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaTRI2X9A6KwyOUNQW5ZXbhUx597usgy2ILhyxGX2NhBGrMQbFqVkfewzpJKw0x+3
         /bvxuuhr5qJ6zxjD13ohnDeZRBS+gH0N+q+49a06kA80KNmWzleuKeE0rjJMo22sx3
         8/EzGDhfGy1nl9HboDowvKOTrlik9bzi+OtM910E=
Date:   Mon, 18 May 2020 17:59:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/cpufeature: Drop open encodings while
 extracting parange
Message-ID: <20200518165958.GS32394@willie-the-truck>
References: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 02:33:34PM +0530, Anshuman Khandual wrote:
> Currently there are multiple instances of parange feature width mask open
> encodings while fetching it's value. Even the width mask value (0x7) itself
> is not accurate. It should be (0xf) per ID_AA64MMFR0_EL1.PARange[3:0] as in
> ARM ARM (0487F.a). Replace them with cpuid_feature_extract_unsigned_field()
> which can extract given standard feature (4 bits width i.e 0xf mask) field.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V2:
> 
> - Used cpuid_feature_extract_unsigned_field() per Mark
> 
> Changes in V1: (https://patchwork.kernel.org/patch/11541913/)
> 
>  arch/arm64/kernel/cpufeature.c |  3 ++-
>  arch/arm64/kvm/reset.c         | 11 ++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

I'm assuming Marc will take this, but let me know if it should go via arm64
instead (where we have a bunch of other cpufeature stuff queued).

Will
