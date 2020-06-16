Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BAEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1841F207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggxB+wKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgFPUd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFPUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:33:56 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:33:56 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j32so16620693qte.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AfiZlqjHsZkjAu5fvsg6fR8prjnrKc4GQvwb6nf23ac=;
        b=ggxB+wKvfbpbc7+0S9cO2GzWftu4wdCC+ifypfCRSdq+hOcg5t9ByanyZAGVsbJMXG
         3V4wpwT3ILuw4S8NPLW/1hl2xSzccumZJnb8W71hii99cWtgtQ7P0Qw/oXP9YzE2yF4u
         GV7y11CkqFRJxd1W697jS66bSL3Cxhvx/Pad1GGzHJxWoY/ard6xlfrswgjWagTgzpAC
         FTK2t1WkDQim4QLrJXAmCd2o/QL7B7b5oojZmd27NFGvZkBnxrYA6YQl4Kuko5Wf4rUq
         +kb3ITxcppTBQBZhNPxna4zrWJBIn0YNLRQnoPHYBv5uXGMRhnKDPk6IIx+R+tRmpDUq
         o0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AfiZlqjHsZkjAu5fvsg6fR8prjnrKc4GQvwb6nf23ac=;
        b=E/1Xq6dlfRxOd1SVUdnunsIQiTQfVgm8HgO/iq0Oo7J/UgRUmeZtRgISsE/pmsu5X8
         vsFgV6y4hK3CSBE4ZkSUS1HnGpRU1X3cTYb92QBmI+PPi9aC5hmtrjpO4UeABYYeDWuR
         1JlJP1OHfkjHL5kS95JHz1k3n5aSUYN7sViEE8DMeRQQWbeYMog7rHYVMcjy+Ibdc4rZ
         2IJilnS746vSEg+e1Tq2qGoXtrQOFLJW1QSj8Uhn+4EkYPxyW+/Jiem0j+5lEBsR3LKq
         4xOmIICDt734+G4zM9/ILSh7eJTaohSHW5b55AzAG0VwXQAjk43I7FbCmFv3jW7rAqQV
         VTgQ==
X-Gm-Message-State: AOAM530nR0e5ZWhM96J1qqcd6hkvMWwTZsOIHoM2VZS0p+ZYyYnRB7VY
        q32FNJDm23sm/k+ii1xSe90=
X-Google-Smtp-Source: ABdhPJzjbbGpm1SQXQMb539pPnMQSEbYLc9gcmjKqMNtCkSX6hO9X6mxcVhQj1jUMueefkQ0LDMO/A==
X-Received: by 2002:ac8:3066:: with SMTP id g35mr22663700qte.193.1592339634780;
        Tue, 16 Jun 2020 13:33:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k188sm14318783qkb.23.2020.06.16.13.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 13:33:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 16 Jun 2020 16:33:52 -0400
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Linux 5.8-rc1
Message-ID: <20200616203352.GA1815527@rani.riverdale.lan>
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
 <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:11:46PM +0200, Gabriel C wrote:
> * Am So., 14. Juni 2020 um 22:44 Uhr schrieb Linus Torvalds
> <torvalds@linux-foundation.org>:
> 
> Hello,
> 
> > So I didn't really expect this, but 5.8 looks to be one of our biggest
> > releases of all time.
> >
> 
> I hit a compiler error caused by e4160b2e4b02377c67f8ecd05786811598f39acd.
> 
> x86/purgatory: Fail the build if purgatory.ro has missing symbols
> 
> Having CONFIG_STACKPROTECTOR* & CONFIG_KEXEC_FILE enabled always
> results in a linking error like this:
> 
> LD      arch/x86/purgatory/purgatory.chk
> ld: arch/x86/purgatory/purgatory.ro: in function `verify_sha256_digest':
> purgatory.c:(.text+0x108): undefined reference to `__stack_chk_fail'
> ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
> sha256.c:(.text+0x1c74): undefined reference to `__stack_chk_fail'
> ld: arch/x86/purgatory/purgatory.ro: in function `__sha256_final':
> sha256.c:(.text+0x1e65): undefined reference to `__stack_chk_fail'
> ld: arch/x86/purgatory/purgatory.ro: in function `_kstrtoull':
> string.c:(.text+0x2107): undefined reference to `__stack_chk_fail'
> 
> I didn't look closer at that but from the error, it seems to be,
> some missing -fstack-protector* vs -fno-stack-protector* checks
> somewhere.
> 
> 
> Best Regards,
> 
> Gabriel C

Can you attach the output of gcc -dumpspecs and gcc -v? I suspect your
compiler enables stack protector by default. My distro compiler does
that too, but not if -ffreestanding is enabled (which it is for the
purgatory).

Does this patch help?

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index b04e6e72a592..088bd764e0b7 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -34,6 +34,7 @@ KCOV_INSTRUMENT := n
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
+PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
