Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843EEC47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578162184D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kLPsQu+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgEHRc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:32:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60601 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgEHRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:32:54 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 048HWjZ53922207
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 8 May 2020 10:32:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 048HWjZ53922207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020042201; t=1588959166;
        bh=h7A5cg0DMlgygdlKSmaWPgKUTraZaMgxwhuDEQt441A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kLPsQu+Duq12mPPzuMs4vVQvm98FOW4+eK2So3t5EdbQALVaGKvfThPUG8hReyI93
         cfRUohHny9yUmOT+ZAvKFnsGnuUygbVEvUeWTZbE3+G36vBEePb/nB9qZmiawjCfQH
         c1ttYxmSE3mSDyuU+sBSfpYR/2NV2Lv4B1YIT+meF9p+apudxF6bEPq1IZ7ew2wzWN
         oBoImUmOGNJBe19+nPRZzvbEpDLiAaMed/rlr2QYh0Pj6+jDRp8iOI6C3FteW+AVrR
         tGOJrbJ/JWgTw1VYMqTj5Wq5Bm+HLP80m2ynIl9WBJQq/ZiX/Br7Ojo5B/4F5NsDJ6
         hzvdXZ6FbIxIQ==
Subject: Re: [PATCH] x86: Use INVPCID mnemonic in invpcid.h
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200508092247.132147-1-ubizjak@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <8f88a2e9-fe01-3bb8-bc84-17f1b7e2dfeb@zytor.com>
Date:   Fri, 8 May 2020 10:32:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508092247.132147-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>

On 2020-05-08 02:22, Uros Bizjak wrote:
> Current minimum required version of binutils is 2.23,
> which supports INVPCID instruction mnemonic.
> 
> Replace the byte-wise specification of INVPCID with
> this proper mnemonic.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/invpcid.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/invpcid.h b/arch/x86/include/asm/invpcid.h
> index 989cfa86de85..23749bbca0ad 100644
> --- a/arch/x86/include/asm/invpcid.h
> +++ b/arch/x86/include/asm/invpcid.h
> @@ -12,12 +12,9 @@ static inline void __invpcid(unsigned long pcid, unsigned long addr,
>  	 * stale TLB entries and, especially if we're flushing global
>  	 * mappings, we don't want the compiler to reorder any subsequent
>  	 * memory accesses before the TLB flush.
> -	 *
> -	 * The hex opcode is invpcid (%ecx), %eax in 32-bit mode and
> -	 * invpcid (%rcx), %rax in long mode.
>  	 */
> -	asm volatile (".byte 0x66, 0x0f, 0x38, 0x82, 0x01"
> -		      : : "m" (desc), "a" (type), "c" (&desc) : "memory");
> +	asm volatile ("invpcid %1, %0"
> +		      : : "r" (type), "m" (desc) : "memory");
>  }
>  
>  #define INVPCID_TYPE_INDIV_ADDR		0
> 

