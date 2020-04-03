Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC9DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2231206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jU/b9ZLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404045AbgDCO6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:58:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25848 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403981AbgDCO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585925899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=on1bKtZlIL1N3USAKGYcyKXZdCQjcVkOO/o7mEoA5jU=;
        b=jU/b9ZLHok+zpJ10hO6fMlm52Zlr+wOf17pnBcyDfKTiMGEfX6NR0nsdyuufWElsA5LSCt
        uIvv41GrNxYTEX4I0L2n3yk2wSwsiKVhCDZbQKP8sFKrmFQSvBd+T5/qhJPhAf3SrUyRtF
        CqxuEuBBe6NSQKeHjYrxnKOz0HY9T3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-kpK4JSH5PriTDNipC-lPew-1; Fri, 03 Apr 2020 10:58:18 -0400
X-MC-Unique: kpK4JSH5PriTDNipC-lPew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50A76107ACC4;
        Fri,  3 Apr 2020 14:58:16 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B1226DD1;
        Fri,  3 Apr 2020 14:58:14 +0000 (UTC)
Date:   Fri, 3 Apr 2020 09:58:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 3/5] objtool: Support Clang non-section symbols in ORC
 generation
Message-ID: <20200403145812.zdoxkyjhn42veu52@treble>
References: <cover.1585761021.git.jpoimboe@redhat.com>
 <9a9cae7fcf628843aabe5a086b1a3c5bf50f42e8.1585761021.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2004031057320.25955@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004031057320.25955@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 10:58:20AM +0200, Miroslav Benes wrote:
> > +	if (insn_sec->sym) {
> > +		rela->sym = insn_sec->sym;
> > +		rela->addend = insn_off;
> > +	} else {
> > +		/*
> > +		 * The Clang assembler doesn't produce section symbols, so we
> > +		 * have to reference the function symbol instead:
> > +		 */
> > +		rela->sym = find_symbol_containing(insn_sec, insn_off);
> > +		if (!rela->sym) {
> > +			/*
> > +			 * Hack alert.  This happens when we need to reference
> > +			 * the NOP pad insn immediately after the function.
> > +			 */
> > +			rela->sym = find_symbol_containing(insn_sec,
> > +							   insn_off - 1);
> > +		}
> 
> I suppose there is always just one NOP pad insn, right? Anyway, it would 
> be better to get rid of it as you proposed.

There can actually be multiple NOPs because functions are aligned on a
16-byte boundary.  But the undefined ORC entry is always at the first
NOP because objtool merges duplicate entries.

-- 
Josh

