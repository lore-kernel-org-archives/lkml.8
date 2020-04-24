Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B62C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333232098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 19:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJg0h0Ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgDXTFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 15:05:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22916 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728943AbgDXTFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587755098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C8wjwSUlBu5CF9/SPvwHt9jPX1JTspiCCnkRG7oTxtg=;
        b=PJg0h0AoHHhKTF5EeYQ6htWBqMJ+Q9q10ptevsuQZpeoo+tv42BZQodi2YRDXAdXES5G19
        O0xKJ+r7GyxAlnHwO7JK8ZyZRj075TybrCO7pXChcsEQOW5ubD5VC6xNJHt3bShdO8V8xU
        Zv2dwL70n90A4VRmrFODvuNzrgwKMec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-XhIgUx9eNn2lJg2Qo7BFYA-1; Fri, 24 Apr 2020 15:04:53 -0400
X-MC-Unique: XhIgUx9eNn2lJg2Qo7BFYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FC09E99EF;
        Fri, 24 Apr 2020 19:04:30 +0000 (UTC)
Received: from treble (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AABF960F8D;
        Fri, 24 Apr 2020 19:04:29 +0000 (UTC)
Date:   Fri, 24 Apr 2020 14:04:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH 5/8] x86/speculation: Change FILL_RETURN_BUFFER to work
 with objtool
Message-ID: <20200424190427.3p7oxloliov72fwu@treble>
References: <20200423125013.452964352@infradead.org>
 <20200423125042.876058319@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423125042.876058319@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 02:47:22PM +0200, Peter Zijlstra wrote:
>  #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
>  	mov	$(nr/2), reg;			\
>  771:						\
> +	ANNOTATE_INTRA_FUNCTION_CALL		\
>  	call	772f;				\
>  773:	/* speculation trap */			\
> +	UNWIND_HINT_EMPTY;			\
>  	pause;					\
>  	lfence;					\
>  	jmp	773b;				\
>  772:						\
> +	ANNOTATE_INTRA_FUNCTION_CALL		\
>  	call	774f;				\
>  775:	/* speculation trap */			\
> +	UNWIND_HINT_EMPTY;			\
>  	pause;					\
>  	lfence;					\
>  	jmp	775b;				\
>  774:						\
> +	add	$(BITS_PER_LONG/8) * 2, sp;	\
>  	dec	reg;				\
> -	jnz	771b;				\
> -	add	$(BITS_PER_LONG/8) * nr, sp;
> +	jnz	771b;

Looks weird having semicolons for one annotation but not the other...

>  
>  #ifdef __ASSEMBLY__
>  
> @@ -137,10 +143,8 @@
>    */
>  .macro FILL_RETURN_BUFFER reg:req nr:req ftr:req
>  #ifdef CONFIG_RETPOLINE
> -	ANNOTATE_NOSPEC_ALTERNATIVE
> -	ALTERNATIVE "jmp .Lskip_rsb_\@",				\
> -		__stringify(__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP))	\
> -		\ftr
> +	ALTERNATIVE "jmp .Lskip_rsb_\@", "", \ftr
> +	__FILL_RETURN_BUFFER(\reg,\nr,%_ASM_SP)

I almost gave my "you can't change the stack in an alternative" lecture,
then I did a double take :-)

We do still need a patch to prevent other code from doing that though.

-- 
Josh

