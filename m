Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D99C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7054F20769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586330746;
	bh=sgM0OgGXdXtnVQaVYMoa5XvNnehXNyhomdt1s63WD7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MmtyOkMCIai9czVsaaD2OtYKqvOeqFQk43QtRtj1gyLAf9z8+28TejXViCe+7/3sX
	 XH+Ir9R8GBQ6a7jXbr9/oKBTI4tcE0yaPJeyWMFQRTV6gMArhzLXcSyHG9KqdeV5bM
	 0roWDDL+R9Op6iDdFrz4xlcSMaRWuvNnq8tb1WtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDHHZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgDHHZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:25:45 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6121320730;
        Wed,  8 Apr 2020 07:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586330744;
        bh=sgM0OgGXdXtnVQaVYMoa5XvNnehXNyhomdt1s63WD7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vgE5cDo9x/6xgxvR0n8f1v/TEM6q6/a4gTc5cOOUBQd6Ve7gNd+iABHvAogAc0q4G
         PLjrumTeHzO0t8H+eGsd2T/ry02ZPsTABVxfugRI3k62xVXKYlw6rXIlzc3JTIMsvt
         5aBmrW0vrGsZ2gbta2bmUIw06u4LCDbUDUVgUg9c=
Date:   Wed, 8 Apr 2020 16:25:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kenny@panix.com, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com, rostedt@goodmis.org,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com, dcovelli@vmware.com
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-Id: <20200408162536.5f14339c3ef5a2b0444d2f06@kernel.org>
In-Reply-To: <20200408015124.ec42bcffc1377cb6ea94f785@kernel.org>
References: <20200407110236.930134290@infradead.org>
        <20200407111007.352324393@infradead.org>
        <20200408015124.ec42bcffc1377cb6ea94f785@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Apr 2020 01:51:24 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Peter,
> 
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
> > +
> > +	if (insn->opcode.bytes[0] != 0x0f)
> > +		return false;
> > +
> > +	switch (insn->opcode.bytes[1]) {
> > +	case 0x01:
> > +		switch (insn->opcode.bytes[2]) {
> > +		case 0xc1: /* VMCALL */
> > +		case 0xc2: /* VMLAUNCH */
> > +		case 0xc3: /* VMRESUME */
> > +		case 0xc4: /* VMXOFF */
> > +			return true;
> > +
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +
> > +	case 0x78: /* VMREAD */
> > +	case 0x79: /* VMWRITE */
> > +		return true;
> > +
> > +	case 0xc7:
> > +		/* VMPTRLD, VMPTRST, VMCLEAR, VMXON */
> > +		if (modrm_mod == 0x03)
> > +			break;
> > +
> > +		if ((modrm_reg == 6 && (!prefix || prefix == 0x66 || prefix == 0xf3)) ||
> > +		    (modrm_reg == 7 && (!prefix || prefix == 0xf3)))
> > +			return true;
> > +
> > +		break;
> > +
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return false;
> > +}
> 
> OK, so here is what you need ;)
> 
> From 36f4f6aec623b0190fde95c8630a6a1d8c23ffc9 Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Wed, 8 Apr 2020 01:04:41 +0900
> Subject: [PATCH] x86: insn: Add insn_is_vmx()
> 
> Add insn_is_vmx() to identify the given instruction is
> for VMX or not. This is simply identifying those instructions
> by mnemonic pattern.
> 

Hmm, I found that this is still not enough... since the inat_tables
mixes the instruction attributes on same entry in group tables.
It distinguishes opcodes by last-prefix variants, but not by
MOD & R/M bits, since it is designed only for decoding instructions.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
