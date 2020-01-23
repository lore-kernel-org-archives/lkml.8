Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E001EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A1D214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579790450;
	bh=P2ot6B9HVK+z/Tf3oXlZLi5L7qNWLA/fO+9rq7CKF70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pUnUPEt+l4x4lk25IiMc+8Vqg5u3ICF0gdSvsQMHYlVDLdiIhXz0pf95/pGreTB4n
	 pe09yOu/Rhcv1J+r8LXxVvLlmHB9N7cERbaHuoCmIcykwoFylxvl/jpLHFOLFJ9FFN
	 qUH0MVmeHfLaQxAw2+y2XxjnptbKECOhDPQQMV4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAWOkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:40:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgAWOkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:40:49 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0D120704;
        Thu, 23 Jan 2020 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579790449;
        bh=P2ot6B9HVK+z/Tf3oXlZLi5L7qNWLA/fO+9rq7CKF70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=19unuZ9oUyArs3WUF1iRYaGScpUNfuGPkJsTwuZ/iiZ52x2hJnMmQKEiycvUYdqiF
         mleGx+yEuN1ie/cuq+e+PosUzXCLwJuWF7xX4bWUfsrUGQleBBLCIK9ZVCAf4L09JZ
         evUwYFk79inu6737+5jx4RCmLP6tbonhigFiEaJQ=
Date:   Thu, 23 Jan 2020 14:40:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com
Subject: Re: [RFC v5 47/57] arm64: assembler: Add macro to annotate asm
 function having non standard stack-frame.
Message-ID: <20200123144044.GB19649@willie-the-truck>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-48-jthierry@redhat.com>
 <20200121103005.GA11154@willie-the-truck>
 <66b1746b-c77b-a4d3-846b-cecdc5a15357@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b1746b-c77b-a4d3-846b-cecdc5a15357@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 01:45:58PM +0000, Julien Thierry wrote:
> On 1/21/20 10:30 AM, Will Deacon wrote:
> > On Thu, Jan 09, 2020 at 04:02:50PM +0000, Julien Thierry wrote:
> > > From: Raphael Gault <raphael.gault@arm.com>
> > > diff --git a/include/linux/frame.h b/include/linux/frame.h
> > > index 02d3ca2d9598..1e35e58ab259 100644
> > > --- a/include/linux/frame.h
> > > +++ b/include/linux/frame.h
> > > @@ -11,14 +11,31 @@
> > >    *
> > >    * For more information, see tools/objtool/Documentation/stack-validation.txt.
> > >    */
> > > +#ifndef __ASSEMBLY__
> > >   #define STACK_FRAME_NON_STANDARD(func) \
> > >   	static void __used __section(.discard.func_stack_frame_non_standard) \
> > >   		*__func_stack_frame_non_standard_##func = func
> > > +#else
> > > +	/*
> > > +	 * This macro is the arm64 assembler equivalent of the
> > > +	 * macro STACK_FRAME_NON_STANDARD define at
> > > +	 * ~/include/linux/frame.h
> > > +	 */
> > > +	.macro	asm_stack_frame_non_standard	func
> > > +	.pushsection ".discard.func_stack_frame_non_standard"
> > > +	.quad	\func
> > > +	.popsection
> > > +	.endm
> > > 
> > > +#endif /* __ASSEMBLY__ */
> > >   #else /* !CONFIG_STACK_VALIDATION */
> > > 
> > > +#ifndef __ASSEMBLY__
> > >   #define STACK_FRAME_NON_STANDARD(func)
> > > -
> > > +#else
> > > +	.macro	asm_stack_frame_non_standard	func
> > > +	.endm
> > > +#endif /* __ASSEMBLY__ */
> > 
> > Hmm. Given that we're currently going through the exercise of converting
> > a bunch of ENTRY/ENDPROC macros to use the new SYM_{CODE,FUNC}_{START,END}
> > macros, I would much prefer for this to be a new flavour of those.
> > 
> > In fact, can you just use SYM_CODE_* for this?
> > 
> 
> You mean to not introduce the STACK_FRAME_NON_STANDARD() macro and just mark
> the asm callable symbols that don't set up a stackframe as SYM_CODE_* ?

Yes, unless I'm mistaken, SYM_CODE_* is intended for that sort of thing
anyway.

Will
