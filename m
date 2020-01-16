Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B56C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334312073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEP6hLoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgAPIvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:51:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38994 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAPIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:51:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so18409876qko.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 00:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+h6b4jmAptddyium2DNixs0SA2T98LtobyUWbV5HXPk=;
        b=cEP6hLoUDDCAQBbgMAbebWuqtACfXmf5wW6edBHv09T3etgbPPYT/FdGhKb04CfIYU
         eQl6wKYdaiyUSbMCjmVFc2sQ3VaVkFjJAzX5Q6ZWRo+sVD5xVrkJj5pKd6WoN56aXMLR
         8+YivdWqZ/smqzObp0Cx4087TduAqWhuSEwthMEvTgzXx6MlYIbUmXXs3YmWCV6Y89IU
         uksCLAXvgz8IFZgAwYu45bqeb0xsyiLRzzBCZsHuUHIpGUAYM1ELyO+bAEFsqp51TL+3
         0h3rNZjwJY3pPVJLSqVen1k6gw2/GZe199PQYah6mYAE/rwQ/jAOammuh9USA8qAw80l
         ifeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+h6b4jmAptddyium2DNixs0SA2T98LtobyUWbV5HXPk=;
        b=YLvFsy2q+E1FB4NzZO9fn85ARdPR2RpfiWxQJz+ndi6MRtF8LRVqi49pgwQl4laa97
         G8dW/eu7VJB6F0bW4SU9R0m/zc2m0ZJ3d1s/0dBfgZUzdm+dd99anjFTrhiFmFlmzRYe
         tqFnskwGtBE/AQ7C9BxRWpx5jwKTlwTaUTtaf/7rvoZ/DA7flFgAxLPWzlBjG9BuqQAB
         tBQzc0Kc68dp9D7rogDMqNPDwHziwJOW+Eb2KF0r55TetTpXP2VxJ7qYyHD8thMpWbw2
         wV/sMBXGfLisqYcxnwsoysB623brWDXnG1g0UjlKyPY7H/GnR+2950XIduPaFUxxw9Lm
         +aWA==
X-Gm-Message-State: APjAAAU7/4s4BX13zPkOxqpzcc6XVlokyUNMwIqG9GUQvTXTcxb1Mzb1
        oI2z+WQ/aCCcgJlKaV4ErVutoVN2SPfS8hVX04pnDQ==
X-Google-Smtp-Source: APXvYqwVV+ZjH+7ImSbUTopEXLagRm1XNqLA9lSgvbh2sUqBYEr6rH2tk6Xs0k3/Bz6og7jZ66aco8yKXf4tMGtExgQ=
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr31096328qkg.43.1579164664973;
 Thu, 16 Jan 2020 00:51:04 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
In-Reply-To: <20200115182816.33892-1-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 09:50:53 +0100
Message-ID: <CACT4Y+aLYjJmGHPGN=vRTv9LUxC1uxR1CkP_rrY0958cpQaqhg@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 7:28 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> Make KASAN run on User Mode Linux on x86_64.
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 5aa882011e04..f783a7dd863c 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -8,6 +8,9 @@
>  # kernel.
>  KCOV_INSTRUMENT                := n
>
> +# Do not instrument on main.o

It's always good to explain why. Otherwise it will be stuck there
forever because nobody really knows why and if they will break
something by removing it.
This comment is also somewhat confusing. We don't instrument the whole
dir, not just main.c? Should we ignore just this single file as
comment says?

> +KASAN_SANITIZE := n
> +
