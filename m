Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC6DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FAB206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZ5BxtaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCMAJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:09:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37355 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCMAJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:09:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id p14so4105149pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8JHt8PTJz90sRvXzr54veMVjti2Y1yUGcUK9CCsYQ4=;
        b=RZ5BxtaEeh7ZllPEFT3iCmhw/c+J/0JAhA2FCN+qOmqUwg/Yvi5kcfa4wE59dMiNgY
         N4K9BLNSpT0vn3BjUY698y01GVQtzTgvKMqqVSukntHuTcF0TMQDAzUxzxROE1n0ojTW
         1EVczZuLF1hpyCuBUHmrCXl583MKxUgu4JwItChm7CRztTN2tLuj9WSURz9956Zni5rx
         AgzLI32g/7rTD5RTNhAGs59iKXodsqW4OG3RJYTzr53wAp/BbDv4cMkN/m6/gQ0LBu0u
         1nfga8tPG0ilwxRDzDyk7GAkKPnzsjb9f9aQIVKx4D9iCuzpdJS5dkebkDXTb/cylPdl
         gbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8JHt8PTJz90sRvXzr54veMVjti2Y1yUGcUK9CCsYQ4=;
        b=tf86Mrx5TwRh8sf3228bGIXqjJc3y5Msqy/ZasGiBOXWtOkMRfFarXxKAhH+pk1vTx
         uyssbiZtLxIF3xBeSDpOeFyp2LSzNeYxfQRQGjZyajqEtcUG2lPLhHBIi1fQSa0W+hFE
         A9B3PkyUe7hACdBIFp6qeosQz4LLRNaATezmhQUgIOtkj/uOkBW6a2VP+bBf0WWl3iI4
         9RmGGLX0mMFPczB8x6HkQ5156bFkPKELG9J/BiSs/EAuHFDoyJi6NqSjb0KfohEehbe/
         Saum5nShvTvbf5sK3D1PsrjuJt1uQcZ4jXDXCLkP1xTzyBFqKEZaF62L8GiO2JOWFC56
         uZ6g==
X-Gm-Message-State: ANhLgQ3P5PGknI9XgvAT/Kd/K04GGYYwJi/XBb/aR73tv0qX48RVBLzJ
        gY8RjeTbBbQtTfgYD6GyQcDmg11Hy2lS/sb3cjrWZg==
X-Google-Smtp-Source: ADFU+vvSIF+fAk4jMoHaDVnuH4BleYR+05fUqL20c699GqIt5mD4LPQbx61DyWsIbf+ejhhxAPN58mTlvs1y7K9j4+4=
X-Received: by 2002:aa7:8283:: with SMTP id s3mr10751804pfm.106.1584058167147;
 Thu, 12 Mar 2020 17:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <1583251361-12748-1-git-send-email-alan.maguire@oracle.com> <1583251361-12748-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1583251361-12748-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 Mar 2020 17:09:15 -0700
Message-ID: <CAFd5g45mSdJ8rF2AAfr6BJrBuPrn=6ntz=Z8a+mj4_Ptjg7XLA@mail.gmail.com>
Subject: Re: [RFC PATCH kunit-next 2/2] kunit: add support for named resources
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 8:03 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> The kunit resources API allows for custom initialization and
> cleanup code (init/fini); here we use the init code to set the
> new "struct kunit_resource" "name" field, and call an additional
> init function if needed.  Having a simple way to name resources
> is useful in cases such as multithreaded tests where a set of
> resources are shared among threads; a pointer to the
> "struct kunit *" test state then is all that is needed to
> retrieve and use named resources.  Support is provided to add,
> find and destroy named resources; the latter two are simply
> wrappers that use a "match-by-name" callback.
>
> If an attempt to add a resource with a name that already exists
> is made kunit_add_named_resource() will return NULL.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Overall, I think this seems reasonable. I think it needs a use case to
be justified, so long as Patricia ends up using it.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  include/kunit/test.h   | 40 ++++++++++++++++++++++++++++++++++++++-
>  lib/kunit/kunit-test.c | 37 ++++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c       | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 127 insertions(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 11c80f5..70ee581 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -73,9 +73,14 @@
>   *                     kunit_kmalloc_free, &params);
>   *     }
>   *
> + * Resources can also be named, with lookup/removal done on a name
> + * basis also.  kunit_add_named_resource(), kunit_find_named_resource()
> + * and kunit_destroy_named_resource() below.  Resource names must be
> + * unique within the test instance.
>   */
>  struct kunit_resource {
>         void *data;
> +       const char *name;       /* optional name */
>         kunit_resource_init_t init;
>         kunit_resource_free_t free;
>
> @@ -275,12 +280,27 @@ struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
>   * @init: a user-supplied function to initialize the result (if needed).  If
>   *        none is supplied, the resource data value is simply set to @data.
>   *       If an init function is supplied, @data is passed to it instead.
> - * @free: a user-supplied function to free the resource (if needed).
> + * @free: a user-supplied function to free the resource data (if needed).
>   * @data: value to pass to init function or set in resource data field.
>   */
>  int kunit_add_resource(struct kunit *test, kunit_resource_init_t init,
>                        kunit_resource_free_t free, struct kunit_resource *res,
>                        void *data);
> +
> +/**
> + * kunit_add_named_resource() - Add a named *test managed resource*.
> + * @test: The test context object.
> + * @init: a user-supplied function to initialize the resource data, if needed.
> + * @free: a user-supplied function to free the resource data, if needed.
> + * @name_data: name and data to be set for resource.
> + */
> +int kunit_add_named_resource(struct kunit *test,
> +                            kunit_resource_init_t init,
> +                            kunit_resource_free_t free,
> +                            struct kunit_resource *res,
> +                            const char *name,
> +                            void *data);
> +
>  /**
>   * kunit_alloc_resource() - Allocates a *test managed resource*.
>   * @test: The test context object.
> @@ -336,6 +356,19 @@ static inline bool kunit_resource_instance_match(struct kunit *test,
>  }
>
>  /**
> + * kunit_resource_name_match() - Match a resource with the same name.
> + * @test: Test case to which the resource belongs.
> + * @res: The resource.
> + * @match_name: The name to match against.
> + */
> +static inline bool kunit_resource_name_match(struct kunit *test,
> +                                            struct kunit_resource *res,
> +                                            void *match_name)
> +{
> +       return res->name && strcmp(res->name, match_name) == 0;
> +}
> +
> +/**
>   * kunit_find_resource() - Find a resource using match function/data.
>   * @test: Test case to which the resource belongs.
>   * @match: match function to be applied to resources/match data.
> @@ -345,6 +378,9 @@ struct kunit_resource *kunit_find_resource(struct kunit *test,
>                                            kunit_resource_match_t match,
>                                            void *match_data);
>
> +#define kunit_find_named_resource(test, name)                  \
> +       kunit_find_resource(test, kunit_resource_name_match, (void *)name)
> +
>  /**
>   * kunit_destroy_resource() - Find a kunit_resource and destroy it.
>   * @test: Test case to which the resource belongs.
> @@ -358,6 +394,8 @@ int kunit_destroy_resource(struct kunit *test,
>                            kunit_resource_match_t match,
>                            void *match_data);
>
> +#define kunit_destroy_named_resource(test, name)               \
> +       kunit_destroy_resource(test, kunit_resource_name_match, name)

nit: I would prefer a static inline function here instead of a macro.

>  /**
>   * kunit_remove_resource: remove resource from resource list associated with
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index b8bf36d..079c558 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -317,6 +317,42 @@ static void kunit_resource_test_static(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
>  }
>
> +static void kunit_resource_test_named(struct kunit *test)
> +{
> +       struct kunit_resource res1, res2, *found = NULL;
> +       struct kunit_test_resource_context ctx;
> +
> +       KUNIT_EXPECT_EQ(test,
> +                       kunit_add_named_resource(test, NULL, NULL, &res1,
> +                                                "resource_1", &ctx),
> +                       0);
> +       KUNIT_EXPECT_PTR_EQ(test, res1.data, (void *)&ctx);
> +
> +       KUNIT_EXPECT_EQ(test,
> +                       kunit_add_named_resource(test, NULL, NULL, &res1,
> +                                                "resource_1", &ctx),
> +                       -EEXIST);
> +
> +       KUNIT_EXPECT_EQ(test,
> +                       kunit_add_named_resource(test, NULL, NULL, &res2,
> +                                                "resource_2", &ctx),
> +                       0);
> +
> +       found = kunit_find_named_resource(test, "resource_1");
> +
> +       KUNIT_EXPECT_PTR_EQ(test, found, &res1);
> +
> +       if (found)
> +               kunit_put_resource(&res1);
> +
> +       KUNIT_EXPECT_EQ(test, kunit_destroy_named_resource(test, "resource_2"),
> +                       0);
> +
> +       kunit_cleanup(test);
> +
> +       KUNIT_EXPECT_TRUE(test, list_empty(&test->resources));
> +}
> +
>  static int kunit_resource_test_init(struct kunit *test)
>  {
>         struct kunit_test_resource_context *ctx =
> @@ -346,6 +382,7 @@ static void kunit_resource_test_exit(struct kunit *test)
>         KUNIT_CASE(kunit_resource_test_cleanup_resources),
>         KUNIT_CASE(kunit_resource_test_proper_free_ordering),
>         KUNIT_CASE(kunit_resource_test_static),
> +       KUNIT_CASE(kunit_resource_test_named),
>         {}
>  };
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 132e9bf..86a4d9c 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -380,6 +380,57 @@ int kunit_add_resource(struct kunit *test, kunit_resource_init_t init,
>  }
>  EXPORT_SYMBOL_GPL(kunit_add_resource);
>
> +/* Used to initialize named resource. */
> +struct kunit_name_data {
> +       const char *name;
> +       kunit_resource_init_t init;
> +       void *data;
> +};
> +
> +static int kunit_init_named_resource(struct kunit_resource *res, void *data)
> +{
> +       struct kunit_name_data *name_data = data;
> +
> +       res->name = name_data->name;
> +       res->data = name_data->data;
> +       res->init = name_data->init;
> +
> +       if (res->init)
> +               return res->init(res, name_data->data);
> +
> +       res->data = name_data->data;
> +
> +       return 0;
> +}
> +
> +int kunit_add_named_resource(struct kunit *test,
> +                            kunit_resource_init_t init,
> +                            kunit_resource_free_t free,
> +                            struct kunit_resource *res,
> +                            const char *name,
> +                            void *data)
> +{
> +       struct kunit_name_data name_data;
> +       struct kunit_resource *existing;
> +
> +       if (!name)
> +               return -EINVAL;
> +
> +       existing = kunit_find_named_resource(test, name);
> +       if (existing) {
> +               kunit_put_resource(existing);
> +               return -EEXIST;
> +       }
> +
> +       name_data.name = name;
> +       name_data.init = init;
> +       name_data.data = data;
> +
> +       return kunit_add_resource(test, kunit_init_named_resource, free, res,
> +                                 &name_data);
> +}
> +EXPORT_SYMBOL_GPL(kunit_add_named_resource);

Could we maybe combine the above with the non-named variants? Seems
like there might be some unnecessary code duplication.

>  struct kunit_resource *kunit_alloc_and_get_resource(struct kunit *test,
>                                                     kunit_resource_init_t init,
>                                                     kunit_resource_free_t free,

Once again, thank you for all your hard work!
