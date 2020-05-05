Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C11AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D2E20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588677053;
	bh=tLnC3k0rye0luMgLxFSFH5txN4xnLzlLq84ZHZhCA2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x8wm3WGQVPaYS2C+utX4N2mC3JqJ/1XbyEsyRfV6bbTI8az4eRh/yMfuYi0g8QT3Z
	 ZrTeCVfMDkDHFgFHhKqASlUKDMx4YULVzqGVZsL9VV9YYLxEv+v91q+ivocD0MzUPW
	 WU6BwmhXWz2YxXuySIfUITmFUMMk0fEJZapvY/YQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgEELKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEELKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:10:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1ED0206B8;
        Tue,  5 May 2020 11:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588677049;
        bh=tLnC3k0rye0luMgLxFSFH5txN4xnLzlLq84ZHZhCA2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xcd5vIJgLtqRrkuJPCcdbU5b2WtJlWCm7UfhN/ckq+9vmS9qPWkYH8U94I7Ta3xG6
         B3gwrGBf+MKsezEyVcBIqJfTF5o0pjmu+4FRTfre6YfZi2V53Ty7hZuThX/Y1cO5vq
         S39yKwl2ZnHA6kNGQTole+6zuVkz6j6CVXpE84w0=
Date:   Tue, 5 May 2020 12:10:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/16] arm64/cpufeature: Make doublelock a signed
 feature in ID_AA64DFR0
Message-ID: <20200505111045.GE19710@willie-the-truck>
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588426445-24344-4-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 07:03:52PM +0530, Anshuman Khandual wrote:
> Double lock feature can have the following possible values.
> 
> 0b0000 - Double lock implemented
> 0b1111 - Double lock not implemented
> 
> But in case of a conflict the safe value should be 0b1111. Hence this must
> be a signed feature instead. Also change FTR_EXACT to FTR_LOWER_SAFE.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 51386dade423..cba43e4a5c79 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -338,7 +338,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
>  };
>  
>  static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 36, 28, 0),
> +	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 36, 28, 0),

Wait, isn't this buggered today? Shouldn't that 28 be a 4? I think we really
need to:

	1. Make it impossible to describe overlapping fields, incomplete
	   registers etc (ideally at build-time)

	2. Have a macro that for 4-bit fields so you don't have to type '4'
	   all the time

Suzuki, any ideas how we can make this a bit more robust?

Will
