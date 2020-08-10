Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BB7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F85020658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eM4E+WeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgHJUho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHJUho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:37:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D4C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:37:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so5604944pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRuWkhrpmAmcdHS/RSpOjVe+mnrE0qLuVyBAgROKiXA=;
        b=eM4E+WeBerf5fSAzchaYTrGpGpDKQKDWHN6PAYU+UFvSjnPMdqlztCS1sdBJCbZbWy
         UxMV3gEQACxBIwho9amuG2UQjwcNFmTfXQoaKvF6hGkTEBhXO35Q+VqVummT6bz8Gz/c
         FWMekgdrOooXKBIgHiHsozjnXgasmXw+Xd8lwlXgTHNqNEHFwBwE4Cbt0bsFKMPj1Cq6
         N0tKFCuewUeu+B51Rh+9kV2BUOGmRBUr1g21GA2SvhBfoj8mSgk4DA5Fjiq/eDBRLF2c
         xoN9JVf4ZYQP7FNUjISyxFVWIU8FU7g9dBC1NkEs6HSX/En2QXv5Zmzp43NO7Tm8lmXc
         GlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRuWkhrpmAmcdHS/RSpOjVe+mnrE0qLuVyBAgROKiXA=;
        b=XuPsoWZIQLTx3NujZK475MZscC55OWPL0juVnU4txR3hFTmEtt5XBSkv1g7YjExf+P
         6Cthq8TVu/G05oJ6geOU77/spayrE9+h0LTuHs5UduGWWBIgja1LXrgFfuIsYa2vhFFK
         fvuDAMZmU1bEE7uY7sTiCqHb622o5DOSUo9Yug3vPCzH5kJo9yHyDFqBNj11Br4N23dc
         aDV6yVoQo2c1ytZ+Yn0oMmEZd80uGFAXGTyaDfjP4yDMiBDNu3wETtlspsY7UZO5KG8P
         ywp0DjkdcXWMdY5QjzBJ2JKUKfIJyoZGgy6Y2dU1Q/xINMB0hYrLEJsUGU0JpkWu26k6
         ug1A==
X-Gm-Message-State: AOAM530KF9W38G9DOq3I4W/SL4luKxHSRgZxnzbf4/5GDC9LnGaiL9Ja
        QqNT+mnfXXOcGz9uG0PRLn02uTpAJWmfHy0ZWD2CQE7WEgY=
X-Google-Smtp-Source: ABdhPJzdSfAqA/j0q/YYNpuGb0tpTIDII2+HAUBc9ozroDpARVr5Zu6I3gO7aiqbyi08i7motFMnChXVW7jUbJRl5+c=
X-Received: by 2002:a62:1b4a:: with SMTP id b71mr2760943pfb.106.1597091863550;
 Mon, 10 Aug 2020 13:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200806174326.3577537-1-urielguajardojr@gmail.com>
In-Reply-To: <20200806174326.3577537-1-urielguajardojr@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 10 Aug 2020 13:37:32 -0700
Message-ID: <CAFd5g45D9xFCYGHhZfCNVeg1qJfe7X=9JB5-LSW79Qf6XPp+0w@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: support failure from dynamic analysis tools
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
> Adds an API to allow dynamic analysis tools to fail the currently
> running KUnit test case.
>
> - Always places the kunit test in the task_struct to allow other tools
> to access the currently running KUnit test.
>
> - Creates a new header file to avoid circular dependencies that could be
> created from the test.h file.
>
> Requires KASAN-KUnit integration patch to access the kunit test from
> task_struct:
> https://lore.kernel.org/linux-kselftest/20200606040349.246780-2-davidgow@google.com/
>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
