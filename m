Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F7C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659E32074D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+WMr8KG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCXVKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:10:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47253 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbgCXVKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585084215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a1cddOFNzKiuz4HxLKTDXuP0YWdbsERaj9bizJLyUwE=;
        b=U+WMr8KGCTnz5pVEesrusr7I5u99KaHx1oepJODqUu6s2KtMi0/9PXd9vDVgEjRF4YRDpI
        dnBa2F8u2t+3C7BZa/nFsAekZ3NtcPxF6lbBtGFrhMVcvGWrujaDu5891COnEToGSAnlJV
        pSfQEb5ZCyOE0v4i5j8sY/NMG88vsbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-cr3paSwiP2a7omC8NSdOpw-1; Tue, 24 Mar 2020 17:10:11 -0400
X-MC-Unique: cr3paSwiP2a7omC8NSdOpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA8BF107ACC4;
        Tue, 24 Mar 2020 21:10:09 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B769A8F363;
        Tue, 24 Mar 2020 21:10:08 +0000 (UTC)
Date:   Tue, 24 Mar 2020 16:10:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 17/26] objtool: Re-arrange validate_functions()
Message-ID: <20200324211006.vaocsz2s7xcalr2i@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.924304616@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324160924.924304616@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:31:30PM +0100, Peter Zijlstra wrote:
> In preparation to adding a vmlinux.o specific pass, rearrange some
> code. No functional changes intended.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/check.c |   60 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2413,9 +2413,8 @@ static bool ignore_unreachable_insn(stru
>  	return false;
>  }
>  
> -static int validate_functions(struct objtool_file *file)
> +static int validate_section(struct objtool_file *file, struct section *sec)
>  {
> -	struct section *sec;
>  	struct symbol *func;
>  	struct instruction *insn;
>  	struct insn_state state;
> @@ -2428,35 +2427,44 @@ static int validate_functions(struct obj
>  	       CFI_NUM_REGS * sizeof(struct cfi_reg));
>  	state.stack_size = initial_func_cfi.cfa.offset;
>  
> -	for_each_sec(file, sec) {
> -		list_for_each_entry(func, &sec->symbol_list, list) {
> -			if (func->type != STT_FUNC)
> -				continue;
> -
> -			if (!func->len) {
> -				WARN("%s() is missing an ELF size annotation",
> -				     func->name);
> -				warnings++;
> -			}
> -
> -			if (func->pfunc != func || func->alias != func)
> -				continue;
> -
> -			insn = find_insn(file, sec, func->offset);
> -			if (!insn || insn->ignore || insn->visited)
> -				continue;
> -
> -			state.uaccess = func->uaccess_safe;
> -
> -			ret = validate_branch(file, func, insn, state);
> -			if (ret && backtrace)
> -				BT_FUNC("<=== (func)", insn);
> -			warnings += ret;
> +	list_for_each_entry(func, &sec->symbol_list, list) {
> +		if (func->type != STT_FUNC)
> +			continue;
> +
> +		if (!func->len) {
> +			WARN("%s() is missing an ELF size annotation",
> +					func->name);

wonky indentation

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

