Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE7BC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DEC2158C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/97Fv/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbgIAQ4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbgIAQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:56:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E33C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 09:56:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d19so982469pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UCJggNANOsFIJdFQUE2H7KD/0UnjI1YMnTYdBOtZHzI=;
        b=f/97Fv/KjczXdrNy7yOMMvqP0qoO7QUX4B8dHtJ8Vro+TG4m0tG01l1X6+rgdO5Sc3
         2hcppzyW+uMj+QXjrRu2OpnxSeuw26zJYbxFQ8zxIt4htOgU96Iz61UF1ciygQpnbVX2
         YT+1+Y38zzNF6+gSan7i4hZCWkOE1VQbySjUINEH8M/FiP6XRkh+wDPgGP0BenAfGlJ5
         2RCKyEssPP+a3dOFVBd9kYokew9vKldrvTMml+b089zYpQuukm0V6IngHyia0QF1pVA1
         yXPKoD4Ji6zMiRigsMzUQthI93sRM4M+qLjkhRgtrXgbtZnTfDNKpsV0oLr2V8GITD/0
         or7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UCJggNANOsFIJdFQUE2H7KD/0UnjI1YMnTYdBOtZHzI=;
        b=ovmqIJj4o19aQMH1T4JOqkj1s3hdxumK6sRjjMKRN1GMlawtLOqPhjPAiXFW0+mae8
         bu8YJkhbwJ1M/C/2aOp0GCYV+FcjcNGhccvMHdFYHCxs/805Tn8bnN/k3zMhWZJdVw6l
         cp1sb261/3UfJi8eKWa5SSo/rTa7aURJxgAwRIkuBZD+T+v3ALSZziwMDbkFVXyUjfe1
         w6PY5QjfDlULr81r8kFa6oiMhNpBoS27ga6tfB9P+moCXrrW0+b0PV2btVNx+r6p3E1B
         f/6AckvMalVNItus+7hzFg+Irjxj+P8hNyZjGagtU38wEJ2nnb+XME4NQYWp98Kh9wAg
         RRXQ==
X-Gm-Message-State: AOAM530ysj8D/vFIDlrVb08qMZicvJVKutaTbZBEWmUc42Zo0NiQAu/V
        BqI8mygDXknRq14zk195fBF3Rw==
X-Google-Smtp-Source: ABdhPJwjXwoMpiJNg5CrZ9VvXe00GjrxVhwJ+UP6FkGXZnaN/Qjh85rk7MFwheGElZRjfIf4my+aEQ==
X-Received: by 2002:a63:8f41:: with SMTP id r1mr2168810pgn.375.1598979362793;
        Tue, 01 Sep 2020 09:56:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id 205sm2651217pfz.14.2020.09.01.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 09:56:01 -0700 (PDT)
Date:   Tue, 1 Sep 2020 09:55:58 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] Revert "kbuild: disable clang's default use of
 -fmerge-all-constants"
Message-ID: <20200901165558.sgzbui6khedvwy3o@google.com>
References: <20200901002326.1137289-1-ndesaulniers@google.com>
 <20200901002326.1137289-3-ndesaulniers@google.com>
 <20200901045516.GA1561318@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200901045516.GA1561318@ubuntu-n2-xlarge-x86>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-08-31, Nathan Chancellor wrote:
>On Mon, Aug 31, 2020 at 05:23:21PM -0700, Nick Desaulniers wrote:
>> This reverts commit 87e0d4f0f37fb0c8c4aeeac46fff5e957738df79.
>>
>> This was fixed in clang-6; the minimum supported version of clang in the
>> kernel is clang-10 (10.0.1).
>>
>> Link: https://reviews.llvm.org/rL329300.
>> Link: https://github.com/ClangBuiltLinux/linux/issues/9
>> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
>Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

How about expanding "This was fixed in clang-6" to be
-fno-merge-all-constants has been the default since clang-6?

(Both gcc|clang -fmerge-all-constants can cause an assertion failure for
the example on https://bugs.llvm.org/show_bug.cgi?id=18538 )

Reviewed-by: Fangrui Song <maskray@google.com>

>> ---
>>  Makefile | 9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 37739ee53f27..144ac6a073ff 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -932,15 +932,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
>>  # disable invalid "can't wrap" optimizations for signed / pointers
>>  KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
>>
>> -# clang sets -fmerge-all-constants by default as optimization, but this
>> -# is non-conforming behavior for C and in fact breaks the kernel, so we
>> -# need to disable it here generally.
>> -KBUILD_CFLAGS	+= $(call cc-option,-fno-merge-all-constants)
>> -
>> -# for gcc -fno-merge-all-constants disables everything, but it is fine
>> -# to have actual conforming behavior enabled.
>> -KBUILD_CFLAGS	+= $(call cc-option,-fmerge-constants)
>> -
>>  # Make sure -fstack-check isn't enabled (like gentoo apparently did)
>>  KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
>>
>> --
>> 2.28.0.402.g5ffc5be6b7-goog
>>
>
>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200901045516.GA1561318%40ubuntu-n2-xlarge-x86.
