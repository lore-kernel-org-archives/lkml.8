Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39283C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FFF2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpTsi49N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgCXWQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:16:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22856 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727664AbgCXWQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585088182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wl6e5Hjme3Eyui+2kEPvftwcG8vaxFOByjXtoh2IhHI=;
        b=CpTsi49NeyOyOJDuSlUwIgbfZnDcLKivQ4Syf3my2J6LTRhg4tFR4HPzMj7wyNJYnIL8pL
        7LaSORCGvYfvs5RMIgpmXIJlojJ+BLNIRFV7lSdUrKf4NKf0gwy0dVKelfuZERm0aOX6BK
        cgZ+akA3dqvhdC6HbLX9pqGMyQrnpAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-wb_WXnbKO--A8-5j-RzKVA-1; Tue, 24 Mar 2020 18:16:20 -0400
X-MC-Unique: wb_WXnbKO--A8-5j-RzKVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CA1C107ACC7;
        Tue, 24 Mar 2020 22:16:19 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 746031000322;
        Tue, 24 Mar 2020 22:16:18 +0000 (UTC)
Date:   Tue, 24 Mar 2020 17:16:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 26/26] objtool: Add STT_NOTYPE noinstr validation
Message-ID: <20200324221616.2tdljgyay37aiw2t@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.470421121@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324160925.470421121@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:31:39PM +0100, Peter Zijlstra wrote:
> Make sure to also check STT_NOTYPE symbols for noinstr violations.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/check.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2563,7 +2563,7 @@ static int validate_symbol(struct objtoo
>  		return 1;
>  	}
>  
> -	if (sym->pfunc != sym || sym->alias != sym)
> +	if ((sym->type == STT_FUNC && sym->pfunc != sym) || sym->alias != sym)
>  		return 0;
>  
>  	insn = find_insn(file, sec, sym->offset);
> @@ -2610,6 +2610,23 @@ static int validate_section(struct objto
>  		warnings += validate_symbol(file, sec, func, &state);
>  	}
>  
> +	if (state.noinstr) {
> +		/*
> +		 * In vmlinux mode we will not run validate_unwind_hints() by
> +		 * default which means we'll not otherwise visit STT_NOTYPE
> +		 * symbols.
> +		 *
> +		 * In case of --duplicate mode, insn->visited will avoid actual
> +		 * duplicate work being done.
> +		 */
> +		list_for_each_entry(func, &sec->symbol_list, list) {
> +			if (func->type != STT_NOTYPE)
> +				continue;
> +
> +			warnings += validate_symbol(file, sec, func, &state);
> +		}
> +	}
> +

I guess this is ok, but is there a valid reason why we don't just call
validate_unwind_hints()?

It's also slightly concerning that validate_reachable_instructions()
isn't called, I'm not 100% convinced all the code will get checked.

-- 
Josh

