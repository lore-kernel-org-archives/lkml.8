Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAF9C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C5B20720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586303998;
	bh=N9TaasfPbDVW6lu1Xgb870eltLDyGIxW4VuLgPXrMS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QnjE8eP0I3wmB+udNDoe5bnWDtyyYOayIsTL8cM3p2CZKjV1r8BBS0sEEbz4E215O
	 KW/tFKrE4c48uDeKaNWSAlY+BeF+o5QYBqDXY1bYyHMc7nTXtgBg6qYAeHq4LsGXQD
	 HyyfvIUV3292Y9MZj/yC4luRI0e7eab0A90j1+TM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgDGX75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:59:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgDGX75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:59:57 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8256B2054F;
        Tue,  7 Apr 2020 23:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586303996;
        bh=N9TaasfPbDVW6lu1Xgb870eltLDyGIxW4VuLgPXrMS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=azhg/LGZXwLxkLBPBoy1E3E+A1F7hwyJDp7Wec79fozwQng8HksXrm3EYQcoQAcW/
         i7Q/I1I3XOHLxmiDNJLrqE4ig0xWatykTX8MBDcFynZU1So5mOZllTVgd7tFA0X/9/
         C84GBRKx1NRhLy/emFupyUUpUCLTyVMDk3A81ySI=
Date:   Wed, 8 Apr 2020 08:59:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <sean.j.christopherson@intel.com>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>,
        <kenny@panix.com>, <jeyu@kernel.org>, <rasmus.villemoes@prevas.dk>,
        <pbonzini@redhat.com>, <fenghua.yu@intel.com>,
        <xiaoyao.li@intel.com>, <nadav.amit@gmail.com>,
        <thellstrom@vmware.com>, <tony.luck@intel.com>,
        <rostedt@goodmis.org>, <gregkh@linuxfoundation.org>,
        <jannh@google.com>, <keescook@chromium.org>,
        <David.Laight@aculab.com>, <dcovelli@vmware.com>
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-Id: <20200408085947.c48be95995fb6915bf16de88@kernel.org>
In-Reply-To: <55dfd3fd-26c2-77d6-4961-3cef8d746f7f@citrix.com>
References: <20200407110236.930134290@infradead.org>
        <20200407111007.352324393@infradead.org>
        <20200408015124.ec42bcffc1377cb6ea94f785@kernel.org>
        <55dfd3fd-26c2-77d6-4961-3cef8d746f7f@citrix.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, 7 Apr 2020 18:16:58 +0100
Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> On 07/04/2020 17:51, Masami Hiramatsu wrote:
> > diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> > index d74d9e605723..ade80796453c 100644
> > --- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
> > +++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
> > @@ -70,6 +70,8 @@ BEGIN {
> >  	mmx_expr = "^(emms|fxsave|fxrstor|ldmxcsr|stmxcsr)" # MMX/SSE nmemonics lacking operands
> >  	fpu_expr = "^x87"
> >  
> > +	vmx_expr = "^VM.*" # All mnemonic start with "VM" are VMX instructions
> 
> Not really.
> 
> VMMCALL, VMLOAD, VMSAVE and VMRUN are SVM instructions.

Here VMX will include SVM instructions. Would we need to distinguish them in this context?
(Or INAT_VIRT might be politically correct :) )

> VMASKMOV is a AVX instruction.

Good point. That instruction is written in lowercase "vmaskmov" in x86-opcode-map.txt.
(Maybe it is better to note it in x86-opcode-map.txt)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
