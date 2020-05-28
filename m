Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0301CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D611E2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FoXMQP8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406702AbgE1TkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406540AbgE1TkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:40:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86193C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:40:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e11so13122893pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zYINYS5M5H4v7usoMXZUPWVFvds+U+lV2Ynob3L6pg=;
        b=FoXMQP8TGdKIsTYwBlxJfrVj2VQ8RR/kNIgT4CxA3KobyKEU1+//9t64t3OLh2Khi+
         3vuUcAJFpfayXZesLB0YySRHjZz50yewdX78MfGCTUDUym7HAZ/sEZgGqKUO+F7X7Pk6
         taRil4k2kvl5UYMcHl7NDrUI1mIZMJjxCQ465VJHxLnrPICiYv/Vi0UXic4hHDqRAvfW
         gqZcYlc3sXu8BEQeytCGnQA807rsOddGVE0d5t1iPEZNc8/uur3Vfn0e9Z/XuQahAovq
         mNxpuC8YNyLKpRRdmmkZkpSmwmMKkOH51NN/AI6z+GhLENAmi5i0h6GvVVzSD/0cGpFf
         5G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zYINYS5M5H4v7usoMXZUPWVFvds+U+lV2Ynob3L6pg=;
        b=HSUg7NRh2nEyybZ5LG4tXtyNHfv7xozncFSfXFFb7FQSW3vDf+uGm5ujnllTMk76pA
         TR8k1tnSM9MpqTwJ5PZwSvtSA/UruB8iD8/Jn+8FZDov1nTAILfU+QIJjQ+4i3/7bSZz
         +7nonrRePj3vZ849C7+qSUscGERzwcEnjssKw9ycc6Tz2UPVdN9aWJ/3hWyBKVR7lBTJ
         ptvF2Xs1SKIjshgMW2mrUErPIslTgJr8TpfIwhrzn+dbW+KxYDwshfojK2XnoW675BBu
         B9i2csKLILmOMeweLhlIgyLV4d45KpxOc/4v1m/1R3jqY9gx8F70a2W5/8UrkQFGM5vu
         mT9g==
X-Gm-Message-State: AOAM533DRoaLyUT9g7c/ef+Tm8UkOQXhzC7ghFCnp3GdZwRGEToiD6kO
        bdTYJjmhX21BymLs2E6LME9WJ61FmOcc0loH8FyKCQ==
X-Google-Smtp-Source: ABdhPJwozeLhos5j9E4l4Rjye1rhwxuDuiI7FKvL5yBfWGFravInkuhzgP2rYNecqDRsWSxeiONoNQrGfUSlOCU39kk=
X-Received: by 2002:a62:8c42:: with SMTP id m63mr4710270pfd.106.1590694812613;
 Thu, 28 May 2020 12:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <1585313122-26441-1-git-send-email-alan.maguire@oracle.com> <1585313122-26441-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1585313122-26441-2-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 May 2020 12:40:01 -0700
Message-ID: <CAFd5g44-eDSDQqt+ZR-CibEjgZ3x6RzYf6WFQ7t088Bf2c8qRg@mail.gmail.com>
Subject: Re: [PATCH v3 kunit-next 1/2] kunit: generalize kunit_resource API
 beyond allocated resources
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     shuah <shuah@kernel.org>,
        Patricia Alfonso <trishalfonso@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 5:45 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> In its original form, the kunit resources API - consisting the
> struct kunit_resource and associated functions - was focused on
> adding allocated resources during test operation that would be
> automatically cleaned up on test completion.
>
> The recent RFC patch proposing converting KASAN tests to KUnit [1]
> showed another potential model - where outside of test context,
> but with a pointer to the test state, we wish to access/update
> test-related data, but expressly want to avoid allocations.
>
> It turns out we can generalize the kunit_resource to support
> static resources where the struct kunit_resource * is passed
> in and initialized for us. As part of this work, we also
> change the "allocation" field to the more general "data" name,
> as instead of associating an allocation, we can associate a
> pointer to static data.  Static data is distinguished by a NULL
> free functions.  A test is added to cover using kunit_add_resource()
> with a static resource and data.
>
> Finally we also make use of the kernel's krefcount interfaces
> to manage reference counting of KUnit resources.  The motivation
> for this is simple; if we have kernel threads accessing and
> using resources (say via kunit_find_resource()) we need to
> ensure we do not remove said resources (or indeed free them
> if they were dynamically allocated) until the reference count
> reaches zero.  A new function - kunit_put_resource() - is
> added to handle this, and it should be called after a
> thread using kunit_find_resource() is finished with the
> retrieved resource.
>
> We ensure that the functions needed to look up, use and
> drop reference count are "static inline"-defined so that
> they can be used by builtin code as well as modules in
> the case that KUnit is built as a module.
>
> A cosmetic change here also; I've tried moving to
> kunit_[action]_resource() as the format of function names
> for consistency and readability.
>
> [1] https://lkml.org/lkml/2020/2/26/1286
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

One comment below, other than that:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Sorry for not keeping up with this. I forgot that I didn't give this a
reviewed-by.

> ---
>  include/kunit/test.h      | 157 +++++++++++++++++++++++++++++++++++++---------
>  lib/kunit/kunit-test.c    |  74 ++++++++++++++++------
>  lib/kunit/string-stream.c |  14 ++---
>  lib/kunit/test.c          | 154 ++++++++++++++++++++++++---------------------
>  4 files changed, 270 insertions(+), 129 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9b0c46a..8c7f3ff 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -52,30 +59,27 @@
>   *
>   *     static void kunit_kmalloc_free(struct kunit_resource *res)
>   *     {
> - *             kfree(res->allocation);
> + *             kfree(res->data);
>   *     }
>   *
>   *     void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
>   *     {
>   *             struct kunit_kmalloc_params params;
> - *             struct kunit_resource *res;
>   *
>   *             params.size = size;
>   *             params.gfp = gfp;
>   *
> - *             res = kunit_alloc_resource(test, kunit_kmalloc_init,
> + *             return kunit_alloc_resource(test, kunit_kmalloc_init,
>   *                     kunit_kmalloc_free, &params);
> - *             if (res)
> - *                     return res->allocation;
> - *
> - *             return NULL;
>   *     }
>   */
>  struct kunit_resource {
> -       void *allocation;
> -       kunit_resource_free_t free;
> +       void *data;
>
>         /* private: internal use only. */
> +       kunit_resource_init_t init;

Apologies for bringing this up so late, but it looks like you never
addressed my comment from v1:

I don't think you use this `init` field anywhere; I only see it passed
as a parameter. Is there something obvious that I am missing?

> +       kunit_resource_free_t free;
> +       struct kref refcount;
>         struct list_head node;
>  };
