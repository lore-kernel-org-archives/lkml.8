Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16800C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E3D214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TpG+6c0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDXXiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXXiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:38:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24A2C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=1kE1ygMphBI1acwN/x2SI7YosUDCPqxGn8y0bHaCg6g=; b=TpG+6c0aIDsnnbYJsiU2GdiEKg
        NYB7/SOQ3XKLgNBMTPfMCMpFLHvtueQkoFUYbm7G1t3il35JmCEeZibxbqCxKfxbghAKjMS6WuoqO
        ys5EivsAKATZWGdg64FmpZUcSX1uZ9by4cTeHGhx21TZrGHs6/85iOC4BMCnbk6VBNfb4mACyFlkQ
        C+d9WiTAtwGb3jO6EiRVgIv3YlWZ9CS0X+dG9qiNpMdbNMmfrXLus6srFEdhktDCto4jpDQ4R+4iO
        SeuGifqXnNti0sVKuGc+kg2G3NUJRbVRnZQsJmslBEH2xnim6rTPWNO/F96eppZPH85+R/oplOSEX
        Hnn08PoQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jS7tT-0002ue-BC; Fri, 24 Apr 2020 23:38:03 +0000
Subject: Re: [PATCH] samples/ftrace: Fix asm function ELF annotations
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <86c1cbca67cb353da9f335643ef5fd19bd82988f.1587761369.git.jpoimboe@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f5c21ce6-45a0-adbb-8af8-9db77469df73@infradead.org>
Date:   Fri, 24 Apr 2020 16:38:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <86c1cbca67cb353da9f335643ef5fd19bd82988f.1587761369.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 1:49 PM, Josh Poimboeuf wrote:
> Enable objtool coverage for the sample ftrace modules by adding ELF
> annotations to the asm trampoline functions.
> 
>   samples/ftrace/ftrace-direct.o: warning: objtool: .text+0x0: unreachable instruction
>   samples/ftrace/ftrace-direct-modify.o: warning: objtool: .text+0x0: unreachable instruction
>   samples/ftrace/ftrace-direct-too.o: warning: objtool: .text+0x0: unreachable instruction
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  samples/ftrace/ftrace-direct-modify.c | 4 ++++
>  samples/ftrace/ftrace-direct-too.c    | 2 ++
>  samples/ftrace/ftrace-direct.c        | 2 ++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
> index e04229d21475..c13a5bc5095b 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -20,18 +20,22 @@ static unsigned long my_ip = (unsigned long)schedule;
>  
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
> +"	.type		my_tramp1, @function\n"
>  "   my_tramp1:"
>  "	pushq %rbp\n"
>  "	movq %rsp, %rbp\n"
>  "	call my_direct_func1\n"
>  "	leave\n"
> +"	.size		my_tramp1, .-my_tramp1\n"
>  "	ret\n"
> +"	.type		my_tramp2, @function\n"
>  "   my_tramp2:"
>  "	pushq %rbp\n"
>  "	movq %rsp, %rbp\n"
>  "	call my_direct_func2\n"
>  "	leave\n"
>  "	ret\n"
> +"	.size		my_tramp2, .-my_tramp2\n"
>  "	.popsection\n"
>  );
>  
> diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
> index 27efa5f6ff52..d5c5022be664 100644
> --- a/samples/ftrace/ftrace-direct-too.c
> +++ b/samples/ftrace/ftrace-direct-too.c
> @@ -15,6 +15,7 @@ extern void my_tramp(void *);
>  
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
> +"	.type		my_tramp, @function\n"
>  "   my_tramp:"
>  "	pushq %rbp\n"
>  "	movq %rsp, %rbp\n"
> @@ -27,6 +28,7 @@ asm (
>  "	popq %rdi\n"
>  "	leave\n"
>  "	ret\n"
> +"	.size		my_tramp, .-my_tramp\n"
>  "	.popsection\n"
>  );
>  
> diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
> index a2e3063bd306..63ca06d42c80 100644
> --- a/samples/ftrace/ftrace-direct.c
> +++ b/samples/ftrace/ftrace-direct.c
> @@ -13,6 +13,7 @@ extern void my_tramp(void *);
>  
>  asm (
>  "	.pushsection    .text, \"ax\", @progbits\n"
> +"	.type		my_tramp, @function\n"
>  "   my_tramp:"
>  "	pushq %rbp\n"
>  "	movq %rsp, %rbp\n"
> @@ -21,6 +22,7 @@ asm (
>  "	popq %rdi\n"
>  "	leave\n"
>  "	ret\n"
> +"	.size		my_tramp, .-my_tramp\n"
>  "	.popsection\n"
>  );
>  
> 


-- 
~Randy
