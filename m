Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1122C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8FE20722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589280001;
	bh=4u2DdZnbBOfH5sHqCv28xYPkeReFp8gr/JDYY65Yi48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Rjw+M8KbOaBXaauaE0+PLzi3U7WwRIGDFuKKs4GW8Nbr20rVJAA8dqe2NF/eGL3sK
	 hwl62Dtwz11+UeDkdIYgia3DdCp6KtywiX+uHMS+pN6aJCgf1fN7NiA54lDm3DTgrn
	 1Kphhn5dp9kVvgoqlxR4IofaYjzZdPOagAGkLsDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgELKkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgELKkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:40:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 704F5206DD;
        Tue, 12 May 2020 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589279999;
        bh=4u2DdZnbBOfH5sHqCv28xYPkeReFp8gr/JDYY65Yi48=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DH7HX+hu1vbOs62ildJh2vK9t5KtpaxktDPdEB2tlwDGMYkOHWB0chJU3wK/ybod+
         00KZ8Y8NlXgVSt7iCdPyn4FUppYC6i8BgaHGniYIk9O+v++8uFsAvJdnscAAUkxFIs
         wFKe1QtNCeHngIo2hJJCTyHLv3lcBRKywcaxXsFY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jYSKL-00BcWZ-MH; Tue, 12 May 2020 11:39:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 May 2020 11:39:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] arm64/cpufeature: Add ID_AA64MMFR0_PARANGE_MASK
In-Reply-To: <1589249606-27177-1-git-send-email-anshuman.khandual@arm.com>
References: <1589249606-27177-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <b01bb1772b291e23ea82ff5855ee7e12@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman,

On 2020-05-12 03:13, Anshuman Khandual wrote:
> This replaces multiple open encoding (0x7) with 
> ID_AA64MMFR0_PARANGE_MASK
> thus cleaning the clutter. It modifies an existing ID_AA64MMFR0 helper 
> and
> introduces a new one i.e id_aa64mmfr0_iparange() and 
> id_aa64mmfr0_parange()
> respectively.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kvmarm@lists.cs.columbia.edu
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies after (https://patchwork.kernel.org/patch/11541893/).
> 
>  arch/arm64/include/asm/cpufeature.h | 11 ++++++++++-
>  arch/arm64/kernel/cpufeature.c      |  5 ++---
>  arch/arm64/kvm/reset.c              |  9 +++++----
>  3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h
> b/arch/arm64/include/asm/cpufeature.h
> index 1291ad5a9ccb..320cfc5b6025 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -706,8 +706,17 @@ void arm64_set_ssbd_mitigation(bool state);
> 
>  extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
> 
> -static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
> +#define ID_AA64MMFR0_PARANGE_MASK 0x7

I still disagree with this 7. Per the letter of the architecture, it
is wrong and should be 0xf, just like any other property described
in an ID register.

> +
> +static inline u32 id_aa64mmfr0_parange(u64 mmfr0)
>  {
> +	return mmfr0 & ID_AA64MMFR0_PARANGE_MASK;
> +}
> +
> +static inline u32 id_aa64mmfr0_iparange(u64 mmfr0)

There is also no such thing as an IPA range in the architecture.
Everything is PA. The only thing that actually describe an IPA
range is what KVM makes of it.

Overall, this patch confuses me more than anything else. I'd rather
you fix ID_AA64MMFR0_PARANGE_MASK to have the right value and be
done with it.

         M.
-- 
Jazz is not dead. It just smells funny...
