Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E8CC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E478C2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5/C/eVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbgCPQ0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:26:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20898 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731950AbgCPQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:26:11 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 12:26:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584375970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsohC5NdJJ5zDtE0SOF+eo4QhwaKwX3h4pprMB28X5Q=;
        b=E5/C/eVX68ulzHqrpKgaFwgNf5lswG/krOFKeLhQ61RTcYN1ZoAPXjHuobFAjunzkY9Xiy
        SoC0H+MiZTOt6WoCxZpqGXXUbQ0EMN2Vaq/g41if0mtSgATSD7AKYYWTmSbzGS3uYhJ4VL
        vNay5HsJhNO+FW6Uf2913oVOCus0c1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-IzJrVBllPJ-BGiD1AR_Pjg-1; Mon, 16 Mar 2020 12:19:08 -0400
X-MC-Unique: IzJrVBllPJ-BGiD1AR_Pjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D6319E3D05;
        Mon, 16 Mar 2020 16:19:07 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3201001DC2;
        Mon, 16 Mar 2020 16:19:06 +0000 (UTC)
Date:   Mon, 16 Mar 2020 11:19:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 15/16] objtool: Implement noinstr validation
Message-ID: <20200316161904.zouwkwup6vwsmxgp@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135042.288201372@infradead.org>
 <20200315180320.cgy2ealklbjlx4g7@treble>
 <20200316132419.GF12521@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316132419.GF12521@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:24:19PM +0100, Peter Zijlstra wrote:
> > And "read_instr_hints" reads as "read_instruction_hints()".
> > 
> > Can we come up with a more readable name?  Why not just "notrace"?
> > 
> > The trace begin/end annotations could be
> > 
> >   trace_allow_begin()
> >   trace_allow_end()
> 
> notrace already exists and we didn't want to confuse things further.

Um, why would it confuse things to call a section of notrace code
".notrace.text"???

> > Also -- what happens when a function belongs in both .notrace.text and
> > in one of the other special-purpose sections like .sched.text,
> > .meminit.text or .entry.text?
> 
> Hasn't happened yet, initially we were thinking of using .entry.text for
> this as a whole, but decided against that due to how .entry.text is
> special for PTI (although exposing most of this code really wouldn't
> matter).
> 
> The thing with .sched.text is that we really should never call into
> scheduling from these contexts anyway. We've not ran into meminit yet.
> (all this finicky entry code is ran with IRQs disabled).
> 
> The one that could potentially interfere is .cpuidle.text.
> 
> > Maybe storing pointers to the functions, like NOKPROBE_SYMBOL does,
> > would be better than putting the functions in a separate section.
> 
> Thing is, I really _hate_ that annotation style.

I do too, but I get the feeling this "put everything in its own section"
thing is going to bite us.

> > Also, maybe we can just hard-code the fact that vmlinux.o is always
> > noinstr-only.  Over time we'll probably need to move more per-.o
> > functionalities to vmlinux.o and I think we should avoid creating a
> > bunch of cmdline options.
> 
> but you're ruining things here, see, for a regular x86_64 config, we'd
> run this with:
> 
> 	objtool check -fail vmlinux.o
>
> And I was hoping to get vmlinux.o objtool clean, surprisingly there
> really aren't that many complaints. But the -i thing makes it run
> significantly faster without duplicating all the bits we've already
> checked.

My suggestion is that the "-i" option would be hard-coded (for now).  So
nothing extra would get checked.

-- 
Josh

