Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A2C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FFA20773
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okb9JBtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCSVnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:43:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43546 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgCSVnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:43:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id a6so4007950otb.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 14:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PiU105LwR4CtW43tXMObNmMhkqu4rll7p1Rlw/fDhGQ=;
        b=Okb9JBtLix6HoE/n1OPWQyGcHGdyvGhMF5VDVjtJhupf/8TOqj5A2Tc/UPUs7A31Sd
         fVrixRhLUlniMsL/7tsy/kCBR83JuNMVD6kX5ECVMuxP0zQJSnIJGfq2mtpLK73uxny2
         Xj+HrbKFe7UHqYJOCwqJ24I0r7mkCpDN9cjGeKy10zAyz0r0AC/IBUURV9ieWN6gMIMp
         /z/MZhjnFSdnQ+BHQzCbEeX6Xgo/+xcujxaNGqyA3SVby1zK0csZYD4R70gCMtrbMJll
         pmBwSe4J29xINTr84WYSnKZ/SPesCkE9xzwoSQ4mvQ/4v/iRif9SKSprStZlYn3pC4VX
         KpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PiU105LwR4CtW43tXMObNmMhkqu4rll7p1Rlw/fDhGQ=;
        b=U9ZJwFep2h0CpgDi/t7inhQvU68ZyVfEaff+rQ5gjigGrHqdarju/Xo5lbpkZwVpyx
         3fHLYQnFAFLaugPU+rbIDpj1PVB53U0/jac4lyxcPHDOauIOglwXRZAlbraReus1S5Jg
         lzZaeGBisdu7XtBHhuqmlD+l68Srbt4V6ar3P6ei09m8+ORtpa5UcYO33gAZMJ3TN7O5
         gEmpJL27KdnH57GBbwYF8G2maXKSbIECi3C8UpRdilk8UzOYEdj+4eoVr80k48xTp9ix
         1bc5iCSaiurW4JJr7KFQ6LJBZs66vm2Y6NzoSenP5auzE+70A2r2SVCVegtL9MrZVB0F
         Ph1w==
X-Gm-Message-State: ANhLgQ1RwlVDJCOza3Z/664J+g5yL5mQ3XUeZSfY01ALT5ab0o2AIXRT
        MgTyXKZYWxBiYv87ONEHiVc=
X-Google-Smtp-Source: ADFU+vtvMwQ7ety0PRkbuZjX9+CuIAPrBtZgxesrF5R32AEbIB2ziIg2w0iTy1qA9/unV9/cH1rg9g==
X-Received: by 2002:a9d:7750:: with SMTP id t16mr4049797otl.333.1584654214036;
        Thu, 19 Mar 2020 14:43:34 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id v12sm1197807otp.75.2020.03.19.14.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 14:43:33 -0700 (PDT)
Date:   Thu, 19 Mar 2020 14:43:31 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] dynamic_debug: Use address-of operator on section
 symbols
Message-ID: <20200319214331.GA53874@ubuntu-m2-xlarge-x86>
References: <20200220051320.10739-1-natechancellor@gmail.com>
 <20200319015909.GA8292@ubuntu-m2-xlarge-x86>
 <4b766edb-73e2-c295-22eb-b501405baa9f@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b766edb-73e2-c295-22eb-b501405baa9f@akamai.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 04:03:39PM -0400, Jason Baron wrote:
> 
> 
> On 3/18/20 9:59 PM, Nathan Chancellor wrote:
> > On Wed, Feb 19, 2020 at 10:13:20PM -0700, Nathan Chancellor wrote:
> >> Clang warns:
> >>
> >> ../lib/dynamic_debug.c:1034:24: warning: array comparison always
> >> evaluates to false [-Wtautological-compare]
> >>         if (__start___verbose == __stop___verbose) {
> >>                               ^
> >> 1 warning generated.
> >>
> >> These are not true arrays, they are linker defined symbols, which are
> >> just addresses. Using the address of operator silences the warning and
> >> does not change the resulting assembly with either clang/ld.lld or
> >> gcc/ld (tested with diff + objdump -Dr).
> >>
> >> Link: https://github.com/ClangBuiltLinux/linux/issues/894
> >> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> >> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >> ---
> >> v1 -> v2: https://lore.kernel.org/lkml/20200219045423.54190-5-natechancellor@gmail.com/
> >>
> >> * No longer a series because there is no prerequisite patch.
> >> * Use address-of operator instead of casting to unsigned long.
> >>
> >>  lib/dynamic_debug.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> >> index aae17d9522e5..8f199f403ab5 100644
> >> --- a/lib/dynamic_debug.c
> >> +++ b/lib/dynamic_debug.c
> >> @@ -1031,7 +1031,7 @@ static int __init dynamic_debug_init(void)
> >>  	int n = 0, entries = 0, modct = 0;
> >>  	int verbose_bytes = 0;
> >>  
> >> -	if (__start___verbose == __stop___verbose) {
> >> +	if (&__start___verbose == &__stop___verbose) {
> >>  		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
> >>  		return 1;
> >>  	}
> >> -- 
> >> 2.25.1
> >>
> > 
> > Gentle ping for review/acceptance.
> > 
> > Cheers,
> > Nathan
> 
> Works for me.
> 
> Acked-by: Jason Baron <jbaron@akamai.com>

Thank you!

Andrew, I assume you'll pick this up?

Cheers,
Nathan
