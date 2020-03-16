Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BCC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7310320679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/loFjT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbgCPUJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:09:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48767 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732448AbgCPUJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:09:10 -0400
X-Greylist: delayed 6769 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 16:09:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584389348;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=xsg87v4ZnYqqejOLTfGiV7OR+/GOIkFfOkgI4flZm7Y=;
        b=K/loFjT9FGdNOkXSa0BaJ+TiQvrXWzOOcN8vVFMBZivDrOPrLF/60C3ry0HoGch+A8jfHi
        TeDmxJfEApM9zeujT8u77awBZlFNB9BrwoEbfycHd4DanoQ2707Yysx5UPV1HFeRt3FINc
        wAe8ABkObGkz/2mi/FH9rk6IQIRuM1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-NBCfviDWPRObsGGk1T4h_A-1; Mon, 16 Mar 2020 16:09:04 -0400
X-MC-Unique: NBCfviDWPRObsGGk1T4h_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EEDE1005514;
        Mon, 16 Mar 2020 20:09:02 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-112-22.ams2.redhat.com [10.36.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F87D5C1BB;
        Mon, 16 Mar 2020 20:09:01 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 02GK8w6U025167;
        Mon, 16 Mar 2020 21:08:58 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 02GK8t6d025166;
        Mon, 16 Mar 2020 21:08:55 +0100
Date:   Mon, 16 Mar 2020 21:08:55 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316200855.GS2156@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
 <20200316181957.GA348193@rani.riverdale.lan>
 <20200316185418.GA372474@rani.riverdale.lan>
 <20200316195340.GA768497@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316195340.GA768497@rani.riverdale.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 03:53:41PM -0400, Arvind Sankar wrote:
> > /*
> >  * Initialize the stackprotector canary value.
> >  *
> >  * NOTE: this must only be called from functions that never return,
> >  * and it must always be inlined.
> >  */
> > static __always_inline void boot_init_stack_canary(void)
> 
> Ugh, gcc10 tail-call optimizes the cpu_startup_entry call, and so checks
> the canary before jumping out. The xen one will need to have stack
> protector disabled too. It doesn't optimize the arch_call_rest_init call
> in start_kernel for some reason, but we should probably disable it there
> too.

If you mark cpu_startup_entry with __attribute__((noreturn)), then gcc won't
tail call it.
If you don't, you could add asm (""); after the call to avoid the tail call
too.
> 
>      a06:       0f ae f8                sfence
>      a09:       48 8b 44 24 08          mov    0x8(%rsp),%rax
>      a0e:       65 48 2b 04 25 28 00    sub    %gs:0x28,%rax
>      a15:       00 00
>      a17:       75 1b                   jne    a34 <start_secondary+0x164>
>      a19:       48 83 c4 10             add    $0x10,%rsp
>      a1d:       bf 8d 00 00 00          mov    $0x8d,%edi
>      a22:       5b                      pop    %rbx
>      a23:       e9 00 00 00 00          jmpq   a28 <start_secondary+0x158>
>                         a24: R_X86_64_PLT32     cpu_startup_entry-0x4
>      a28:       0f 01 1d 00 00 00 00    lidt   0x0(%rip)        # a2f <start_secondary+0x15f>
>                         a2b: R_X86_64_PC32      debug_idt_descr-0x4
>      a2f:       e9 cc fe ff ff          jmpq   900 <start_secondary+0x30>
>      a34:       e8 00 00 00 00          callq  a39 <start_secondary+0x169>
>                         a35: R_X86_64_PLT32     __stack_chk_fail-0x4

	Jakub

