Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72335C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDE42068E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iHgo0dCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgEAMXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbgEAMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:23:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81434C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4mG4qBfAtTLoyMkOz50BSyv07PCU8ojhx0uykodQSgM=; b=iHgo0dCG9zjACxGyRlYaGP1dA5
        4O39yMe2eUInaL5afhYr4mWY39TpopFdTjWZcoC6ZYx8H1A41fPHwQcNFkxqjr9PKeci77ioIYNiY
        m7mNxSd3Hr3yuNkHAl36bzZjeLy4ulThSLGdWqNSsDtAi0gAz29BNu4q400QoAXNL8hGu7jjvwjLZ
        EEXUa2sgjI5HeiqQ7oTsxz0OYcEVdny2RLnWFd0QB73uJX0djdBHpIHWoeCg4vZ/093z37iimO5IA
        ZsjueeEEzForPFCJhG9AolbSylo5Vzb+/xAjKLhHSCeQJa/FpYSCTI4fSSd6bw8bXdglbN1ggaHpp
        A0ZPfARw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUUhH-0004Hz-8A; Fri, 01 May 2020 12:23:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B133B3011E8;
        Fri,  1 May 2020 14:23:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9633129942A31; Fri,  1 May 2020 14:23:12 +0200 (CEST)
Date:   Fri, 1 May 2020 14:23:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200501122312.GA3762@hirez.programming.kicks-ass.net>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <20200429191846.hcfc7t4zusdudtej@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429191846.hcfc7t4zusdudtej@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 02:18:46PM -0500, Josh Poimboeuf wrote:
> On Tue, Apr 28, 2020 at 11:10:44AM -0500, Josh Poimboeuf wrote:
> > > ==> build/x86/0x2EA4CE4F_defconfig/log <==
> > > kernel/kcov.o: warning: objtool: write_comp_data()+0x1b: call to check_kcov_mode() with UACCESS enabled
> > > kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc()+0x15: call to check_kcov_mode() with UACCESS enabled
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] objtool: Add check_kcov_mode() to the uaccess safelist
> 
> check_kcov_mode() is called by write_comp_data() and
> __sanitizer_cov_trace_pc(), which are already on the uaccess safe list.
> Might as well add check_kcov_mode() to the party.

Hurmph, the actual reason it's ok is because it's notrace and doesn't
call out to other stuff, that's the reason those other two functions got
away without having user_access_save()/restore() on.

The alternative fix would be to mark that check_kcov_mode() thing as
__always_inline, it's puny anyway.

> This fixes the following warnings:
> 
>   kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc()+0x15: call to check_kcov_mode() with UACCESS enabled
>   kernel/kcov.o: warning: objtool: write_comp_data()+0x1b: call to check_kcov_mode() with UACCESS enabled
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/objtool/check.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0c732d586924..fec890547e04 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -516,6 +516,7 @@ static const char *uaccess_safe_builtin[] = {
>  	"__tsan_write16",
>  	/* KCOV */
>  	"write_comp_data",
> +	"check_kcov_mode",
>  	"__sanitizer_cov_trace_pc",
>  	"__sanitizer_cov_trace_const_cmp1",
>  	"__sanitizer_cov_trace_const_cmp2",
> -- 
> 2.21.1
> 
