Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D761C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3566920708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ArjHkPiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgEAMdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728682AbgEAMdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:33:40 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B680DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i0w1XvvvNEeQ8/SDOP5BmNxiGkiniSG4kmik5XFiNSA=; b=ArjHkPiBh+R+86CFTF3YO8VhCb
        /Rj5IeMU7/cY7LNzt8tGCkQ/CUDCB1isD4l6O4FAW0Nwxb3RkHsv4OrkE1f60p9yH+eaq5YQ8ARBX
        66NwcSRBDog3O7vX1VqI1SNw3qjO16NMC/v5NHuJPJDF++ZMl5+pO0FGj7ZnmKOhRa+fA5Vq6emS0
        TzFc2eZ+l+MMe5JyWoo9BtSfBzZappuBssO16SeWBy0XJz04j3W4YqmTPW0lwXgJzoTXq7ynt3HVE
        GAyjKvEzDgFzdJib1p13nzEX8gbiyYSfgqFP4ZamrPDh4XE9C0zjFfjfCVzXNUdbou106lwFwR5Rt
        Fz4SjJ6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUUr2-0004TG-Gb; Fri, 01 May 2020 12:33:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51CED300130;
        Fri,  1 May 2020 14:33:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C79829A7943C; Fri,  1 May 2020 14:33:19 +0200 (CEST)
Date:   Fri, 1 May 2020 14:33:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200501123319.GC3762@hirez.programming.kicks-ass.net>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
 <20200501010733.ptvgzl3nbxybo4rd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501010733.ptvgzl3nbxybo4rd@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 08:07:33PM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 30, 2020 at 04:05:07PM +0200, Arnd Bergmann wrote:
> > lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x133: call to do_strncpy_from_user() with UACCESS enabled
> > lib/strnlen_user.o: warning: objtool: strnlen_user()+0x122: call to do_strnlen_user() with UACCESS enabled
> 
> Does this fix it?
> 

GCC is a moron, a static function with inline and a single callsite,
let's out-of-line it, shees!, try this instead:

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 706020b06617..be420c8c0fdd 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -24,7 +24,7 @@
  * hit it), 'max' is the address space maximum (and we return
  * -EFAULT if we hit it).
  */
-static inline long do_strncpy_from_user(char *dst, const char __user *src,
+static __always_inline long do_strncpy_from_user(char *dst, const char __user *src,
 					unsigned long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 41670d4a5816..c996b745733e 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -20,7 +20,7 @@
  * if it fits in a aligned 'long'. The caller needs to check
  * the return value against "> max".
  */
-static inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
+static __always_inline long do_strnlen_user(const char __user *src, unsigned long count, unsigned long max)
 {
 	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
 	unsigned long align, res = 0;

