Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B580BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9F320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586517948;
	bh=Z3fufQrEQmEd62KkcBy5D2UDAuqjgdsgeNuolOlliic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Fl8hV2on1+38R0+kEm4lh8UtYL1cJqbRQcPo3py3/3oC4FENWxysbLAckmNiAI5uf
	 vyg2+2SKXAL/X0A/2UrIFRr0jX7Q/LlZViFwEgvvOZwRI0cTvj8bO0hrleSfJbRVea
	 +rVwoPYwHjPmMO0L/3IqVJugwQ7r4His0KBfC9zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDJLZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgDJLZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:25:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69BAA20753;
        Fri, 10 Apr 2020 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586517946;
        bh=Z3fufQrEQmEd62KkcBy5D2UDAuqjgdsgeNuolOlliic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=psRP04/ZE/3yHHxF1ZdUDBRqmXJDH2JOiofbKoaLtskwN69InazhQ5htBqtrR5nJL
         Bc42ZWqwRG5/qNS26bZsi0tBg5rpqPqVvvXVMd3dLu0d5vvnxTIT7nioBjt2kcLPxS
         jBvkx9wYVk2t3WtOnlDwCyKG+T88f+PtN5iAZfzI=
Date:   Fri, 10 Apr 2020 20:25:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com, dcovelli@vmware.com
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-Id: <20200410202538.623dda798c16217f303ed85f@kernel.org>
In-Reply-To: <20200408095604.GR20713@hirez.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
        <20200407111007.352324393@infradead.org>
        <20200408170934.7238715574818f31f03e687b@kernel.org>
        <20200408095604.GR20713@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 11:56:04 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 08, 2020 at 05:09:34PM +0900, Masami Hiramatsu wrote:
> > On Tue, 07 Apr 2020 13:02:39 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > +static bool insn_is_vmx(struct insn *insn)
> > > +{
> > > +	u8 modrm = insn->modrm.bytes[0];
> > > +	u8 modrm_mod = X86_MODRM_MOD(modrm);
> > > +	u8 modrm_reg = X86_MODRM_REG(modrm);
> > > +
> > > +	u8 prefix = insn->prefixes.bytes[0];
> > 
> > This should be the last prefix,
> > 
> > 	u8 prefix = insn->prefixes.bytes[3];
> > 
> > (The last prefix always copied on the bytes[3])
> 
> And that is 0 on no-prefix, right?

Yes, it should be.

> > > +
> > > +	if (insn->opcode.bytes[0] != 0x0f)
> > > +		return false;
> > > +
> > > +	switch (insn->opcode.bytes[1]) {
> > > +	case 0x01:
> > > +		switch (insn->opcode.bytes[2]) {
> > 
> > Sorry, VMCALL etc. is in Grp7 (0f 01), the 3rd code is embedded
> > in modrm instead of opcode. Thus it should be,
> > 
> > 		switch (insn->modrm.value) {
> 
> Indeed, I was hoping (I really should've checked) that that byte was
> duplicated in opcodes.
> 
> Also, since I already have modrm = insn->modrm.bytes[0], I should
> probably use that anyway.

Yeah, and please use modrm.value instead of bytes[0].
(maybe bytes[0] will be OK since x86 is little-endian)

> > > +		case 0xc1: /* VMCALL */
> > > +		case 0xc2: /* VMLAUNCH */
> > > +		case 0xc3: /* VMRESUME */
> > > +		case 0xc4: /* VMXOFF */
> > 
> > 		case 0xd4:	/* VMFUNC */
> 
> As per Andrew, VMCALL and VMFUNC are SMV, and I really only need VMX in
> this case. Including SMV is probably harmless, but I'm thinking a
> smaller function is better.

I got it.

> 
> > > +			return true;
> > > +
> > > +		default:
> > > +			break;
> > > +		}
> > > +		break;
> > > +
> > > +	case 0x78: /* VMREAD */
> > > +	case 0x79: /* VMWRITE */
> > 
> > 		return !insn_is_evex(insn);
> > 
> > With EVEX prefix, these becomes vcvt* instructions.
> 
> Thanks!


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
