Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD41C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEB1206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbnfcEGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgENTgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726726AbgENTgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:36:04 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E41C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:36:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c3so3312210otr.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mB8eiiLNg/9uJ3nUxq/59BVSbCYvlFaWEg3uZJv8hY=;
        b=gbnfcEGyjeI2E05TrmYnpbwO5XUejuKLbsbfrYHUGBGhzXIfKiaSJxWicb5N9NCYXW
         GgYgl4zbUlTIApjgtdTSRPdDIVkeB2irPolCipFB5kshPF5Y8JSOno5jkZzxLeOgmTBA
         Khm1PuSmasV1okZgPN0wEhJ5FpwHNTQgUrqD7kuusrZVDPFEwMJqKWROLlNg+VD9saM1
         zo6geu9ijH30I+HzUS0S0ko1pe/p6ezJMWrpUw+GPieAzEKOzZXw10hS+DmoEXNJF7yu
         DLLhyWlNbOxS/Mqzt4igaQYo6zd7p2jg1Yhot90+cQvX8PLiDDZmfLIY/VXizJUffaey
         yAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mB8eiiLNg/9uJ3nUxq/59BVSbCYvlFaWEg3uZJv8hY=;
        b=PuqoRwPhTUHiXumWvMbPvH8tygN8tAwgpcFEWu0FlJCakGC2xUtEfNq0x79LxzuEQS
         eFLTu/rLO9bpEJje0Uzu6KYAVexEfxMu+vvw7Mz7W/DfsfiAsJ5W2OzE4R4ia4pKzWtg
         VHa6MUZnhYomAXnf6pcwJPItILkhAAlk4m/2n/nXj5TU6/jH8gw9A3HxxKj0ORU2kd6f
         A7yL4IA4KTG84L30YbWpHTSNZjMcWf06Dkv5ChzBKB3oiSYqS4Hhf9ZRn0WDAzi4BjoI
         NCQ6nDPYtQV4l3dLrsh3WPx7XMqLmCAGs+SB5UKw5W8yRV5SXrIO9w5Y4ZsZ0n1X8I6s
         92hA==
X-Gm-Message-State: AOAM530JzExJhF3BgYegLWh579ZXQ2ftEkC9lEFoY9g8M9rQiLiRzZpB
        w3r7DooeENeiv2e/B/YDu8gcvJ1b8O6pancHB08nj4aq1ps=
X-Google-Smtp-Source: ABdhPJxzXMbOXADm7edX7KBcGIZwn9CE69pYU7XfrV+RF4T8zgJb4e8inNsnKPyJ3tbNEN/48TKx17tf/NonaZ9sMkI=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr4430416oto.251.1589484963699;
 Thu, 14 May 2020 12:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200513042956.109987-1-davidgow@google.com>
In-Reply-To: <20200513042956.109987-1-davidgow@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 May 2020 21:35:52 +0200
Message-ID: <CANpmjNOzxt3QL8BR+J+GDT=5BJkEQqEeXXJgqWx7JZAR6G8sHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: Support skipped tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 06:30, David Gow <davidgow@google.com> wrote:
>
> This is a proof-of-concept to support "skipping" tests.
>
> The kunit_mark_skipped() macro marks the current test as "skipped", with
> the provided reason. The kunit_skip() macro will mark the test as
> skipped, and abort the test.
>
> The TAP specification supports this "SKIP directive" as a comment after
> the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> spec for details:
> https://testanything.org/tap-specification.html#directives
>
> kunit_tool will parse this SKIP directive, and renders skipped tests in
> yellow and counts them. Skipped tests do not affect the result for a
> suite.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Following on from discussions about the KCSAN test[1], which requires a
> multi-core/processor system to make sense, it would be useful for tests
> to be able to mark themselves as "skipped", where tests have runtime
> dependencies which aren't met.
>
> As a proof-of-concept, this patch doesn't implement some things which
> we'd ideally like to have (e.g., non-static "reasons" for skipping the
> test, maybe some SKIP macros akin to the EXPECT and ASSERT ones), and
> the implementation is still pretty hacky, but I though I'd put this out
> there to see if there are any thoughts on the concept in general.
>
> Cheers,
> -- David
>
> [1]: https://lkml.org/lkml/2020/5/5/31
>
>  include/kunit/test.h                | 12 ++++++++++++
>  lib/kunit/kunit-example-test.c      |  7 +++++++
>  lib/kunit/test.c                    | 23 ++++++++++++++++-------
>  tools/testing/kunit/kunit_parser.py | 21 +++++++++++++++++----
>  4 files changed, 52 insertions(+), 11 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9b0c46a6ca1f..7817c5580b2c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -178,6 +178,7 @@ struct kunit_suite {
>         /* private - internal use only */
>         struct dentry *debugfs;
>         char *log;
> +       const char *skip_directive;
>  };
>
>  /**
> @@ -213,6 +214,8 @@ struct kunit {
>          * protect it with some type of lock.
>          */
>         struct list_head resources; /* Protected by lock. */
> +
> +       const char *skip_directive;
>  };
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> @@ -391,6 +394,15 @@ void kunit_cleanup(struct kunit *test);
>
>  void kunit_log_append(char *log, const char *fmt, ...);
>
> +#define kunit_mark_skipped(test_or_suite, reason)                      \
> +       (test_or_suite)->skip_directive = "SKIP " reason
> +

Would it be useful to make this accept any string possibly with a
format? Otherwise, the reason will always need to be a constant string
here.

I'm fine with printing more detailed info via pr_warn() or so, if
that's an unreasonable request.

> +#define kunit_skip(test_or_suite, reason)                              \
> +       do {                                                            \
> +               kunit_mark_skipped(test_or_suite, reason);              \
> +               kunit_try_catch_throw(&((test_or_suite)->try_catch));   \
> +       } while (0)
> +
[...]

This looks good to me. One question I'd have is: will this work in
test_init functions? Because in the KCSAN test, the test setup
determines if we have enough CPUs, and then causes test_init to return
a non-zero error code.

Thanks,
-- Marco
