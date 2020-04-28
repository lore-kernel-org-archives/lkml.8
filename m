Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0719C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806CD206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2zBwzPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgD1Wss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:48:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28133 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1Wsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588114126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDlc9kkbs35fKeQ7nMa6pyxw4cDkdD/FqAhx/zDgHv4=;
        b=c2zBwzPzsgSQofqVS14wD2hGQzLOOEUW7pHmhLfMuYJz7KREGjC7m24RS/sdTaReYqpn7o
        oIjpzaw+wWqCgVWED5Ivn9f6u70kgHxNX1X06mJeSX23DLSRD7w1PO41xuiLSTmx1AKRmE
        VSx/eWoUct774JC+Sm+Jws/2niSdTz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-V9fve5YtN0CwuGIkI45MQA-1; Tue, 28 Apr 2020 18:48:44 -0400
X-MC-Unique: V9fve5YtN0CwuGIkI45MQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE82D107ACCA;
        Tue, 28 Apr 2020 22:48:42 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D37A05D710;
        Tue, 28 Apr 2020 22:48:40 +0000 (UTC)
Date:   Tue, 28 Apr 2020 17:48:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200428224838.k4ttccrtoug5otan@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <CAK8P3a0X4kMW1BQU6x9A2oo6i3-CMxi1h=0PhQgEbBtYWbJa9A@mail.gmail.com>
 <20200428203855.zapf6jhcp6mbft7i@treble>
 <20200428215554.GA16027@hirez.programming.kicks-ass.net>
 <20200428220353.uepo455bj76sym4k@treble>
 <20200428223327.GC16027@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428223327.GC16027@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:33:27AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 05:03:53PM -0500, Josh Poimboeuf wrote:
> > On Tue, Apr 28, 2020 at 11:55:54PM +0200, Peter Zijlstra wrote:
> 
> > > binutils.git/gas/configure/tc-i386.c:i386_generate_nops
> > > 
> > > When there's too many NOPs (as here) it generates a JMP across the NOPS.
> > > It makes some sort of sense, at some point executing NOPs is going to be
> > > more expensive than a branch.. But shees..
> > 
> > Urgh.  Even if I tell it specifically to pad with NOPs, it still does
> > this "trick".  I have no idea how to deal with this in objtool.
> 
> This is horrible... but it _might_ just work.

HAHA, nice.

This seems to work:

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3063aa9090f9..afdf43c9bac1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -597,8 +597,13 @@ SYM_CODE_START_LOCAL(common_spurious)
 SYM_CODE_END(common_spurious)
 _ASM_NOKPROBE(common_spurious)
 
+.macro P2ALIGN_NOPS shift
+	.p2align \shift-1
+	.p2align \shift
+.endm
+
 /* common_interrupt is a hotpath. Align it */
-	.p2align CONFIG_X86_L1_CACHE_SHIFT
+P2ALIGN_NOPS shift=CONFIG_X86_L1_CACHE_SHIFT
 SYM_CODE_START_LOCAL(common_interrupt)
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry

