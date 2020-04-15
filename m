Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE9C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DF92074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586953780;
	bh=gHxluNrZU2tTOHcwpOtq2n46qQQhnsi8V7TZgKMK1Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0wFXDxVoWPA2uL/NhOslOu3lPXxWEQNIM9aeAQNE9TdeMzN77XB1FU46haphQdxC7
	 oYp0LytMqVxuZr0CCF84Y3JDPn0uraAb6lndG2LLv2roYrqe5vtp4mk5ngWjVKSM0R
	 VuTFLuQzmB+9zbBWNmHJYZH9ej0h9K3NnxJnOePo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369417AbgDOM3i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409111AbgDOM3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:29:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E55AF2074F;
        Wed, 15 Apr 2020 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586953771;
        bh=gHxluNrZU2tTOHcwpOtq2n46qQQhnsi8V7TZgKMK1Ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gq2BveZDD/Gb/fhWrNYUmp9bkKiMRoVR76H1UymoeIJDTW1qzZMFZ4KqJGQiYlRI4
         3LemfZ0UNyfbRFuW4qThg5ia3zMNOvmcfBva2pDMq/CazF1sPRXR9Usvu0d2D0D1Dx
         frs/d28k4Qrk6T3zmCS1b5T9p+dqmMeKPL4aXXJs=
Date:   Wed, 15 Apr 2020 13:29:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
Subject: Re: [PATCH 7/8] arm64: cpufeature: Relax checks for AArch32 support
 at EL[0-2]
Message-ID: <20200415122926.GA17095@willie-the-truck>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-8-will@kernel.org>
 <714f124c-7eb7-b750-e98c-63da64ddae75@arm.com>
 <20200415105843.GE12621@willie-the-truck>
 <d1f538ec-e956-c136-d0f8-54e7351a28a9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f538ec-e956-c136-d0f8-54e7351a28a9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:37:31PM +0100, Suzuki K Poulose wrote:
> On 04/15/2020 11:58 AM, Will Deacon wrote:
> > On Wed, Apr 15, 2020 at 11:50:58AM +0100, Suzuki K Poulose wrote:
> > > On 04/14/2020 10:31 PM, Will Deacon wrote:
> > > > We don't need to be quite as strict about mismatched AArch32 support,
> > > > which is good because the friendly hardware folks have been busy
> > > > mismatching this to their hearts' content.
> > > > 
> > > >     * We don't care about EL2 or EL3 (there are silly comments concerning
> > > >       the latter, so remove those)
> > > > 
> > > >     * EL1 support is gated by the ARM64_HAS_32BIT_EL1 capability and handled
> > > >       gracefully when a mismatch occurs
> > > > 
> > > >     * EL1 support is gated by the ARM64_HAS_32BIT_EL0 capability and handled
> > > 
> > > s/EL1/EL0
> > > 
> > > >       gracefully when a mismatch occurs
> > > > 
> > > > Relax the AArch32 checks to FTR_NONSTRICT.
> > > 
> > > Agreed. We should do something similar for the features exposed by the
> > > ELF_HWCAP, of course in a separate series.
> > 
> > Hmm, I didn't think we needed to touch the HWCAPs, as they're derived from
> > the sanitised feature register values. What am I missing?
> 
> sorry, that was cryptic. I was suggesting to relax the ftr fields to
> NONSTRICT for the fields covered by ELF HWCAPs (and other CPU hwcaps).

Ah, gotcha. Given that the HWCAPs usually describe EL0 features, I say we
can punt this down the road until people give us hardware with mismatched
AArch32 at EL0.

Will
