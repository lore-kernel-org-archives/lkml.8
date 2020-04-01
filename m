Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B43C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E360A206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfVSzmTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbgDATJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:09:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43186 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732148AbgDATJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585768141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fxjc2faGUuidInE7GQX8+k3Ww+5cqbigEP6zGWTotOQ=;
        b=CfVSzmTwh+IhyjG2Y4OwNKtNCvAIC34Kl2zwxev+weZjloopS6xCegmSaTaacfYSVtgYn4
        Ju58cBHeWT4VbygTyMh5BA1EEyztuaiBgiPp6m8/DtHVUb4B8+ATXA7/07/pXzUiihb6d9
        MN2FEycwd30/Q2hbFslBAKPOJ5ybmAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-m4nIgWddMrSTUt7mi-QG0Q-1; Wed, 01 Apr 2020 15:08:59 -0400
X-MC-Unique: m4nIgWddMrSTUt7mi-QG0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15BE38017FA;
        Wed,  1 Apr 2020 19:08:58 +0000 (UTC)
Received: from treble (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D5C950BEE;
        Wed,  1 Apr 2020 19:08:57 +0000 (UTC)
Date:   Wed, 1 Apr 2020 14:08:55 -0500
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
Message-ID: <20200401190855.yvk4lc3ijaexoxal@treble>
References: <cover.1585761021.git.jpoimboe@redhat.com>
 <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
 <20200401184953.GZ20730@hirez.programming.kicks-ass.net>
 <20200401190548.rodiauk3iolknvfe@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401190548.rodiauk3iolknvfe@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 02:05:51PM -0500, Josh Poimboeuf wrote:
> On Wed, Apr 01, 2020 at 08:49:53PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 01, 2020 at 01:23:27PM -0500, Josh Poimboeuf wrote:
> > 
> > > @@ -105,8 +100,32 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
> > >  	}
> > >  	memset(rela, 0, sizeof(*rela));
> > >  
> > > -	rela->sym = insn_sec->sym;
> > > -	rela->addend = insn_off;
> > > +	if (insn_sec->sym) {
> > > +		rela->sym = insn_sec->sym;
> > > +		rela->addend = insn_off;
> > > +	} else {
> > > +		/*
> > > +		 * The Clang assembler doesn't produce section symbols, so we
> > > +		 * have to reference the function symbol instead:
> > > +		 */
> > > +		rela->sym = find_symbol_containing(insn_sec, insn_off);
> > 
> > It's a good thing I made that a lot faster I suppose ;-)
> 
> :-)
> 
> > > +		if (!rela->sym) {
> > > +			/*
> > > +			 * Hack alert.  This happens when we need to reference
> > > +			 * the NOP pad insn immediately after the function.
> > > +			 */
> > > +			rela->sym = find_symbol_containing(insn_sec,
> > > +							   insn_off - 1);
> > 
> > Urgh, when does that happen? 
> 
> It happens naturally in the padding between functions, since objtool
> doesn't traverse those instructions.  So they have undefined entries
> like
> 
>  .text+68: sp:(und) bp:(und) type:call end:0
> 
> I suppose those aren't technically necessary.

In fact, we could probably get substantial savings in the ORC table if
we skipped those, i.e.

  .text+0: sp:sp+8 bp:(und) type:call end:0
  .text+8: sp:(und) bp:(und) type:call end:0
  .text+10: sp:sp+8 bp:(und) type:call end:0
  .text+17: sp:sp+16 bp:(und) type:call end:0
  .text+18: sp:sp+24 bp:prevsp-24 type:call end:0
  .text+1c: sp:sp+32 bp:prevsp-24 type:call end:0
  .text+5a: sp:sp+24 bp:prevsp-24 type:call end:0
  .text+61: sp:sp+16 bp:(und) type:call end:0
  .text+63: sp:sp+8 bp:(und) type:call end:0
  .text+68: sp:(und) bp:(und) type:call end:0
  .text+70: sp:sp+8 bp:(und) type:call end:0
  .text+8c: sp:(und) bp:(und) type:call end:0
  .text+90: sp:sp+8 bp:(und) type:call end:0
  .text+cd: sp:(und) bp:(und) type:call end:0
  .text+d0: sp:sp+8 bp:(und) type:call end:0

would be compressed to

  .text+0: sp:sp+8 bp:(und) type:call end:0
  .text+17: sp:sp+16 bp:(und) type:call end:0
  .text+18: sp:sp+24 bp:prevsp-24 type:call end:0
  .text+1c: sp:sp+32 bp:prevsp-24 type:call end:0
  .text+5a: sp:sp+24 bp:prevsp-24 type:call end:0
  .text+61: sp:sp+16 bp:(und) type:call end:0
  .text+63: sp:sp+8 bp:(und) type:call end:0

but I can do that in a separate patch, and if it works I can remove this
hack.

-- 
Josh

