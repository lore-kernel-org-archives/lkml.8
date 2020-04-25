Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99E3C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC68620728
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 20:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nooniy0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDYUEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYUEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 16:04:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A328C09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8Bd+ctYzTwdjwyV++DNTzMUoXdVybrOMUquy9bP6cAI=; b=nooniy0vGIrVsqOGmfD6M29ODs
        YozmLK1FE0qET6vSCTOOgvPAEjk29Cqb+tLTVRbu8bLFVHFYFIGORou4EAXeSrNbFYUyPwQEgN844
        1pJc0Lv2orKOcbOv5BYlupNtzGU/BKTkUnHCquzQP6t7VgUsJG0whSpR6B6mpIzgpirbXCS6TilOR
        2rnx150LBGecZtb63LGHcxNZrrU0fVoVyn9EsvXFe2y/3EQpYBq2GnOtqy9lQ+MsGr0hGAq89Fq7H
        jEIbBps8PPrPqdGA+qo/Kz3NNaLShQRfxoBtFYz/5BCCO08J/4HUhDU6CZmLvg07ILFPqtzYM1k8k
        LnFhaDeQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSR2N-0000RY-7e; Sat, 25 Apr 2020 20:04:31 +0000
Subject: Re: [PATCH] objtool: Fix infinite loop in for_offset_range()
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>
References: <02b719674b031800b61e33c30b2e823183627c19.1587842122.git.jpoimboe@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <844c4770-5e33-d02c-32d9-200dc7bc4146@infradead.org>
Date:   Sat, 25 Apr 2020 13:04:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <02b719674b031800b61e33c30b2e823183627c19.1587842122.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/20 12:19 PM, Josh Poimboeuf wrote:
> Randy reported that objtool got stuck in an infinite loop when
> processing drivers/i2c/busses/i2c-parport.o.  It was caused by the
> following code:
> 
>   00000000000001fd <line_set>:
>    1fd:	48 b8 00 00 00 00 00 	movabs $0x0,%rax
>    204:	00 00 00
>   			1ff: R_X86_64_64	.rodata-0x8
>    207:	41 55                	push   %r13
>    209:	41 89 f5             	mov    %esi,%r13d
>    20c:	41 54                	push   %r12
>    20e:	49 89 fc             	mov    %rdi,%r12
>    211:	55                   	push   %rbp
>    212:	48 89 d5             	mov    %rdx,%rbp
>    215:	53                   	push   %rbx
>    216:	0f b6 5a 01          	movzbl 0x1(%rdx),%ebx
>    21a:	48 8d 34 dd 00 00 00 	lea    0x0(,%rbx,8),%rsi
>    221:	00
>   			21e: R_X86_64_32S	.rodata
>    222:	48 89 f1             	mov    %rsi,%rcx
>    225:	48 29 c1             	sub    %rax,%rcx
> 
> find_jump_table() saw the .rodata reference and tried to find a jump
> table associated with it (though there wasn't one).  The -0x8 rela
> addend is unusual.  It caused find_jump_table() to send a negative
> table_offset (unsigned 0xfffffffffffffff8) to find_rela_by_dest().
> 
> The negative offset should have been harmless, but it actually threw
> for_offset_range() for a loop... literally.  When the mask value got
> incremented past the end value, it also wrapped to zero, causing the
> loop exit condition to remain true forever.
> 
> Prevent this scenario from happening by ensuring the incremented value
> is always >= the starting value.
> 
> Fixes: 74b873e49d92 ("objtool: Optimize find_rela_by_dest_range()")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Hi Josh,

When applied to linux-next 20200414 (where it was reported) and using
config-r2092, objtool still loops (I killed it after 6 minutes of CPU time).

When applied to linux-next 20200424 and using the same config-r2092 file,
objtool appears to terminate normally and the entire build does also.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  tools/objtool/elf.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index 5e76ac38cf99..f753148f5dac 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -89,9 +89,10 @@ struct elf {
>  #define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
>  #define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
>  
> -#define for_offset_range(_offset, _start, _end)		\
> -	for (_offset = ((_start) & OFFSET_STRIDE_MASK);	\
> -	     _offset <= ((_end) & OFFSET_STRIDE_MASK);	\
> +#define for_offset_range(_offset, _start, _end)			\
> +	for (_offset = ((_start) & OFFSET_STRIDE_MASK);		\
> +	     _offset >= ((_start) & OFFSET_STRIDE_MASK) &&	\
> +	     _offset <= ((_end) & OFFSET_STRIDE_MASK);		\
>  	     _offset += OFFSET_STRIDE)
>  
>  static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
> 


-- 
~Randy
