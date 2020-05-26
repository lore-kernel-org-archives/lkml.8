Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF35C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7852088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgEZMTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:19:09 -0400
Received: from foss.arm.com ([217.140.110.172]:50052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731015AbgEZMTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:19:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 432BD30E;
        Tue, 26 May 2020 05:19:08 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF8663F6C4;
        Tue, 26 May 2020 05:19:06 -0700 (PDT)
Date:   Tue, 26 May 2020 13:19:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: Move BUG_ON() inside
 get_arm64_ftr_reg()
Message-ID: <20200526121903.GF17051@gaia>
References: <1589937774-20479-1-git-send-email-anshuman.khandual@arm.com>
 <20200520122012.GA25815@willie-the-truck>
 <20200520154711.GD18302@gaia>
 <20200520173953.GA27629@willie-the-truck>
 <cdea1cc5-41be-c125-d4d1-f63ff1989ec6@arm.com>
 <20200521162212.GK6608@willie-the-truck>
 <20200521165916.GF11507@gaia>
 <aa6436d4-c724-4933-1341-6ca417ce40ed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6436d4-c724-4933-1341-6ca417ce40ed@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 05:22:23AM +0530, Anshuman Khandual wrote:
> On 05/21/2020 10:29 PM, Catalin Marinas wrote:
> > On Thu, May 21, 2020 at 05:22:15PM +0100, Will Deacon wrote:
> >> On Thu, May 21, 2020 at 08:45:38AM +0530, Anshuman Khandual wrote:
> >>> The existing code has BUG_ON() in three different callers doing exactly the
> >>> same thing that can easily be taken care in get_arm64_ftr_reg() itself. As
> >>> mentioned before an enum variable (as preferred - over a bool) can still
> >>> preserve the existing behavior for emulate_sys_reg().
> >>>
> >>> IMHO these are very good reasons for us to change the code which will make
> >>> it cleaner while also removing three redundant BUG_ON() instances. Hence I
> >>> will request you to please reconsider this proposal.
> >>
> >> Hmm, then how about trying my proposal with the WARN_ON(), but having a
> >> get_arm64_ftr_reg_nowarn() variant for the user emulation case?
[...]
> > read_sanitised_ftr_reg() would need to return something though. Would
> > all 0s be ok? I think it works as long as we don't have negative CPUID
> > fields.
> 
> Just trying to understand. If get_arm64_ftr_reg() returns NULL, then
> read_sanitised_ftr_reg() should also return 0 for that non existent
> register (already been warned in get_arm64_ftr_reg).
> 
> @@ -961,8 +972,8 @@ u64 read_sanitised_ftr_reg(u32 id)
>  {
>         struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
> 
> -       /* We shouldn't get a request for an unsupported register */
> -       BUG_ON(!regp);
> +       if (!regp)
> +               return 0;
>         return regp->sys_val;
>  }

Yes, as long as we also get the WARN_ON().

-- 
Catalin
