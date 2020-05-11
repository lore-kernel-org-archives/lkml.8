Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7614BC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2252098B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589192968;
	bh=/HtkDEUSJNCGLykcJeF51FbbiEEPPZDAt/jaVHdhRWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SuEF4LFf1FYbjN/wv/DQpLWq8dDKmcLvNnuEcFxwbr8l8ezFbu7pFT28vZwpvpSdD
	 GOUByfdYLdlIjWG6FC65S2jzs5y53uBlSFzzcoDSO4z9+I+ZEfUGIPfaYGrRLIiKEs
	 0XYNByJKnusmMzeqAkz+bZtdlWtkdn2JUTyakypE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgEKK31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgEKK31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:29:27 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E97C02080C;
        Mon, 11 May 2020 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589192966;
        bh=/HtkDEUSJNCGLykcJeF51FbbiEEPPZDAt/jaVHdhRWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0vuf+ZotQeRxth/qHzk0monizmO/oZrY0XlTEMp3GOvKC2C9ZGzbBQsmEje6tfhV
         drhODojTl9CKLTGN3jGxEvkg0amm8cChelSejV1audJqLmta+BCdVclouAv4z/FqLZ
         5UsKODnRShHCuOk9nIvWvHXpIdZ2tVePfXGqPstU=
Date:   Mon, 11 May 2020 11:29:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     David Brazdil <dbrazdil@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] arm64: kvm: Move __smccc_workaround_1_smc to
 .rodata
Message-ID: <20200511102921.GA18310@willie-the-truck>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-7-dbrazdil@google.com>
 <20200511110459.1fcf4db7@why>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511110459.1fcf4db7@why>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 11:04:59AM +0100, Marc Zyngier wrote:
> On Thu, 30 Apr 2020 15:48:22 +0100
> David Brazdil <dbrazdil@google.com> wrote:
> 
> > This snippet of assembly is used by cpu_errata.c to overwrite parts of KVM hyp
> > vector. It is never directly executed, so move it from .text to .rodata.
> > 
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > ---
> >  arch/arm64/kvm/hyp/hyp-entry.S | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
> > index 5986e1d78d3f..7e5f386c5c2d 100644
> > --- a/arch/arm64/kvm/hyp/hyp-entry.S
> > +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> > @@ -364,6 +364,11 @@ SYM_CODE_END(__bp_harden_hyp_vecs)
> >  	.popsection
> >  
> >  #ifndef __HYPERVISOR__
> > +	/*
> > +	 * This is not executed directly and is instead copied into the vectors
> > +	 * by install_bp_hardening_cb().
> > +	 */
> > +	.pushsection	.rodata
> >  SYM_CODE_START(__smccc_workaround_1_smc)
> 
> I wonder whether we should keep the SYM_CODE_START() annotation or not.
> It feels weird to say "code" in a rodata section, and the alignment
> doesn't matter as we copy it in place, as you noticed.

The BTI patches hook these, but I don't see that being relevant for a
vector entry as PSTATE.BTYPE is zapped to 0.

Will
