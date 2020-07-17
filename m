Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49914C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CE320739
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="anj7sbR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgGQWjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQWjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:39:52 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58680C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:39:52 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id r7so2459931vkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTzkNMrSwyq0Nv+U+VjnxqvQEMur6myVfbA5cZN1NmQ=;
        b=anj7sbR3gHHz3pzQ2Ipg9Wh7rvglfTdQbjTjABe/EZlztDtVTkGTG4xUBw1qYq73W8
         gd2WYYGYPYOCVbDYxcee5lvkREjjWLCBiuqRm2yaTdP46zSKO3v32BIGFG5W3D1M+KTp
         wVfS9XfA29IIp0e56zQZBjftCyHvc5zJzodzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTzkNMrSwyq0Nv+U+VjnxqvQEMur6myVfbA5cZN1NmQ=;
        b=iJJZdDMFDAJ6buDfKVEWiF48a8/YswcHXMlWZGt2Ka+8Piy1oeImK+TUvtXvP6Aj74
         h7Mo4qeiRfrEdQRsXHyTU3VBeqmw0VG5yQcnhhol5F6tNZSUmoveQ4k6KKWxKR8bw2uP
         kfUzo/Qwc4ROr/OFVmYLjUEAm/G343X6xLs9Dw5hB+WwK9TFWHwwWURbGo5liCIx4c60
         G4wKtGO82AkuvOY7FqSbOVA9DhvJJOlvBjcZ8TRX7NV8Fv1ajBBvQjxv8Ns8H8HZk1bI
         pEzW9qvfStHIsicD103jzfbYI6PnvnXbGH0XZh4m84xx5p7taOKJvRUsVh1IJQD0ja33
         0ybg==
X-Gm-Message-State: AOAM532D5tipuzXdspECmWV4DEpJUTi0boEx07C6p8rK8kcm85CCYl/r
        UjvVCu7cXsbUHBlPOsOqtp0Ff5ReheA=
X-Google-Smtp-Source: ABdhPJy+7LWa8AyXALTsNXVO0NbgOhitRRxgoy3Mv+Rfwppl6IAoEpAQEu6aTgrjWP5kSgWl3VfPsg==
X-Received: by 2002:a1f:418f:: with SMTP id o137mr8883231vka.25.1595025590353;
        Fri, 17 Jul 2020 15:39:50 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id f15sm1200188vsa.28.2020.07.17.15.39.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 15:39:49 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id m6so5632715vsl.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:39:48 -0700 (PDT)
X-Received: by 2002:a67:ec0f:: with SMTP id d15mr8409511vso.121.1595025588164;
 Fri, 17 Jul 2020 15:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200716151943.2167652-1-daniel.thompson@linaro.org> <20200716151943.2167652-2-daniel.thompson@linaro.org>
In-Reply-To: <20200716151943.2167652-2-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jul 2020 15:39:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUxWoWr2VZJ0Ng6orxDJmEt8VRYeiFC11mT8L=NwpKig@mail.gmail.com>
Message-ID: <CAD=FV=XUxWoWr2VZJ0Ng6orxDJmEt8VRYeiFC11mT8L=NwpKig@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kgdb: Honour the kprobe blocklist when setting breakpoints
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 16, 2020 at 8:20 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kgdb has absolutely no safety rails in place to discourage or
> prevent a user from placing a breakpoint in dangerous places such as
> the debugger's own trap entry/exit and other places where it is not safe
> to take synchronous traps.
>
> Introduce a new config symbol KGDB_HONOUR_BLOCKLIST and modify the
> default implementation of kgdb_validate_break_address() so that we use
> the kprobe blocklist to prohibit instrumentation of critical functions
> if the config symbol is set. The config symbol dependencies are set to
> ensure that the blocklist will be enabled by default if we enable KGDB
> and are compiling for an architecture where we HAVE_KPROBES.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  include/linux/kgdb.h      | 18 ++++++++++++++++++
>  kernel/debug/debug_core.c |  4 ++++
>  kernel/debug/kdb/kdb_bp.c |  9 +++++++++
>  lib/Kconfig.kgdb          | 14 ++++++++++++++
>  4 files changed, 45 insertions(+)

Seems reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
