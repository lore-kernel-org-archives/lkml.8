Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC1C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08FC920781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjNZAuK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgDWR0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgDWR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:26:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98B1C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:26:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n143so7226688qkn.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0wqst2mhEuWLnZwDqC3VBRcH3//gDPmWLfGb4vS/m0=;
        b=AjNZAuK8LPgGHclTuG/kCSLmZJEP7FWoBVmhH+w1pehgUAmXCyqVy7qQA2fwm7qUiR
         k9Lmfh5VKJVTWMV2C6ZeurvmxIhxSJpBM7xqje4n3oBUNHk1H6MGfT6lCmjJ8lapiu/k
         ne3GwMMr67DYY0ZAIClkZ+EwoiPD0WuOIgkAOmBiAKNtX0IbrBFh0unMoMktP7k9wCUo
         bNqfwY5729iY0AtVSrXjyFCvj2i8YSh2kSPH0Qx3vzRCnoVw5DBeGROYHNDwM+MA3P5Z
         2BlNZA3XJYAho83LaVSB8dzdgpuWOCzuS7WObuRPhBAhn7NrpJcI7cUrUjXlVX5WL56Y
         toFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0wqst2mhEuWLnZwDqC3VBRcH3//gDPmWLfGb4vS/m0=;
        b=qHIICqzzdIZq89ses5Z9jkXgVAqX9Hh0E5sqSaNc0ojSVkGaaAi87IQLKL8dE9MTi8
         YOSpTeNItbEKxvUrqE+m0j71/zSu118eBV1/cVaFY/BDieJX+bi/5NVUarBTs3AuTvuT
         B60App+dsK7wqZkqs7gxcb/Fjfp4CvSobf2HncAgRujLWFAdIMjcJP/jN7wtx3YQDUeY
         OC3Gw3wvj/fq4+W8uNkRd+rGQ9TVsGNIONJp2s82wRM2htoGrtaYVtICEP7yWkJMrZKt
         EaNWMuBy+4A3jMelE7XIONS4L9bu8YINNty7lZHmrdbbK0iDgBJkZCDFNGk6+Mp9eeP1
         +yWA==
X-Gm-Message-State: AGi0PuauFSTQeFqsSTqMxJXLlB+uHryc89gQG4h/x2+5RYPf3MSEe09e
        tNbu/TLRUcKf6zQ37OG5JFskYxzdRWzR5YTa1k5VuQ==
X-Google-Smtp-Source: APiQypJCTcCvmXfupMphFqiB7ydFbx6n9jBBTNmyYJuiGke7N3DdxVWWIubnTmi/l/uhC37qYQSvTfge5RrZlH5ct6I=
X-Received: by 2002:a05:620a:1362:: with SMTP id d2mr4610858qkl.256.1587662765591;
 Thu, 23 Apr 2020 10:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200423154503.5103-1-dja@axtens.net> <20200423154503.5103-4-dja@axtens.net>
In-Reply-To: <20200423154503.5103-4-dja@axtens.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 23 Apr 2020 19:25:53 +0200
Message-ID: <CACT4Y+b7omyQ0bBBApOs5O_m0MDZWjoBi3QV6MxG4h_14gUa2g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kasan: initialise array in kasan_memcmp test
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 5:45 PM Daniel Axtens <dja@axtens.net> wrote:
>
> memcmp may bail out before accessing all the memory if the buffers
> contain differing bytes. kasan_memcmp calls memcmp with a stack array.
> Stack variables are not necessarily initialised (in the absence of a
> compiler plugin, at least). Sometimes this causes the memcpy to bail
> early thus fail to trigger kasan.
>
> Make sure the array initialised to zero in the code.
>
> No other test is dependent on the contents of an array on the stack.
>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/test_kasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 939f395a5392..7700097842c8 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -638,7 +638,7 @@ static noinline void __init kasan_memcmp(void)
>  {
>         char *ptr;
>         size_t size = 24;
> -       int arr[9];
> +       int arr[9] = {};
>
>         pr_info("out-of-bounds in memcmp\n");
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);

My version of this function contains the following below:

memset(arr, 0, sizeof(arr));

What am I missing?
