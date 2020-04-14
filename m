Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54405C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5012168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586872646;
	bh=n9zV/CUm5fQ6kJG9xx9uBNkS1o6bnb2V/CMUwlWKrf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xsR6OrF/1yzbmOqcwoY6KdaDYXnpYsWPLm1XS30ANbHiteRQ7gTmdSSXEdydm0Xku
	 CXEZMQ4Gr1Sj4rJb7ucGQdUZyXHeLGR+UvA5sAI8Oi6E5xb8SMH7H31dYmECVxHR+S
	 pKyRLUkGmqoS7MblyuJzMoJlaDG/Enhu038M/gkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbgDNN5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388513AbgDNN5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:57:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF22620656;
        Tue, 14 Apr 2020 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586872636;
        bh=n9zV/CUm5fQ6kJG9xx9uBNkS1o6bnb2V/CMUwlWKrf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/kuN0mMrGpZr4ilxxpfussBIw4+VR3Qlk9Sl3WR2i289CFIIqOtaL7p7RASlKDZ9
         vfPpAOPXooK8inL7i2YwIB/rSjj0cncaL/gt2OX7jThO1ap0y36WURbAwnGgHOf4ut
         fLSxAyZq70gzsRO490XT4UfNLbRwPP3L1RQSmHh0=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jOM3u-003AqO-B3; Tue, 14 Apr 2020 14:57:14 +0100
Date:   Tue, 14 Apr 2020 14:57:12 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arm64: kvm: Delete duplicated label: in invalid_vector
Message-ID: <20200414145712.603e37d5@why>
In-Reply-To: <CAKwvOdn35v5LkvhWugfLmK_FjVsd0RdPtBCRSqVaM9EP_1KU7w@mail.gmail.com>
References: <20200413231016.250737-1-maskray@google.com>
        <CAKwvOdn35v5LkvhWugfLmK_FjVsd0RdPtBCRSqVaM9EP_1KU7w@mail.gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ndesaulniers@google.com, maskray@google.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, clang-built-linux@googlegroups.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Mon, 13 Apr 2020 16:37:10 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Mon, Apr 13, 2020 at 4:10 PM Fangrui Song <maskray@google.com> wrote:
> >
> > SYM_CODE_START defines \label , so it is redundant to define \label again.
> > A redefinition at the same place is accepted by GNU as
> > (https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=159fbb6088f17a341bcaaac960623cab881b4981)
> > but rejected by the clang integrated assembler.
> >
> > Fixes: 617a2f392c92 ("arm64: kvm: Annotate assembly using modern annoations")  
> 
> Thanks for the patch!  I think a more accurate Fixes tag would be:
> Fixes: 2b28162cf65a ("arm64: KVM: HYP mode entry points")

I'm not sure this commit is accurate. At that time, there was no other
declaration for \label and dropping it would simply break compilation.
I believe that Fangrui is correct in his analysis that 617a2f392c92 is
the first broken commit.

> With this patch applied, and your other arm64 integrated assembler
> patch (https://lore.kernel.org/linux-arm-kernel/20200413033811.75074-1-maskray@google.com/T/#u),
> I can now assemble arch/arm64/kvm/.

Progress! ;-)

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/988
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > ---
> >  arch/arm64/kvm/hyp/hyp-entry.S | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
> > index c2a13ab3c471..9c5cfb04170e 100644
> > --- a/arch/arm64/kvm/hyp/hyp-entry.S
> > +++ b/arch/arm64/kvm/hyp/hyp-entry.S
> > @@ -198,7 +198,6 @@ SYM_CODE_END(__hyp_panic)
> >  .macro invalid_vector  label, target = __hyp_panic
> >         .align  2
> >  SYM_CODE_START(\label)
> > -\label:
> >         b \target
> >  SYM_CODE_END(\label)
> >  .endm
> > --
> > 2.26.0.110.g2183baf09c-goog
> >  
> 
> 

I'll pick this up as soon as we've sorted the queue with the rest of
the fixes.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
