Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F683C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7562054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z8UG5e/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgELPPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:15:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:15:30 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0A9D0059BB7FCAE11E2EA0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9d00:59bb:7fca:e11e:2ea0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C563C1EC0114;
        Tue, 12 May 2020 17:15:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589296526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bPeAtc/ouqJ2VEXlhLFvfKjqV47RCLeXOikuieDXBWA=;
        b=Z8UG5e/bHeGvTITOd8GxXo0hvpM0PRuSa0dwMrUivg+DvSc0DCTHw2JC6Y8CE5I+T5MKC9
        gZcrlQ6qnMcj9R+8L5FgBBtL44Eh/fpQgkMteRIgkSkWz4Vcxgxfqspk07o+TqggSWoJwK
        kMepWsQGFmHDoZkJUk64qGn+BD53s60=
Date:   Tue, 12 May 2020 17:15:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/cpu] x86/cpu: Use INVPCID mnemonic in invpcid.h
Message-ID: <20200512151522.GB6859@zn.tnic>
References: <20200508092247.132147-1-ubizjak@gmail.com>
 <158929264101.390.18239205970315804831.tip-bot2@tip-bot2>
 <CAFULd4bZLkME4kn9bmbOBMtd+ZpNnsH-w8a6tPdtmpV57WSHtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4bZLkME4kn9bmbOBMtd+ZpNnsH-w8a6tPdtmpV57WSHtw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 04:26:37PM +0200, Uros Bizjak wrote:
> Actually, the order was correct for AT&T syntax in the original patch.
> 
> The insn template for AT&T syntax goes:
> 
> insn arg2, arg1, arg0
> 
> where rightmost arguments are output operands.
> 
> The operands in asm template go
> 
> asm ("insn template" : output0, output1 : input0, input1 : clobbers)
> 
> so, in effect:
> 
> asm ("insn template" : arg0, arg1 : arg2, arg3: clobbers)
> 
> As you can see, the operand order in insn tempate is reversed for AT&T
> syntax. I didn't notice the reversal of operands in your improvement.

Your version had:

+       asm volatile ("invpcid %1, %0"
+                     : : "r" (type), "m" (desc) : "memory");

with "type" being the 0th operand and "desc" being the 1st operand in
the input operands list.

The order of the operands after the "invpcid" mnemonic are the other way
around though: you first have %1 which is "desc" and then %0 which is
the type.

I simply swapped the arguments order in the input operands list, after
the second ':'

+       asm volatile("invpcid %[desc], %[type]"
+                    :: [desc] "m" (desc), [type] "r" (type) : "memory");

so that "desc" comes first and "type" second when reading from
left-to-right in both

1. *after* the "invpcid" mnemonic and
2. in the input operands list, after the second ':'.

And since I'm using the symbolic operand names, then the order just
works because looking at a before-and-after thing doesn't show any
opcode differences:

$ diff -suprN /tmp/before /tmp/after
Files /tmp/before and /tmp/after are identical

$ cat /tmp/before
ffffffff81058392:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8105c542:	66 44 0f 38 82 04 24 	invpcid (%rsp),%r8
ffffffff8105c5b4:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8105ccd2:	66 44 0f 38 82 14 24 	invpcid (%rsp),%r10
ffffffff8105d6cf:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8105d7ef:	66 0f 38 82 1c 24    	invpcid (%rsp),%rbx
ffffffff8105e4db:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8106067b:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8169547d:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff82406698 <x86_noinvpcid_setup>:
ffffffff824066a3:	75 27                	jne    ffffffff824066cc <x86_noinvpcid_setup+0x34>
ffffffff824066b4:	73 16                	jae    ffffffff824066cc <x86_noinvpcid_setup+0x34>
ffffffff824124db:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff82412e34:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff82415158:	66 0f 38 82 44 24 10 	invpcid 0x10(%rsp),%rax

$ cat /tmp/after
ffffffff81058392:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8105c542:	66 44 0f 38 82 04 24 	invpcid (%rsp),%r8
ffffffff8105c5b4:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8105ccd2:	66 44 0f 38 82 14 24 	invpcid (%rsp),%r10
ffffffff8105d6cf:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8105d7ef:	66 0f 38 82 1c 24    	invpcid (%rsp),%rbx
ffffffff8105e4db:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8106067b:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff8169547d:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff82406698 <x86_noinvpcid_setup>:
ffffffff824066a3:	75 27                	jne    ffffffff824066cc <x86_noinvpcid_setup+0x34>
ffffffff824066b4:	73 16                	jae    ffffffff824066cc <x86_noinvpcid_setup+0x34>
ffffffff824124db:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff82412e34:	66 0f 38 82 04 24    	invpcid (%rsp),%rax
ffffffff82415158:	66 0f 38 82 44 24 10 	invpcid 0x10(%rsp),%rax

Makes sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
