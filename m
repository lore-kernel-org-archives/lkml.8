Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B04EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34C420719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5jZnoc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgDGN1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:27:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37241 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728482AbgDGN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586266074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XbhhpaH/SFh6E99OqnskVI1bse12C1UUsZMwShUxJYc=;
        b=Z5jZnoc2UOqK8Aby7ru2nFwImerM3xnztdQ1Gk//C32d9MM9TM+ve4QnDHHbLsmPLxKCot
        TM2vYgI9XHrvrjSXjfB7ebWnmHPypK5ApBOKct8zUAkODJ/INtNjx6uqDjJDf2u6JZPHS2
        ncOU8vYXLLuKG7OkYM0Rmx81oMUiUrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-UsDFAZpXOSCwoiO2FQ8XBQ-1; Tue, 07 Apr 2020 09:27:50 -0400
X-MC-Unique: UsDFAZpXOSCwoiO2FQ8XBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C87CA0CCB;
        Tue,  7 Apr 2020 13:27:49 +0000 (UTC)
Received: from treble (ovpn-116-24.rdu2.redhat.com [10.10.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 647B35DF2A;
        Tue,  7 Apr 2020 13:27:47 +0000 (UTC)
Date:   Tue, 7 Apr 2020 08:27:45 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V2 6/9] x86/speculation: Change __FILL_RETURN_BUFFER to
 work with objtool
Message-ID: <20200407132745.iieggolloidvdiwu@treble>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-7-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407073142.20659-7-alexandre.chartre@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:31:39AM +0200, Alexandre Chartre wrote:
> Change __FILL_RETURN_BUFFER so that the stack state is deterministically
> defined for each iteration and that objtool can have an accurate view
> of the stack.
> 
> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>  arch/x86/include/asm/nospec-branch.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 5c24a7b35166..9a946fd5e824 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -60,8 +60,8 @@
>  	jmp	775b;				\
>  774:						\
>  	dec	reg;				\
> -	jnz	771b;				\
> -	add	$(BITS_PER_LONG/8) * nr, sp;
> +	add	$(BITS_PER_LONG/8) * 2, sp;	\
> +	jnz	771b;
>  
>  #ifdef __ASSEMBLY__

This still isn't a complete fix because the macro is used in an
alternative.  So in the !X86_FEATURE_RSB_CTXSW case, this code isn't
patched in and the ORC data which refers to it is wrong.

As I said before I think the easiest fix would be to convert RSB and
retpolines to use static branches instead of alternatives.

-- 
Josh

