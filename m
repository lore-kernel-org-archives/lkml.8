Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C10C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B0C206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nj9SP6zN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732316AbgDATF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:05:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36151 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726785AbgDATF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585767955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFdpcoTA4jsLarYiYPsXrW1fL3hk+7go53WyoZphPvg=;
        b=Nj9SP6zN8LEExUdAt3HweuJYqgFm+5uacTlTMNkjefikohflmFsdrtgJYNgu/WWSr56fvJ
        RaWWHNbTSW8CRFyUun4hdAMUaAG5Eo58yAH6zqqDt8i7SqJuskurDZx7SMJsVw6cIkLOaq
        MLACZEyMqTHnUED1NbUpwCy+eZ9NCMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-WaMpdmD1Mf2XN1TgppcOtw-1; Wed, 01 Apr 2020 15:05:53 -0400
X-MC-Unique: WaMpdmD1Mf2XN1TgppcOtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A35F18A5512;
        Wed,  1 Apr 2020 19:05:51 +0000 (UTC)
Received: from treble (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E12E55DA76;
        Wed,  1 Apr 2020 19:05:49 +0000 (UTC)
Date:   Wed, 1 Apr 2020 14:05:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 3/5] objtool: Support Clang non-section symbols in ORC
 generation
Message-ID: <20200401190548.rodiauk3iolknvfe@treble>
References: <cover.1585761021.git.jpoimboe@redhat.com>
 <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
 <20200401184953.GZ20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401184953.GZ20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 08:49:53PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 01, 2020 at 01:23:27PM -0500, Josh Poimboeuf wrote:
> 
> > @@ -105,8 +100,32 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
> >  	}
> >  	memset(rela, 0, sizeof(*rela));
> >  
> > -	rela->sym = insn_sec->sym;
> > -	rela->addend = insn_off;
> > +	if (insn_sec->sym) {
> > +		rela->sym = insn_sec->sym;
> > +		rela->addend = insn_off;
> > +	} else {
> > +		/*
> > +		 * The Clang assembler doesn't produce section symbols, so we
> > +		 * have to reference the function symbol instead:
> > +		 */
> > +		rela->sym = find_symbol_containing(insn_sec, insn_off);
> 
> It's a good thing I made that a lot faster I suppose ;-)

:-)

> > +		if (!rela->sym) {
> > +			/*
> > +			 * Hack alert.  This happens when we need to reference
> > +			 * the NOP pad insn immediately after the function.
> > +			 */
> > +			rela->sym = find_symbol_containing(insn_sec,
> > +							   insn_off - 1);
> 
> Urgh, when does that happen? 

It happens naturally in the padding between functions, since objtool
doesn't traverse those instructions.  So they have undefined entries
like

 .text+68: sp:(und) bp:(und) type:call end:0

I suppose those aren't technically necessary.

-- 
Josh

