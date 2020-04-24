Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD67C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696B62075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWc5yXiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgDXTag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:30:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31285 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725970AbgDXTag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587756634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ge7RuOHNZQV0/ehkXqTGiPI9XSwcuH5fh3qy7yYriIw=;
        b=SWc5yXiLCL9yOQgdvmtFCdvjYVil0SAa4zSvj8IjrPlYUqBckaW/GPbts+8nw6cOC1uZmw
        NYDinTcrCBUh5sci0c3tFbjYt/vcPTSorBAC1SH/pudM4O0aaIfPk7SBiLyRHf2pZLmmFJ
        hcdv362TSK8uar8iNOqEkZLRd1uB1CE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-O485Etz1PCmQkIOHwhF_jA-1; Fri, 24 Apr 2020 15:30:33 -0400
X-MC-Unique: O485Etz1PCmQkIOHwhF_jA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D85DD1009600;
        Fri, 24 Apr 2020 19:30:31 +0000 (UTC)
Received: from treble (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEA2F5D9CA;
        Fri, 24 Apr 2020 19:30:30 +0000 (UTC)
Date:   Fri, 24 Apr 2020 14:30:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH 8/8] x86/retpoline: Fix retpoline unwind
Message-ID: <20200424193028.tecqlugzzue2n5vj@treble>
References: <20200423125013.452964352@infradead.org>
 <20200423125043.129313983@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423125043.129313983@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 02:47:25PM +0200, Peter Zijlstra wrote:
>  .macro CALL_NOSPEC reg:req
>  #ifdef CONFIG_RETPOLINE
> -	ANNOTATE_NOSPEC_ALTERNATIVE
> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg),\
> -		__stringify(RETPOLINE_CALL %\reg), X86_FEATURE_RETPOLINE,\
> -		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_AMD
> +	/*
> +	 * This cannot be ALTERNATIVE_2 like with JMP_NOSPEC, because ORC
> +	 * unwind data is alternative invariant and needs stack modifying
> +	 * instructions to be in the same place for all alternatives.
> +	 *
> +	 * IOW the CALL instruction must be at the same offset for all cases.
> +	 */
> +	ALTERNATIVE "", "lfence", X86_FEATURE_RETPOLINE_AMD
> +	ALTERNATIVE __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
> +		    __stringify(call __x86_retpoline_\reg), X86_FEATURE_RETPOLINE

I'm missing why ALTERNATIVE_2 wouldn't work here.  How is the call a
"stack modifying instruction"?  It's not an intra-function call so it
shouldn't affect ORC at all, right?

>  # define CALL_NOSPEC						\
> -	ANNOTATE_NOSPEC_ALTERNATIVE				\
> -	ALTERNATIVE_2(						\
> -	ANNOTATE_RETPOLINE_SAFE					\
> -	"call *%[thunk_target]\n",				\
> -	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
> -	X86_FEATURE_RETPOLINE,					\
> -	"lfence;\n"						\
> -	ANNOTATE_RETPOLINE_SAFE					\
> -	"call *%[thunk_target]\n",				\
> -	X86_FEATURE_RETPOLINE_AMD)
> +	ALTERNATIVE("", "lfence", X86_FEATURE_RETPOLINE_AMD)	\
> +	ALTERNATIVE(ANNOTATE_RETPOLINE_SAFE			\
> +		    "call *%[thunk_target]\n",			\
> +		    "call __x86_indirect_thunk_%V[thunk_target]\n", \
> +		    X86_FEATURE_RETPOLINE)
> +

Same.

-- 
Josh

