Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FBCC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299B6208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7hnEas2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgEFReV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEFReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:34:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E8AC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:34:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so1255208pjh.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5j4S3JEVj0FPIjZ8oxj1MyFeG1ZAskbKGCn2iAsiYc=;
        b=f7hnEas2RuwiW30eTk9Sr6ocUIfaNFrt9EpsP8J9y68iep50a17a2n4POGJTkjLfwC
         3g6JC/2fbDod1d56lq0TSLPPbSnmhoGLN/ULurD//t9cNNtQjHEZumIuton8xNfVTydP
         D61fB9wRz7oGNLtjq6t5N4+GxpnDeL9Li9uqZHo6c5VlABFervrl32YalUuS9BIutyPl
         mLJs9lV06k3jJ6Vk9/UDOeTClyBrph4sfuG941+oaVxADzsySotpIb0N6W9Mli/DdZ5e
         UPxtl7qHf6WnWtW+CDuyNzBc49juGSrdZRs58//GQK9rIMwVjsuTlwYPOr6AeBfB69p8
         O+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5j4S3JEVj0FPIjZ8oxj1MyFeG1ZAskbKGCn2iAsiYc=;
        b=BSW/j2AyTH6phh1nIHFUiCOH8Kfwgc8J8C8xpzffthRn5sn/qxjT91SWYkYu8DR0j0
         kXhS5khN9e9Fejn5n3RqjgurEMqM7kKHxW46f0x4z6fsh4B38XMU5iIZYhAIWODxjhuX
         Vc/peE0n9fcFeUVC5MGIAk753BGoKxPwi0O//y7VbJW/x4c8FbRV7EowDgQjAl70RmcE
         PA8Wh5KGKCrWiDRjKjazGoTRAaUz+g4HHxdINAXMgP14+nb63nVgzKvC3pQ2csUm7rqO
         Pcesq9p01PDjBCE8NFa1gl+c0MlQAUYSx90ElBSobkStXYfVs1je7sQq2Aq9vBv/Q88E
         d+EQ==
X-Gm-Message-State: AGi0PubGcRovOY2kPgKW6RwteC47FISDVcV4VanC8Eke3XkKomU73ztb
        DUEGD/zlN4np0ZY3HgMWHt7SAg==
X-Google-Smtp-Source: APiQypLb+RC6/cMnfZERoKxaxndhqIfrmhAyRJ4+TYtl0zrdOB1QJHeG7mElx357RbHMDcXFPqymJg==
X-Received: by 2002:a17:90a:5289:: with SMTP id w9mr10372222pjh.97.1588786460049;
        Wed, 06 May 2020 10:34:20 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id k6sm5207655pju.44.2020.05.06.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:34:19 -0700 (PDT)
Date:   Wed, 6 May 2020 10:34:16 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Torsten Duwe <duwe@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Torsten Duwe <duwe@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] arm64: disable patchable function entry on big-endian
 clang builds
Message-ID: <20200506173416.hmdp5cgkslunfko7@google.com>
References: <20200505141257.707945-1-arnd@arndb.de>
 <20200505142556.GF82823@C02TD0UTHF1T.local>
 <20200505194243.5bfc6ec6@blackhole>
 <20200506034523.GA564255@ubuntu-s3-xlarge-x86>
 <CAK8P3a24EiEvGAenL0FdgGakmwWi=giReOJuiisnzkgC_SuhZg@mail.gmail.com>
 <20200506153156.GA1213645@ubuntu-s3-xlarge-x86>
 <20200506154556.5fsxzs3vbfwixggd@google.com>
 <CAKwvOdnKn0AZTdaesEqG=uEJXzK+rQK=KJxqDQCFqAMFrPKWkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdnKn0AZTdaesEqG=uEJXzK+rQK=KJxqDQCFqAMFrPKWkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-06, Nick Desaulniers wrote:
>On Wed, May 6, 2020 at 8:46 AM 'Fangrui Song' via Clang Built Linux
><clang-built-linux@googlegroups.com> wrote:
>> Created https://reviews.llvm.org/D79495 to allow the function attribute
>> 'patchable_function_entry' on aarch64_be.
>> I think -fpatchable-function-entry= just works.
>>
>> Note, LLD does not support aarch64_be
>> (https://github.com/ClangBuiltLinux/linux/issues/380).
>
>I've approved the patch. Thanks for the quick fix.  Looks like we
>backported -fpatchable-function-entry= to the clang-10 release, so we
>should cherry pick your fix to the release-10 branch for the clang
>10.1 release.
>
>I'd rather have this fixed on the toolchain side.

+1.

Cherry picked to release/10.x
https://github.com/llvm/llvm-project/commit/98f9f73f6d2367aa8001c4d16de9d3b347febb08
I did not use any endianness-sensitive in the original implementation,
so hopefully this will not run into issues.


The scheduled rc1 of LLVM 10.0.1 will happen on May 18, 2020
(https://lists.llvm.org/pipermail/llvm-dev/2020-April/141128.html)
We should be quick if we want to test it on qemu or real hardware.
