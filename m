Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A8EC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA3D20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588623905;
	bh=dCUcj64WxQsEocNsatvppm/zf3WGdXsZ0RfjpWEZz/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cJ6vWzqwjfhCesa3c4d/8Dmof7hvrG1CX+XG9U1qc7iuFS+6r1lf9rjLMXMoBRtYX
	 CpA9sS7sbtN+te7BD8XMwbaqG2DYhMqyvjitYaiJ4TXAZbRH996asLZQYBRLdKNSSU
	 IjT3BYGXvkZu1pEPqo7/6CL1+wNbVraSggsSzrAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgEDUZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgEDUZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:25:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E3420721;
        Mon,  4 May 2020 20:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588623899;
        bh=dCUcj64WxQsEocNsatvppm/zf3WGdXsZ0RfjpWEZz/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=drrSv1ltJv0WLhISRLHG/qvOeiVCSP5oy99VBxNo0rvRjwYLzOrpF1RSA+AaAi49u
         PdtCfQw2CQ6rcLvPivJ8lN+g6CShd3diYYqcPVuQyUtKTi2wb7lRIqGi9xiU1/4PaB
         7EiOLTyNgeIM5z78mmHFcW0lKuQr5xeu8ZcZJrDs=
Date:   Mon, 4 May 2020 21:24:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 02/16] arm64/cpufeature: Drop TraceFilt feature
 exposure from ID_DFR0 register
Message-ID: <20200504202453.GA5012@willie-the-truck>
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588426445-24344-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 07:03:51PM +0530, Anshuman Khandual wrote:
> ID_DFR0 based TraceFilt feature should not be exposed to guests. Hence lets
> drop it.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6d032fbe416f..51386dade423 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -435,7 +435,6 @@ static const struct arm64_ftr_bits ftr_id_pfr1[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_dfr0[] = {
> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),

Hmm, this still confuses me. Is this not now FTR_NONSTRICT? Why is that ok?

Will
