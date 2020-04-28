Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA641C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C662085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHBKioGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgD1Tze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:55:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32375 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728713AbgD1Tzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588103732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wnxZ+MGYIfVpjNWWL77weyCkpT6dVXtZj0ovH4iODX0=;
        b=ZHBKioGqC5fOCm5B1qPXXuR3/rNRn5UkalmvK5gxaOizZYUluRG+NyWiYzAJH8F5cdYbEr
        cZYmv6un7wO5bcJTQTMh/1VT/uBQxKyb7E6Z+6vscRMOc7tq4SfSY2j67N2kqKjpJPv+w/
        Us0Z812GAm4EzxK91HfrsOoPuWJ1Je8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-sRF5gptWPbqB8tamEeScuw-1; Tue, 28 Apr 2020 15:55:28 -0400
X-MC-Unique: sRF5gptWPbqB8tamEeScuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B41187661D;
        Tue, 28 Apr 2020 19:55:27 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B45A60638;
        Tue, 28 Apr 2020 19:55:25 +0000 (UTC)
Date:   Tue, 28 Apr 2020 14:55:24 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 02/14] objtool: Fix ORC vs alternatives
Message-ID: <20200428195524.iidaw7vjrnyrq72l@treble>
References: <20200428191101.886208539@infradead.org>
 <20200428191659.499074346@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428191659.499074346@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:11:03PM +0200, Peter Zijlstra wrote:
> Jann reported that (for instance) entry_64.o:general_protection has
> very odd ORC data:
> 
>   0000000000000f40 <general_protection>:
>   #######sp:sp+8 bp:(und) type:iret end:0
>     f40:       90                      nop
>   #######sp:(und) bp:(und) type:call end:0
>     f41:       90                      nop
>     f42:       90                      nop
>   #######sp:sp+8 bp:(und) type:iret end:0
>     f43:       e8 a8 01 00 00          callq  10f0 <error_entry>
>   #######sp:sp+0 bp:(und) type:regs end:0
>     f48:       f6 84 24 88 00 00 00    testb  $0x3,0x88(%rsp)
>     f4f:       03
>     f50:       74 00                   je     f52 <general_protection+0x12>
>     f52:       48 89 e7                mov    %rsp,%rdi
>     f55:       48 8b 74 24 78          mov    0x78(%rsp),%rsi
>     f5a:       48 c7 44 24 78 ff ff    movq   $0xffffffffffffffff,0x78(%rsp)
>     f61:       ff ff
>     f63:       e8 00 00 00 00          callq  f68 <general_protection+0x28>
>     f68:       e9 73 02 00 00          jmpq   11e0 <error_exit>
>   #######sp:(und) bp:(und) type:call end:0
>     f6d:       0f 1f 00                nopl   (%rax)
> 
> Note the entry at 0xf41. Josh found this was the result of commit:
> 
>   764eef4b109a ("objtool: Rewrite alt->skip_orig")
> 
> Due to the early return in validate_branch() we no longer set
> insn->cfi of the original instruction stream (the NOPs at 0xf41 and
> 0xf42) and we'll end up with the above weirdness.
> 
> In other discussions we realized alternatives should be ORC invariant;
> that is, due to there being only a single ORC table, it must be valid
> for all alternatives. The easiest way to ensure this is to not allow
> any stack modifications in alternatives.
> 
> When we enforce this latter observation, we get the property that the
> whole alternative must have the same CFI, which we can employ to fix
> the former report.
> 
> Fixes: 764eef4b109a ("objtool: Rewrite alt->skip_orig")
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/Documentation/stack-validation.txt |    7 ++++
>  tools/objtool/check.c                            |   34 ++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> --- a/tools/objtool/Documentation/stack-validation.txt
> +++ b/tools/objtool/Documentation/stack-validation.txt
> @@ -315,6 +315,13 @@ they mean, and suggestions for how to fi
>        function tracing inserts additional calls, which is not obvious from the
>        sources).
>  
> +10. file.o: warning: func()+0x5c: alternative modifies stack
> +
> +    This means that an alternative includes instructions that modify the
> +    stack. The problem is that there is only one ORC unwind table, this means
> +    that the ORC unwind entries must be valid for each of the alternatives.
> +    The easiest way to enforce this is to ensure alternative do not contain

"alternatives"

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

