Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C04CC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5A020787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586340606;
	bh=SALhRrOgnxlgM3VDuriZSzbFdgJdGnCyvNjc6KlUz70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a2Rthig+hi0wz9sw2lqglKU5+oOUsXpzstGtvLvDL2DCiovk9DUJB32b4q6NDjvS2
	 vr/Z1LkH7GOmARyer98t8r6qG6N7Bjy7vt8uMYiQOniZn1j2CjX/1fqZaL2l8NomE3
	 NcXGTzmmV56Y7fgFQHLhLAKo/zexFnD+v57W+TIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgDHKKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgDHKKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:10:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20A420747;
        Wed,  8 Apr 2020 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586340604;
        bh=SALhRrOgnxlgM3VDuriZSzbFdgJdGnCyvNjc6KlUz70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/f66JrxyGnfMIaVOAiCUUwXoNfqiq7cdoscfL9dTICI/B0tWaGwz4DUf7+Hp12Rg
         1BgGWCRi3OGJFybvHZcDfvujMP6LqdBzYAIuSRBUas2/8+n9/TwgBjmsu9m2NgMA4y
         Fui4xB3/lFIsdotuDctEmWkoDnpMfrYH8ta2wkZY=
Date:   Wed, 8 Apr 2020 11:09:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, james.morse@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] arm64: Add workaround for Cortex-A77 erratum 1542418
Message-ID: <20200408100956.GA32568@willie-the-truck>
References: <20191114145918.235339-1-suzuki.poulose@arm.com>
 <20191114163948.GA5158@willie-the-truck>
 <14773d6b-96d5-b894-7fc4-17c54f15ee30@arm.com>
 <20191120191854.GG4799@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120191854.GG4799@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Nov 20, 2019 at 07:18:55PM +0000, Will Deacon wrote:
> On Fri, Nov 15, 2019 at 01:14:07AM +0000, Suzuki K Poulose wrote:
> > On 11/14/2019 04:39 PM, Will Deacon wrote:
> > > addr:	B	foo
> > > 
> > > and another CPU writes out a new function:
> > > 
> > > bar:
> > > 	insn0
> > > 	...
> > > 	insnN
> > > 
> > > before doing any necessary maintenance and then patches the original
> > > branch to:
> > > 
> > > addr:	B	bar
> > > 
> > > The idea is that a concurrently executing CPU could mispredict the original
> > > branch to point at 'bar', fetch the instructions before they've been written
> > > out and then confirm the prediction by looking at the newly written branch
> > > instruction. Even without the prefetch-speculation-protection, that's
> > > fairly difficult to achieve in practice: you'd need to be doing something
> > > like reusing memory to hold the instructions so that the initial
> > > misprediction occurs.
> > > 
> > > How does A77 stop this from occurring when the ASID is not reallocated (e.g.
> > > the example above)? Is the MOP cache flushed somehow?
> > 
> > IIUC, The MOP cache is flushed on I-cache invalidate, thus it is fine.	
> 
> Hmm, so this is interesting. Does that mean we could do a local I-cache
> invalidation in check_and_switch_context() at the same as doing the local
> TLBI after a rollover?
> 
> I still don't grok the failure case, though, because assuming A77 has IDC=0,
> then won't you see the I-cache maintenance from userspace anyway?

Please could you explain why the userspace I-cache maintenance doesn't
resolve the issue here?

Thanks,

Will
