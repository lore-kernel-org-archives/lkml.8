Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4F920826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590078141;
	bh=5WuN5J6JrrL0Ru1Jeq5Ugd2Xq4HNCOyuxSZAqZ9/hJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G/Xz0libus9IJpgnlyxmXqHKm0eaH84A2FGYrs3m4JZDsoyn5gPy+nbqHHKoVGPUz
	 Yvk+VoZLPjZKZIynQivevsNKnpL9JV7FSN3b3RBIfqfqNKC0cIFZ5kYdMqMp74MDIC
	 pzA/u7M4IDuDreHSMljVu5Zfu33lxf2u8YYx+8Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEUQWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgEUQWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:22:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7586E20748;
        Thu, 21 May 2020 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590078139;
        bh=5WuN5J6JrrL0Ru1Jeq5Ugd2Xq4HNCOyuxSZAqZ9/hJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTs5YccrNnx7oMz2b9CUi2XjtNt1vO4YfZvow8YVbqCY8nR5T0dOo2tDlQ2ApwHTJ
         ICYraVFGWQO4IbdRvn9DPI5exaKFpwsq2vu9Fjw46Rwd0vatycQJgF1ofc3kpom1D7
         j4vqjgcvEJD3qNHpgWksTasFY55N2TOrPt+Xccnc=
Date:   Thu, 21 May 2020 17:22:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: Move BUG_ON() inside
 get_arm64_ftr_reg()
Message-ID: <20200521162212.GK6608@willie-the-truck>
References: <1589937774-20479-1-git-send-email-anshuman.khandual@arm.com>
 <20200520122012.GA25815@willie-the-truck>
 <20200520154711.GD18302@gaia>
 <20200520173953.GA27629@willie-the-truck>
 <cdea1cc5-41be-c125-d4d1-f63ff1989ec6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdea1cc5-41be-c125-d4d1-f63ff1989ec6@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 08:45:38AM +0530, Anshuman Khandual wrote:
> 
> 
> On 05/20/2020 11:09 PM, Will Deacon wrote:
> > On Wed, May 20, 2020 at 04:47:11PM +0100, Catalin Marinas wrote:
> >> On Wed, May 20, 2020 at 01:20:13PM +0100, Will Deacon wrote:
> >>> On Wed, May 20, 2020 at 06:52:54AM +0530, Anshuman Khandual wrote:
> >>>> There is no way to proceed when requested register could not be searched in
> >>>> arm64_ftr_reg[]. Requesting for a non present register would be an error as
> >>>> well. Hence lets just BUG_ON() when the search fails in get_arm64_ftr_reg()
> >>>> rather than checking for return value and doing the same in some individual
> >>>> callers.
> >>>>
> >>>> But there are some callers that dont BUG_ON() upon search failure. It adds
> >>>> an argument 'failsafe' that provides required switch between callers based
> >>>> on whether they could proceed or not.
> >>>>
> >>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>> Cc: Will Deacon <will@kernel.org>
> >>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>>> Cc: Mark Brown <broonie@kernel.org>
> >>>> Cc: linux-arm-kernel@lists.infradead.org
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>>
> >>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >>>> ---
> >>>> Applies on next-20200518 that has recent cpufeature changes from Will.
> >>>>
> >>>>  arch/arm64/kernel/cpufeature.c | 26 +++++++++++++-------------
> >>>>  1 file changed, 13 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >>>> index bc5048f152c1..62767cc540c3 100644
> >>>> --- a/arch/arm64/kernel/cpufeature.c
> >>>> +++ b/arch/arm64/kernel/cpufeature.c
> >>>> @@ -557,7 +557,7 @@ static int search_cmp_ftr_reg(const void *id, const void *regp)
> >>>>   *         - NULL on failure. It is upto the caller to decide
> >>>>   *	     the impact of a failure.
> >>>>   */
> >>>> -static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
> >>>> +static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id, bool failsafe)
> >>>
> >>> Generally, I'm not a big fan of boolean arguments because they are really
> >>> opaque at the callsite. It also seems bogus to me that we don't trust the
> >>> caller to pass a valid sys_id, but we trust it to get "failsafe" right,
> >>> which seems to mean "I promise to check the result isn't NULL before
> >>> dereferencing it."
> >>>
> >>> So I don't see how this patch improves anything. I'd actually be more
> >>> inclined to stick a WARN() in get_arm64_ftr_reg() when it returns NULL and
> >>> have the callers handle NULL by returning early, getting rid of all the
> >>> BUG_ONs in here. Sure, the system might end up in a funny state, but we
> >>> WARN()d about it and tried to keep going (and Linus has some strong opinions
> >>> on this too).
> >>
> >> Such WARN can be triggered by the user via emulate_sys_reg(), so we
> >> can't really have it in get_arm64_ftr_reg() without a 'failsafe' option.
> > 
> > Ah yes, that would be bad. In which case, I don't think the existing code
> > should change.
> 
> The existing code has BUG_ON() in three different callers doing exactly the
> same thing that can easily be taken care in get_arm64_ftr_reg() itself. As
> mentioned before an enum variable (as preferred - over a bool) can still
> preserve the existing behavior for emulate_sys_reg().
> 
> IMHO these are very good reasons for us to change the code which will make
> it cleaner while also removing three redundant BUG_ON() instances. Hence I
> will request you to please reconsider this proposal.

Hmm, then how about trying my proposal with the WARN_ON(), but having a
get_arm64_ftr_reg_nowarn() variant for the user emulation case?

Will
