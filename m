Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2700FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035FD208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590522415;
	bh=RaZmosue4ssXAe/hL4EcL9bo7edRNvGkgXFzuwwE8Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qNdvgdMqVA040Wp2RrcAzggDBQJcJ/OndcfTCc0lM9jhWzgJFGOj+B7iIyg+t3MhJ
	 eDPF3zGqaBDsL8AGfeVpUdGxGxjAvwdHKLfNyvqfrGAboQ43sZr1mJ7mG45Q0sW9aY
	 9R6wKHWJBA0vfWYNRgds37SiWjEXy6GYRhfmg360=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbgEZTqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389277AbgEZTqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:46:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272E12086A;
        Tue, 26 May 2020 19:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590522413;
        bh=RaZmosue4ssXAe/hL4EcL9bo7edRNvGkgXFzuwwE8Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=koDImTcZ4jx1g4tTY5/IvaZ0wpBkbrCaKpv2YtCnvjMnwpHa04/0PNBu0tGV8Yzzj
         8w7IgjVSHhiaeSLy+jDwtVycS9LmC/eWlDrNnhgIjwIBNPqGfjILccONNfJAPUbuAq
         df+SiPYuJrVHvJ1lN2f5ffzGlwpJpssiepy3kvcI=
Date:   Tue, 26 May 2020 20:46:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
Message-ID: <20200526194648.GA2206@willie-the-truck>
References: <1590500353-28082-1-git-send-email-anshuman.khandual@arm.com>
 <20200526150135.GI17051@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526150135.GI17051@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 04:01:35PM +0100, Catalin Marinas wrote:
> On Tue, May 26, 2020 at 07:09:13PM +0530, Anshuman Khandual wrote:
> > @@ -632,8 +654,6 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
> >  	const struct arm64_ftr_bits *ftrp;
> >  	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
> >  
> > -	BUG_ON(!reg);
> > -
> >  	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
> >  		u64 ftr_mask = arm64_ftr_mask(ftrp);
> >  		s64 ftr_new = arm64_ftr_value(ftrp, new);
> > @@ -762,7 +782,6 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
> >  {
> >  	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
> >  
> > -	BUG_ON(!regp);
> >  	update_cpu_ftr_reg(regp, val);
> >  	if ((boot & regp->strict_mask) == (val & regp->strict_mask))
> >  		return 0;
> > @@ -776,9 +795,6 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
> >  	const struct arm64_ftr_bits *ftrp;
> >  	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
> >  
> > -	if (WARN_ON(!regp))
> > -		return;
> 
> I think Will wanted an early return in all these functions not just
> removing the BUG_ON(). I'll let him clarify.

Yes, the callers need to check the pointer and return early.

Will
