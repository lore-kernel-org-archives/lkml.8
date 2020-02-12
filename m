Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF3C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EF42082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WerW6PQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgBLRNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:13:53 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44901 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLRNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:13:53 -0500
Received: by mail-vs1-f68.google.com with SMTP id p6so1646231vsj.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLARtlkQ5V54FNIE3ZdRrfKU32yjdaqkKYODoptkcYk=;
        b=WerW6PQIBeKwwjPZTA8DMO3hZSDEobp9lOJYJQ8RP84ewYEZfZIsG2wnz89UWiXkkQ
         QFdIpHXWaDhJ+QqK2ANjRInpZK4GtnYsVurZrWhEsqVRnnuYa1kkeQH7ez8lu8qlkr0V
         ECvN/3yQ+E2pGHry9V1K0Rzb6ftNMp0yCeBvCJQNXY4sqY9jFeth+6ilfTrDPK9/wlJf
         qyXXsFV2eVo1FMW3KKrjf906yRpNmzjnuWGK/8aiRWZgzWeJGyzcgdvV6oRAntbZt/lY
         BJyajF4/um+eZP7l8B98PhUyb9SZEJjbt/HujZEAgF2/GKCtPbNGWX4hGWtaBCUyH/Rj
         PmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLARtlkQ5V54FNIE3ZdRrfKU32yjdaqkKYODoptkcYk=;
        b=FeR6u+yN7R1sicipkenphCVnLL9YreecyMeUtXz0Kz/HdooOWLAbf7G8DVMjuVz1+Q
         9MlAzZVWmbpp6CGlL5sUastxOdT5icCdRsKDxRuTRQw2/hhxghTDG0Ta+j994Q+lOhpp
         Q1tPR50b/LGUU7LKmMBZGIsGpdGdW69mez2Ta0ksLdDWSA6z9a/+6v8wGqX0M3zibi9w
         6NmIQ7GWTh9SWjrk1w/7Y3OUau5oOL+4w34/rcL1vURdxTbXezzzV6F9sVaTk/9AZ+pX
         gLeiljwnIRc9lEd+BFxaP6AQqpSnhXVaw9kZkvlfp2dhuO4NoP313+r5NXwbjruQfQr4
         M2zQ==
X-Gm-Message-State: APjAAAWnwmkjojjGGEYY8lZ0UOwjiPkFbbN5yaoen6J3Lmb0xfDrfCw1
        kj8f43vg9m5Hwsoyyj5wmeUsqgwRo/MUrtYBpx/AldQq4iQ=
X-Google-Smtp-Source: APXvYqxXc8CMyLzSZUjJiXBoVFA+KwhUw4OZokUMJRDyBgehezx83xZlp12bFEdwlGJXQLi06FpDl8lPHP59NprkuS4=
X-Received: by 2002:a67:f4d2:: with SMTP id s18mr12464458vsn.15.1581527631474;
 Wed, 12 Feb 2020 09:13:51 -0800 (PST)
MIME-Version: 1.0
References: <20200210131925.145463-1-samitolvanen@google.com> <CAK7LNAS7UchtP_+2m4AB-hJ=nMwsM-qpkJ+VHU1JGJrn8K1KPg@mail.gmail.com>
In-Reply-To: <CAK7LNAS7UchtP_+2m4AB-hJ=nMwsM-qpkJ+VHU1JGJrn8K1KPg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 12 Feb 2020 09:13:40 -0800
Message-ID: <CABCJKuemBAeySJQY6yxhzbxK=XGBtVSt+6J6WXpO=RoiVXH7GQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove duplicate dependencies from .mod files
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 5:23 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> In which case are undefined symbols duplicated?

When a module consists of multiple compilation units, which depend on
the same external symbols. In Android, we ran into this when adding
hardening features that all depend on an external error handler
function with a rather long name. When CONFIG_TRIM_UNUSED_SYMS was
later enabled, we ran into this:

$ llvm-nm drivers/gpu/drm/nouveau/nouveau.o | sed -n 's/^  *U //p' |
xargs echo | wc
      2    9136  168660

xargs defaults to 128kiB limit for command line size, so the output
was split into two lines, which means some of the dependencies were
dropped and we ran into modpost errors. One method of fixing this is
to increase the limit:

$ llvm-nm drivers/gpu/drm/nouveau/nouveau.o | sed -n 's/^  *U //p' |
xargs -s 262144 echo | wc
      1    9136  168660

But it seems removing duplicates is a better solution as the length of
the dependency list is reduced significantly:

$ llvm-nm drivers/gpu/drm/nouveau/nouveau.o | sed -n 's/^  *U //p' |
sort -u | xargs echo | wc
      1    2716   50461

> Do you have a .config to reproduce it?

I can currently reproduce this on an Android kernel that has
Control-Flow Integrity (CFI) enabled. While this feature is not
upstreamed yet, there's nothing that would prevent us from hitting the
command line limit with sufficiently large modules otherwise as well.

Sami
