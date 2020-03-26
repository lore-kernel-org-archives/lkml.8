Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521F8C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222BC2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585186321;
	bh=4xTfullO5VLxDedU6xpT8Tve12vpn0mxm08+kaIPBrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=le0cgMv2RQg5FVXDFupZy0M5llK/fKyiX8RThSKEHAYys2WroU3VGQhDTdMvj4owt
	 WMn4BqmCQGHrgsD+IBHctrGR5cW3+PXmlMQ4308DDg0R8SnXjrKRi56JXnaQRwJK5U
	 KGJ+DFlio652JYv5PeCzwOBYBmprFgDXoK3hdZYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCZBcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgCZBb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:31:59 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D59AA20719;
        Thu, 26 Mar 2020 01:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585186318;
        bh=4xTfullO5VLxDedU6xpT8Tve12vpn0mxm08+kaIPBrE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YXQQplg9DN+lwKhz9fKK/S6DpHuHDIN0HMHBZAGcaP6ugTJRtmOjKCD4eUz/3CKZ7
         jbyKdAmvsATalTg+SaAuKY2Z99mtUtiU6OqajLDH3u0NuYZQ/UHNsiqd+OnxxoqjNG
         FOB6SFLLuBZWB+rIwlr+gMAxJn/RYS0Gx5PItatw=
Date:   Thu, 26 Mar 2020 10:31:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mingbo Zhang <whensungoes@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
Message-Id: <20200326103153.de709903f26fee0918414bd2@kernel.org>
In-Reply-To: <20200303045033.6137-1-whensungoes@gmail.com>
References: <20200303045033.6137-1-whensungoes@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon,  2 Mar 2020 23:50:30 -0500
Mingbo Zhang <whensungoes@gmail.com> wrote:

> Intel CET instructions are not described in the Intel SDM. When trying to
> get the instruction length, the following instructions get wrong (missing
> ModR/M byte).
> 
> RDSSPD r32
> RSDDPQ r64
> ENDBR32
> ENDBR64
> WRSSD r/m32, r32
> WRSSQ r/m64, r64
> 
> RDSSPD/Q and ENDBR32/64 use the same opcode (f3 0f 1e) slot, which is
> described in SDM as Reserved-NOP with no encoding characters, and got an
> empty slot in the opcode map. WRSSD/Q (0f 38 f6) also got an empty slot.
> 

This looks good to me. BTW, wouldn't we need to add decode test cases to perf?

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Mingbo Zhang <whensungoes@gmail.com>
> ---
>  arch/x86/lib/x86-opcode-map.txt       | 4 ++--
>  tools/arch/x86/lib/x86-opcode-map.txt | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> index 53adc1762ec0..0e3434c882d4 100644
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -366,7 +366,7 @@ AVXcode: 1
>  1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
>  1c: Grp20 (1A),(1C)
>  1d:
> -1e:
> +1e: NOP Gy,Gy
>  1f: NOP Ev
>  # 0x0f 0x20-0x2f
>  20: MOV Rd,Cd
> @@ -804,7 +804,7 @@ f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
>  f2: ANDN Gy,By,Ey (v)
>  f3: Grp17 (1A)
>  f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
> -f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
> +f6: NOP Ey,Gy | ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
>  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
>  f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
>  f9: MOVDIRI My,Gy
> diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
> index 53adc1762ec0..0e3434c882d4 100644
> --- a/tools/arch/x86/lib/x86-opcode-map.txt
> +++ b/tools/arch/x86/lib/x86-opcode-map.txt
> @@ -366,7 +366,7 @@ AVXcode: 1
>  1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
>  1c: Grp20 (1A),(1C)
>  1d:
> -1e:
> +1e: NOP Gy,Gy
>  1f: NOP Ev
>  # 0x0f 0x20-0x2f
>  20: MOV Rd,Cd
> @@ -804,7 +804,7 @@ f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
>  f2: ANDN Gy,By,Ey (v)
>  f3: Grp17 (1A)
>  f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
> -f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
> +f6: NOP Ey,Gy | ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
>  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
>  f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
>  f9: MOVDIRI My,Gy
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
