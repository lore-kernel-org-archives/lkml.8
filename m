Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093E4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04222080D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6AtfbNF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="huyQWIPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgGSKjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 06:39:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4486DC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 03:39:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595155185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1ETd7aKPSpRrinlrpad4x5lxTm4WfHvh56U5uL7UPE=;
        b=d6AtfbNFQu5hSS7Hsnpx76Ie2zyZ++Geam3INRfD2YMGCgtSju6pFp3S6WHzz4VnWxndVN
        woj6+CT+PoqdxSlh6UWyp4xMLkYZolgwMozRx4PNQ1tOWujWCHRNgt8edNKE5IqnbjkAcD
        1kJyzbL8TcpDoW1pMM6LfWIDxMCnqGHatAaKldR5CKz5R2s1tkOkLW1FSrMSxiwWRuBEjW
        pkxtZArpp9maN8wQ59qu6k0NnbDDT404XdbkWFz/GqLg1tPNSkQuflA8wngDel628wBZBg
        jyKLWpWM1wTADt3ZzwYN7roKT/2wzwarWemgNwoR9owB37KolR9YHp595nNJyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595155185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1ETd7aKPSpRrinlrpad4x5lxTm4WfHvh56U5uL7UPE=;
        b=huyQWIPP5mwxTRp2eJvw3UaEPGs6rn1ENY8RmBy7MM1jRBkeRMy51MVaCMohHQiiZe+0Pj
        D131i0zXBkXmphBw==
To:     Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/idt: Make sure idt_table takes a whole page
In-Reply-To: <20200719023405.GA564835@rani.riverdale.lan>
References: <0CEC6A66-FD50-4B6B-9521-A40E5B9DA10F@zytor.com> <7FB389D0-77D4-482E-8A21-8662DDB00268@amacapital.net> <0B7CF270-EC04-4907-821A-A01F24BEF156@zytor.com> <20200719023405.GA564835@rani.riverdale.lan>
Date:   Sun, 19 Jul 2020 12:39:44 +0200
Message-ID: <87pn8rokjz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arvind Sankar <nivedita@alum.mit.edu> writes:
> To repeat the commit message, the problem is not misaligned
> bss..page_aligned objects, but symbols in _other_ bss sections, which
> can get allocated in the last page of bss..page_aligned, because its end
> isn't page-aligned (maybe it should be?)

That's the real and underlying problem.

> Given that this IDT's page is actually going to be mapped with different
> page protections, it seems like allocating the full page isn't
> unreasonable.

Wrong. The expectation of bss page aligned is that each object in that
section starts at a page boundary independent of its size.

Having the regular .bss objects which have no alignment requirements
start inside the bss aligned section if the last object there does not
have page size or a multiple of page size, is just hideous.

The right fix is trivial. See below.

Thanks,

        tglx
----
 arch/x86/kernel/vmlinux.lds.S     |    1 +
 include/asm-generic/vmlinux.lds.h |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -358,6 +358,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
+		. = ALIGN(PAGE_SIZE);
 		*(BSS_MAIN)
 		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -738,6 +738,7 @@
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
 		BSS_FIRST_SECTIONS					\
 		*(.bss..page_aligned)					\
+		. = ALIGN(PAGE_SIZE);					\
 		*(.dynbss)						\
 		*(BSS_MAIN)						\
 		*(COMMON)						\
