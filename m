Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E888EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E6D2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqNQky+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbgDCQQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:16:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36770 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404071AbgDCQQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585930575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HdCOAJQBf5kjshxNb+3zZTkGKBqwGXfbMXAkL5oZvvg=;
        b=EqNQky+Sd6E0tliAF/NE/agol1q7mhFAhE4ctd3mSsw0DA3vp8LoSxM8rWunSFpA7ku4Li
        pnuGXyamxZPwvJaDfXorkUSir71HU22OBahAr5VAfNqzexQAVc0sFHDhdO0CtdsiJ3wznk
        X3yGpRjmqtl2CQSVnAZNzk4j79Vj3UE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-RM_xudjgP22Rpw0iwHMPKA-1; Fri, 03 Apr 2020 12:16:13 -0400
X-MC-Unique: RM_xudjgP22Rpw0iwHMPKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31D35A0CC0;
        Fri,  3 Apr 2020 16:16:12 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC76F10027A3;
        Fri,  3 Apr 2020 16:16:10 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:16:07 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH 5/7] x86/speculation: Annotate intra-function calls
Message-ID: <20200403161607.jxz6duaz7dud22wf@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-6-alexandre.chartre@oracle.com>
 <20200403160538.qwu237amhanr6pyi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403160538.qwu237amhanr6pyi@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 11:05:38AM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 02, 2020 at 10:22:18AM +0200, Alexandre Chartre wrote:
> >  .macro RETPOLINE_JMP reg:req
> > -	call	.Ldo_rop_\@
> > +	INTRA_FUNCTION_CALL .Ldo_rop_\@
> >  .Lspec_trap_\@:
> >  	pause
> >  	lfence
> > @@ -102,7 +116,7 @@
> >  .Ldo_retpoline_jmp_\@:
> >  	RETPOLINE_JMP \reg
> >  .Ldo_call_\@:
> > -	call	.Ldo_retpoline_jmp_\@
> > +	INTRA_FUNCTION_CALL .Ldo_retpoline_jmp_\@
> >  .endm
> 
> There's a catch: this is part of an alternative.  Which means if
> X86_FEATURE_RETPOLINE isn't set at runtime, then the retpoline won't be
> there and the ORC data will be wrong.
> 
> In fact objtool should probably be made smart enough to warn about this
> situation, when an alternative changes the stack state.
> 
> The only way I can think of to fix this is to have ORC alternatives :-/

Or they could be converted to use static branches instead of
alternatives.

-- 
Josh

