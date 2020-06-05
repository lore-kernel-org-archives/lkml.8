Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A039C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58C4206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3wUV67S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgFEVUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgFEVUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:20:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4EC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:20:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so4191549plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHQW5BYXXwiXrCyLQHmDQmz1BrijG2qlo7eTGZ7BGTo=;
        b=l3wUV67SS8YzgG+J497FQhzIUlIstI8rWeqr96YqvC8EpoaFAHOoxFPBzJYizvw7av
         f0+7++GMnbuFj1b3iY/KSvMC4AuMstDWfRPIvwqEpuPL8l/LacTOCl88TcWVxmzayieP
         AlSQfaSMs8hdbfOEqqWIYS25AHvoxDxbIOgFN9oQkntkmUtuYol2rbAUcSoc65IJag8+
         ozAAsfAY2ydITmm15ZQ5HwBC8Lh63os6BRSsj7vMQmZlx6fMy1H6kJrx4e1QQSjKJZHZ
         Bxz31wHWAyme744qB5O2FwSXBfM0hJUopynJYIZe9osoD7en2pl30eSmfd6UxfSs/6Vl
         uhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHQW5BYXXwiXrCyLQHmDQmz1BrijG2qlo7eTGZ7BGTo=;
        b=WBRPH2IqX7K8oSop9heCcJhxrLa/p473h5KvKiaSNKtzB+xA3JOXxco5gMSYvuaXby
         8m3kmOF2TQODQPZzBOvd5E+E8ZCFGAUS92nR0kA7HmFP/MJ+jc5OHe7FbA2z1tTYs0LO
         MMVTDatSWb6tLw1H4DJ06mO65SuPpcFMDTTer1i/g8QTbmrAWAkNnKwq7qpIbyYoylrj
         jsnEzMaTekjF9nCl57gLT7BMbFr1oQYKoOxAt+3WmjtOx0fuqpNfDKfbkS1uEPbigweW
         r4ZpgZPnM2XDC9aaGNR9/Otf5cYpzlwNA/NsuNwc+65B/98j+FNQE25vDH0CdVGZ+Cr2
         eY7g==
X-Gm-Message-State: AOAM533SdAvGk5dq8i001xQMDGc1SH5SHQjcKVp+uK96qj3QUDu8iz+O
        cw6MGT0F2S5PxLSbS+hEYCiHZ9tRs4jGL8KtuxewKA==
X-Google-Smtp-Source: ABdhPJxn2AdJDXSYLUY6qD3G2Tb2nEEMAWnsUakhn4HQ0naRzZal3cGyLMpcClBFVWS9fngFHKn1CZ/c9Y3RCIzFFJ4=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr5173836pjv.217.1591392046747;
 Fri, 05 Jun 2020 14:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <1590788781-1895-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1590788781-1895-1-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Jun 2020 14:20:35 -0700
Message-ID: <CAFd5g46Uu_5TG89uOm0Dj5CMq+11cwjBnsd-k_CVy6bQUeU4Jw@mail.gmail.com>
Subject: Re: [PATCH v4 kunit-next 0/2] kunit: extend kunit resources API
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
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

On Fri, May 29, 2020 at 2:46 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> A recent RFC patch set [1] suggests some additional functionality
> may be needed around kunit resources.  It seems to require
>
> 1. support for resources without allocation
> 2. support for lookup of such resources
> 3. support for access to resources across multiple kernel threads
>
> The proposed changes here are designed to address these needs.
> The idea is we first generalize the API to support adding
> resources with static data; then from there we support named
> resources.  The latter support is needed because if we are
> in a different thread context and only have the "struct kunit *"
> to work with, we need a way to identify a resource in lookup.
>
> [1] https://lkml.org/lkml/2020/2/26/1286
>
> Changes since v3:
> - removed unused "init" field from "struct kunit_resources" (Brendan)

Shuah, it looks like you haven't sent a PR to Linus yet. Would you
mind picking this up for 5.8?
