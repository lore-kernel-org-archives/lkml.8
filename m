Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6D6C34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4C224125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKslbmH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgBRT0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:26:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34796 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRT0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:26:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so11159698pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PG1inGCjkR8mbsV9FBAGsiFoMPIEZyx6SU/E1O5JF7M=;
        b=LKslbmH0dvmcG60Ck8sK/dmQiiexpGxXSgYtk3lY8upWmpuvOz/oM+fPI6ZbcDhDsa
         RpPSJd2RUqGFX/QQYtGVauBVeZypL2oKXrEObFBe12YylfCiFeSoI80UMMRdjEsdg7n3
         POgU5qp0Tgi8hPVyOf17vRI1G2fQe7rF6uWKLJxDaereKr+1W2qiRv0L6RwRmoOfryLx
         h96KAO8dbjtrrnazYDf6UwT1vUQ+L70DL0X/CZlKWXMQT7OYN3/dnpovh7DVQASJ7rMX
         IguDxDfOK8XUGiszApK+IDSIuUQMX1PFq8XSomi7opasBfzniD9phH9yq00SVfztmKO3
         xZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PG1inGCjkR8mbsV9FBAGsiFoMPIEZyx6SU/E1O5JF7M=;
        b=OWD9p13aVKXikqtiP5ZOVDI0LT5AuPcEkr/ShrCr97eg9eDZOPDZQAZd3mjWGiBAVH
         ifafOBV6b/GgpemE7h8bleq/3rbqU7tKv1BzKWpNIMSEHRSj7v3VDUZRlQtQWsF0ZqEg
         8Jo3klJy6CGA+GVXTC8km6LtzdrXd9vGvuuGVzqyd7rdBk87URNsDSFhZr3cO7Y2ocWG
         8F9YpDzWqES1W+HW9hnMLcoUt7zzxMeBPl83bmSelwjqfUh1WbpiYKPEwT88brKezzre
         u4cjUOwWmB8cLJBTPuCgxrQnmZIcp98OBjojaPrTzYotf8e3TE+W3MtMWzaiR5nSXtIM
         mbSQ==
X-Gm-Message-State: APjAAAVr7uFyFHPAvs3XO4MYF69LaOSUO1jT8J9x6E4n6ZgxvJ9j0aTj
        5rX22w9gDwNW8XkhLBbrnA/WwIXqLLeVopIvz9ikQw==
X-Google-Smtp-Source: APXvYqz4+UZUuuR5h/fNaE5Tzptkbuq8wJ2Z/GQxsLTn9qb7rpgmkUShMVAz14BtnZOgirr4od0cln9sN1EnrYiTfSs=
X-Received: by 2002:a62:6842:: with SMTP id d63mr23106087pfc.113.1582054013382;
 Tue, 18 Feb 2020 11:26:53 -0800 (PST)
MIME-Version: 1.0
References: <1581949660-20113-1-git-send-email-alan.maguire@oracle.com> <1581949660-20113-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1581949660-20113-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 18 Feb 2020 11:26:42 -0800
Message-ID: <CAFd5g47bU+5dEb2FxbT1X0oXgcD0jOkqW7a4WfCxVttRhDSYoA@mail.gmail.com>
Subject: Re: [PATCH v4 kunit-next 2/3] kunit: add log test
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 6:28 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> the logging test ensures multiple strings logged appear in the
> log string associated with the test when CONFIG_KUNIT_DEBUGFS is
> enabled.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

One minor comment below.

> ---
>  lib/kunit/kunit-test.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index aceb5bf..0789060 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -329,6 +329,31 @@ static void kunit_resource_test_exit(struct kunit *test)
>         .exit = kunit_resource_test_exit,
>         .test_cases = kunit_resource_test_cases,
>  };
> -kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite);
> +
> +static void kunit_log_test(struct kunit *test)
> +{
> +       kunit_log(KERN_INFO, test, "put this in log.");
> +       kunit_log(KERN_INFO, test, "this too.");
> +
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                                    strstr(test->log, "put this in log."));
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                                    strstr(test->log, "this too."));
> +#endif
> +}

Would you mind adding some expectations against the suite log? It
might be good for the sake of completeness.

> +
> +static struct kunit_case kunit_log_test_cases[] = {
> +       KUNIT_CASE(kunit_log_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_log_test_suite = {
> +       .name = "kunit-log-test",
> +       .test_cases = kunit_log_test_cases,
> +};
> +
> +kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
> +                 &kunit_log_test_suite);
>
>  MODULE_LICENSE("GPL v2");
> --
> 1.8.3.1
>
