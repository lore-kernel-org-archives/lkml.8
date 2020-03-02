Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D86EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440902146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PM3TrmDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgCBPSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:18:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23690 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726751AbgCBPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583162319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uLJAHthmvS8hkm1/d/PCltojnK50qfTYzIcTPSazgdk=;
        b=PM3TrmDRwdfh7yQBxLq9Rz/hB7XtkGlCX6PQA6RAXYXDUtLRuLX+OOYXMx6I/bUtosnEdb
        0Pt4Hi8JDTat5uSViWGakcNhV2/HYp+l3uS4a+kpm9oDNx+QqJHmKFmdZBfHbopXk3z4zB
        ao2s8ubv5/YJZBPE8yBrVq51iuzSzkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-RTJE1aO2MkGc8DVhMXWMTQ-1; Mon, 02 Mar 2020 10:18:35 -0500
X-MC-Unique: RTJE1aO2MkGc8DVhMXWMTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33E451088397;
        Mon,  2 Mar 2020 15:18:34 +0000 (UTC)
Received: from treble (ovpn-123-162.rdu2.redhat.com [10.10.123.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84D0A8C09A;
        Mon,  2 Mar 2020 15:18:31 +0000 (UTC)
Date:   Mon, 2 Mar 2020 09:18:29 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: x86 entry perf unwinding failure (missing IRET_REGS annotation
 on stack switch?)
Message-ID: <20200302151829.brlkedossh7qs47s@treble>
References: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1rkN0YU-ieBaUZDKFYG5XFnd7dhDjSDdRmVfWyQzsA5g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 07:02:15AM +0100, Jann Horn wrote:
> It looks to me like things go wrong at the point where we switch over
> to the trampoline stack? The ORC info claims that we have full user
> registers on the trampoline stack (and that we're clobbering them with
> our pushes - apparently objtool is not smart enough to realize that
> that looks bogus), but at that point we should probably actually use
> something like UNWIND_HINT_IRET_REGS, right?

Good timing.  I have a patch set coming in a few days which fixes
several ORC issues, and this was one of them.

> By the way, looking through the rest of the entry stuff, there's some
> other funny-looking stuff, too:
> 
> ============
> 0000000000000f40 <general_protection>:
> #######sp:sp+8 bp:(und) type:iret end:0
>      f40:       90                      nop
> #######sp:(und) bp:(und) type:call end:0
>      f41:       90                      nop
>      f42:       90                      nop
> #######sp:sp+8 bp:(und) type:iret end:0
>      f43:       e8 a8 01 00 00          callq  10f0 <error_entry>
> #######sp:sp+0 bp:(und) type:regs end:0
>      f48:       f6 84 24 88 00 00 00    testb  $0x3,0x88(%rsp)
>      f4f:       03
>      f50:       74 00                   je     f52 <general_protection+0x12>
>      f52:       48 89 e7                mov    %rsp,%rdi
>      f55:       48 8b 74 24 78          mov    0x78(%rsp),%rsi
>      f5a:       48 c7 44 24 78 ff ff    movq   $0xffffffffffffffff,0x78(%rsp)
>      f61:       ff ff
>      f63:       e8 00 00 00 00          callq  f68 <general_protection+0x28>
>      f68:       e9 73 02 00 00          jmpq   11e0 <error_exit>
> #######sp:(und) bp:(und) type:call end:0
>      f6d:       0f 1f 00                nopl   (%rax)
> ============
> 
> So I think on machines without X86_FEATURE_SMAP, trying to unwind from
> the two NOPs at f41 and f42 will cause the unwinder to report an
> error? Looking at unwind_next_frame(), "sp:(und)" without the "end:1"
> marker seems to be reserved for errors.

Hm... good catch.  Not sure why objtool is doing that but I'll look into
it.

-- 
Josh

