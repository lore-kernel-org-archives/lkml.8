Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF11C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696522100A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590565990;
	bh=Uz9VQ5ssMAnN5D1Zw8oLy/WNGOVCjJrTYN7Wo34QeXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=suVKYvYvb4vMFy+OuZTaAOJnxloUjGL5gRw1xWYbxMiZbUpqF4Jfwl/vaVa9BmV3e
	 Tgw1b1ilX98rWIc2F+z7rxtjtoIm+3Gw1XTsAKf8mlsYHAwmkRxz0yo+46zwf4RL3D
	 u5uOYs/R2IjhNQwqHIq7B7nYh/mdRC/BdoS6dyss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbgE0HxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387650AbgE0HxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:53:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 894A120FC3;
        Wed, 27 May 2020 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590565988;
        bh=Uz9VQ5ssMAnN5D1Zw8oLy/WNGOVCjJrTYN7Wo34QeXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgSznrbPLEsdZgh8jYyrwAoodAz/I/EFVZy0/azyVkV+fdaIHQitlZQ/IxT5L/XQ4
         XBVOOpb3V2yjhN5922zof+32xjxajhg0/d1vULou0YTHSJe+VWQX214hMELGMqD3fv
         7k0OjwYs6SIZWzHrd5ORT/MDGT37kqMDP5JQnOJo=
Date:   Wed, 27 May 2020 08:53:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
Message-ID: <20200527075303.GC9887@willie-the-truck>
References: <1590500353-28082-1-git-send-email-anshuman.khandual@arm.com>
 <20200526150135.GI17051@gaia>
 <20200526194648.GA2206@willie-the-truck>
 <ca38b2c0-533f-9b98-46a2-37ba8bf21d83@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca38b2c0-533f-9b98-46a2-37ba8bf21d83@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 07:56:30AM +0530, Anshuman Khandual wrote:
> 
> 
> On 05/27/2020 01:16 AM, Will Deacon wrote:
> > On Tue, May 26, 2020 at 04:01:35PM +0100, Catalin Marinas wrote:
> >> On Tue, May 26, 2020 at 07:09:13PM +0530, Anshuman Khandual wrote:
> >>> @@ -632,8 +654,6 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
> >>>  	const struct arm64_ftr_bits *ftrp;
> >>>  	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
> >>>  
> >>> -	BUG_ON(!reg);
> >>> -
> >>>  	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
> >>>  		u64 ftr_mask = arm64_ftr_mask(ftrp);
> >>>  		s64 ftr_new = arm64_ftr_value(ftrp, new);
> >>> @@ -762,7 +782,6 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
> >>>  {
> >>>  	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
> >>>  
> >>> -	BUG_ON(!regp);
> >>>  	update_cpu_ftr_reg(regp, val);
> >>>  	if ((boot & regp->strict_mask) == (val & regp->strict_mask))
> >>>  		return 0;
> >>> @@ -776,9 +795,6 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
> >>>  	const struct arm64_ftr_bits *ftrp;
> >>>  	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
> >>>  
> >>> -	if (WARN_ON(!regp))
> >>> -		return;
> >>
> >> I think Will wanted an early return in all these functions not just
> >> removing the BUG_ON(). I'll let him clarify.
> > 
> > Yes, the callers need to check the pointer and return early.
> 
> Sure, will do. But for check_update_ftr_reg(), a feature register search
> failure should be treated as a success (0) or a failure (1). What should
> it return ? Seems bit tricky, as there are good reasons to go either way.

We're unable to check it so return 0, otherwise we'll randomly taint the
kernel and print a weird message.

Will
