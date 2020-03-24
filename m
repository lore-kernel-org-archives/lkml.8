Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C90C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505CC20789
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgCXPJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:09:57 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:60456 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727567AbgCXPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:09:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3CCFD18027F92;
        Tue, 24 Mar 2020 15:09:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rifle75_567c803e6e424
X-Filterd-Recvd-Size: 1914
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Mar 2020 15:09:54 +0000 (UTC)
Message-ID: <7a87a9b971caefa847c412608c98c0a2e1835904.camel@perches.com>
Subject: Re: [PATCH v2]     x86: Alias memset to __builtin_memset.
From:   Joe Perches <joe@perches.com>
To:     Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Tue, 24 Mar 2020 08:08:04 -0700
In-Reply-To: <20200324140742.71850-1-courbet@google.com>
References: <20200323114207.222412-1-courbet@google.com>
         <20200324140742.71850-1-courbet@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-24 at 15:07 +0100, Clement Courbet wrote:
>     Recent compilers know the meaning of builtins (`memset`,
>     `memcpy`, ...) and can replace calls by inline code when
>     deemed better. For example, `memset(p, 0, 4)` will be lowered
>     to a four-byte zero store.
> 
>     When using -ffreestanding (this is the case e.g. building on
>     clang), these optimizations are disabled. This means that **all**
>     memsets, including those with small, constant sizes, will result
>     in an actual call to memset.
[]
>     In terms of code size, this grows the clang-built kernel a
>     bit (+0.022%):
>     440285512 vmlinux.clang.after
>     440383608 vmlinux.clang.before

This shows the kernel getting smaller not larger.
Is this still reversed or is this correct?


