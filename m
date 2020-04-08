Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE5C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D67920771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gCwX1vXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgDHJ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:56:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgDHJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xk7EXFmm5O5vM+yetiaSM6FRKc8dFBIchmJgrgA7YLA=; b=gCwX1vXCJAuvl86aUYLJnbpE2t
        IKp5cWAu+6e+PWifFt1apHAkE0/fAvBmWzF9VOmj7J3yDVqCF6nqR73JQvVSofUpbuPnY9h1qaHQJ
        547OQWd2kxNqd/tiDTrWH4zbGPz8KCY0APyXt280C7IEjYC7p18rJvqq+7g9Rs2d/n4E7fQgho/9x
        r3LOeRKqS0QcCZ2pUzueVQwRFI1Ke8urswmVUFMTz/WIkKwwG2498i5w6PDb69t6C/lJ9mG7B8b+K
        0gUsZr0dEox0XwWwRT3CIPHS3ZNBjm0WAbSKgqvII9jVwl9WIXxMM7Qmnu4bZH4hM5hNATr/wgCY6
        drMCuyGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM7RG-0001lD-Tz; Wed, 08 Apr 2020 09:56:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EA0A304E03;
        Wed,  8 Apr 2020 11:56:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7857B2B0A1248; Wed,  8 Apr 2020 11:56:04 +0200 (CEST)
Date:   Wed, 8 Apr 2020 11:56:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com, dcovelli@vmware.com
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-ID: <20200408095604.GR20713@hirez.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org>
 <20200408170934.7238715574818f31f03e687b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408170934.7238715574818f31f03e687b@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:09:34PM +0900, Masami Hiramatsu wrote:
> On Tue, 07 Apr 2020 13:02:39 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > +static bool insn_is_vmx(struct insn *insn)
> > +{
> > +	u8 modrm = insn->modrm.bytes[0];
> > +	u8 modrm_mod = X86_MODRM_MOD(modrm);
> > +	u8 modrm_reg = X86_MODRM_REG(modrm);
> > +
> > +	u8 prefix = insn->prefixes.bytes[0];
> 
> This should be the last prefix,
> 
> 	u8 prefix = insn->prefixes.bytes[3];
> 
> (The last prefix always copied on the bytes[3])

And that is 0 on no-prefix, right?

> > +
> > +	if (insn->opcode.bytes[0] != 0x0f)
> > +		return false;
> > +
> > +	switch (insn->opcode.bytes[1]) {
> > +	case 0x01:
> > +		switch (insn->opcode.bytes[2]) {
> 
> Sorry, VMCALL etc. is in Grp7 (0f 01), the 3rd code is embedded
> in modrm instead of opcode. Thus it should be,
> 
> 		switch (insn->modrm.value) {

Indeed, I was hoping (I really should've checked) that that byte was
duplicated in opcodes.

Also, since I already have modrm = insn->modrm.bytes[0], I should
probably use that anyway.

> > +		case 0xc1: /* VMCALL */
> > +		case 0xc2: /* VMLAUNCH */
> > +		case 0xc3: /* VMRESUME */
> > +		case 0xc4: /* VMXOFF */
> 
> 		case 0xd4:	/* VMFUNC */

As per Andrew, VMCALL and VMFUNC are SMV, and I really only need VMX in
this case. Including SMV is probably harmless, but I'm thinking a
smaller function is better.

> > +			return true;
> > +
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +
> > +	case 0x78: /* VMREAD */
> > +	case 0x79: /* VMWRITE */
> 
> 		return !insn_is_evex(insn);
> 
> With EVEX prefix, these becomes vcvt* instructions.

Thanks!
