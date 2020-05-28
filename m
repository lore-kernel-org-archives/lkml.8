Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220E5207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhnoiyLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406774AbgE1Tsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406731AbgE1Try (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:47:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8DC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:47:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n15so14109661pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/FdgxgI19k7/RKqJ/1UKTtp/t1yUz4BSjmKYARom7w=;
        b=NhnoiyLyrHenDPN/ByLZft3pE/05o6EphRSK5zVl2eNUOny+2wX24yFoolbzQitLUx
         r1GJXMjbbm/uPWj11cJZ0AuerxLLigaZsPLeD6BjBI4nIQcZfUzdv3Ma2fJ9el4c2Mdf
         I2tbk9B6lqi1qJY5nBKMXroSqoQj+E4tNPXHZJyzOGOa40wcvmhJaOsVX2Dkjn6as5+N
         H9n79lJcVEPFG7rwcG4FcNl+zCwgaSH+NoOjN+mYTzMdNLwTXyLsQVmm1TUL2+SWydmQ
         a9S58luzSRtufXod/x4psb8i0Kyky1Fo7GHjE9FpMNuVMaz8XmjXJPtw2XlDn86Atmfn
         2yPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/FdgxgI19k7/RKqJ/1UKTtp/t1yUz4BSjmKYARom7w=;
        b=bhBryyY1X1B1v15+DtvN2Z1nnAemsk1g8vwTczp4hKVaQ0oKWqxpWkYjZi8pOLh/LK
         ANPVQIeOvn2jyKXJ17Ajc6NppJyUja7EjIqREpW3MYrHahnYEIoVLth4JB2CPRvEgo8A
         VJlszN1uG629xOQ0U8jQycZJaPwKARpMLirNuEqSkyyQEUWKICJpIXfXWLe0jWhPGPyR
         jrPIcrWuog7ggIbmrxbnc+vsf3z0QkXgwR91eJQmlZ14O+GZkd97YLyq4LQU9Bb6SUjd
         GYTGu4Bm+mx4/A+0bbFHSWuCEWGNVz2BPulbevcvPqKMc7JyrIhGxG/Ap9H+s8V9wuVq
         S+Kg==
X-Gm-Message-State: AOAM531/qMCHn+2bhGgwrGpl7XpTTcirPcbRe7mdVYKowepwS2dY+WbK
        3togz6ATLCAFMweOq9UqkPMv5g9ZjKZdTRVAR/NA1w==
X-Google-Smtp-Source: ABdhPJwgEtpb6jI3FOheNRBghe6AUmRsRvAFRwYEW6C/h7VOF9DNYfEAHMINt1bf+zlknXXh4+o9UNQsHuK9Q3SImW8=
X-Received: by 2002:a62:8c42:: with SMTP id m63mr4739825pfd.106.1590695274111;
 Thu, 28 May 2020 12:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <1585313122-26441-1-git-send-email-alan.maguire@oracle.com> <1585313122-26441-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1585313122-26441-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 May 2020 12:47:43 -0700
Message-ID: <CAFd5g46uNRwDnKHjukU2gBu6wM0kzBragaWBJigbfJkFuQvsFw@mail.gmail.com>
Subject: Re: [PATCH v3 kunit-next 2/2] kunit: add support for named resources
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

On Fri, Mar 27, 2020 at 5:46 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> The kunit resources API allows for custom initialization and
> cleanup code (init/fini); here a new resource add function sets
> the "struct kunit_resource" "name" field, and calls the standard
> add function.  Having a simple way to name resources is
> useful in cases such as multithreaded tests where a set of
> resources are shared among threads; a pointer to the
> "struct kunit *" test state then is all that is needed to
> retrieve and use named resources.  Support is provided to add,
> find and destroy named resources; the latter two are simply
> wrappers that use a "match-by-name" callback.
>
> If an attempt to add a resource with a name that already exists
> is made kunit_add_named_resource() will return -EEXIST.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

FYI, I already gave a reviewed-by for this commit back in v1, so:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
