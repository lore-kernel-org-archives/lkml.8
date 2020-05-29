Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE98C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587A820814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CFd2q/Wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgE2RLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgE2RLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:11:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF73C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f/in7NoroM39WHJQQWyyxGcdE2gOsEiL3/PCxFMMgDI=; b=CFd2q/Wj/2tYLwwP3ywqyKasst
        ggOZHHxTqoELXqOLh6HPg7Yvgy9ANk/Yz4xuwOdN6ugzCgKFcU7WKKIKadEFt36ElGo8r9qLH6eLB
        vOw3c3hT+E4Y9UkBPSdfsF6dpDi+NhFn7q/BtQhUmxc+rpdYq0BqxiGkFVv6RMcajMLEnA71bBXw8
        1PsUMmpnCPM1aQI25RLPLTFgaF4tR8PFav30DzWMQzYDD6c5JaseDVAO9CEj5De8z8RRNgzgOKZHA
        VnuX7uf48Yup68AfcsJnA+lQAY4ANGbz1ea57CS8NOFoT5N5ZaiPzUenrzTuGL4L2hBmGkfdiBLCg
        CsfcBYUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeiXC-00057Q-0U; Fri, 29 May 2020 17:11:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4212730047A;
        Fri, 29 May 2020 19:11:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F5822BB51407; Fri, 29 May 2020 19:11:04 +0200 (CEST)
Date:   Fri, 29 May 2020 19:11:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: PANIC: double fault in fixup_bad_iret
Message-ID: <20200529171104.GD706518@hirez.programming.kicks-ass.net>
References: <000000000000d2474c05a6c938fe@google.com>
 <CACT4Y+ajjB8RmG3_H_9r-kaRAZ05ejW02-Py47o7wkkBjwup3Q@mail.gmail.com>
 <87o8q6n38p.fsf@nanos.tec.linutronix.de>
 <20200529160711.GC706460@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529160711.GC706460@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:07:11PM +0200, Peter Zijlstra wrote:

> Like with KCSAN, we should blanket kill KASAN/UBSAN and friends (at the
> very least in arch/x86/) until they get that function attribute stuff
> sorted.

Something like so.

---
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378de8bc0..a90d32b87d7e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -1,6 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 # Unified Makefile for i386 and x86_64
 
+#
+# Until such a time that __no_kasan and __no_ubsan work as expected (and are
+# made part of noinstr), don't sanitize anything.
+#
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+
 # select defconfig based on actual architecture
 ifeq ($(ARCH),x86)
   ifeq ($(shell uname -m),x86_64)
