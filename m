Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296B2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D122065E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="As1cLWvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgG2Cz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2Cz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 22:55:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE3C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 19:55:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so1336518wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 19:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ln9vWFQ/R74p2MABDMNrBE8755UppvYDgTP+VF5FnfY=;
        b=As1cLWvjMWIb8eYeBcN+UOPdKjgux7/c9qT+PwRSvDOtEpdrzZ7k0cjGME45WL4C2l
         IjTsPWpeM65JmZWEJWkNUNgKM4fmEyNSiCBNuF6cWifnQRvuMsa315jznyOoArIPg6y/
         WWDhkvCqim2MSOevJgFas6W8w5QXmGEpf8tskRzUqGljtxsNZWm7U9QO5ZQbst4PgAwI
         8/xXX5IdpK9Es+qz8B/5HeCWQAS9PTy2NajE2O1lYDvviFHhZGnq8xGws81kJanxq3oc
         CuxTW6jFIsIucM7XBtcZNt3sFDD2ywmgh6c4bGVNWhmhEg7hC/jhPGYcMxbVSaMQpgQU
         8s0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ln9vWFQ/R74p2MABDMNrBE8755UppvYDgTP+VF5FnfY=;
        b=SUt9u4m30BfXiiR3jaEicoiDZuaDUz1x6YATqllYe2V97Hb2LPh/9gVY3YmKf1Nj0A
         qSv4RsSRK4IUW/V/08GflYjl9HJq2i/BiqiaksOxYhpL4L8fN+pChhHvp2Sm8P9oICX3
         vhxQJN8cvwup/ZKZycjXxTtWVMsSBbK70VS0Gr5rirJRyPGHTbDzZMVtkIDJH5ExYKY7
         ZKGzBT6wn0XFETK9Omp1vt4Ne5pEGXiud3380UIktpVSipdId6u7kplb4Bbyz+UaFU7Y
         SaiZ/Rq4+Fh5pVJWcxd+ToT1rOOd4qj9UHlRsciTbyWcOdQYKH7XDKFWJN3dLtaIoDAG
         KdIQ==
X-Gm-Message-State: AOAM533BBNAqLoUZEiRMs8skIXRlRds1R9tt/InnYr8JHjEhcsz2KtoH
        nDU/qSqpYwO0JuVG9HQwRfvjllHqgdZdbkZSLWE6Xw==
X-Google-Smtp-Source: ABdhPJxT3j5WynGVuW0VuoY8qY/5Amc/7kfSdWeRsPvEvMDgZGYVIzeOtUQvTj9hYexyARXZu48S57GO/r051ILiNu8=
X-Received: by 2002:a1c:7d81:: with SMTP id y123mr6189574wmc.87.1595991326463;
 Tue, 28 Jul 2020 19:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <3f437939521cea1157b6803acd312e1a04399474.1595990061.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <3f437939521cea1157b6803acd312e1a04399474.1595990061.git.marcelo.schmitt1@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 29 Jul 2020 10:55:15 +0800
Message-ID: <CABVgOS=FaHb6QLCcSnNBfXAHha+hRPkgQZD0GKxnWjPWuSb2Dg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: adjust parse regex
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        felixguoxiuping@gmail.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:42 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> kunit config subcommand terminates with error if .config has a
> configuration assigned with a string, for instance:
>
> CONFIG_CC_VERSION_TEXT="gcc (distro package version) ..."
>
> This patch adjusts the parse regex to consider such string assignments.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---

Thanks, Marcelo.

I think we've actually already got a fix for this upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3f37d14b8a3152441f36b6bc74000996679f0998

Cheers,
-- David
