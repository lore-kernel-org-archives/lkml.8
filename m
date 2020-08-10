Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE715C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15E5206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLV5IMYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHJUnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgHJUnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:43:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9531C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:43:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so5594866pgl.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+Vem1mPePRTF6yuvkTSfUvQ+T0mz1vgwNb7in9eFI0=;
        b=rLV5IMYYk3qhRR8OaqNl7bVx/f6TTfAKUbKi9cxnNxk+WqNAxQsbVUNbgs3NwD7W8z
         YMpoTdb1gYXoBNx6osqdLbdfephLsl2AlcmUGdc36l769CeErMCnOF3uUD61rZq02Rz1
         UEAEgv4RTY7ogrE52HbPUF0nQn3sFmpnpI0sUksXCITaCUIyPQ7Snz4JZUdT9kbu3WFi
         xbP+oB43v0QNpwNMTFsBfYR1c8H9ujLjRl91UKV4hhazszyFC/pX22Omw+/ith7x/54a
         SYDrTYmpeXAvZ5ABQWjSVftGtQYPkUAzPqxqzySf+0akRRSZWVr+TS9ZggzhmwhkorpA
         VPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+Vem1mPePRTF6yuvkTSfUvQ+T0mz1vgwNb7in9eFI0=;
        b=BOneoNVHE9uBwqm3KGu4yH2/PF01DL8UKx0OPQN81EZMQE7G9okhSkYzCAVhIrG2m8
         rQVuIGHXiDyHmv2+C1L3ydfdBB4qMXTi4Pg/2/kuURefNtm/77SIU/EVF2u2IQb4l2SN
         E3zPHbbbKw9HUAWV0B6pu5h5HAj39fbvW5nJKsW++0YnNx19RxyWqlq8ixJMCs88M6TC
         7JTFGtaAaRAUAqr1WW2vsHAO0zsPa6gp722mCHb3hmVzyU6H+XTh9iXAVNN3ddid39Wl
         5t/Gas9l8ijOhksIxHllx81ffpumaNYJAwANm/BDRHrg0pTmQedcXbHmMvwMgdhk5j21
         sETg==
X-Gm-Message-State: AOAM532KCBqIJ7mq3Pg3jqfjY8wytUEBOJ8PEMwfidlhM/j0hAJ694Ao
        q7E9Ihh2l4d1T/dNEjKT/CI4NFZAGbhAE3RQPP7nMg==
X-Google-Smtp-Source: ABdhPJzflIhS968NdWQ+OK33LSfgJpCxuHDzOO363XN8hpalQG79JJeEo4wGnIQYudlWzLeqptInIpto9l7CwNAHMeU=
X-Received: by 2002:a63:7746:: with SMTP id s67mr23105137pgc.159.1597092181923;
 Mon, 10 Aug 2020 13:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200806174326.3577537-1-urielguajardojr@gmail.com> <20200806174326.3577537-2-urielguajardojr@gmail.com>
In-Reply-To: <20200806174326.3577537-2-urielguajardojr@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Aug 2020 13:42:51 -0700
Message-ID: <CAFd5g47AO64WMvQvz2an_ak-ReL9UT3oBMpFBdC_pFmQK3scfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: ubsan integration
To:     Uriel Guajardo <urielguajardojr@gmail.com>
Cc:     Uriel Guajardo <urielguajardo@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 10:43 AM Uriel Guajardo
<urielguajardojr@gmail.com> wrote:
>
> Integrates UBSAN into the KUnit testing framework. It fails KUnit tests
> whenever it reports undefined behavior.
>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>

You should resend this to the UBSAN maintainers as well; they will
need to sign off on this.

In the future, make sure to run get_maintainers.pl

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  lib/ubsan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index cb9af3f6b77e..1460e2c828c8 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/sched.h>
>  #include <linux/uaccess.h>
> +#include <kunit/test.h>
>
>  #include "ubsan.h"
>
> @@ -137,6 +138,7 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
>  {
>         current->in_ubsan++;
>
> +       kunit_fail_current_test();
>         pr_err("========================================"
>                 "========================================\n");
>         pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
> --
> 2.28.0.163.g6104cc2f0b6-goog
>
