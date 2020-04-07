Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3571AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAD620748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="B2qz40op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDGVVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:21:08 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:22364 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGVVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1586294467;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yohZgO1cSq06DF0y1oMl6qbvylo5IHTJURPzFHgykKA=;
  b=B2qz40opb6DJJtrtHJqMct2v9NtfyzAcNrFnCL83r2jKbt95d+TRDCHS
   SeMAYlhvxkBEqy24tcVAJDVQB4vwKTdu4a4/Kr9Chdzko5k1sOp+TXsQ/
   73ZBJYGsJ+GzWBPMrZ2rDySUcOeBWEHIRrRar6b+LdGdN4J8AdQkygNXx
   o=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: T07NPnfs91txdCmkBzYw7URfU7gbHGeWsimmexUlwAFk+7pISy9lknhEjUONEtzYabCua/c4FC
 9xsOYdZ0SQy/Gwjegmq58XM0TvJxdGeI/Myp573HIzABBdGd9nE24Y9UdBelg6kPJPqYTaLB/B
 YJV8/jr22AjwTBz0Vv1aOV3AY5WR2cwPZrMroh40RBuUywuTLipfHMnbKKZvU/zfmM2Qjiz7cF
 pRWIYnqfnsHf1qtRLi4TFCz2Z1lbGN5ViHiptcRXdLVHas++pQGRi4r9zl35yvxHMwpZaCq976
 n28=
X-SBRS: 2.7
X-MesageID: 15736135
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,356,1580792400"; 
   d="scan'208";a="15736135"
Subject: Re: [PATCH 0/4] x86/module: Out-of-tree module decode and sanitize
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <hch@infradead.org>, <sean.j.christopherson@intel.com>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <x86@kernel.org>, <kenny@panix.com>, <jeyu@kernel.org>,
        <rasmus.villemoes@prevas.dk>, <pbonzini@redhat.com>,
        <fenghua.yu@intel.com>, <xiaoyao.li@intel.com>,
        <nadav.amit@gmail.com>, <thellstrom@vmware.com>,
        <tony.luck@intel.com>, <rostedt@goodmis.org>,
        <gregkh@linuxfoundation.org>, <jannh@google.com>,
        <keescook@chromium.org>, <David.Laight@aculab.com>,
        <dcovelli@vmware.com>, <mhiramat@kernel.org>
References: <20200407110236.930134290@infradead.org>
 <a53a01b9-2907-4eb3-a9fd-16e6e8029028@citrix.com>
 <20200407194112.GQ2452@worktop.programming.kicks-ass.net>
 <e6d9f83e-e88c-c079-50b3-ff8ad8682074@citrix.com>
 <20200407204530.GR2452@worktop.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <34f2a325-45c4-44e8-595a-187d0d37afa6@citrix.com>
Date:   Tue, 7 Apr 2020 22:21:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407204530.GR2452@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2020 21:45, Peter Zijlstra wrote:
>> POPF: Don't really want someone being able to set IOPL3.  However, this
>> might quite easily show up as a false positive depending on how the
>> irqsafe infrastructure gets inlined.
> local_irq_restore() will be a POPF :/

Ok.  Something to consider in an orthogonal direction.  A while ago, I
put this into Xen as a security fix:

iret_exit_to_guest:
        andl  $~(X86_EFLAGS_IOPL|X86_EFLAGS_NT|X86_EFLAGS_VM),24(%rsp)
        orl   $X86_EFLAGS_IF,24(%rsp)
        addq  $8,%rsp
.Lft0:  iretq

which unconditionally fixes up the unsafe flags even if something
manages to slips through (e.g. local_irq_restore() against stack
rubble).  It turns out that it has saved us several CVEs in the
intervening time.

Is this the kind of things the hardening folk would be interested in?

> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -282,6 +282,68 @@ static bool insn_is_mov_DRn(struct insn
>  	return false;
>  }
>
> +static bool insn_is_GDT_modifier(struct insn *insn)
> +{
> +	u8 modrm = insn->modrm.bytes[0];
> +	u8 modrm_mod = X86_MODRM_MOD(modrm);
> +	u8 modrm_reg = X86_MODRM_REG(modrm);
> +
> +	if (insn->opcode.bytes[0] != 0x0f)
> +		return false;
> +
> +	switch (insn->opcode.bytes[1]) {
> +	case 0x00: /* Grp6 */
> +		switch (modrm_reg) {
> +		/* case 0x0: SLDT */
> +		case 0x2: /* LLDT */
> +		case 0x3: /* LTR */
> +			return true;

Come to think of it, if you include the Sxxx variants, a sufficiently
clever compiler can collapse this entire switch statement into a single
"and $~3, modrm_reg" instruction, rather than being forced to use "and
$~1, modrm_reg; cmp $2, ...".

Probably on the extreme end of micro-optimising however.

~Andrew
